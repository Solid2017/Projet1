<?php
declare(strict_types=1);

class LessonController
{
    public function show(string $id): void
    {
        Auth::requireLogin();
        $lesson = Lesson::findWithContext((int) $id);
        if (!$lesson) {
            http_response_code(404);
            View::render('errors/404');
            return;
        }

        $userId = Auth::id();
        if (!Track::isEnrolled($userId, (int) $lesson['track_id'])) {
            Router::redirect("tracks/{$lesson['track_slug']}");
            return;
        }

        Progress::markStarted($userId, (int) $lesson['id']);

        $status = Progress::statusFor($userId, (int) $lesson['id']);
        $quiz = Quiz::findByLesson((int) $lesson['id']);
        $next = Lesson::next((int) $lesson['track_id'], (int) $lesson['id']);

        View::render('lessons/show', [
            'lesson' => $lesson,
            'status' => $status,
            'quiz' => $quiz,
            'next' => $next,
        ]);
    }

    public function complete(string $id): void
    {
        Auth::requireLogin();
        header('Content-Type: application/json; charset=utf-8');

        if (!Request::checkCsrf()) {
            View::json(['ok' => false, 'error' => 'Jeton CSRF invalide.'], 419);
            return;
        }

        $lesson = Lesson::findWithContext((int) $id);
        $userId = Auth::id();
        if (!$lesson || !Track::isEnrolled($userId, (int) $lesson['track_id'])) {
            View::json(['ok' => false, 'error' => 'Leçon introuvable.'], 404);
            return;
        }

        Progress::markCompleted($userId, (int) $lesson['id']);
        $progress = Track::progressPercent($userId, (int) $lesson['track_id']);

        View::json(['ok' => true, 'progress' => $progress]);
    }
}
