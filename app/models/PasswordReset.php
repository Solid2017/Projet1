<?php
declare(strict_types=1);

class PasswordReset
{
    private const TTL_MINUTES = 60;

    /** Génère un token en clair (envoyé par e-mail, jamais stocké tel quel) et enregistre son empreinte. */
    public static function create(int $userId): string
    {
        self::deleteForUser($userId);

        $token = bin2hex(random_bytes(32));
        $stmt = Database::connection()->prepare(
            'INSERT INTO password_resets (user_id, token_hash, expires_at) VALUES (?, ?, DATE_ADD(NOW(), INTERVAL ? MINUTE))'
        );
        $stmt->execute([$userId, hash('sha256', $token), self::TTL_MINUTES]);

        return $token;
    }

    public static function findValidUserId(string $token): ?int
    {
        $stmt = Database::connection()->prepare(
            'SELECT user_id FROM password_resets WHERE token_hash = ? AND expires_at > NOW() LIMIT 1'
        );
        $stmt->execute([hash('sha256', $token)]);
        $row = $stmt->fetch();
        return $row ? (int) $row['user_id'] : null;
    }

    public static function deleteForUser(int $userId): void
    {
        $stmt = Database::connection()->prepare('DELETE FROM password_resets WHERE user_id = ?');
        $stmt->execute([$userId]);
    }
}
