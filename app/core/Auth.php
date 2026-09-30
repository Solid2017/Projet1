<?php
declare(strict_types=1);

/**
 * Authentification par session + protection CSRF.
 */
class Auth
{
    public static function attempt(string $email, string $password): ?array
    {
        $user = User::findByEmail($email);
        if (!$user || !$user['is_active']) {
            return null;
        }
        if (!password_verify($password, $user['password_hash'])) {
            return null;
        }

        session_regenerate_id(true);
        $_SESSION['user_id'] = $user['id'];
        User::touchLastLogin((int) $user['id']);

        unset($user['password_hash']);
        return $user;
    }

    public static function logout(): void
    {
        $_SESSION = [];
        if (ini_get('session.use_cookies')) {
            $params = session_get_cookie_params();
            setcookie(session_name(), '', time() - 42000, $params['path'], $params['domain'], $params['secure'], $params['httponly']);
        }
        session_destroy();
    }

    public static function check(): bool
    {
        return isset($_SESSION['user_id']);
    }

    public static function isAdmin(): bool
    {
        $user = self::user();
        return $user !== null && $user['role'] === 'admin';
    }

    private static ?array $cachedUser = null;

    public static function user(): ?array
    {
        if (!self::check()) {
            return null;
        }
        if (self::$cachedUser === null) {
            self::$cachedUser = User::find((int) $_SESSION['user_id']);
        }
        return self::$cachedUser;
    }

    public static function id(): ?int
    {
        return self::check() ? (int) $_SESSION['user_id'] : null;
    }

    /** Routes accessibles sans avoir encore ajouté de photo de profil (pour ne pas bloquer l'ajout lui-même). */
    private const PHOTO_EXEMPT_ROUTES = ['account/photo', 'logout'];

    public static function requireLogin(): void
    {
        if (!self::check()) {
            Router::redirect('login');
            return;
        }

        $user = self::user();
        $route = trim((string) ($_GET['route'] ?? ''), '/');
        if ($user && empty($user['avatar_path']) && !in_array($route, self::PHOTO_EXEMPT_ROUTES, true)) {
            Router::redirect('account/photo');
        }
    }

    public static function requireAdmin(): void
    {
        self::requireLogin();
        if (!self::isAdmin()) {
            http_response_code(403);
            View::render('errors/403');
            exit;
        }
    }

    /** Nombre de messages gratuits offerts avant de demander un abonnement (essai, une fois dans la vie du compte). */
    public const FREE_TRIAL_MESSAGES = 5;

    /** Un administrateur a toujours accès ; les autres doivent avoir un abonnement actif. */
    public static function hasMentorAccess(): bool
    {
        if (self::isAdmin()) {
            return true;
        }
        $id = self::id();
        return $id !== null && Subscription::isActive($id);
    }

    /** Messages d'essai gratuit restants (0 si l'essai est épuisé ou si l'utilisateur n'est pas connecté). */
    public static function freeTrialRemaining(): int
    {
        $id = self::id();
        if ($id === null) {
            return 0;
        }
        return max(0, self::FREE_TRIAL_MESSAGES - Conversation::userMessageCountTotal($id));
    }

    /** Accès au mentor : abonnement actif OU essai gratuit non épuisé. */
    public static function canUseMentor(): bool
    {
        return self::hasMentorAccess() || self::freeTrialRemaining() > 0;
    }

    // -------------------------------------------------------------
    // CSRF
    // -------------------------------------------------------------
    public static function csrfToken(): string
    {
        if (empty($_SESSION['csrf_token'])) {
            $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
        }
        return $_SESSION['csrf_token'];
    }

    public static function csrfField(): string
    {
        $token = htmlspecialchars(self::csrfToken(), ENT_QUOTES, 'UTF-8');
        return '<input type="hidden" name="csrf_token" value="' . $token . '">';
    }

    public static function verifyCsrf(?string $token): bool
    {
        return $token !== null
            && !empty($_SESSION['csrf_token'])
            && hash_equals($_SESSION['csrf_token'], $token);
    }
}
