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
    // E-mails de fidélisation
    // -------------------------------------------------------------
    public function emails(): void
    {
        $pdo = Database::connection();
        $counts = [];
        foreach ($pdo->query(
            "SELECT email_key, SUM(status = 'sent') AS sent, SUM(status = 'failed') AS failed
             FROM email_log WHERE sent_at >= NOW() - INTERVAL 30 DAY GROUP BY email_key"
        ) as $row) {
            $counts[$row['email_key']] = $row;
        }
        $lastRunFile = APP_ROOT . '/storage/cron_emails_last_run.txt';

        View::render('admin/emails', [
            'rules' => RetentionMailer::RULES,
            'counts' => $counts,
            'recent' => $pdo->query(
                'SELECT el.email_key, el.status, el.attempts, el.sent_at, u.name, u.email
                 FROM email_log el JOIN users u ON u.id = el.user_id ORDER BY el.sent_at DESC LIMIT 50'
            )->fetchAll(),
            'optOuts' => (int) $pdo->query('SELECT COUNT(*) FROM users WHERE email_opt_out = 1')->fetchColumn(),
            'lastRun' => is_file($lastRunFile) ? trim((string) file_get_contents($lastRunFile)) : null,
            'cronPath' => APP_ROOT . '/cron/emails.php',
        ]);
    }

    /** Aperçu d'un modèle d'e-mail, rempli avec des données d'exemple et le compte de l'admin. */
    public function emailPreview(string $key): void
    {
        if (!isset(RetentionMailer::RULES[$key])) {
            http_response_code(404);
            echo 'Modèle inconnu.';
            return;
        }
        $mail = RetentionMailer::preview($key, Auth::user());
        echo $mail['html'];
    }

    // -------------------------------------------------------------
    // Abonnements / revenus
    // -------------------------------------------------------------
    public function subscriptions(): void
    {
        View::render('admin/subscriptions', [
            'activeCount' => Subscription::activeCount(),
            'revenueThisMonth' => Payment::revenueThisMonth(),
            'payments' => Payment::recent(30),
        ]);
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

    /** Export CSV des numéros WhatsApp, pour ajout manuel au groupe des apprenants. */
    public function usersWhatsappCsv(): void
    {
        header('Content-Type: text/csv; charset=utf-8');
        header('Content-Disposition: attachment; filename="igotech-whatsapp.csv"');

        $out = fopen('php://output', 'w');
        fputcsv($out, ['Nom', 'E-mail', 'WhatsApp', 'Rôle'], ',', '"', '\\');
        foreach (User::all() as $u) {
            fputcsv($out, [$u['name'], $u['email'], $u['whatsapp_number'] ?? '', $u['role']], ',', '"', '\\');
        }
        fclose($out);
    }

    public function userRole(string $id): void
    {
        if (Request::checkCsrf()) {
            User::setRole((int) $id, (string) Request::input('role', 'student'));
        }
        Router::redirect('admin/users');
    }

    // -------------------------------------------------------------
    // Mentors physiques (rôle "mentor") : bio, contact, domaines
    // -------------------------------------------------------------
    public function mentorEdit(string $id): void
    {
        $mentor = User::find((int) $id);
        if (!$mentor || $mentor['role'] !== 'mentor') {
            Router::redirect('admin/users');
            return;
        }

        View::render('admin/mentor_edit', [
            'mentor' => $mentor,
            'tracks' => Track::all(),
            'selectedTrackIds' => MentorDomain::trackIdsForMentor((int) $id),
        ]);
    }

    public function mentorUpdate(string $id): void
    {
        $mentor = User::find((int) $id);
        if ($mentor && $mentor['role'] === 'mentor' && Request::checkCsrf()) {
            User::updateMentorProfile(
                (int) $id,
                (string) Request::input('mentor_bio', ''),
                (string) Request::input('whatsapp_number', '')
            );
            $trackIds = array_map('intval', (array) Request::input('track_ids', []));
            MentorDomain::setForMentor((int) $id, $trackIds);
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
