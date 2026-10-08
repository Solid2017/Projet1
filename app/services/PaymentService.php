<?php
declare(strict_types=1);

/**
 * Passerelle de paiement Mobile Money pour l'abonnement au mentor IA.
 *
 * Deux modes (config payment.provider) : « manual » — l'apprenant paie
 * sur WhatsApp et reçoit un code d'accès généré par l'admin — ou « cinetpay ».
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

    /** Mode « manuel » : paiement Mobile Money négocié sur WhatsApp, puis code d'accès généré par l'admin. */
    public static function isManual(): bool
    {
        return (APP_CONFIG['payment']['provider'] ?? 'manual') === 'manual';
    }

    /** @return array{plan:string, months:int, amount:int} */
    public static function planDetails(string $plan): array
    {
        $cfg = APP_CONFIG['payment'] ?? [];
        return $plan === 'annual'
            ? ['plan' => 'annual', 'months' => 12, 'amount' => (int) ($cfg['amount_fcfa_annual'] ?? 20000)]
            : ['plan' => 'monthly', 'months' => 1, 'amount' => (int) ($cfg['amount_fcfa'] ?? 2000)];
    }

    /** Numéro WhatsApp à contacter pour payer (format international sans « + »), ou '' s'il n'est pas configuré. */
    public static function whatsappNumber(): string
    {
        $number = APP_CONFIG['payment']['whatsapp_number'] ?? '';
        if ($number === '') {
            $number = APP_CONFIG['social']['whatsapp_number'] ?? '';
        }
        return self::waDigits((string) $number);
    }

    /** Lien wa.me avec message prérempli ; sans numéro, WhatsApp laisse choisir le contact. */
    public static function whatsappLink(string $phone, string $text): string
    {
        $digits = self::waDigits($phone);
        return 'https://wa.me/' . $digits . '?text=' . rawurlencode($text);
    }

    /** "+235 66 12 34 56" ou "66 12 34 56" → "23566123456" */
    public static function waDigits(string $phone): string
    {
        $digits = preg_replace('/\D/', '', $phone) ?? '';
        if (str_starts_with($digits, '00')) {
            $digits = substr($digits, 2);
        }
        // Numéro tchadien local (8 chiffres) : on ajoute l'indicatif +235.
        if (strlen($digits) === 8) {
            $digits = '235' . $digits;
        }
        return $digits;
    }

    /**
     * Active l'abonnement de l'apprenant avec un code d'accès généré par
     * l'administrateur après réception de son transfert Mobile Money.
     *
     * @return array{ok:bool, message:string}
     */
    public static function redeemAccessCode(array $user, string $input): array
    {
        $code = AccessCode::normalize($input);
        $row = $code !== '' ? AccessCode::findByCode($code) : null;

        if (!$row) {
            return ['ok' => false, 'message' => 'Code invalide. Vérifie-le (format IGO-XXXX-XXXX) ou contacte-nous sur WhatsApp.'];
        }
        if ($row['revoked_at'] !== null) {
            return ['ok' => false, 'message' => "Ce code a été annulé. Contacte-nous sur WhatsApp pour en recevoir un nouveau."];
        }
        if ($row['used_at'] !== null) {
            return ['ok' => false, 'message' => (int) $row['used_by'] === (int) $user['id']
                ? 'Tu as déjà utilisé ce code : ton abonnement est activé.'
                : 'Ce code a déjà été utilisé.'];
        }
        if (!empty($row['reserved_email']) && strcasecmp($row['reserved_email'], $user['email']) !== 0) {
            return ['ok' => false, 'message' => "Ce code est réservé à un autre compte. Connecte-toi avec l'adresse e-mail communiquée lors du paiement."];
        }

        $pdo = Database::connection();
        $pdo->beginTransaction();
        try {
            if (!AccessCode::markUsed((int) $row['id'], (int) $user['id'])) {
                $pdo->rollBack();
                return ['ok' => false, 'message' => 'Ce code a déjà été utilisé.'];
            }

            $formatted = AccessCode::format($code);
            $paymentId = Payment::create((int) $user['id'], 'code_' . $code, 'manual', (int) $row['amount_fcfa'], (string) ($row['learner_phone'] ?? ''), 'MOBILE_MONEY_MANUEL', $row['plan']);
            Payment::markSuccess($paymentId, $formatted, json_encode(['code' => $formatted, 'note' => $row['note']], JSON_UNESCAPED_UNICODE));
            Subscription::activate((int) $user['id'], (int) $row['amount_fcfa'], (int) $row['months']);
            self::rewardReferralIfFirstPayment((int) $user['id']);

            $pdo->commit();
        } catch (Throwable $e) {
            $pdo->rollBack();
            $message = 'Erreur activation code (' . AccessCode::format($code) . ') : ' . $e->getMessage();
            error_log('[IgoTech IA] ' . $message);
            @file_put_contents(APP_ROOT . '/storage/app.log', '[' . date('Y-m-d H:i:s') . '] ' . $message . "\n", FILE_APPEND);
            return ['ok' => false, 'message' => "Une erreur est survenue, ton code n'a pas été consommé. Réessaie dans un instant."];
        }

        $months = (int) $row['months'];
        return ['ok' => true, 'message' => 'Code accepté ! Ton accès au mentor IA est activé pour ' . ($months === 12 ? '1 an' : ($months === 1 ? '1 mois' : $months . ' mois')) . '.'];
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
