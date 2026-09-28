<?php
declare(strict_types=1);

class AuthController
{
    public function showLogin(): void
    {
        if (Auth::check()) {
            Router::redirect('dashboard');
        }
        View::render('auth/login', ['error' => null]);
    }

    public function login(): void
    {
        if (!Request::checkCsrf()) {
            View::render('auth/login', ['error' => 'Session expirée, réessaie.']);
            return;
        }

        $email = strtolower(Request::input('email', ''));
        $password = (string) Request::input('password', '');

        $user = Auth::attempt($email, $password);
        if (!$user) {
            View::render('auth/login', ['error' => 'Identifiants incorrects.']);
            return;
        }

        Router::redirect('dashboard');
    }

    public function showRegister(): void
    {
        if (Auth::check()) {
            Router::redirect('dashboard');
        }
        View::render('auth/register', ['error' => null]);
    }

    public function register(): void
    {
        if (!Request::checkCsrf()) {
            View::render('auth/register', ['error' => 'Session expirée, réessaie.']);
            return;
        }

        $name = Request::input('name', '');
        $email = strtolower(Request::input('email', ''));
        $password = (string) Request::input('password', '');
        $headline = Request::input('headline', '');

        if (strlen($name) < 2 || !filter_var($email, FILTER_VALIDATE_EMAIL) || strlen($password) < 8) {
            View::render('auth/register', ['error' => 'Merci de vérifier les champs (mot de passe : 8 caractères minimum).']);
            return;
        }

        if (User::emailExists($email)) {
            View::render('auth/register', ['error' => 'Un compte existe déjà avec cet e-mail.']);
            return;
        }

        $id = User::create($name, $email, $password, $headline);
        $_SESSION['user_id'] = $id;
        session_regenerate_id(true);

        Router::redirect('dashboard');
    }

    public function logout(): void
    {
        Auth::logout();
        Router::redirect('login');
    }
}
