<?php
declare(strict_types=1);

/**
 * Routeur minimaliste : associe une méthode HTTP + un motif d'URL
 * à [Controleur, méthode]. Les segments {comme_ceci} sont capturés
 * et passés en arguments au contrôleur.
 */
class Router
{
    /** @var array<int, array{method:string, handler:array, regex:string}> */
    private static array $routes = [];

    public static function get(string $pattern, array $handler): void
    {
        self::add('GET', $pattern, $handler);
    }

    public static function post(string $pattern, array $handler): void
    {
        self::add('POST', $pattern, $handler);
    }

    private static function add(string $method, string $pattern, array $handler): void
    {
        $regex = preg_replace('/\{(\w+)\}/', '([^/]+)', $pattern);

        self::$routes[] = [
            'method'  => $method,
            'handler' => $handler,
            'regex'   => '#^' . $regex . '$#',
        ];
    }

    public static function dispatch(): void
    {
        $path = trim((string) ($_GET['route'] ?? ''), '/');
        $method = Request::method();

        foreach (self::$routes as $route) {
            if ($route['method'] !== $method) {
                continue;
            }
            if (preg_match($route['regex'], $path, $matches)) {
                array_shift($matches);

                [$controllerName, $action] = $route['handler'];
                $controller = new $controllerName();
                call_user_func_array([$controller, $action], array_values($matches));
                return;
            }
        }

        http_response_code(404);
        View::render('errors/404');
    }

    public static function url(string $path = ''): string
    {
        $base = rtrim(self::basePath(), '/');
        $path = ltrim($path, '/');
        return $base . '/' . $path;
    }

    /** Chemin de base de l'application (utile si installée dans un sous-dossier). */
    public static function basePath(): string
    {
        static $base = null;
        if ($base === null) {
            $script = $_SERVER['SCRIPT_NAME'] ?? '/index.php';
            $base = str_replace('\\', '/', dirname($script));
            $base = $base === '/' ? '' : $base;
        }
        return $base;
    }

    public static function redirect(string $path): void
    {
        header('Location: ' . self::url($path));
        exit;
    }

    /** Redirection vers une URL absolue externe (ex: page de paiement CinetPay). */
    public static function redirectExternal(string $url): void
    {
        header('Location: ' . $url);
        exit;
    }
}
