<?php
declare(strict_types=1);

class Progress
{
    public static function statusFor(int $userId, int $lessonId): string
    {
        $stmt = Database::connection()->prepare(
            'SELECT status FROM lesson_progress WHERE user_id = ? AND lesson_id = ?'
        );
        $stmt->execute([$userId, $lessonId]);
        $row = $stmt->fetch();
        return $row['status'] ?? 'not_started';
    }

    /** @return array<int,string> lesson_id => status */
    public static function statusesForTrack(int $userId, int $trackId): array
    {
        $stmt = Database::connection()->prepare(
            'SELECT l.id, lp.status FROM lessons l
             INNER JOIN modules m ON m.id = l.module_id
             LEFT JOIN lesson_progress lp ON lp.lesson_id = l.id AND lp.user_id = ?
             WHERE m.track_id = ?'
        );
        $stmt->execute([$userId, $trackId]);
        $out = [];
        foreach ($stmt->fetchAll() as $row) {
            $out[(int) $row['id']] = $row['status'] ?? 'not_started';
        }
        return $out;
    }

    public static function markStarted(int $userId, int $lessonId): void
    {
        $stmt = Database::connection()->prepare(
            'INSERT INTO lesson_progress (user_id, lesson_id, status, started_at)
             VALUES (?, ?, "in_progress", NOW())
             ON DUPLICATE KEY UPDATE
                started_at = COALESCE(started_at, VALUES(started_at)),
                status = IF(status = "completed", status, VALUES(status))'
        );
        $stmt->execute([$userId, $lessonId]);
    }

    public static function markCompleted(int $userId, int $lessonId): void
    {
        $stmt = Database::connection()->prepare(
            'INSERT INTO lesson_progress (user_id, lesson_id, status, started_at, completed_at)
             VALUES (?, ?, "completed", NOW(), NOW())
             ON DUPLICATE KEY UPDATE status = "completed", completed_at = NOW()'
        );
        $stmt->execute([$userId, $lessonId]);
    }
}
