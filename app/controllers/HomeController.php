<?php
declare(strict_types=1);

class HomeController
{
    public function index(): void
    {
        if (Auth::check()) {
            Router::redirect('dashboard');
            return;
        }

        View::render('home/index', ['tracks' => Track::published()]);
    }
}
