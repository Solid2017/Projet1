<?php
/**
 * Point d'amorçage de l'application IgoTech IA.
 * Charge la configuration, l'autoload des classes et démarre la session.
 */

declare(strict_types=1);

define('APP_ROOT', dirname(__DIR__));

// ---------------------------------------------------------------------
// Configuration
// ---------------------------------------------------------------------
$configFile = APP_ROOT . '/config/config.php';
if (!is_file($configFile)) {
    http_response_code(500);
    die(
        "Configuration manquante. Copie config/config.sample.php vers " .
        "config/config.php puis renseigne tes identifiants."
    );
}
$config = require $configFile;
define('APP_CONFIG', $config);

// ---------------------------------------------------------------------
// Filet de sécurité : toute erreur fatale est journalisée dans
// storage/app.log (lisible en FTP) et, en mode debug, affichée
// directement — pour ne pas dépendre de la page d'erreur générique
// de l'hébergeur, qui peut masquer le vrai message.
// ---------------------------------------------------------------------
$logDir = APP_ROOT . '/storage';
if (!is_dir($logDir)) {
    @mkdir($logDir, 0755, true);
}

function igotech_report_fatal(string $message): void
{
    $logDir = APP_ROOT . '/storage';
    $line = '[' . date('Y-m-d H:i:s') . '] ' . $message . "\n";
    @file_put_contents($logDir . '/app.log', $line, FILE_APPEND);
    error_log('[IgoTech IA] ' . $message);

    if (!empty(APP_CONFIG['app']['debug'])) {
        http_response_code(200);
        header('Content-Type: text/plain; charset=utf-8');
        echo "Erreur IgoTech IA (mode debug) :\n\n" . $message . "\n";
    } else {
        http_response_code(500);
        header('Content-Type: text/html; charset=utf-8');
        echo '<h1>Erreur interne</h1><p>Une erreur est survenue. Consulte storage/app.log pour le détail.</p>';
    }
}

set_exception_handler(function (Throwable $e): void {
    igotech_report_fatal($e::class . ': ' . $e->getMessage() . ' in ' . $e->getFile() . ':' . $e->getLine());
});

register_shutdown_function(function (): void {
    $error = error_get_last();
    if ($error && in_array($error['type'], [E_ERROR, E_PARSE, E_CORE_ERROR, E_COMPILE_ERROR], true)) {
        igotech_report_fatal($error['message'] . ' in ' . $error['file'] . ':' . $error['line']);
    }
});

// ---------------------------------------------------------------------
// Autoload simple par convention de dossiers (pas de dépendance Composer,
// pour rester compatible avec un hébergement mutualisé LWSPanel).
// ---------------------------------------------------------------------
spl_autoload_register(function (string $class): void {
    $dirs = ['core', 'services', 'models', 'controllers'];
    foreach ($dirs as $dir) {
        $path = APP_ROOT . "/app/{$dir}/{$class}.php";
        if (is_file($path)) {
            require $path;
            return;
        }
    }
});

// ---------------------------------------------------------------------
// Erreurs
// ---------------------------------------------------------------------
if (!empty($config['app']['debug'])) {
    ini_set('display_errors', '1');
    error_reporting(E_ALL);
} else {
    ini_set('display_errors', '0');
    error_reporting(E_ALL & ~E_DEPRECATED & ~E_NOTICE);
}

// ---------------------------------------------------------------------
// Session sécurisée
// ---------------------------------------------------------------------
$isHttps = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off')
    || (($_SERVER['HTTP_X_FORWARDED_PROTO'] ?? '') === 'https');

session_name('igotech_session');
session_set_cookie_params([
    'lifetime' => 0,
    'path'     => '/',
    'secure'   => $isHttps,
    'httponly' => true,
    'samesite' => 'Lax',
]);
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

date_default_timezone_set('Africa/Abidjan');
mb_internal_encoding('UTF-8');
