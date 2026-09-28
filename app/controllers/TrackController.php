<?php
declare(strict_types=1);

class TrackController
{
    public function index(): void
    {
        Auth::requireLogin();
        $tracks = Track::published();
        $userId = Auth::id();
        foreach ($tracks as &$track) {
            $track['enrolled'] = Track::isEnrolled($userId, (int) $track['id']);
        }
        unset($track);

        View::render('tracks/index', ['tracks' => $tracks]);
    }

    public function show(string $slug): void
    {
        Auth::requireLogin();
        $track = Track::findBySlug($slug);
        if (!$track || !$track['is_published']) {
            http_response_code(404);
            View::render('errors/404');
            return;
        }

        $userId = Auth::id();
        $enrolled = Track::isEnrolled($userId, (int) $track['id']);
        $modules = Track::modulesWithLessons((int) $track['id']);
        $statuses = $enrolled ? Progress::statusesForTrack($userId, (int) $track['id']) : [];
        $progress = $enrolled ? Track::progressPercent($userId, (int) $track['id']) : 0;

        View::render('tracks/show', [
            'track' => $track,
            'modules' => $modules,
            'enrolled' => $enrolled,
            'statuses' => $statuses,
            'progress' => $progress,
        ]);
    }

    public function enroll(string $slug): void
    {
        Auth::requireLogin();
        if (!Request::checkCsrf()) {
            Router::redirect("tracks/{$slug}");
            return;
        }

        $track = Track::findBySlug($slug);
        if ($track) {
            Track::enroll(Auth::id(), (int) $track['id']);
        }

        Router::redirect("tracks/{$slug}");
    }
}
