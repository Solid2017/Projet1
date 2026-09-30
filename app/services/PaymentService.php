<?php
declare(strict_types=1);

/**
 * Passerelle de paiement Mobile Money pour l'abonnement au mentor IA.
 *
 * Implémentée pour CinetPay (agrégateur gérant Airtel Money, Moov Money,
 * Orange Money et cartes en une seule API — très utilisé en Afrique
 * centrale/francophone). Si tu utilises un autre agrégateur ou une
 * intégration directe Airtel/Moov, seule cette classe doit changer.
 *
 * ⚠️ IMPORTANT : les noms de champs ci-dessous correspondent au format
 * CinetPay documenté au moment de l'écriture de ce code. Vérifie-les
 * contre la documentation actuelle (https://docs.cinetpay.com) une fois
 * que tu as ton compte marchand — un agrégateur de paiement peut faire
 * évoluer son API sans préavis.
 */
class PaymentService
{
    /**
     * Démarre un paiement Mobile Money et renvoie l'URL de paiement
     * CinetPay vers laquelle rediriger l'apprenant (il y choisit
     * Airtel Money ou Moov Money et confirme via USSD sur son téléphone).
     *
     * @return array{ok:bool, payment_url?:string, transaction_id?:string, error?:string}
     */
    public static function initiateSubscription(array $user, string $phone, string $plan = 'monthly'): array
    {
        $cfg = APP_CONFIG['payment'];
        $transactionId = 'igotech_' . time() . '_' . $user['id'] . '_' . bin2hex(random_bytes(3));
        $isAnnual = $plan === 'annual';
        $amount = (int) ($isAnnual ? ($cfg['amount_fcfa_annual'] ?? 20000) : ($cfg['amount_fcfa'] ?? 2000));

        Payment::create($user['id'], $transactionId, $cfg['provider'] ?? 'cinetpay', $amount, $phone, 'MOBILE_MONEY', $isAnnual ? 'annual' : 'monthly');

        $payload = [
            'apikey' => $cfg['api_key'],
            'site_id' => $cfg['site_id'],
            'transaction_id' => $transactionId,
            'amount' => $amount,
            'currency' => $cfg['currency'] ?? 'XAF',
            'description' => $isAnnual ? 'Abonnement annuel Mentor IA — IgoTech IA' : 'Abonnement mensuel Mentor IA — IgoTech IA',
            'notify_url' => self::notifyUrl(),
            'return_url' => self::returnUrl($transactionId),
            'channels' => 'MOBILE_MONEY',
            'customer_name' => $user['name'],
            'customer_surname' => '.',
            'customer_phone_number' => $phone,
        ];

        try {
            $response = self::post(rtrim($cfg['base_url'], '/') . '/v2/payment', $payload);

            if (($response['code'] ?? null) !== '201' || empty($response['data']['payment_url'])) {
                throw new RuntimeException('Réponse CinetPay inattendue : ' . json_encode($response));
            }

            return [
                'ok' => true,
                'payment_url' => $response['data']['payment_url'],
                'transaction_id' => $transactionId,
            ];
        } catch (Throwable $e) {
            $message = 'Erreur initiation paiement (' . ($cfg['provider'] ?? 'cinetpay') . ') : ' . $e->getMessage();
            error_log('[IgoTech IA] ' . $message);
            @file_put_contents(APP_ROOT . '/storage/app.log', '[' . date('Y-m-d H:i:s') . '] ' . $message . "\n", FILE_APPEND);
            return ['ok' => false, 'error' => 'Impossible de démarrer le paiement pour le moment. Réessaie dans un instant.'];
        }
    }

    /**
     * Vérifie le statut réel d'une transaction auprès de CinetPay (ne
     * jamais faire confiance uniquement à l'appel webhook entrant) et
     * active l'abonnement si le paiement est confirmé.
     *
     * @return array{ok:bool, status:string}
     */
    public static function verifyAndActivate(string $transactionId): array
    {
        $payment = Payment::findByTransactionId($transactionId);
        if (!$payment) {
            return ['ok' => false, 'status' => 'unknown'];
        }
        if ($payment['status'] === 'success') {
            return ['ok' => true, 'status' => 'success'];
        }

        $cfg = APP_CONFIG['payment'];

        try {
            $response = self::post(rtrim($cfg['base_url'], '/') . '/v2/payment/check', [
                'apikey' => $cfg['api_key'],
                'site_id' => $cfg['site_id'],
                'transaction_id' => $transactionId,
            ]);

            $status = $response['data']['status'] ?? null;

            if ($status === 'ACCEPTED') {
                Payment::markSuccess((int) $payment['id'], $response['data']['operator_id'] ?? null, json_encode($response));

                $userId = (int) $payment['user_id'];
                $months = ($payment['plan'] ?? 'monthly') === 'annual' ? 12 : 1;
                Subscription::activate($userId, (int) $payment['amount_fcfa'], $months);

                self::rewardReferralIfFirstPayment($userId);

                return ['ok' => true, 'status' => 'success'];
            }

            Payment::markFailed((int) $payment['id'], json_encode($response));
            return ['ok' => false, 'status' => 'failed'];
        } catch (Throwable $e) {
            $message = 'Erreur vérification paiement (' . $transactionId . ') : ' . $e->getMessage();
            error_log('[IgoTech IA] ' . $message);
            @file_put_contents(APP_ROOT . '/storage/app.log', '[' . date('Y-m-d H:i:s') . '] ' . $message . "\n", FILE_APPEND);
            return ['ok' => false, 'status' => 'error'];
        }
    }

    /** Récompense le parrain et le filleul (jours d'abonnement offerts) au tout premier paiement réussi du filleul. */
    private static function rewardReferralIfFirstPayment(int $userId): void
    {
        $referral = Referral::findPendingForReferred($userId);
        if (!$referral) {
            return;
        }
        Subscription::extendByDays((int) $referral['referrer_id'], Referral::REWARD_DAYS);
        Subscription::extendByDays($userId, Referral::REWARD_DAYS);
        Referral::markRewarded((int) $referral['id']);
    }

    private static function notifyUrl(): string
    {
        $cfg = APP_CONFIG['app'];
        return rtrim($cfg['url'], '/') . Router::url('payments/cinetpay/webhook');
    }

    private static function returnUrl(string $transactionId): string
    {
        $cfg = APP_CONFIG['app'];
        return rtrim($cfg['url'], '/') . Router::url('subscribe/return') . '?transaction_id=' . urlencode($transactionId);
    }

    private static function post(string $url, array $payload): array
    {
        $ch = curl_init($url);
        curl_setopt_array($ch, [
            CURLOPT_POST => true,
            CURLOPT_POSTFIELDS => json_encode($payload, JSON_UNESCAPED_UNICODE),
            CURLOPT_HTTPHEADER => ['content-type: application/json'],
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_TIMEOUT => 30,
            CURLOPT_CONNECTTIMEOUT => 10,
        ]);

        $raw = curl_exec($ch);
        $status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $error = curl_error($ch);
        curl_close($ch);

        if ($raw === false) {
            throw new RuntimeException("Requête réseau échouée : {$error}");
        }
        if ($status < 200 || $status >= 300) {
            throw new RuntimeException("Le fournisseur de paiement a répondu avec le statut {$status} : " . substr((string) $raw, 0, 300));
        }

        $decoded = json_decode((string) $raw, true);
        if (!is_array($decoded)) {
            throw new RuntimeException('Réponse JSON invalide du fournisseur de paiement.');
        }

        return $decoded;
    }
}
