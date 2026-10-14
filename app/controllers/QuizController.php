<?php
declare(strict_types=1);

class QuizController
{
    public function show(string $id): void
    {
        Auth::requireLogin();
        $quiz = Quiz::find((int) $id);
        if (!$quiz) {
            http_response_code(404);
            View::render('errors/404');
            return;
        }

        $lesson = Lesson::findWithContext((int) $quiz['lesson_id']);
        if (!$lesson || !Track::isEnrolled(Auth::id(), (int) $lesson['track_id'])) {
            Router::redirect('dashboard');
            return;
        }

        $questions = Quiz::questionsWithOptions((int) $quiz['id']);

        View::render('quiz/show', [
            'quiz' => $quiz,
            'lesson' => $lesson,
            'questions' => $questions,
        ]);
    }

    public function submit(string $id): void
    {
        Auth::requireLogin();

        if (!Request::checkCsrf()) {
            View::json(['ok' => false, 'error' => 'Jeton CSRF invalide.'], 419);
            return;
        }

        $quiz = Quiz::find((int) $id);
        if (!$quiz) {
            View::json(['ok' => false, 'error' => 'Quiz introuvable.'], 404);
            return;
        }

        $lesson = Lesson::findWithContext((int) $quiz['lesson_id']);
        $userId = Auth::id();
        if (!$lesson || !Track::isEnrolled($userId, (int) $lesson['track_id'])) {
            View::json(['ok' => false, 'error' => 'Accès refusé.'], 403);
            return;
        }

        $rawAnswers = Request::input('answers', []);
        if (!is_array($rawAnswers)) {
            $rawAnswers = [];
        }
        $answers = [];
        foreach ($rawAnswers as $questionId => $optionId) {
            $answers[(int) $questionId] = (int) $optionId;
        }

        $result = Quiz::grade((int) $quiz['id'], $answers);
        Quiz::recordAttempt($userId, (int) $quiz['id'], $result['score_percent'], $result['passed']);

        if ($result['passed']) {
            Progress::markCompleted($userId, (int) $lesson['id']);
        }

        View::json(['ok' => true] + $result);
    }
}
