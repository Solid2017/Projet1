<?php
declare(strict_types=1);

/**
 * Petit wrapper autour de la requête HTTP courante.
 */
class Request
{
    public static function method(): string
    {
        return strtoupper($_SERVER['REQUEST_METHOD'] ?? 'GET');
    }

    public static function isPost(): bool
    {
        return self::method() === 'POST';
    }

    public static function input(string $key, $default = null)
    {
        if (array_key_exists($key, $_POST)) {
            $value = $_POST[$key];
        } elseif (array_key_exists($key, $_GET)) {
            $value = $_GET[$key];
        } elseif (array_key_exists($key, self::json())) {
            $value = self::json()[$key];
        } else {
            $value = $default;
        }
        return is_string($value) ? trim($value) : $value;
    }

    private static ?array $jsonCache = null;

    public static function json(): array
    {
        if (self::$jsonCache === null) {
            $raw = file_get_contents('php://input');
            $data = $raw ? json_decode($raw, true) : null;
            self::$jsonCache = is_array($data) ? $data : [];
        }
        return self::$jsonCache;
    }

    public static function wantsJson(): bool
    {
        $accept = $_SERVER['HTTP_ACCEPT'] ?? '';
        $xrw = $_SERVER['HTTP_X_REQUESTED_WITH'] ?? '';
        return str_contains($accept, 'application/json') || strtolower($xrw) === 'xmlhttprequest';
    }

    public static function checkCsrf(): bool
    {
        return Auth::verifyCsrf(self::input('csrf_token'));
    }
}
