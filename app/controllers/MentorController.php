<?php
declare(strict_types=1);

class MentorController
{
    public function index(): void
    {
        Auth::requireLogin();
        View::render('mentors/index', [
            'byTrack' => MentorDomain::directory(),
        ]);
    }
}
