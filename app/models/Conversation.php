<?php
declare(strict_types=1);

class Conversation
{
    public static function find(int $id): ?array
    {
        $stmt = Database::connection()->prepare('SELECT * FROM conversations WHERE id = ? LIMIT 1');
        $stmt->execute([$id]);
        return $stmt->fetch() ?: null;
    }

    public static function forUser(int $userId): array
    {
        $stmt = Database::connection()->prepare(
            'SELECT c.*, t.title AS track_title FROM conversations c
             LEFT JOIN tracks t ON t.id = c.track_id
             WHERE c.user_id = ? ORDER BY c.updated_at DESC'
        );
        $stmt->execute([$userId]);
        return $stmt->fetchAll();
    }

    public static function create(int $userId, ?int $trackId, ?int $lessonId, string $title): int
    {
        $stmt = Database::connection()->prepare(
            'INSERT INTO conversations (user_id, track_id, lesson_id, title) VALUES (?, ?, ?, ?)'
        );
        $stmt->execute([$userId, $trackId, $lessonId, $title]);
        return (int) Database::connection()->lastInsertId();
    }

    public static function touch(int $id): void
    {
        $stmt = Database::connection()->prepare('UPDATE conversations SET updated_at = NOW() WHERE id = ?');
        $stmt->execute([$id]);
    }

    public static function belongsToUser(int $conversationId, int $userId): bool
    {
        $stmt = Database::connection()->prepare('SELECT id FROM conversations WHERE id = ? AND user_id = ?');
        $stmt->execute([$conversationId, $userId]);
        return (bool) $stmt->fetch();
    }

    public static function messages(int $conversationId): array
    {
        $stmt = Database::connection()->prepare(
            'SELECT role, content, created_at FROM messages WHERE conversation_id = ? ORDER BY id ASC'
        );
        $stmt->execute([$conversationId]);
        return $stmt->fetchAll();
    }

    public static function addMessage(int $conversationId, string $role, string $content): void
    {
        $stmt = Database::connection()->prepare(
            'INSERT INTO messages (conversation_id, role, content) VALUES (?, ?, ?)'
        );
        $stmt->execute([$conversationId, $role, $content]);
        self::touch($conversationId);
    }

    /** Nombre total de messages envoyés par cet utilisateur, tous temps confondus (pour l'essai gratuit). */
    public static function userMessageCountTotal(int $userId): int
    {
        $stmt = Database::connection()->prepare(
            "SELECT COUNT(*) FROM messages m
             INNER JOIN conversations c ON c.id = m.conversation_id
             WHERE c.user_id = ? AND m.role = 'user'"
        );
        $stmt->execute([$userId]);
        return (int) $stmt->fetchColumn();
    }

    /** Nombre de messages envoyés par cet utilisateur aujourd'hui (quota anti-abus). */
    public static function userMessageCountToday(int $userId): int
    {
        $stmt = Database::connection()->prepare(
            "SELECT COUNT(*) FROM messages m
             INNER JOIN conversations c ON c.id = m.conversation_id
             WHERE c.user_id = ? AND m.role = 'user' AND DATE(m.created_at) = CURDATE()"
        );
        $stmt->execute([$userId]);
        return (int) $stmt->fetchColumn();
    }
}
