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
    /**
     * Petit convertisseur Markdown → HTML (sans dépendance) pour les leçons
     * et les réponses du mentor IA. Le texte est échappé AVANT toute
     * transformation : aucun HTML saisi ne passe tel quel.
     *
     * Gère : titres (# à ####), paragraphes, **gras**, *italique*, `code`,
     * blocs ```code```, listes à puces et numérotées, citations / encadrés
     * (> **Info** …), tableaux | a | b |, séparateurs ---, liens et images https.
     */
    public static function markdown(string $text): string
    {
        $text = str_replace(["\r\n", "\r", "\x01"], ["\n", "\n", ""], $text);
        $blocks = [];

        // 1. Blocs de code : extraits avant tout le reste pour rester intacts.
        $text = preg_replace_callback('/^```[ \t]*([\w+-]*)[ \t]*\n(.*?)\n?^```[ \t]*$/ms', function ($m) use (&$blocks) {
            $lang = $m[1] !== '' ? ' class="language-' . htmlspecialchars($m[1], ENT_QUOTES, 'UTF-8') . '"' : '';
            $blocks[] = '<pre><code' . $lang . '>' . htmlspecialchars($m[2], ENT_QUOTES, 'UTF-8') . '</code></pre>';
            return "\x01B" . (count($blocks) - 1) . "\x01";
        }, $text) ?? $text;

        $lines = explode("\n", $text);
        $out = [];
        $para = [];
        $flushPara = function () use (&$para, &$out) {
            if ($para) {
                $out[] = '<p>' . implode('<br>', array_map([self::class, 'inlineMarkdown'], $para)) . '</p>';
                $para = [];
            }
        };

        $count = count($lines);
        for ($i = 0; $i < $count; $i++) {
            $line = $lines[$i];
            $trim = trim($line);

            if ($trim === '') {
                $flushPara();
                continue;
            }
            if (preg_match('/^\x01B(\d+)\x01$/', $trim, $m)) {
                $flushPara();
                $out[] = $blocks[(int) $m[1]];
                continue;
            }
            if (preg_match('/^(#{1,4})\s+(.+?)\s*#*$/', $trim, $m)) {
                $flushPara();
                $level = strlen($m[1]);
                $out[] = "<h{$level}>" . self::inlineMarkdown($m[2]) . "</h{$level}>";
                continue;
            }
            if (preg_match('/^(-{3,}|\*{3,}|_{3,})$/', $trim)) {
                $flushPara();
                $out[] = '<hr>';
                continue;
            }
            // Citation / encadré : lignes consécutives commençant par ">".
            if (str_starts_with($trim, '>')) {
                $flushPara();
                $quote = [];
                while ($i < $count && str_starts_with(trim($lines[$i]), '>')) {
                    $quote[] = preg_replace('/^>\s?/', '', trim($lines[$i]));
                    $i++;
                }
                $i--;
                $out[] = '<blockquote>' . self::markdown(implode("\n", $quote)) . '</blockquote>';
                continue;
            }
            // Listes : à puces (-, *) ou numérotées (1.), sur des lignes consécutives.
            if (preg_match('/^([-*]|\d+[.)])\s+/', $trim, $m)) {
                $flushPara();
                $ordered = ctype_digit($m[1][0]);
                $items = [];
                while ($i < $count && preg_match($ordered ? '/^\s*\d+[.)]\s+(.*)$/' : '/^\s*[-*]\s+(.*)$/', $lines[$i], $im)) {
                    $items[] = '<li>' . self::inlineMarkdown($im[1]) . '</li>';
                    $i++;
                }
                $i--;
                $start = $ordered && (int) $m[1] > 1 ? ' start="' . (int) $m[1] . '"' : '';
                $out[] = ($ordered ? "<ol{$start}>" : '<ul>') . implode('', $items) . ($ordered ? '</ol>' : '</ul>');
                continue;
            }
            // Tableaux : | a | b | puis | --- | --- |
            if (str_starts_with($trim, '|') && $i + 1 < $count && preg_match('/^\|?\s*:?-{2,}/', trim($lines[$i + 1]))) {
                $flushPara();
                $cells = [self::class, 'tableCells'];
                $html = '<div class="table-wrap"><table><thead><tr>';
                foreach ($cells($trim) as $c) {
                    $html .= '<th>' . self::inlineMarkdown($c) . '</th>';
                }
                $html .= '</tr></thead><tbody>';
                $i += 2;
                while ($i < $count && str_starts_with(trim($lines[$i]), '|')) {
                    $html .= '<tr>';
                    foreach ($cells($lines[$i]) as $c) {
                        $html .= '<td>' . self::inlineMarkdown($c) . '</td>';
                    }
                    $html .= '</tr>';
                    $i++;
                }
                $i--;
                $out[] = $html . '</tbody></table></div>';
                continue;
            }
            $para[] = $trim;
        }
        $flushPara();

        return implode("\n", $out);
    }

    /** Découpe une ligne de tableau sur les « | », sauf ceux placés dans du `code`. */
    private static function tableCells(string $row): array
    {
        $row = trim($row);
        $row = substr($row, 0, 1) === '|' ? substr($row, 1) : $row;
        $row = substr($row, -1) === '|' ? substr($row, 0, -1) : $row;
        $cells = [];
        $current = '';
        $inCode = false;
        foreach (preg_split('//u', $row, -1, PREG_SPLIT_NO_EMPTY) as $char) {
            if ($char === '`') {
                $inCode = !$inCode;
            } elseif ($char === '|' && !$inCode) {
                $cells[] = trim($current);
                $current = '';
                continue;
            }
            $current .= $char;
        }
        $cells[] = trim($current);
        return $cells;
    }

    /** Mise en forme dans une ligne : code, gras, italique, images et liens (https uniquement). */
    private static function inlineMarkdown(string $text): string
    {
        $codes = [];
        $text = preg_replace_callback('/`([^`]+)`/', function ($m) use (&$codes) {
            $codes[] = '<code>' . htmlspecialchars($m[1], ENT_QUOTES, 'UTF-8') . '</code>';
            return "\x01C" . (count($codes) - 1) . "\x01";
        }, $text) ?? $text;

        $text = htmlspecialchars($text, ENT_QUOTES, 'UTF-8');
        $text = preg_replace('/!\[([^\]]*)\]\((https:\/\/[^\s)]+)\)/', '<img src="$2" alt="$1" loading="lazy">', $text);
        $text = preg_replace('/\[([^\]]+)\]\((https?:\/\/[^\s)]+)\)/', '<a href="$2" target="_blank" rel="noopener">$1</a>', $text);
        $text = preg_replace('/\*\*(.+?)\*\*/', '<strong>$1</strong>', $text);
        $text = preg_replace('/(?<![\w*])\*(?!\s)(.+?)(?<!\s)\*(?![\w*])/', '<em>$1</em>', $text);

        return preg_replace_callback('/\x01C(\d+)\x01/', fn ($m) => $codes[(int) $m[1]], $text);
    }
}
