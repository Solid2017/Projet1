<?php
declare(strict_types=1);

class SubscriptionController
{
    /** Page d'abonnement : tarif, statut actuel, paiement (WhatsApp + code d'accès, ou CinetPay). */
    public function pricing(): void
    {
        Auth::requireLogin();

        View::render('subscribe/index', [
            'subscription' => Subscription::current(Auth::id()),
            'amount' => PaymentService::planDetails('monthly')['amount'],
            'amountAnnual' => PaymentService::planDetails('annual')['amount'],
            'manual' => PaymentService::isManual(),
            'whatsappNumber' => PaymentService::whatsappNumber(),
            'user' => Auth::user(),
            'error' => Request::input('error'),
            'success' => Request::input('success'),
        ]);
    }

    /** Paiement manuel : l'apprenant saisit le code d'accès reçu sur WhatsApp. */
    public function redeem(): void
    {
        Auth::requireLogin();
        if (!Request::checkCsrf()) {
            Router::redirect('subscribe');
            return;
        }

        // Limite anti-devinette : 5 codes faux par quart d'heure.
        $now = time();
        $failures = array_filter($_SESSION['access_code_failures'] ?? [], fn ($t) => $t > $now - 900);
        if (count($failures) >= 5) {
            Router::redirect('subscribe?error=' . urlencode("Trop d'essais. Réessaie dans 15 minutes ou contacte-nous sur WhatsApp."));
            return;
        }

        $result = PaymentService::redeemAccessCode(Auth::user(), (string) Request::input('code', ''));
        if (!$result['ok']) {
            $failures[] = $now;
            $_SESSION['access_code_failures'] = array_values($failures);
            Router::redirect('subscribe?error=' . urlencode($result['message']));
            return;
        }

        unset($_SESSION['access_code_failures']);
        Router::redirect('subscribe?success=' . urlencode($result['message']));
    }

    /** Démarre le paiement et redirige vers la page de paiement CinetPay. */
    public function pay(): void
    {
        Auth::requireLogin();
        if (!Request::checkCsrf()) {
            Router::redirect('subscribe');
            return;
        }

        if (PaymentService::isManual()) {
            Router::redirect('subscribe');
            return;
        }

        $phone = trim((string) Request::input('phone', ''));
        if ($phone === '' || !preg_match('/^[0-9+][0-9+ ]{6,20}$/', $phone)) {
            Router::redirect('subscribe?error=' . urlencode('Numéro de téléphone invalide.'));
            return;
        }

        $plan = Request::input('plan') === 'annual' ? 'annual' : 'monthly';
        $result = PaymentService::initiateSubscription(Auth::user(), $phone, $plan);

        if (!$result['ok']) {
            Router::redirect('subscribe?error=' . urlencode($result['error']));
            return;
        }

        Router::redirectExternal($result['payment_url']);
    }

    /**
     * L'apprenant revient ici après avoir payé (ou annulé) sur la page
     * CinetPay. On revérifie toujours le statut réel auprès de CinetPay
     * plutôt que de faire confiance au simple retour navigateur.
     */
    public function returnFromProvider(): void
    {
        Auth::requireLogin();

        $transactionId = (string) Request::input('transaction_id', '');
        $status = $transactionId !== '' ? PaymentService::verifyAndActivate($transactionId) : ['ok' => false, 'status' => 'unknown'];

        View::render('subscribe/return', [
            'success' => $status['ok'],
            'subscription' => Subscription::current(Auth::id()),
        ]);
    }

    /**
     * Notification serveur-à-serveur envoyée par CinetPay (notify_url).
     * Doit répondre 200 rapidement et sans authentification de session
     * (CinetPay n'a pas de cookie de session IgoTech).
     */
    public function webhook(): void
    {
        $transactionId = (string) Request::input('cpm_trans_id', Request::input('transaction_id', ''));
        if ($transactionId !== '') {
            PaymentService::verifyAndActivate($transactionId);
        }
        http_response_code(200);
        echo 'OK';
    }
}
