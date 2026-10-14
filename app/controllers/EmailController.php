<?php
declare(strict_types=1);

/**
 * Désinscription des e-mails de fidélisation. Le jeton signé du lien sert
 * d'authentification : pas besoin d'être connecté, ni de jeton CSRF.
 */
class EmailController
{
    public function showUnsubscribe(): void
    {
        [$userId, $token, $user] = $this->resolve();
        View::render('emails/unsubscribe', [
            'state' => $user ? ((int) $user['email_opt_out'] === 1 ? 'done' : 'confirm') : 'invalid',
            'userId' => $userId,
            'token' => $token,
            'email' => $user['email'] ?? '',
        ]);
    }

    public function unsubscribe(): void
    {
        [$userId, $token, $user] = $this->resolve();
        if ($user) {
            User::setEmailOptOut($userId, true);
        }

        // Désinscription « en un clic » envoyée directement par Gmail/Outlook (RFC 8058).
        if (($_POST['List-Unsubscribe'] ?? '') === 'One-Click') {
            http_response_code($user ? 200 : 400);
            header('Content-Type: text/plain; charset=utf-8');
            echo $user ? 'Désinscription enregistrée.' : 'Lien invalide.';
            return;
        }

        View::render('emails/unsubscribe', [
            'state' => $user ? 'done' : 'invalid', 'userId' => $userId, 'token' => $token, 'email' => $user['email'] ?? '',
        ]);
    }

    public function resubscribe(): void
    {
        [$userId, $token, $user] = $this->resolve();
        if ($user) {
            User::setEmailOptOut($userId, false);
        }
        View::render('emails/unsubscribe', [
            'state' => $user ? 'resubscribed' : 'invalid', 'userId' => $userId, 'token' => $token, 'email' => $user['email'] ?? '',
        ]);
    }

    /** @return array{0:int, 1:string, 2:?array} */
    private function resolve(): array
    {
        $userId = (int) ($_GET['u'] ?? $_POST['u'] ?? 0);
        $token = (string) ($_GET['t'] ?? $_POST['t'] ?? '');
        $user = RetentionMailer::checkToken($userId, $token) ? User::find($userId) : null;
        return [$userId, $token, $user];
    }
}
