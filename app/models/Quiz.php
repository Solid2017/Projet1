<?php
declare(strict_types=1);

class Quiz
{
    public static function findByLesson(int $lessonId): ?array
    {
        $stmt = Database::connection()->prepare('SELECT * FROM quizzes WHERE lesson_id = ? LIMIT 1');
        $stmt->execute([$lessonId]);
        return $stmt->fetch() ?: null;
    }

    public static function find(int $id): ?array
    {
        $stmt = Database::connection()->prepare('SELECT * FROM quizzes WHERE id = ? LIMIT 1');
        $stmt->execute([$id]);
        return $stmt->fetch() ?: null;
    }

    /** Questions avec leurs options (sans révéler la bonne réponse). */
    public static function questionsWithOptions(int $quizId): array
    {
        $pdo = Database::connection();

        $stmt = $pdo->prepare('SELECT id, question, position FROM quiz_questions WHERE quiz_id = ? ORDER BY position ASC');
        $stmt->execute([$quizId]);
        $questions = $stmt->fetchAll();

        if (!$questions) {
            return [];
        }

        $ids = array_column($questions, 'id');
        $placeholders = implode(',', array_fill(0, count($ids), '?'));
        $stmt = $pdo->prepare(
            "SELECT id, question_id, option_text, position FROM quiz_options WHERE question_id IN ($placeholders) ORDER BY position ASC"
        );
        $stmt->execute($ids);
        $options = $stmt->fetchAll();

        $byQuestion = [];
        foreach ($options as $opt) {
            $byQuestion[$opt['question_id']][] = $opt;
        }

        foreach ($questions as &$q) {
            $q['options'] = $byQuestion[$q['id']] ?? [];
        }

        return $questions;
    }

    /**
     * Corrige une soumission : $answers = [question_id => option_id].
     * Retourne ['score_percent' => int, 'passed' => bool, 'correct' => int, 'total' => int].
     */
    public static function grade(int $quizId, array $answers): array
    {
        $pdo = Database::connection();

        $stmt = $pdo->prepare('SELECT id FROM quiz_questions WHERE quiz_id = ?');
        $stmt->execute([$quizId]);
        $questionIds = array_column($stmt->fetchAll(), 'id');
        $total = count($questionIds);

        if ($total === 0) {
            return ['score_percent' => 0, 'passed' => false, 'correct' => 0, 'total' => 0];
        }

        $stmt = $pdo->prepare('SELECT id, question_id FROM quiz_options WHERE question_id IN (' . implode(',', array_fill(0, $total, '?')) . ') AND is_correct = 1');
        $stmt->execute($questionIds);
        $correctByQuestion = [];
        foreach ($stmt->fetchAll() as $row) {
            $correctByQuestion[(int) $row['question_id']] = (int) $row['id'];
        }

        $correct = 0;
        foreach ($questionIds as $qId) {
            $selected = isset($answers[$qId]) ? (int) $answers[$qId] : null;
            if ($selected !== null && $selected === ($correctByQuestion[$qId] ?? null)) {
                $correct++;
            }
        }

        $scorePercent = (int) round(($correct / $total) * 100);
        $quiz = self::find($quizId);
        $passed = $scorePercent >= (int) ($quiz['pass_score_percent'] ?? 60);

        return ['score_percent' => $scorePercent, 'passed' => $passed, 'correct' => $correct, 'total' => $total];
    }

    public static function recordAttempt(int $userId, int $quizId, int $scorePercent, bool $passed): void
    {
        $stmt = Database::connection()->prepare(
            'INSERT INTO quiz_attempts (user_id, quiz_id, score_percent, passed) VALUES (?, ?, ?, ?)'
        );
        $stmt->execute([$userId, $quizId, $scorePercent, $passed ? 1 : 0]);
    }
}
