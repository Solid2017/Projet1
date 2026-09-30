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
        $refCode = (string) Request::input('ref', '');
        $referrer = $refCode !== '' ? User::findByReferralCode($refCode) : null;
        View::render('auth/register', ['error' => null, 'refCode' => $referrer ? $refCode : null]);
    }

    public function register(): void
    {
        if (!Request::checkCsrf()) {
            View::render('auth/register', ['error' => 'Session expirée, réessaie.', 'refCode' => null]);
            return;
        }

        $name = Request::input('name', '');
        $email = strtolower(Request::input('email', ''));
        $password = (string) Request::input('password', '');
        $headline = Request::input('headline', '');
        $whatsapp = trim((string) Request::input('whatsapp', ''));
        $refCode = (string) Request::input('ref_code', '');

        if (strlen($name) < 2 || !filter_var($email, FILTER_VALIDATE_EMAIL) || strlen($password) < 8) {
            View::render('auth/register', ['error' => 'Merci de vérifier les champs (mot de passe : 8 caractères minimum).', 'refCode' => $refCode ?: null]);
            return;
        }

        if (!preg_match('/^[0-9+][0-9+ ]{6,20}$/', $whatsapp)) {
            View::render('auth/register', ['error' => 'Merci de renseigner un numéro WhatsApp valide — il sert à t\'ajouter au groupe des apprenants.', 'refCode' => $refCode ?: null]);
            return;
        }

        if (User::emailExists($email)) {
            View::render('auth/register', ['error' => 'Un compte existe déjà avec cet e-mail.', 'refCode' => $refCode ?: null]);
            return;
        }

        $referrer = $refCode !== '' ? User::findByReferralCode($refCode) : null;
        $id = User::create($name, $email, $password, $headline, $referrer ? (int) $referrer['id'] : null, $whatsapp);

        if ($referrer) {
            Referral::create((int) $referrer['id'], $id);
        }

        $this->sendWelcomeEmail($name, $email);

        $_SESSION['user_id'] = $id;
        session_regenerate_id(true);

        Router::redirect('dashboard');
    }

    /** E-mail automatique de bienvenue avec le lien d'invitation du groupe WhatsApp (si configuré). Meilleur effort : n'empêche jamais l'inscription. */
    private function sendWelcomeEmail(string $name, string $email): void
    {
        $groupLink = APP_CONFIG['social']['whatsapp_group_invite_link'] ?? '';

        $html = '<p>Bonjour ' . htmlspecialchars($name, ENT_QUOTES, 'UTF-8') . ',</p>'
            . '<p>Bienvenue sur IgoTech IA ! Ton compte est prêt, tu peux dès maintenant choisir un parcours et discuter avec ton mentor IA.</p>';

        if ($groupLink !== '') {
            $html .= '<p>Rejoins aussi le groupe WhatsApp des apprenants IgoTech IA pour échanger avec les autres :</p>'
                . '<p><a href="' . htmlspecialchars($groupLink, ENT_QUOTES, 'UTF-8') . '">Rejoindre le groupe WhatsApp</a></p>';
        }

        MailService::send($email, $name, 'Bienvenue sur IgoTech IA', $html);
    }

    public function logout(): void
    {
        Auth::logout();
        Router::redirect('login');
    }
}
