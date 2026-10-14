<?php
declare(strict_types=1);

/**
 * Passerelle vers le modèle de langage du mentor IA.
 * Fournisseurs supportés : "anthropic" (Claude), "openai" (ou toute API
 * compatible OpenAI : Groq, Google Gemini, OpenRouter…), "ollama" (modèle
 * exécuté en local, sans clé API).
 *
 * Bascule automatique : si le fournisseur principal échoue (quota gratuit
 * du jour épuisé, panne, clé invalide), les fournisseurs de secours listés
 * dans 'ai_fallbacks' (config.php) sont essayés dans l'ordre.
 */
class AIService
{
    /**
     * @param array<int, array{role:string, content:string}> $history
     * @return array{ok:bool, content:string}
     */
    public static function reply(string $systemPrompt, array $history): array
    {
        $chain = array_merge([APP_CONFIG['ai']], APP_CONFIG['ai_fallbacks'] ?? []);

        foreach ($chain as $index => $cfg) {
            $provider = $cfg['provider'] ?? 'anthropic';
            $label = $provider . (isset($cfg['model']) ? ' / ' . $cfg['model'] : '');

            try {
                $content = match ($provider) {
                    'anthropic' => self::callAnthropic($cfg, $systemPrompt, $history),
                    'openai'    => self::callOpenAi($cfg, $systemPrompt, $history),
                    'ollama'    => self::callOllama($cfg, $systemPrompt, $history),
                    default     => throw new RuntimeException("Fournisseur IA inconnu : {$provider}"),
                };

                if ($index > 0) {
                    self::log("Mentor IA servi par le secours n°{$index} ({$label})");
                }
                return ['ok' => true, 'content' => $content];
            } catch (Throwable $e) {
                self::log('Erreur mentor IA (' . $label . ') : ' . $e->getMessage());
            }
        }

        return [
            'ok' => false,
            'content' => "Le mentor IA est très sollicité en ce moment. Réessaie dans quelques minutes, " .
                "ou relis la leçon en attendant : ta question est importante !",
        ];
    }

    private static function log(string $message): void
    {
        error_log('[IgoTech IA] ' . $message);
        @file_put_contents(
            APP_ROOT . '/storage/app.log',
            '[' . date('Y-m-d H:i:s') . '] ' . $message . "\n",
            FILE_APPEND
        );
    }

    private static function callAnthropic(array $cfg, string $system, array $history): string
    {
        $url = rtrim($cfg['base_url'] ?: 'https://api.anthropic.com', '/') . '/v1/messages';

        $payload = [
            'model' => $cfg['model'],
            'system' => $system,
            'max_tokens' => (int) ($cfg['max_tokens'] ?? 1024),
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
        $url = self::chatCompletionsUrl((string) ($cfg['base_url'] ?? ''));

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
        if (is_string($text)) {
            // Certains modèles « raisonneurs » renvoient leur réflexion entre balises <think>.
            $text = trim((string) preg_replace('/<think>.*?<\/think>/s', '', $text));
        }
        if (!$text) {
            throw new RuntimeException('Réponse vide ou inattendue du fournisseur compatible OpenAI.');
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

    /**
     * Adresse de l'API « chat completions » compatible OpenAI :
     *   https://api.openai.com                                   → …/v1/chat/completions
     *   https://api.groq.com/openai                              → …/openai/v1/chat/completions
     *   https://generativelanguage.googleapis.com/v1beta/openai  → …/v1beta/openai/chat/completions
     *   https://openrouter.ai/api/v1                             → …/api/v1/chat/completions
     */
    public static function chatCompletionsUrl(string $baseUrl): string
    {
        $base = rtrim($baseUrl !== '' ? $baseUrl : 'https://api.openai.com', '/');
        if (str_ends_with($base, '/chat/completions')) {
            return $base;
        }
        if (preg_match('#/v\d+[a-z0-9]*(/openai)?$#', $base)) {
            return $base . '/chat/completions';
        }
        return $base . '/v1/chat/completions';
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
