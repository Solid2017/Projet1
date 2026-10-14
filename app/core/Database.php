<?php
declare(strict_types=1);

/**
 * Connexion PDO unique (singleton) à MySQL.
 */
class Database
{
    private static ?PDO $instance = null;

    public static function connection(): PDO
    {
        if (self::$instance === null) {
            $cfg = APP_CONFIG['db'];
            $dsn = sprintf(
                'mysql:host=%s;dbname=%s;charset=%s',
                $cfg['host'],
                $cfg['name'],
                $cfg['charset'] ?? 'utf8mb4'
            );

            try {
                self::$instance = new PDO($dsn, $cfg['user'], $cfg['pass'], [
                    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                    PDO::ATTR_DEFAULT_FETCH_MODE  => PDO::FETCH_ASSOC,
                    PDO::ATTR_EMULATE_PREPARES    => false,
                ]);
            } catch (PDOException $e) {
                error_log('[IgoTech IA] Connexion base de données échouée : ' . $e->getMessage());
                http_response_code(500);
                die('Impossible de se connecter à la base de données. Vérifie config/config.php.');
            }
        }

        return self::$instance;
    }
}
