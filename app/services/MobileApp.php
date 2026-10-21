<?php
declare(strict_types=1);

/**
 * Application Android : l'APK est déposé dans assets/app/igotech-ia.apk.
 * L'application affiche ce même site (mêmes comptes, même base de données)
 * et ajoute « IgoTechApp » à son user-agent.
 */
class MobileApp
{
    private const APK = 'assets/app/igotech-ia.apk';

    public static function available(): bool
    {
        return is_file(APP_ROOT . '/' . self::APK);
    }

    /** Lien de téléchargement ; le paramètre v force le navigateur à reprendre la dernière version. */
    public static function apkUrl(): string
    {
        return Router::url(self::APK) . '?v=' . (int) @filemtime(APP_ROOT . '/' . self::APK);
    }

    public static function apkSizeLabel(): string
    {
        $bytes = (int) @filesize(APP_ROOT . '/' . self::APK);
        return $bytes >= 1048576
            ? number_format($bytes / 1048576, 1, ',', ' ') . ' Mo'
            : max(1, (int) round($bytes / 1024)) . ' Ko';
    }

    /** Vrai quand la page est affichée dans l'application Android elle-même. */
    public static function isInApp(): bool
    {
        return str_contains($_SERVER['HTTP_USER_AGENT'] ?? '', 'IgoTechApp');
    }

    /** L'APK ne s'installe pas sur iPhone / iPad : inutile de le proposer. */
    public static function isIos(): bool
    {
        return (bool) preg_match('/iPhone|iPad|iPod/i', $_SERVER['HTTP_USER_AGENT'] ?? '');
    }

    /** Afficher la proposition flottante de téléchargement ? */
    public static function shouldSuggest(): bool
    {
        return self::available() && !self::isInApp() && !self::isIos();
    }
}
