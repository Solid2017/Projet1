<?php
declare(strict_types=1);

class Lesson
{
    public static function find(int $id): ?array
    {
        $stmt = Database::connection()->prepare('SELECT * FROM lessons WHERE id = ? LIMIT 1');
        $stmt->execute([$id]);
        return $stmt->fetch() ?: null;
    }

    /** Récupère la leçon avec les infos de son module et de son parcours (pour breadcrumbs / contrôle d'accès). */
    public static function findWithContext(int $id): ?array
    {
        $stmt = Database::connection()->prepare(
            'SELECT l.*, m.track_id, m.title AS module_title, t.slug AS track_slug, t.title AS track_title
             FROM lessons l
             INNER JOIN modules m ON m.id = l.module_id
             INNER JOIN tracks t ON t.id = m.track_id
             WHERE l.id = ? LIMIT 1'
        );
        $stmt->execute([$id]);
        return $stmt->fetch() ?: null;
    }

    public static function forModule(int $moduleId): array
    {
        $stmt = Database::connection()->prepare('SELECT * FROM lessons WHERE module_id = ? ORDER BY position ASC');
        $stmt->execute([$moduleId]);
        return $stmt->fetchAll();
    }

    public static function create(array $data): int
    {
        $stmt = Database::connection()->prepare(
            'INSERT INTO lessons (module_id, title, summary, content, video_url, duration_minutes, position)
             VALUES (:module_id, :title, :summary, :content, :video_url, :duration_minutes, :position)'
        );
        $stmt->execute([
            'module_id' => $data['module_id'],
            'title' => $data['title'],
            'summary' => $data['summary'] ?? null,
            'content' => $data['content'] ?? null,
            'video_url' => $data['video_url'] ?: null,
            'duration_minutes' => $data['duration_minutes'] ?? 15,
            'position' => $data['position'] ?? 0,
        ]);
        return (int) Database::connection()->lastInsertId();
    }

    public static function update(int $id, array $data): void
    {
        $stmt = Database::connection()->prepare(
            'UPDATE lessons SET title=:title, summary=:summary, content=:content, video_url=:video_url,
             duration_minutes=:duration_minutes, position=:position WHERE id=:id'
        );
        $stmt->execute([
            'title' => $data['title'],
            'summary' => $data['summary'] ?? null,
            'content' => $data['content'] ?? null,
            'video_url' => $data['video_url'] ?: null,
            'duration_minutes' => $data['duration_minutes'] ?? 15,
            'position' => $data['position'] ?? 0,
            'id' => $id,
        ]);
    }

    public static function delete(int $id): void
    {
        $stmt = Database::connection()->prepare('DELETE FROM lessons WHERE id = ?');
        $stmt->execute([$id]);
    }

    /** Leçon suivante dans le même parcours (toutes leçons ordonnées par module puis position). */
    public static function next(int $trackId, int $currentLessonId): ?array
    {
        $stmt = Database::connection()->prepare(
            'SELECT l.* FROM lessons l
             INNER JOIN modules m ON m.id = l.module_id
             WHERE m.track_id = ?
             ORDER BY m.position ASC, l.position ASC'
        );
        $stmt->execute([$trackId]);
        $all = $stmt->fetchAll();

        $found = false;
        foreach ($all as $lesson) {
            if ($found) {
                return $lesson;
            }
            if ((int) $lesson['id'] === $currentLessonId) {
                $found = true;
            }
        }
        return null;
    }
}
