<?php
declare(strict_types=1);

/**
 * Passerelle vers le modèle de langage du mentor IA.
 * Fournisseurs supportés : "anthropic" (Claude), "openai" (ou toute API
 * compatible OpenAI), "ollama" (modèle exécuté en local, sans clé API).
 */
class AIService
{
    /**
     * @param array<int, array{role:string, content:string}> $history
     * @return array{ok:bool, content:string}
     */
    public static function reply(string $systemPrompt, array $history): array
    {
        $cfg = APP_CONFIG['ai'];
        $provider = $cfg['provider'] ?? 'anthropic';

        try {
            $content = match ($provider) {
                'anthropic' => self::callAnthropic($cfg, $systemPrompt, $history),
                'openai'    => self::callOpenAi($cfg, $systemPrompt, $history),
                'ollama'    => self::callOllama($cfg, $systemPrompt, $history),
                default     => throw new RuntimeException("Fournisseur IA inconnu : {$provider}"),
            };

            return ['ok' => true, 'content' => $content];
        } catch (Throwable $e) {
            $message = 'Erreur mentor IA (' . $provider . ') : ' . $e->getMessage();
            error_log('[IgoTech IA] ' . $message);
            @file_put_contents(
                APP_ROOT . '/storage/app.log',
                '[' . date('Y-m-d H:i:s') . '] ' . $message . "\n",
                FILE_APPEND
            );
            return [
                'ok' => false,
                'content' => "Le mentor IA est momentanément indisponible. Vérifie la configuration du " .
                    "fournisseur IA (config/config.php) ou réessaie dans un instant.",
            ];
        }
    }

    private static function callAnthropic(array $cfg, string $system, array $history): string
    {
        $url = rtrim($cfg['base_url'] ?: 'https://api.anthropic.com', '/') . '/v1/messages';

        $payload = [
            'model' => $cfg['model'],
            'system' => $system,
            'max_tokens' => (int) ($cfg['max_tokens'] ?? 1024),
            'temperature' => (float) ($cfg['temperature'] ?? 0.6),
            'messages' => array_map(fn ($m) => [
                'role' => $m['role'] === 'assistant' ? 'assistant' : 'user',
                'content' => $m['content'],
            ], $history),
        ];

        $response = self::post($url, $payload, [
            'content-type: application/json',
            'anthropic-version: 2023-06-01',
            'x-api-key: ' . $cfg['api_key'],
        ]);

        $blocks = $response['content'] ?? [];
        $text = '';
        foreach ($blocks as $block) {
            if (($block['type'] ?? '') === 'text') {
                $text .= $block['text'];
            }
        }

        if ($text === '') {
            throw new RuntimeException('Réponse Anthropic vide ou inattendue.');
        }

        return $text;
    }

    private static function callOpenAi(array $cfg, string $system, array $history): string
    {
        $url = rtrim($cfg['base_url'] ?: 'https://api.openai.com', '/') . '/v1/chat/completions';

        $messages = array_merge(
            [['role' => 'system', 'content' => $system]],
            array_map(fn ($m) => ['role' => $m['role'], 'content' => $m['content']], $history)
        );

        $payload = [
            'model' => $cfg['model'],
            'messages' => $messages,
            'temperature' => (float) ($cfg['temperature'] ?? 0.6),
            'max_tokens' => (int) ($cfg['max_tokens'] ?? 1024),
        ];

        $response = self::post($url, $payload, [
            'content-type: application/json',
            'authorization: Bearer ' . $cfg['api_key'],
        ]);

        $text = $response['choices'][0]['message']['content'] ?? null;
        if (!$text) {
            throw new RuntimeException('Réponse OpenAI vide ou inattendue.');
        }

        return $text;
    }

    private static function callOllama(array $cfg, string $system, array $history): string
    {
        $url = rtrim($cfg['base_url'] ?: 'http://127.0.0.1:11434', '/') . '/api/chat';

        $messages = array_merge(
            [['role' => 'system', 'content' => $system]],
            array_map(fn ($m) => ['role' => $m['role'], 'content' => $m['content']], $history)
        );

        $payload = [
            'model' => $cfg['model'],
            'messages' => $messages,
            'stream' => false,
            'options' => ['temperature' => (float) ($cfg['temperature'] ?? 0.6)],
        ];

        $response = self::post($url, $payload, ['content-type: application/json']);

        $text = $response['message']['content'] ?? null;
        if (!$text) {
            throw new RuntimeException('Réponse Ollama vide ou inattendue.');
        }

        return $text;
    }

    /** @param string[] $headers */
    private static function post(string $url, array $payload, array $headers): array
    {
        $ch = curl_init($url);
        curl_setopt_array($ch, [
            CURLOPT_POST => true,
            CURLOPT_POSTFIELDS => json_encode($payload, JSON_UNESCAPED_UNICODE),
            CURLOPT_HTTPHEADER => $headers,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_TIMEOUT => 40,
            CURLOPT_CONNECTTIMEOUT => 10,
        ]);

        $raw = curl_exec($ch);
        $status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $error = curl_error($ch);
        curl_close($ch);

        if ($raw === false) {
            throw new RuntimeException("Requête réseau échouée : {$error}");
        }
        if ($status < 200 || $status >= 300) {
            throw new RuntimeException("Le fournisseur IA a répondu avec le statut {$status} : " . substr((string) $raw, 0, 300));
        }

        $decoded = json_decode((string) $raw, true);
        if (!is_array($decoded)) {
            throw new RuntimeException('Réponse JSON invalide du fournisseur IA.');
        }

        return $decoded;
    }
}
