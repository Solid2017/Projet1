<?php
declare(strict_types=1);

class DashboardController
{
    public function index(): void
    {
        Auth::requireLogin();
        $userId = Auth::id();

        $enrolled = Track::enrolledForUser($userId);
        foreach ($enrolled as &$track) {
            $track['progress'] = Track::progressPercent($userId, (int) $track['id']);
        }
        unset($track);

        $availableTracks = array_filter(Track::published(), function ($t) use ($enrolled) {
            foreach ($enrolled as $e) {
                if ($e['id'] === $t['id']) {
                    return false;
                }
            }
            return true;
        });

        View::render('dashboard/index', [
            'enrolled' => $enrolled,
            'available' => $availableTracks,
        ]);
    }
}
