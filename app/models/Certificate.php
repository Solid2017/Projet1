<?php
declare(strict_types=1);

class Certificate
{
    public static function findForUserTrack(int $userId, int $trackId): ?array
    {
        $stmt = Database::connection()->prepare(
            'SELECT * FROM certificates WHERE user_id = ? AND track_id = ? LIMIT 1'
        );
        $stmt->execute([$userId, $trackId]);
        return $stmt->fetch() ?: null;
    }

    public static function findByCode(string $code): ?array
    {
        $stmt = Database::connection()->prepare(
            'SELECT c.*, u.name AS user_name, t.title AS track_title
             FROM certificates c
             INNER JOIN users u ON u.id = c.user_id
             INNER JOIN tracks t ON t.id = c.track_id
             WHERE c.code = ? LIMIT 1'
        );
        $stmt->execute([$code]);
        return $stmt->fetch() ?: null;
    }

    /** Émet un certificat s'il n'existe pas déjà pour ce parcours ; renvoie le certificat (nouveau ou existant). */
    public static function issue(int $userId, int $trackId): array
    {
        $existing = self::findForUserTrack($userId, $trackId);
        if ($existing) {
            return $existing;
        }

        $code = strtoupper(bin2hex(random_bytes(6)));
        $stmt = Database::connection()->prepare(
            'INSERT INTO certificates (user_id, track_id, code) VALUES (?, ?, ?)'
        );
        $stmt->execute([$userId, $trackId, $code]);

        return self::findForUserTrack($userId, $trackId);
    }
}
