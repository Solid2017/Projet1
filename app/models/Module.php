<?php
declare(strict_types=1);

class Module
{
    public static function find(int $id): ?array
    {
        $stmt = Database::connection()->prepare('SELECT * FROM modules WHERE id = ? LIMIT 1');
        $stmt->execute([$id]);
        return $stmt->fetch() ?: null;
    }

    public static function forTrack(int $trackId): array
    {
        $stmt = Database::connection()->prepare('SELECT * FROM modules WHERE track_id = ? ORDER BY position ASC');
        $stmt->execute([$trackId]);
        return $stmt->fetchAll();
    }

    public static function create(int $trackId, string $title, string $description, int $position): int
    {
        $stmt = Database::connection()->prepare(
            'INSERT INTO modules (track_id, title, description, position) VALUES (?, ?, ?, ?)'
        );
        $stmt->execute([$trackId, $title, $description ?: null, $position]);
        return (int) Database::connection()->lastInsertId();
    }

    public static function update(int $id, string $title, string $description, int $position): void
    {
        $stmt = Database::connection()->prepare(
            'UPDATE modules SET title = ?, description = ?, position = ? WHERE id = ?'
        );
        $stmt->execute([$title, $description ?: null, $position, $id]);
    }

    public static function delete(int $id): void
    {
        $stmt = Database::connection()->prepare('DELETE FROM modules WHERE id = ?');
        $stmt->execute([$id]);
    }
}
