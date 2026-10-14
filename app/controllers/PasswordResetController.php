<?php
declare(strict_types=1);

class PasswordResetController
{
    public function showForgot(): void
    {
        if (Auth::check()) {
            Router::redirect('dashboard');
            return;
        }
        View::render('auth/forgot', ['sent' => false, 'error' => null]);
    }

    public function sendReset(): void
    {
        if (!Request::checkCsrf()) {
            View::render('auth/forgot', ['sent' => false, 'error' => 'Session expirée, réessaie.']);
            return;
        }

        $email = strtolower(trim((string) Request::input('email', '')));
        $user = filter_var($email, FILTER_VALIDATE_EMAIL) ? User::findByEmail($email) : null;

        if ($user && $user['is_active']) {
            $token = PasswordReset::create((int) $user['id']);
            $resetUrl = rtrim((string) APP_CONFIG['app']['url'], '/') . Router::url('reset-password/' . $token);

            $html = '<p>Bonjour ' . htmlspecialchars($user['name'], ENT_QUOTES, 'UTF-8') . ',</p>'
                . '<p>Tu as demandé la réinitialisation de ton mot de passe IgoTech IA. '
                . 'Clique sur le lien ci-dessous pour choisir un nouveau mot de passe (valable 1 heure) :</p>'
                . '<p><a href="' . htmlspecialchars($resetUrl, ENT_QUOTES, 'UTF-8') . '">Réinitialiser mon mot de passe</a></p>'
                . "<p>Si tu n'es pas à l'origine de cette demande, ignore simplement cet e-mail.</p>";

            MailService::send($user['email'], $user['name'], 'Réinitialisation de ton mot de passe IgoTech IA', $html);
        }

        // Même message qu'un compte existe ou non, pour ne pas révéler quels e-mails sont enregistrés.
        View::render('auth/forgot', ['sent' => true, 'error' => null]);
    }

    public function showReset(string $token): void
    {
        if (!PasswordReset::findValidUserId($token)) {
            View::render('auth/reset', ['token' => null, 'error' => 'Ce lien de réinitialisation est invalide ou a expiré.']);
            return;
        }
        View::render('auth/reset', ['token' => $token, 'error' => null]);
    }

    public function resetPassword(string $token): void
    {
        if (!Request::checkCsrf()) {
            View::render('auth/reset', ['token' => $token, 'error' => 'Session expirée, réessaie.']);
            return;
        }

        $userId = PasswordReset::findValidUserId($token);
        if (!$userId) {
            View::render('auth/reset', ['token' => null, 'error' => 'Ce lien de réinitialisation est invalide ou a expiré.']);
            return;
        }

        $password = (string) Request::input('password', '');
        $confirm = (string) Request::input('password_confirm', '');

        if (strlen($password) < 8 || $password !== $confirm) {
            View::render('auth/reset', ['token' => $token, 'error' => 'Les mots de passe doivent correspondre (8 caractères minimum).']);
            return;
        }

        User::updatePassword($userId, password_hash($password, PASSWORD_DEFAULT));
        PasswordReset::deleteForUser($userId);

        Router::redirect('login');
    }
}
