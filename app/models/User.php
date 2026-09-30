<?php
declare(strict_types=1);

class User
{
    public static function findByEmail(string $email): ?array
    {
        $stmt = Database::connection()->prepare('SELECT * FROM users WHERE email = ? LIMIT 1');
        $stmt->execute([$email]);
        $row = $stmt->fetch();
        return $row ?: null;
    }

    public static function find(int $id): ?array
    {
        $stmt = Database::connection()->prepare('SELECT * FROM users WHERE id = ? LIMIT 1');
        $stmt->execute([$id]);
        $row = $stmt->fetch();
        return $row ?: null;
    }

    public static function emailExists(string $email): bool
    {
        return self::findByEmail($email) !== null;
    }

    public static function create(string $name, string $email, string $password, string $headline = '', ?int $referredBy = null, string $whatsapp = ''): int
    {
        $colors = ['#EE1111', '#1111EE'];
        $stmt = Database::connection()->prepare(
            'INSERT INTO users (name, email, whatsapp_number, password_hash, headline, avatar_color, referral_code, referred_by)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?)'
        );
        $stmt->execute([
            $name,
            $email,
            $whatsapp ?: null,
            password_hash($password, PASSWORD_DEFAULT),
            $headline ?: null,
            $colors[array_rand($colors)],
            self::generateReferralCode(),
            $referredBy,
        ]);
        return (int) Database::connection()->lastInsertId();
    }

    private static function generateReferralCode(): string
    {
        do {
            $code = strtoupper(bin2hex(random_bytes(4)));
        } while (self::findByReferralCode($code) !== null);
        return $code;
    }

    public static function findByReferralCode(string $code): ?array
    {
        $stmt = Database::connection()->prepare('SELECT * FROM users WHERE referral_code = ? LIMIT 1');
        $stmt->execute([$code]);
        return $stmt->fetch() ?: null;
    }

    public static function touchLastLogin(int $id): void
    {
        $stmt = Database::connection()->prepare('UPDATE users SET last_login_at = NOW() WHERE id = ?');
        $stmt->execute([$id]);
    }

    public static function all(): array
    {
        return Database::connection()
            ->query('SELECT id, name, email, whatsapp_number, role, is_active, created_at FROM users ORDER BY created_at DESC')
            ->fetchAll();
    }

    public static function mentors(): array
    {
        return Database::connection()
            ->query("SELECT * FROM users WHERE role = 'mentor' AND is_active = 1 ORDER BY name ASC")
            ->fetchAll();
    }

    public static function setRole(int $id, string $role): void
    {
        $role = in_array($role, ['student', 'mentor', 'admin'], true) ? $role : 'student';
        $stmt = Database::connection()->prepare('UPDATE users SET role = ? WHERE id = ?');
        $stmt->execute([$role, $id]);
    }

    public static function updateMentorProfile(int $id, string $bio, string $whatsapp): void
    {
        $stmt = Database::connection()->prepare('UPDATE users SET mentor_bio = ?, whatsapp_number = ? WHERE id = ?');
        $stmt->execute([$bio ?: null, $whatsapp ?: null, $id]);
    }

    public static function setActive(int $id, bool $active): void
    {
        $stmt = Database::connection()->prepare('UPDATE users SET is_active = ? WHERE id = ?');
        $stmt->execute([$active ? 1 : 0, $id]);
    }

    public static function updatePassword(int $id, string $passwordHash): void
    {
        $stmt = Database::connection()->prepare('UPDATE users SET password_hash = ? WHERE id = ?');
        $stmt->execute([$passwordHash, $id]);
    }
}
