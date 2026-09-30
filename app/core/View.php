<?php
declare(strict_types=1);

/**
 * Rendu des vues PHP (templates dans app/views).
 */
class View
{
    /**
     * @param array<string,mixed> $data
     */
    public static function render(string $template, array $data = [], bool $withLayout = true): void
    {
        $file = APP_ROOT . "/app/views/{$template}.php";
        if (!is_file($file)) {
            http_response_code(500);
            echo "Vue introuvable : {$template}";
            return;
        }

        extract($data, EXTR_SKIP);
        $user = Auth::user();

        if ($withLayout) {
            require APP_ROOT . '/app/views/layout/header.php';
        }
        require $file;
        if ($withLayout) {
            require APP_ROOT . '/app/views/layout/footer.php';
        }
    }

    public static function partial(string $template, array $data = []): void
    {
        extract($data, EXTR_SKIP);
        require APP_ROOT . "/app/views/{$template}.php";
    }

    public static function e(?string $value): string
    {
        return htmlspecialchars($value ?? '', ENT_QUOTES, 'UTF-8');
    }

    /** Avatar d'un utilisateur : photo de profil si présente, sinon initiale sur fond coloré. */
    public static function avatar(array $user, int $size = 34): string
    {
        $style = "width:{$size}px;height:{$size}px;border-radius:50%;object-fit:cover;";
        if (!empty($user['avatar_path'])) {
            return '<img src="' . Router::url($user['avatar_path']) . '" alt="" style="' . $style . '">';
        }
        $initial = self::e(mb_strtoupper(mb_substr($user['name'] ?? '?', 0, 1)));
        $color = self::e($user['avatar_color'] ?? '#1111EE');
        $fontSize = max(12, (int) round($size * 0.42));
        return '<span class="avatar" style="' . $style . "background:{$color};display:inline-flex;align-items:center;justify-content:center;color:#fff;font-weight:700;font-size:{$fontSize}px;\">" . $initial . '</span>';
    }

    public static function json($data, int $status = 200): void
    {
        http_response_code($status);
        header('Content-Type: application/json; charset=utf-8');
        echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    }

    /** Rendu Markdown minimal (gras, italique, code, titres, listes, liens). */
    public static function markdown(string $text): string
    {
        $escaped = htmlspecialchars($text, ENT_QUOTES, 'UTF-8');

        // Blocs de code ```...```
        $escaped = preg_replace_callback('/```([a-zA-Z]*)\n(.*?)```/s', function ($m) {
            return '<pre><code>' . $m[2] . '</code></pre>';
        }, $escaped);

        // Titres
        $escaped = preg_replace('/^### (.+)$/m', '<h3>$1</h3>', $escaped);
        $escaped = preg_replace('/^## (.+)$/m', '<h2>$1</h2>', $escaped);
        $escaped = preg_replace('/^# (.+)$/m', '<h1>$1</h1>', $escaped);

        // Gras / italique / code inline
        $escaped = preg_replace('/\*\*(.+?)\*\*/', '<strong>$1</strong>', $escaped);
        $escaped = preg_replace('/`([^`]+?)`/', '<code>$1</code>', $escaped);

        // Liens [texte](url)
        $escaped = preg_replace('/\[(.+?)\]\((https?:\/\/[^\s)]+)\)/', '<a href="$2" target="_blank" rel="noopener">$1</a>', $escaped);

        // Listes à puces
        $escaped = preg_replace('/^- (.+)$/m', '<li>$1</li>', $escaped);
        $escaped = preg_replace('/(<li>.*<\/li>\n?)+/s', '<ul>$0</ul>', $escaped);

        // Paragraphes (lignes restantes)
        $lines = explode("\n", $escaped);
        $out = [];
        foreach ($lines as $line) {
            $trimmed = trim($line);
            if ($trimmed === '') {
                continue;
            }
            if (preg_match('/^<(h1|h2|h3|ul|li|pre)/', $trimmed)) {
                $out[] = $line;
            } else {
                $out[] = "<p>{$line}</p>";
            }
        }

        return implode("\n", $out);
    }
}
