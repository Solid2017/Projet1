<?php
declare(strict_types=1);

class AdminController
{
    public function __construct()
    {
        Auth::requireAdmin();
    }

    public function dashboard(): void
    {
        $pdo = Database::connection();
        $stats = [
            'users' => (int) $pdo->query('SELECT COUNT(*) FROM users')->fetchColumn(),
            'tracks' => (int) $pdo->query('SELECT COUNT(*) FROM tracks')->fetchColumn(),
            'lessons' => (int) $pdo->query('SELECT COUNT(*) FROM lessons')->fetchColumn(),
            'enrollments' => (int) $pdo->query('SELECT COUNT(*) FROM enrollments')->fetchColumn(),
            'conversations' => (int) $pdo->query('SELECT COUNT(*) FROM conversations')->fetchColumn(),
        ];

        View::render('admin/dashboard', ['stats' => $stats]);
    }

    // -------------------------------------------------------------
    // Parcours
    // -------------------------------------------------------------
    public function tracks(): void
    {
        View::render('admin/tracks', ['tracks' => Track::all()]);
    }

    public function trackNew(): void
    {
        View::render('admin/track_edit', ['track' => null]);
    }

    public function trackEdit(string $id): void
    {
        $track = Track::find((int) $id);
        if (!$track) {
            Router::redirect('admin/tracks');
            return;
        }
        View::render('admin/track_edit', ['track' => $track]);
    }

    public function trackStore(): void
    {
        if (!Request::checkCsrf()) {
            Router::redirect('admin/tracks');
            return;
        }
        $data = $this->trackData();
        $id = Track::create($data);
        Router::redirect("admin/tracks/{$id}");
    }

    public function trackUpdate(string $id): void
    {
        if (!Request::checkCsrf()) {
            Router::redirect('admin/tracks');
            return;
        }
        Track::update((int) $id, $this->trackData());
        Router::redirect("admin/tracks/{$id}");
    }

    public function trackDelete(string $id): void
    {
        if (Request::checkCsrf()) {
            Track::delete((int) $id);
        }
        Router::redirect('admin/tracks');
    }

    private function trackData(): array
    {
        $title = Request::input('title', '');
        return [
            'title' => $title,
            'slug' => Request::input('slug') ?: AdminController::slugify($title),
            'subtitle' => Request::input('subtitle', ''),
            'description' => Request::input('description', ''),
            'icon' => Request::input('icon', 'code'),
            'color' => in_array(Request::input('color'), ['red', 'blue'], true) ? Request::input('color') : 'blue',
            'level' => Request::input('level', 'debutant'),
            'mentor_persona' => Request::input('mentor_persona', ''),
            'is_published' => Request::input('is_published') ? 1 : 0,
            'position' => (int) Request::input('position', 0),
        ];
    }

    // -------------------------------------------------------------
    // Parcours : détail (gestion des modules + leçons)
    // -------------------------------------------------------------
    public function trackShow(string $id): void
    {
        $track = Track::find((int) $id);
        if (!$track) {
            Router::redirect('admin/tracks');
            return;
        }
        $modules = Track::modulesWithLessons((int) $id);
        View::render('admin/track_show', ['track' => $track, 'modules' => $modules]);
    }

    // -------------------------------------------------------------
    // Modules
    // -------------------------------------------------------------
    public function moduleStore(string $trackId): void
    {
        if (Request::checkCsrf()) {
            Module::create(
                (int) $trackId,
                Request::input('title', 'Nouveau module'),
                (string) Request::input('description', ''),
                (int) Request::input('position', 0)
            );
        }
        Router::redirect("admin/tracks/{$trackId}");
    }

    public function moduleUpdate(string $id): void
    {
        $module = Module::find((int) $id);
        if ($module && Request::checkCsrf()) {
            Module::update(
                (int) $id,
                Request::input('title', $module['title']),
                (string) Request::input('description', ''),
                (int) Request::input('position', $module['position'])
            );
        }
        Router::redirect('admin/tracks/' . ($module['track_id'] ?? ''));
    }

    public function moduleDelete(string $id): void
    {
        $module = Module::find((int) $id);
        if ($module && Request::checkCsrf()) {
            Module::delete((int) $id);
        }
        Router::redirect('admin/tracks/' . ($module['track_id'] ?? ''));
    }

    // -------------------------------------------------------------
    // Leçons
    // -------------------------------------------------------------
    public function lessonNew(string $moduleId): void
    {
        $module = Module::find((int) $moduleId);
        if (!$module) {
            Router::redirect('admin/tracks');
            return;
        }
        View::render('admin/lesson_edit', ['lesson' => null, 'module' => $module]);
    }

    public function lessonEdit(string $id): void
    {
        $lesson = Lesson::find((int) $id);
        if (!$lesson) {
            Router::redirect('admin/tracks');
            return;
        }
        $module = Module::find((int) $lesson['module_id']);
        View::render('admin/lesson_edit', ['lesson' => $lesson, 'module' => $module]);
    }

    public function lessonStore(string $moduleId): void
    {
        $module = Module::find((int) $moduleId);
        if ($module && Request::checkCsrf()) {
            Lesson::create(array_merge($this->lessonData(), ['module_id' => (int) $moduleId]));
        }
        Router::redirect('admin/tracks/' . ($module['track_id'] ?? ''));
    }

    public function lessonUpdate(string $id): void
    {
        $lesson = Lesson::find((int) $id);
        if ($lesson && Request::checkCsrf()) {
            Lesson::update((int) $id, $this->lessonData());
        }
        $module = $lesson ? Module::find((int) $lesson['module_id']) : null;
        Router::redirect('admin/tracks/' . ($module['track_id'] ?? ''));
    }

    public function lessonDelete(string $id): void
    {
        $lesson = Lesson::find((int) $id);
        $module = $lesson ? Module::find((int) $lesson['module_id']) : null;
        if ($lesson && Request::checkCsrf()) {
            Lesson::delete((int) $id);
        }
        Router::redirect('admin/tracks/' . ($module['track_id'] ?? ''));
    }

    private function lessonData(): array
    {
        return [
            'title' => Request::input('title', 'Nouvelle leçon'),
            'summary' => Request::input('summary', ''),
            'content' => Request::input('content', ''),
            'video_url' => Request::input('video_url', ''),
            'duration_minutes' => (int) Request::input('duration_minutes', 15),
            'position' => (int) Request::input('position', 0),
        ];
    }

    // -------------------------------------------------------------
    // Utilisateurs
    // -------------------------------------------------------------
    public function users(): void
    {
        View::render('admin/users', ['users' => User::all()]);
    }

    public function userRole(string $id): void
    {
        if (Request::checkCsrf()) {
            $role = Request::input('role') === 'admin' ? 'admin' : 'student';
            User::setRole((int) $id, $role);
        }
        Router::redirect('admin/users');
    }

    public function userToggle(string $id): void
    {
        if (Request::checkCsrf()) {
            $user = User::find((int) $id);
            if ($user) {
                User::setActive((int) $id, !$user['is_active']);
            }
        }
        Router::redirect('admin/users');
    }

    public static function slugify(string $text): string
    {
        $text = iconv('UTF-8', 'ASCII//TRANSLIT', $text) ?: $text;
        $text = strtolower($text);
        $text = preg_replace('/[^a-z0-9]+/', '-', $text);
        return trim($text ?? '', '-') ?: 'parcours-' . substr(md5((string) mt_rand()), 0, 6);
    }
}
