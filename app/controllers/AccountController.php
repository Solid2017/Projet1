<?php
declare(strict_types=1);

class AccountController
{
    public function showPassword(): void
    {
        Auth::requireLogin();
        View::render('account/password', ['error' => null, 'success' => null]);
    }

    public function updatePassword(): void
    {
        Auth::requireLogin();

        if (!Request::checkCsrf()) {
            View::render('account/password', ['error' => 'Session expirée, réessaie.', 'success' => null]);
            return;
        }

        $current = (string) Request::input('current_password', '');
        $new = (string) Request::input('new_password', '');
        $confirm = (string) Request::input('new_password_confirm', '');

        $user = User::find(Auth::id());

        if (!password_verify($current, $user['password_hash'])) {
            View::render('account/password', ['error' => 'Mot de passe actuel incorrect.', 'success' => null]);
            return;
        }

        if (strlen($new) < 8) {
            View::render('account/password', ['error' => 'Le nouveau mot de passe doit contenir au moins 8 caractères.', 'success' => null]);
            return;
        }

        if ($new !== $confirm) {
            View::render('account/password', ['error' => 'La confirmation ne correspond pas au nouveau mot de passe.', 'success' => null]);
            return;
        }

        User::updatePassword((int) $user['id'], password_hash($new, PASSWORD_DEFAULT));

        View::render('account/password', ['error' => null, 'success' => 'Ton mot de passe a été mis à jour.']);
    }

    private const MAX_PHOTO_BYTES = 3 * 1024 * 1024; // 3 Mo
    private const ALLOWED_MIME_TO_EXT = ['image/jpeg' => 'jpg', 'image/png' => 'png', 'image/webp' => 'webp'];
    private const MAX_PHOTO_DIMENSION = 512;

    public function showPhoto(): void
    {
        Auth::requireLogin();
        View::render('account/photo', ['error' => null, 'user' => Auth::user()]);
    }

    public function uploadPhoto(): void
    {
        Auth::requireLogin();
        $user = Auth::user();

        if (!Request::checkCsrf()) {
            View::render('account/photo', ['error' => 'Session expirée, réessaie.', 'user' => $user]);
            return;
        }

        $file = $_FILES['photo'] ?? null;
        if (!$file || ($file['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_OK) {
            View::render('account/photo', ['error' => 'Merci de choisir une photo (JPG, PNG ou WebP, 3 Mo maximum).', 'user' => $user]);
            return;
        }

        if ($file['size'] > self::MAX_PHOTO_BYTES) {
            View::render('account/photo', ['error' => 'Le fichier est trop volumineux (3 Mo maximum).', 'user' => $user]);
            return;
        }

        $finfo = finfo_open(FILEINFO_MIME_TYPE);
        $mime = finfo_file($finfo, $file['tmp_name']);
        finfo_close($finfo);

        $ext = self::ALLOWED_MIME_TO_EXT[$mime] ?? null;
        $imageInfo = $ext ? @getimagesize($file['tmp_name']) : false;

        if (!$ext || !$imageInfo) {
            View::render('account/photo', ['error' => 'Format non reconnu. Utilise une image JPG, PNG ou WebP.', 'user' => $user]);
            return;
        }

        $dir = APP_ROOT . '/uploads/avatars';
        if (!is_dir($dir)) {
            @mkdir($dir, 0755, true);
        }

        $filename = 'user_' . $user['id'] . '_' . time() . '.' . $ext;
        $destination = $dir . '/' . $filename;

        $resized = $this->storeResized($file['tmp_name'], $mime, $imageInfo, $destination);
        if (!$resized) {
            // GD indisponible ou échec du redimensionnement : on enregistre l'original tel quel.
            move_uploaded_file($file['tmp_name'], $destination);
        }

        if (!empty($user['avatar_path'])) {
            $old = APP_ROOT . '/' . ltrim((string) $user['avatar_path'], '/');
            if (is_file($old) && $old !== $destination) {
                @unlink($old);
            }
        }

        User::setAvatarPath((int) $user['id'], 'uploads/avatars/' . $filename);

        Router::redirect('dashboard');
    }

    /** Redimensionne (si GD est disponible) pour garder des photos légères et carrées. */
    private function storeResized(string $tmpPath, string $mime, array $imageInfo, string $destination): bool
    {
        if (!function_exists('imagecreatetruecolor')) {
            return false;
        }

        [$width, $height] = $imageInfo;
        $source = match ($mime) {
            'image/jpeg' => @imagecreatefromjpeg($tmpPath),
            'image/png' => @imagecreatefrompng($tmpPath),
            'image/webp' => function_exists('imagecreatefromwebp') ? @imagecreatefromwebp($tmpPath) : false,
            default => false,
        };
        if (!$source) {
            return false;
        }

        $side = min($width, $height);
        $srcX = (int) (($width - $side) / 2);
        $srcY = (int) (($height - $side) / 2);
        $targetSide = min(self::MAX_PHOTO_DIMENSION, $side);

        $target = imagecreatetruecolor($targetSide, $targetSide);
        imagecopyresampled($target, $source, 0, 0, $srcX, $srcY, $targetSide, $targetSide, $side, $side);

        $ok = match ($mime) {
            'image/png' => imagepng($target, $destination),
            'image/webp' => function_exists('imagewebp') ? imagewebp($target, $destination) : imagejpeg($target, $destination),
            default => imagejpeg($target, $destination, 85),
        };

        imagedestroy($source);
        imagedestroy($target);

        return (bool) $ok;
    }
}
