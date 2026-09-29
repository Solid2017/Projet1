<?php
declare(strict_types=1);

class SubscriptionController
{
    /** Page d'abonnement : tarif, statut actuel, formulaire Mobile Money. */
    public function pricing(): void
    {
        Auth::requireLogin();

        View::render('subscribe/index', [
            'subscription' => Subscription::current(Auth::id()),
            'amount' => APP_CONFIG['payment']['amount_fcfa'] ?? 2000,
            'error' => Request::input('error'),
        ]);
    }

    /** Démarre le paiement et redirige vers la page de paiement CinetPay. */
    public function pay(): void
    {
        Auth::requireLogin();
        if (!Request::checkCsrf()) {
            Router::redirect('subscribe');
            return;
        }

        $phone = trim((string) Request::input('phone', ''));
        if ($phone === '' || !preg_match('/^[0-9+][0-9+ ]{6,20}$/', $phone)) {
            Router::redirect('subscribe?error=' . urlencode('Numéro de téléphone invalide.'));
            return;
        }

        $result = PaymentService::initiateSubscription(Auth::user(), $phone);

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
