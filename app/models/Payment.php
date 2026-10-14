<?php
declare(strict_types=1);

class Payment
{
    public static function create(int $userId, string $transactionId, string $provider, int $amountFcfa, string $phone, string $channel, string $plan = 'monthly'): int
    {
        $stmt = Database::connection()->prepare(
            'INSERT INTO payments (user_id, transaction_id, provider, channel, phone, amount_fcfa, plan, status)
             VALUES (?, ?, ?, ?, ?, ?, ?, "pending")'
        );
        $stmt->execute([$userId, $transactionId, $provider, $channel, $phone, $amountFcfa, $plan]);
        return (int) Database::connection()->lastInsertId();
    }

    public static function findByTransactionId(string $transactionId): ?array
    {
        $stmt = Database::connection()->prepare('SELECT * FROM payments WHERE transaction_id = ? LIMIT 1');
        $stmt->execute([$transactionId]);
        return $stmt->fetch() ?: null;
    }

    public static function markSuccess(int $id, ?string $providerReference, string $rawResponse): void
    {
        $stmt = Database::connection()->prepare(
            'UPDATE payments SET status = "success", provider_reference = ?, raw_response = ? WHERE id = ?'
        );
        $stmt->execute([$providerReference, $rawResponse, $id]);
    }

    public static function markFailed(int $id, string $rawResponse): void
    {
        $stmt = Database::connection()->prepare(
            'UPDATE payments SET status = "failed", raw_response = ? WHERE id = ?'
        );
        $stmt->execute([$rawResponse, $id]);
    }

    public static function revenueThisMonth(): int
    {
        $stmt = Database::connection()->query(
            "SELECT COALESCE(SUM(amount_fcfa), 0) FROM payments
             WHERE status = 'success' AND YEAR(created_at) = YEAR(NOW()) AND MONTH(created_at) = MONTH(NOW())"
        );
        return (int) $stmt->fetchColumn();
    }

    public static function recent(int $limit = 20): array
    {
        $limit = max(1, min(100, $limit));
        return Database::connection()
            ->query(
                "SELECT p.*, u.name AS user_name, u.email AS user_email FROM payments p
                 INNER JOIN users u ON u.id = p.user_id
                 ORDER BY p.created_at DESC LIMIT {$limit}"
            )
            ->fetchAll();
    }
}
