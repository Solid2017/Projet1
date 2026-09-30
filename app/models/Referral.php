<?php
declare(strict_types=1);

class Referral
{
    /** Nombre de jours offerts au parrain et au filleul lors du premier paiement du filleul. */
    public const REWARD_DAYS = 7;

    public static function create(int $referrerId, int $referredId): void
    {
        $stmt = Database::connection()->prepare(
            'INSERT IGNORE INTO referrals (referrer_id, referred_id) VALUES (?, ?)'
        );
        $stmt->execute([$referrerId, $referredId]);
    }

    public static function findPendingForReferred(int $referredId): ?array
    {
        $stmt = Database::connection()->prepare(
            "SELECT * FROM referrals WHERE referred_id = ? AND status = 'pending' LIMIT 1"
        );
        $stmt->execute([$referredId]);
        return $stmt->fetch() ?: null;
    }

    public static function markRewarded(int $id): void
    {
        $stmt = Database::connection()->prepare(
            "UPDATE referrals SET status = 'rewarded', rewarded_at = NOW() WHERE id = ?"
        );
        $stmt->execute([$id]);
    }

    public static function countRewardedForUser(int $referrerId): int
    {
        $stmt = Database::connection()->prepare(
            "SELECT COUNT(*) FROM referrals WHERE referrer_id = ? AND status = 'rewarded'"
        );
        $stmt->execute([$referrerId]);
        return (int) $stmt->fetchColumn();
    }

    public static function countPendingForUser(int $referrerId): int
    {
        $stmt = Database::connection()->prepare(
            "SELECT COUNT(*) FROM referrals WHERE referrer_id = ? AND status = 'pending'"
        );
        $stmt->execute([$referrerId]);
        return (int) $stmt->fetchColumn();
    }
}
