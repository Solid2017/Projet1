<?php
declare(strict_types=1);

class Track
{
    public static function published(): array
    {
        return Database::connection()
            ->query('SELECT * FROM tracks WHERE is_published = 1 ORDER BY position ASC')
            ->fetchAll();
    }

    public static function all(): array
    {
        return Database::connection()
            ->query('SELECT * FROM tracks ORDER BY position ASC')
            ->fetchAll();
    }

    public static function find(int $id): ?array
    {
        $stmt = Database::connection()->prepare('SELECT * FROM tracks WHERE id = ? LIMIT 1');
        $stmt->execute([$id]);
        return $stmt->fetch() ?: null;
    }

    public static function findBySlug(string $slug): ?array
    {
        $stmt = Database::connection()->prepare('SELECT * FROM tracks WHERE slug = ? LIMIT 1');
        $stmt->execute([$slug]);
        return $stmt->fetch() ?: null;
    }

    public static function create(array $data): int
    {
        $stmt = Database::connection()->prepare(
            'INSERT INTO tracks (slug, title, subtitle, description, icon, color, level, mentor_persona, is_published, position)
             VALUES (:slug, :title, :subtitle, :description, :icon, :color, :level, :mentor_persona, :is_published, :position)'
        );
        $stmt->execute([
            'slug' => $data['slug'],
            'title' => $data['title'],
            'subtitle' => $data['subtitle'] ?? null,
            'description' => $data['description'] ?? null,
            'icon' => $data['icon'] ?? 'code',
            'color' => $data['color'] ?? 'blue',
            'level' => $data['level'] ?? 'debutant',
            'mentor_persona' => $data['mentor_persona'] ?? null,
            'is_published' => !empty($data['is_published']) ? 1 : 0,
            'position' => $data['position'] ?? 0,
        ]);
        return (int) Database::connection()->lastInsertId();
    }

    public static function update(int $id, array $data): void
    {
        $stmt = Database::connection()->prepare(
            'UPDATE tracks SET slug=:slug, title=:title, subtitle=:subtitle, description=:description,
             icon=:icon, color=:color, level=:level, mentor_persona=:mentor_persona,
             is_published=:is_published, position=:position WHERE id=:id'
        );
        $stmt->execute([
            'slug' => $data['slug'],
            'title' => $data['title'],
            'subtitle' => $data['subtitle'] ?? null,
            'description' => $data['description'] ?? null,
            'icon' => $data['icon'] ?? 'code',
            'color' => $data['color'] ?? 'blue',
            'level' => $data['level'] ?? 'debutant',
            'mentor_persona' => $data['mentor_persona'] ?? null,
            'is_published' => !empty($data['is_published']) ? 1 : 0,
            'position' => $data['position'] ?? 0,
            'id' => $id,
        ]);
    }

    public static function delete(int $id): void
    {
        $stmt = Database::connection()->prepare('DELETE FROM tracks WHERE id = ?');
        $stmt->execute([$id]);
    }

    public static function modulesWithLessons(int $trackId): array
    {
        $pdo = Database::connection();

        $stmt = $pdo->prepare('SELECT * FROM modules WHERE track_id = ? ORDER BY position ASC');
        $stmt->execute([$trackId]);
        $modules = $stmt->fetchAll();

        if (!$modules) {
            return [];
        }

        $moduleIds = array_column($modules, 'id');
        $placeholders = implode(',', array_fill(0, count($moduleIds), '?'));
        $stmt = $pdo->prepare("SELECT * FROM lessons WHERE module_id IN ($placeholders) ORDER BY position ASC");
        $stmt->execute($moduleIds);
        $lessons = $stmt->fetchAll();

        $byModule = [];
        foreach ($lessons as $lesson) {
            $byModule[$lesson['module_id']][] = $lesson;
        }

        foreach ($modules as &$module) {
            $module['lessons'] = $byModule[$module['id']] ?? [];
        }

        return $modules;
    }

    public static function isEnrolled(int $userId, int $trackId): bool
    {
        $stmt = Database::connection()->prepare('SELECT id FROM enrollments WHERE user_id = ? AND track_id = ?');
        $stmt->execute([$userId, $trackId]);
        return (bool) $stmt->fetch();
    }

    public static function enroll(int $userId, int $trackId): void
    {
        $stmt = Database::connection()->prepare(
            'INSERT IGNORE INTO enrollments (user_id, track_id) VALUES (?, ?)'
        );
        $stmt->execute([$userId, $trackId]);
    }

    public static function enrolledForUser(int $userId): array
    {
        $stmt = Database::connection()->prepare(
            'SELECT t.*, e.enrolled_at, e.status AS enrollment_status
             FROM tracks t
             INNER JOIN enrollments e ON e.track_id = t.id
             WHERE e.user_id = ?
             ORDER BY e.enrolled_at DESC'
        );
        $stmt->execute([$userId]);
        return $stmt->fetchAll();
    }

    /** Nombre total de leçons d'un parcours. */
    public static function lessonCount(int $trackId): int
    {
        $stmt = Database::connection()->prepare(
            'SELECT COUNT(*) FROM lessons l INNER JOIN modules m ON m.id = l.module_id WHERE m.track_id = ?'
        );
        $stmt->execute([$trackId]);
        return (int) $stmt->fetchColumn();
    }

    /** Nombre de leçons complétées par un utilisateur sur un parcours. */
    public static function completedLessonCount(int $userId, int $trackId): int
    {
        $stmt = Database::connection()->prepare(
            'SELECT COUNT(*) FROM lesson_progress lp
             INNER JOIN lessons l ON l.id = lp.lesson_id
             INNER JOIN modules m ON m.id = l.module_id
             WHERE m.track_id = ? AND lp.user_id = ? AND lp.status = "completed"'
        );
        $stmt->execute([$trackId, $userId]);
        return (int) $stmt->fetchColumn();
    }

    public static function progressPercent(int $userId, int $trackId): int
    {
        $total = self::lessonCount($trackId);
        if ($total === 0) {
            return 0;
        }
        $done = self::completedLessonCount($userId, $trackId);
        return (int) round(($done / $total) * 100);
    }
}
