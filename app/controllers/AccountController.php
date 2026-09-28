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
}
