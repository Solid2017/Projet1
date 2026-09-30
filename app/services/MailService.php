<?php
declare(strict_types=1);

/**
 * Client SMTP minimal (sans dépendance externe, pas de Composer) pour
 * envoyer des e-mails via la boîte mail fournie par l'hébergeur LWSPanel.
 * Nécessite la section 'mail' dans config/config.php (voir config.sample.php).
 */
class MailService
{
    /** @return array{ok:bool, error?:string} */
    public static function send(string $toEmail, string $toName, string $subject, string $htmlBody): array
    {
        try {
            self::deliver($toEmail, $toName, $subject, $htmlBody);
            return ['ok' => true];
        } catch (Throwable $e) {
            $message = 'Erreur envoi e-mail (' . $toEmail . ') : ' . $e->getMessage();
            error_log('[IgoTech IA] ' . $message);
            @file_put_contents(APP_ROOT . '/storage/app.log', '[' . date('Y-m-d H:i:s') . '] ' . $message . "\n", FILE_APPEND);
            return ['ok' => false, 'error' => $message];
        }
    }

    private static function deliver(string $toEmail, string $toName, string $subject, string $htmlBody): void
    {
        $cfg = APP_CONFIG['mail'] ?? null;
        if (!$cfg || empty($cfg['host'])) {
            throw new RuntimeException("Configuration 'mail' manquante dans config/config.php.");
        }

        $host = $cfg['host'];
        $port = (int) ($cfg['port'] ?? 587);
        $encryption = $cfg['encryption'] ?? 'tls';
        $fromEmail = $cfg['from_email'] ?? $cfg['username'];
        $fromName = $cfg['from_name'] ?? 'IgoTech IA';
        $ehloDomain = substr((string) strrchr($fromEmail, '@'), 1) ?: 'localhost';

        $remote = ($encryption === 'ssl' ? 'ssl://' : '') . $host;
        $socket = @fsockopen($remote, $port, $errno, $errstr, 15);
        if (!$socket) {
            throw new RuntimeException("Connexion SMTP impossible ({$host}:{$port}) : {$errstr} ({$errno})");
        }
        stream_set_timeout($socket, 15);

        try {
            self::expect($socket, [220]);
            self::command($socket, "EHLO {$ehloDomain}", [250]);

            if ($encryption === 'tls') {
                self::command($socket, 'STARTTLS', [220]);
                if (!stream_socket_enable_crypto($socket, true, STREAM_CRYPTO_METHOD_TLS_CLIENT)) {
                    throw new RuntimeException('Échec de la négociation TLS (STARTTLS).');
                }
                self::command($socket, "EHLO {$ehloDomain}", [250]);
            }

            self::command($socket, 'AUTH LOGIN', [334]);
            self::command($socket, base64_encode((string) $cfg['username']), [334]);
            self::command($socket, base64_encode((string) $cfg['password']), [235]);

            self::command($socket, 'MAIL FROM:<' . $fromEmail . '>', [250]);
            self::command($socket, 'RCPT TO:<' . $toEmail . '>', [250, 251]);
            self::command($socket, 'DATA', [354]);

            $headers = [
                'From: ' . self::encodeHeader($fromName) . ' <' . $fromEmail . '>',
                'To: ' . self::encodeHeader($toName) . ' <' . $toEmail . '>',
                'Subject: ' . self::encodeHeader($subject),
                'MIME-Version: 1.0',
                'Content-Type: text/html; charset=UTF-8',
                'Content-Transfer-Encoding: 8bit',
                'Date: ' . date('r'),
            ];

            // Transparence SMTP : un "." seul en début de ligne doit être doublé.
            $body = str_replace("\n.", "\n..", $htmlBody);
            $data = implode("\r\n", $headers) . "\r\n\r\n" . $body . "\r\n.";
            self::command($socket, $data, [250]);

            self::command($socket, 'QUIT', [221]);
        } finally {
            fclose($socket);
        }
    }

    private static function encodeHeader(string $value): string
    {
        return '=?UTF-8?B?' . base64_encode($value) . '?=';
    }

    /** @param resource $socket @param int[] $expectedCodes */
    private static function command($socket, string $command, array $expectedCodes): string
    {
        fwrite($socket, $command . "\r\n");
        return self::expect($socket, $expectedCodes);
    }

    /** @param resource $socket @param int[] $expectedCodes */
    private static function expect($socket, array $expectedCodes): string
    {
        $response = '';
        while (($line = fgets($socket, 515)) !== false) {
            $response .= $line;
            if (isset($line[3]) && $line[3] === ' ') {
                break;
            }
        }
        if ($response === '') {
            throw new RuntimeException('Pas de réponse du serveur SMTP.');
        }
        $code = (int) substr($response, 0, 3);
        if (!in_array($code, $expectedCodes, true)) {
            throw new RuntimeException('Réponse SMTP inattendue : ' . trim($response));
        }
        return $response;
    }
}
