<?php
declare(strict_types=1);

/**
 * Codes d'accès au mentor IA, générés par l'administrateur après un
 * paiement Mobile Money reçu manuellement (voir PaymentService::redeemAccessCode).
 */
class AccessCode
{
    /** Sans 0/O ni 1/I/L pour éviter les erreurs de saisie : 8 caractères ≈ 40 bits. */
    private const ALPHABET = '23456789ABCDEFGHJKMNPQRSTUVWXYZ';
    private const LENGTH = 8;
    private const PREFIX = 'IGO';

    public static function generate(string $plan, int $months, int $amountFcfa, ?string $reservedEmail, ?string $learnerPhone, ?string $note, ?int $createdBy): array
    {
        $pdo = Database::connection();
        $stmt = $pdo->prepare(
            'INSERT INTO access_codes (code, plan, months, amount_fcfa, reserved_email, learner_phone, note, created_by)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?)'
        );

        for ($attempt = 0; ; $attempt++) {
            $code = '';
            for ($i = 0; $i < self::LENGTH; $i++) {
                $code .= self::ALPHABET[random_int(0, strlen(self::ALPHABET) - 1)];
            }
            try {
                $stmt->execute([$code, $plan, $months, $amountFcfa, $reservedEmail, $learnerPhone, $note, $createdBy]);
                return self::find((int) $pdo->lastInsertId());
            } catch (PDOException $e) {
                // Collision (très improbable) : on retente avec un autre code.
                if ($attempt >= 4 || $e->getCode() !== '23000') {
                    throw $e;
                }
            }
        }
    }

    /** "igo 7k3m-q9tz" → "7K3MQ9TZ" */
    public static function normalize(string $input): string
    {
        $clean = preg_replace('/[^A-Z0-9]/', '', strtoupper($input)) ?? '';
        if (strlen($clean) === strlen(self::PREFIX) + self::LENGTH && str_starts_with($clean, self::PREFIX)) {
            $clean = substr($clean, strlen(self::PREFIX));
        }
        return $clean;
    }

    /** "7K3MQ9TZ" → "IGO-7K3M-Q9TZ" */
    public static function format(string $code): string
    {
        return self::PREFIX . '-' . substr($code, 0, 4) . '-' . substr($code, 4);
    }

    public static function find(int $id): ?array
    {
        $stmt = Database::connection()->prepare('SELECT * FROM access_codes WHERE id = ?');
        $stmt->execute([$id]);
        return $stmt->fetch() ?: null;
    }

    public static function findByCode(string $code): ?array
    {
        $stmt = Database::connection()->prepare('SELECT * FROM access_codes WHERE code = ? LIMIT 1');
        $stmt->execute([$code]);
        return $stmt->fetch() ?: null;
    }

    /** Marque le code comme utilisé ; false s'il vient d'être utilisé ou révoqué entre-temps. */
    public static function markUsed(int $id, int $userId): bool
    {
        $stmt = Database::connection()->prepare(
            'UPDATE access_codes SET used_by = ?, used_at = NOW()
             WHERE id = ? AND used_at IS NULL AND revoked_at IS NULL'
        );
        $stmt->execute([$userId, $id]);
        return $stmt->rowCount() === 1;
    }

    /** Révoque un code encore inutilisé (ex: envoyé par erreur). */
    public static function revoke(int $id): bool
    {
        $stmt = Database::connection()->prepare(
            'UPDATE access_codes SET revoked_at = NOW() WHERE id = ? AND used_at IS NULL AND revoked_at IS NULL'
        );
        $stmt->execute([$id]);
        return $stmt->rowCount() === 1;
    }

    public static function recent(int $limit = 50): array
    {
        $limit = max(1, min(200, $limit));
        return Database::connection()
            ->query(
                "SELECT c.*, u.name AS used_by_name, u.email AS used_by_email FROM access_codes c
                 LEFT JOIN users u ON u.id = c.used_by
                 ORDER BY c.created_at DESC, c.id DESC LIMIT {$limit}"
            )
            ->fetchAll();
    }

    public static function unusedCount(): int
    {
        return (int) Database::connection()
            ->query('SELECT COUNT(*) FROM access_codes WHERE used_at IS NULL AND revoked_at IS NULL')
            ->fetchColumn();
    }
}
