<?php
declare(strict_types=1);

class Subscription
{
    public static function isActive(int $userId): bool
    {
        $stmt = Database::connection()->prepare(
            "SELECT id FROM subscriptions
             WHERE user_id = ? AND status = 'active' AND expires_at > NOW()
             ORDER BY expires_at DESC LIMIT 1"
        );
        $stmt->execute([$userId]);
        return (bool) $stmt->fetch();
    }

    public static function current(int $userId): ?array
    {
        $stmt = Database::connection()->prepare(
            'SELECT * FROM subscriptions WHERE user_id = ? ORDER BY expires_at DESC LIMIT 1'
        );
        $stmt->execute([$userId]);
        return $stmt->fetch() ?: null;
    }

    /** Active ou prolonge l'abonnement d'un mois à partir d'aujourd'hui ou de la date d'expiration actuelle si elle est future. */
    public static function activate(int $userId, int $amountFcfa, int $months = 1): void
    {
        $current = self::current($userId);
        $pdo = Database::connection();

        if ($current && $current['status'] === 'active' && strtotime($current['expires_at']) > time()) {
            $stmt = $pdo->prepare(
                "UPDATE subscriptions SET expires_at = DATE_ADD(expires_at, INTERVAL ? MONTH), status = 'active' WHERE id = ?"
            );
            $stmt->execute([$months, $current['id']]);
            return;
        }

        $stmt = $pdo->prepare(
            "INSERT INTO subscriptions (user_id, status, started_at, expires_at, amount_fcfa)
             VALUES (?, 'active', NOW(), DATE_ADD(NOW(), INTERVAL ? MONTH), ?)"
        );
        $stmt->execute([$userId, $months, $amountFcfa]);
    }

    /** Prolonge l'abonnement d'un utilisateur de N jours (récompense de parrainage). S'il n'a pas d'abonnement actif, lui en crée un court plutôt que de perdre la récompense. */
    public static function extendByDays(int $userId, int $days): void
    {
        $current = self::current($userId);
        $pdo = Database::connection();

        if ($current && $current['status'] === 'active' && strtotime($current['expires_at']) > time()) {
            $stmt = $pdo->prepare('UPDATE subscriptions SET expires_at = DATE_ADD(expires_at, INTERVAL ? DAY) WHERE id = ?');
            $stmt->execute([$days, $current['id']]);
            return;
        }

        $stmt = $pdo->prepare(
            "INSERT INTO subscriptions (user_id, status, started_at, expires_at, amount_fcfa)
             VALUES (?, 'active', NOW(), DATE_ADD(NOW(), INTERVAL ? DAY), 0)"
        );
        $stmt->execute([$userId, $days]);
    }

    public static function activeCount(): int
    {
        $stmt = Database::connection()->query(
            "SELECT COUNT(DISTINCT user_id) FROM subscriptions WHERE status = 'active' AND expires_at > NOW()"
        );
        return (int) $stmt->fetchColumn();
    }
}
