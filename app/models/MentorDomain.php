<?php
declare(strict_types=1);

class MentorDomain
{
    /** @return array<int,array> les parcours (domaines) couverts par ce mentor */
    public static function domainsForMentor(int $mentorId): array
    {
        $stmt = Database::connection()->prepare(
            'SELECT t.* FROM mentor_domains md
             INNER JOIN tracks t ON t.id = md.track_id
             WHERE md.mentor_id = ? ORDER BY t.title ASC'
        );
        $stmt->execute([$mentorId]);
        return $stmt->fetchAll();
    }

    /** @return int[] ids des parcours couverts, pour pré-cocher un formulaire */
    public static function trackIdsForMentor(int $mentorId): array
    {
        $stmt = Database::connection()->prepare('SELECT track_id FROM mentor_domains WHERE mentor_id = ?');
        $stmt->execute([$mentorId]);
        return array_map('intval', $stmt->fetchAll(PDO::FETCH_COLUMN));
    }

    /** Remplace les domaines d'un mentor par la liste donnée. */
    public static function setForMentor(int $mentorId, array $trackIds): void
    {
        $pdo = Database::connection();
        $pdo->prepare('DELETE FROM mentor_domains WHERE mentor_id = ?')->execute([$mentorId]);

        $stmt = $pdo->prepare('INSERT INTO mentor_domains (mentor_id, track_id) VALUES (?, ?)');
        foreach ($trackIds as $trackId) {
            $stmt->execute([$mentorId, (int) $trackId]);
        }
    }

    /** @return array<int,array> mentors actifs groupés par domaine, pour l'annuaire */
    public static function directory(): array
    {
        $mentors = User::mentors();
        $byTrack = [];

        foreach ($mentors as $mentor) {
            $domains = self::domainsForMentor((int) $mentor['id']);
            foreach ($domains as $track) {
                $byTrack[$track['id']]['track'] = $track;
                $byTrack[$track['id']]['mentors'][] = $mentor;
            }
        }

        return $byTrack;
    }
}
