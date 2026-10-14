<?php
declare(strict_types=1);

/**
 * E-mails automatiques de fidélisation, lancés chaque heure par cron/emails.php.
 *
 * Chaque règle repère une situation (inscrit depuis 1 jour sans question au
 * mentor, abonnement qui expire dans 3 jours…). email_log garantit qu'un même
 * e-mail n'est jamais envoyé deux fois à la même personne, et un délai minimum
 * entre deux e-mails évite de saturer la boîte des apprenants.
 */
class RetentionMailer
{
    private const MAX_ATTEMPTS = 3;
    private const ACTIVE_USER = 'u.is_active = 1 AND u.email_opt_out = 0';
    private const USER_COLS = 'u.id AS user_id, u.name, u.email, u.referral_code';

    /**
     * Ordre = priorité : si plusieurs e-mails concernent la même personne,
     * seul le premier part pendant ce passage. 'bypassGap' = ignore le délai
     * minimum (rappels liés à l'abonnement, qui ne peuvent pas attendre).
     */
    public const RULES = [
        'sub_expiring'      => ['label' => 'Abonnement qui expire dans 3 jours', 'bypassGap' => true],
        'trial_almost_over' => ['label' => 'Essai gratuit presque épuisé'],
        'certificate'       => ['label' => 'Certificat obtenu'],
        'module_done'       => ['label' => 'Module terminé'],
        'first_question'    => ['label' => 'J+1 : aucune question au mentor IA'],
        'first_lesson'      => ['label' => 'J+3 : aucune leçon commencée'],
        'inactive_7d'       => ['label' => '7 jours sans connexion'],
        'winback'           => ['label' => 'Abonnement expiré depuis 7 jours'],
        'weekly_digest'     => ['label' => 'Résumé de la semaine (lundi)'],
    ];

    /**
     * @return array{dry:bool, sent:int, failed:int, byKey:array<string,int>, lines:string[]}
     */
    public static function run(bool $dryRun = false, ?int $limit = null): array
    {
        $cfg = APP_CONFIG['retention'] ?? [];
        $limit = $limit ?? (int) ($cfg['max_per_run'] ?? 100);
        $gapHours = (int) ($cfg['min_gap_hours'] ?? 48);
        $report = ['dry' => $dryRun, 'sent' => 0, 'failed' => 0, 'byKey' => [], 'lines' => []];

        if (array_key_exists('enabled', $cfg) && !$cfg['enabled']) {
            $report['lines'][] = "E-mails de fidélisation désactivés (retention.enabled = false dans config.php).";
            return $report;
        }

        $handled = [];
        $failuresInARow = 0;

        foreach (self::RULES as $key => $rule) {
            if ($key === 'weekly_digest' && !self::isDigestTime($cfg)) {
                continue;
            }
            foreach (self::candidates($key) as $row) {
                if ($report['sent'] + $report['failed'] >= $limit) {
                    $report['lines'][] = "Limite de {$limit} e-mails atteinte pour ce passage, la suite partira à la prochaine exécution.";
                    break 2;
                }
                $userId = (int) $row['user_id'];
                $ref = (string) ($row['ref_key'] ?? '');
                if (isset($handled[$userId]) || self::alreadyDone($userId, $key, $ref)) {
                    continue;
                }
                if (empty($rule['bypassGap']) && self::sentRecently($userId, $gapHours)) {
                    continue;
                }
                $handled[$userId] = true;
                $mail = self::build($key, $row);

                if ($dryRun) {
                    $report['sent']++;
                    $report['byKey'][$key] = ($report['byKey'][$key] ?? 0) + 1;
                    $report['lines'][] = "[test] {$key} → {$row['email']} : {$mail['subject']}";
                    continue;
                }

                $result = MailService::send((string) $row['email'], (string) $row['name'], $mail['subject'], $mail['html'], self::unsubscribeHeaders($userId));
                self::log($userId, $key, $ref, $result['ok']);
                if ($result['ok']) {
                    $failuresInARow = 0;
                    $report['sent']++;
                    $report['byKey'][$key] = ($report['byKey'][$key] ?? 0) + 1;
                    $report['lines'][] = "{$key} → {$row['email']}";
                } else {
                    $report['failed']++;
                    $report['lines'][] = "ÉCHEC {$key} → {$row['email']} : " . ($result['error'] ?? '');
                    if (++$failuresInARow >= 3) {
                        $report['lines'][] = "3 échecs d'envoi de suite : le serveur SMTP semble indisponible, arrêt de ce passage.";
                        break 2;
                    }
                }
            }
        }

        return $report;
    }

    /** E-mail d'exemple pour l'aperçu dans l'administration (données fictives). */
    public static function preview(string $key, array $user): array
    {
        $row = [
            'user_id' => (int) $user['id'], 'name' => (string) $user['name'], 'email' => (string) $user['email'],
            'referral_code' => (string) ($user['referral_code'] ?? 'EXEMPLE'), 'ref_key' => 'apercu',
            'expires_at' => date('Y-m-d H:i:s', strtotime('+3 days')), 'used' => Auth::FREE_TRIAL_MESSAGES - 1,
            'code' => 'EXEMPLE', 'track_title' => 'Développement Web Full-Stack', 'track_slug' => 'developpement-web',
            'module_title' => 'Les bases du web', 'module_id' => 0, 'track_id' => 0, 'module_position' => 0,
            'lessons_week' => 3, 'messages_week' => 7,
        ];
        return self::build($key, $row);
    }

    // -----------------------------------------------------------------
    // Ciblage
    // -----------------------------------------------------------------

    /** @return array<int, array<string, mixed>> */
    private static function candidates(string $key): array
    {
        $a = self::ACTIVE_USER;
        $c = self::USER_COLS;
        $lastSub = 'NOT EXISTS (SELECT 1 FROM subscriptions s2 WHERE s2.user_id = s.user_id AND s2.expires_at > s.expires_at)';
        $userMessages = 'SELECT 1 FROM conversations c JOIN messages m ON m.conversation_id = c.id AND m.role = \'user\' WHERE c.user_id = u.id';

        [$sql, $params] = match ($key) {
            'sub_expiring' => ["SELECT {$c}, s.id AS ref_key, s.expires_at
                FROM subscriptions s JOIN users u ON u.id = s.user_id
                WHERE {$a} AND s.status = 'active' AND s.expires_at > NOW() AND s.expires_at <= NOW() + INTERVAL 3 DAY AND {$lastSub}", []],

            'trial_almost_over' => ["SELECT {$c}, '' AS ref_key, COUNT(m.id) AS used
                FROM users u JOIN conversations c ON c.user_id = u.id JOIN messages m ON m.conversation_id = c.id AND m.role = 'user'
                WHERE {$a} AND u.role = 'student' AND NOT EXISTS (SELECT 1 FROM subscriptions s WHERE s.user_id = u.id)
                GROUP BY u.id, u.name, u.email, u.referral_code
                HAVING COUNT(m.id) >= ?", [Auth::FREE_TRIAL_MESSAGES - 1]],

            'certificate' => ["SELECT {$c}, ce.id AS ref_key, ce.code, t.title AS track_title
                FROM certificates ce JOIN users u ON u.id = ce.user_id JOIN tracks t ON t.id = ce.track_id
                WHERE {$a} AND ce.issued_at >= NOW() - INTERVAL 3 DAY", []],

            'module_done' => ["SELECT {$c}, mo.id AS ref_key, mo.id AS module_id, mo.title AS module_title, mo.track_id, mo.position AS module_position,
                    t.title AS track_title, t.slug AS track_slug
                FROM lesson_progress lp
                JOIN lessons l ON l.id = lp.lesson_id
                JOIN modules mo ON mo.id = l.module_id
                JOIN tracks t ON t.id = mo.track_id
                JOIN users u ON u.id = lp.user_id
                WHERE {$a} AND lp.status = 'completed'
                GROUP BY u.id, u.name, u.email, u.referral_code, mo.id, mo.title, mo.track_id, mo.position, t.title, t.slug
                HAVING COUNT(DISTINCT l.id) = (SELECT COUNT(*) FROM lessons l2 WHERE l2.module_id = mo.id)
                   AND MAX(lp.completed_at) >= NOW() - INTERVAL 3 DAY", []],

            'first_question' => ["SELECT {$c}, '' AS ref_key FROM users u
                WHERE {$a} AND u.role = 'student'
                  AND u.created_at <= NOW() - INTERVAL 1 DAY AND u.created_at > NOW() - INTERVAL 4 DAY
                  AND NOT EXISTS ({$userMessages})", []],

            'first_lesson' => ["SELECT {$c}, '' AS ref_key FROM users u
                WHERE {$a} AND u.role = 'student'
                  AND u.created_at <= NOW() - INTERVAL 3 DAY AND u.created_at > NOW() - INTERVAL 8 DAY
                  AND NOT EXISTS (SELECT 1 FROM lesson_progress lp WHERE lp.user_id = u.id AND lp.status IN ('in_progress', 'completed'))", []],

            'inactive_7d' => ["SELECT {$c}, DATE(u.last_login_at) AS ref_key FROM users u
                WHERE {$a} AND u.role = 'student'
                  AND u.last_login_at <= NOW() - INTERVAL 7 DAY AND u.last_login_at > NOW() - INTERVAL 30 DAY", []],

            'winback' => ["SELECT {$c}, s.id AS ref_key, s.expires_at
                FROM subscriptions s JOIN users u ON u.id = s.user_id
                WHERE {$a} AND s.expires_at <= NOW() - INTERVAL 7 DAY AND s.expires_at > NOW() - INTERVAL 14 DAY AND {$lastSub}", []],

            'weekly_digest' => ["SELECT {$c}, ? AS ref_key,
                    (SELECT COUNT(*) FROM lesson_progress lp WHERE lp.user_id = u.id AND lp.status = 'completed' AND lp.completed_at >= NOW() - INTERVAL 7 DAY) AS lessons_week,
                    (SELECT COUNT(*) FROM conversations c JOIN messages m ON m.conversation_id = c.id
                       WHERE c.user_id = u.id AND m.role = 'user' AND m.created_at >= NOW() - INTERVAL 7 DAY) AS messages_week
                FROM users u
                WHERE {$a} AND u.role = 'student' AND u.last_login_at >= NOW() - INTERVAL 30 DAY
                HAVING lessons_week + messages_week > 0", [date('o-\WW')]],
        };

        $stmt = Database::connection()->prepare($sql);
        $stmt->execute($params);
        return $stmt->fetchAll();
    }

    private static function isDigestTime(array $cfg): bool
    {
        return ($cfg['weekly_digest'] ?? true) && date('N') === '1' && (int) date('G') >= 8;
    }

    private static function alreadyDone(int $userId, string $key, string $ref): bool
    {
        $stmt = Database::connection()->prepare(
            "SELECT 1 FROM email_log WHERE user_id = ? AND email_key = ? AND ref_key = ? AND (status = 'sent' OR attempts >= ?)"
        );
        $stmt->execute([$userId, $key, $ref, self::MAX_ATTEMPTS]);
        return (bool) $stmt->fetchColumn();
    }

    private static function sentRecently(int $userId, int $hours): bool
    {
        $stmt = Database::connection()->prepare(
            "SELECT 1 FROM email_log WHERE user_id = ? AND status = 'sent' AND sent_at > NOW() - INTERVAL ? HOUR LIMIT 1"
        );
        $stmt->execute([$userId, $hours]);
        return (bool) $stmt->fetchColumn();
    }

    private static function log(int $userId, string $key, string $ref, bool $ok): void
    {
        $stmt = Database::connection()->prepare(
            'INSERT INTO email_log (user_id, email_key, ref_key, status) VALUES (?, ?, ?, ?)
             ON DUPLICATE KEY UPDATE status = VALUES(status), attempts = attempts + 1, sent_at = NOW()'
        );
        $stmt->execute([$userId, $key, $ref, $ok ? 'sent' : 'failed']);
    }

    // -----------------------------------------------------------------
    // Contenu des e-mails
    // -----------------------------------------------------------------

    /** @return array{subject:string, html:string} */
    private static function build(string $key, array $row): array
    {
        $e = static fn ($v): string => htmlspecialchars((string) $v, ENT_QUOTES, 'UTF-8');
        $first = $e(self::firstName((string) $row['name']));
        $userId = (int) $row['user_id'];
        $monthly = number_format((int) (APP_CONFIG['payment']['amount_fcfa'] ?? 2000), 0, ',', ' ');
        $annual = number_format((int) (APP_CONFIG['payment']['amount_fcfa_annual'] ?? 20000), 0, ',', ' ');
        $priceLine = "{$monthly} FCFA par mois, ou {$annual} FCFA par an (2 mois offerts), payables avec Airtel Money ou Moov Money.";
        $referralLine = !empty($row['referral_code'])
            ? 'Invite un ami avec ton lien de parrainage : dès son premier abonnement, vous recevez chacun ' . Referral::REWARD_DAYS
              . ' jours de mentor IA offerts. <a href="' . $e(self::url('register') . '?ref=' . urlencode((string) $row['referral_code'])) . '" style="color:#1111EE;">Ton lien de parrainage</a>'
            : null;

        switch ($key) {
            case 'sub_expiring':
                $date = self::frenchDate((string) $row['expires_at']);
                $subject = "Ton abonnement IgoTech IA se termine le {$date}";
                $o = [
                    'preheader' => 'Renouvelle avec Airtel Money ou Moov Money pour garder ton mentor.',
                    'title' => "{$first}, ton accès au mentor IA se termine le {$e($date)}",
                    'paragraphs' => [
                        'Pour garder ton rythme, tes conversations et l’accès illimité à ton mentor IA, pense à renouveler avant cette date.',
                        $e($priceLine),
                    ],
                    'cta_label' => 'Renouveler mon abonnement', 'cta_url' => self::url('subscribe'),
                ];
                break;

            case 'trial_almost_over':
                $left = max(0, Auth::FREE_TRIAL_MESSAGES - (int) $row['used']);
                $subject = $left > 0 ? 'Plus qu’un message gratuit avec ton mentor IA' : 'Tes ' . Auth::FREE_TRIAL_MESSAGES . ' messages gratuits sont utilisés';
                $o = [
                    'preheader' => 'Continue sans limite avec ton mentor IA.',
                    'title' => $left > 0 ? "{$first}, il te reste un message gratuit" : "{$first}, ton essai gratuit est terminé",
                    'paragraphs' => [
                        'Tu as déjà posé ' . (int) $row['used'] . ' questions à ton mentor IA. Avec l’abonnement, tu continues sans limite, à toute heure, sur tous les parcours.',
                        $e($priceLine),
                    ],
                    'cta_label' => 'Continuer avec mon mentor IA', 'cta_url' => self::url('subscribe'),
                ];
                break;

            case 'certificate':
                $subject = 'Bravo ' . self::firstName((string) $row['name']) . ', ton certificat est prêt';
                $o = [
                    'preheader' => 'Partage-le sur LinkedIn ou WhatsApp.',
                    'title' => "Félicitations {$first} !",
                    'paragraphs' => [
                        'Tu as terminé le parcours <strong>' . $e($row['track_title']) . '</strong>. Ton certificat est prêt : partage-le sur LinkedIn ou WhatsApp pour montrer ce que tu sais faire.',
                    ],
                    'cta_label' => 'Voir et partager mon certificat', 'cta_url' => self::url('certificate/' . rawurlencode((string) $row['code'])),
                    'after' => array_filter([$referralLine]),
                ];
                break;

            case 'module_done':
                $next = self::nextModuleLesson((int) $row['track_id'], (int) $row['module_position'], (int) $row['module_id']);
                $subject = 'Module terminé : ' . $row['module_title'];
                $o = [
                    'preheader' => 'Une étape de plus vers ton objectif.',
                    'title' => "Bien joué {$first}, module terminé !",
                    'paragraphs' => [
                        'Tu as terminé le module <strong>' . $e($row['module_title']) . '</strong> du parcours ' . $e($row['track_title']) . '.',
                        $next ? 'La suite t’attend : <strong>' . $e($next['title']) . '</strong>.' : 'Continue sur ta lancée avec la suite de ton parcours.',
                    ],
                    'cta_label' => $next ? 'Commencer la suite' : 'Voir mon parcours',
                    'cta_url' => $next ? self::url('lessons/' . (int) $next['id']) : self::url('tracks/' . rawurlencode((string) $row['track_slug'])),
                    'after' => array_filter([$referralLine]),
                ];
                break;

            case 'first_question':
                $subject = 'Ta première question au mentor IA ?';
                $o = [
                    'preheader' => 'Il te répond en quelques secondes, à toute heure.',
                    'title' => "{$first}, ton mentor IA t’attend",
                    'paragraphs' => [
                        'Pose-lui n’importe quelle question sur les métiers de l’informatique. Par exemple :',
                        '« Par où commencer pour devenir développeur web ? »<br>« Quelles compétences recherchent les banques au Tchad ? »<br>« Comment préparer un entretien en cybersécurité ? »',
                        'Tes ' . Auth::FREE_TRIAL_MESSAGES . ' premiers messages sont gratuits.',
                    ],
                    'cta_label' => 'Poser ma question', 'cta_url' => self::url('chat'),
                ];
                break;

            case 'first_lesson':
                $lesson = self::firstLessonOfEnrolledTrack($userId);
                $subject = $lesson ? 'Ta première leçon t’attend' : 'Choisis ton parcours sur IgoTech IA';
                $o = [
                    'preheader' => 'Quelques minutes suffisent pour démarrer.',
                    'title' => $lesson ? "{$first}, ton parcours t’attend" : "{$first}, quel métier de l’IT te fait envie ?",
                    'paragraphs' => $lesson
                        ? ['Ta première leçon du parcours <strong>' . $e($lesson['track_title']) . '</strong> : « ' . $e($lesson['title']) . ' ». Elle prend environ ' . (int) $lesson['duration_minutes'] . ' minutes.']
                        : ['Choisis parmi ' . self::trackCount() . ' parcours métiers : développement web, cybersécurité, data, Mobile Money, informatique bancaire… et avance leçon par leçon, avec ton mentor IA à tes côtés.'],
                    'cta_label' => $lesson ? 'Commencer la leçon' : 'Choisir mon parcours',
                    'cta_url' => $lesson ? self::url('lessons/' . (int) $lesson['id']) : self::url('tracks'),
                ];
                break;

            case 'inactive_7d':
                $lesson = self::resumeLesson($userId) ?? self::firstLessonOfEnrolledTrack($userId);
                $subject = $lesson ? 'Reprends là où tu t’étais arrêté' : 'Ton mentor IA est toujours là';
                $o = [
                    'preheader' => 'Ta progression est sauvegardée.',
                    'title' => "{$first}, on te garde ta place",
                    'paragraphs' => $lesson
                        ? ['Tu en étais au parcours <strong>' . $e($lesson['track_title']) . '</strong>. Prochaine étape : « ' . $e($lesson['title']) . ' ».', 'Un quart d’heure aujourd’hui, et tu gardes le rythme.']
                        : ['Ça fait une semaine qu’on ne t’a pas vu. Ton mentor IA est disponible à toute heure pour répondre à tes questions sur ta future carrière.'],
                    'cta_label' => $lesson ? 'Reprendre où j’en étais' : 'Revenir sur IgoTech IA',
                    'cta_url' => $lesson ? self::url('lessons/' . (int) $lesson['id']) : self::url('dashboard'),
                ];
                break;

            case 'winback':
                $date = self::frenchDate((string) $row['expires_at']);
                $subject = 'Ta progression t’attend sur IgoTech IA';
                $o = [
                    'preheader' => 'Tout est sauvegardé : leçons, certificats, conversations.',
                    'title' => "{$first}, tout est encore là",
                    'paragraphs' => [
                        'Ton abonnement s’est terminé le ' . $e($date) . ', mais rien n’est perdu : tes leçons, tes certificats et tes conversations avec le mentor IA sont sauvegardés.',
                        $e($priceLine),
                    ],
                    'cta_label' => 'Réactiver mon mentor IA', 'cta_url' => self::url('subscribe'),
                ];
                break;

            case 'weekly_digest':
            default:
                $lesson = self::resumeLesson($userId);
                $subject = 'Ta semaine sur IgoTech IA';
                $o = [
                    'preheader' => 'Ton bilan et ta prochaine étape.',
                    'title' => "{$first}, voici ta semaine",
                    'paragraphs' => array_filter([
                        'Bravo pour ta régularité, c’est elle qui fait la différence.',
                        $lesson ? 'Prochaine étape : « ' . $e($lesson['title']) . ' ».' : null,
                    ]),
                    'stats' => [
                        [(string) (int) $row['lessons_week'], (int) $row['lessons_week'] > 1 ? 'leçons terminées' : 'leçon terminée'],
                        [(string) (int) $row['messages_week'], (int) $row['messages_week'] > 1 ? 'questions au mentor' : 'question au mentor'],
                    ],
                    'cta_label' => $lesson ? 'Commencer la prochaine leçon' : 'Continuer mon parcours',
                    'cta_url' => $lesson ? self::url('lessons/' . (int) $lesson['id']) : self::url('dashboard'),
                ];
                break;
        }

        $o['unsubscribe_url'] = self::unsubscribeUrl($userId);
        return ['subject' => $subject, 'html' => EmailTemplate::render($o)];
    }

    // -----------------------------------------------------------------
    // Leçons à proposer
    // -----------------------------------------------------------------

    /** Dernière leçon en cours, sinon la suivante non terminée dans le même parcours. */
    private static function resumeLesson(int $userId): ?array
    {
        $pdo = Database::connection();
        $stmt = $pdo->prepare(
            "SELECT lp.status, l.id, l.title, l.position, mo.id AS module_id, mo.position AS module_position, mo.track_id, t.title AS track_title
             FROM lesson_progress lp JOIN lessons l ON l.id = lp.lesson_id JOIN modules mo ON mo.id = l.module_id JOIN tracks t ON t.id = mo.track_id
             WHERE lp.user_id = ? AND lp.status IN ('in_progress', 'completed')
             ORDER BY COALESCE(lp.completed_at, lp.started_at) DESC, lp.id DESC LIMIT 1"
        );
        $stmt->execute([$userId]);
        $last = $stmt->fetch();
        if (!$last) {
            return null;
        }
        if ($last['status'] === 'in_progress') {
            return $last;
        }
        $stmt = $pdo->prepare(
            "SELECT l.id, l.title, t.title AS track_title
             FROM lessons l JOIN modules mo ON mo.id = l.module_id JOIN tracks t ON t.id = mo.track_id
             WHERE mo.track_id = ? AND (mo.position, mo.id, l.position, l.id) > (?, ?, ?, ?)
               AND NOT EXISTS (SELECT 1 FROM lesson_progress p WHERE p.user_id = ? AND p.lesson_id = l.id AND p.status = 'completed')
             ORDER BY mo.position, mo.id, l.position, l.id LIMIT 1"
        );
        $stmt->execute([$last['track_id'], $last['module_position'], $last['module_id'], $last['position'], $last['id'], $userId]);
        return $stmt->fetch() ?: null;
    }

    private static function firstLessonOfEnrolledTrack(int $userId): ?array
    {
        $stmt = Database::connection()->prepare(
            "SELECT l.id, l.title, l.duration_minutes, t.title AS track_title
             FROM enrollments en JOIN tracks t ON t.id = en.track_id JOIN modules mo ON mo.track_id = t.id JOIN lessons l ON l.module_id = mo.id
             WHERE en.user_id = ? AND en.status = 'active'
             ORDER BY en.enrolled_at DESC, mo.position, mo.id, l.position, l.id LIMIT 1"
        );
        $stmt->execute([$userId]);
        return $stmt->fetch() ?: null;
    }

    private static function nextModuleLesson(int $trackId, int $modulePosition, int $moduleId): ?array
    {
        $stmt = Database::connection()->prepare(
            'SELECT l.id, l.title FROM modules mo JOIN lessons l ON l.module_id = mo.id
             WHERE mo.track_id = ? AND (mo.position, mo.id) > (?, ?)
             ORDER BY mo.position, mo.id, l.position, l.id LIMIT 1'
        );
        $stmt->execute([$trackId, $modulePosition, $moduleId]);
        return $stmt->fetch() ?: null;
    }

    private static function trackCount(): int
    {
        return (int) Database::connection()->query('SELECT COUNT(*) FROM tracks WHERE is_published = 1')->fetchColumn();
    }

    // -----------------------------------------------------------------
    // Désinscription
    // -----------------------------------------------------------------

    public static function unsubscribeToken(int $userId): string
    {
        return substr(hash_hmac('sha256', 'unsubscribe|' . $userId, (string) APP_CONFIG['app']['secret_key']), 0, 32);
    }

    public static function checkToken(int $userId, string $token): bool
    {
        return $userId > 0 && hash_equals(self::unsubscribeToken($userId), $token);
    }

    public static function unsubscribeUrl(int $userId): string
    {
        return self::url('email/unsubscribe') . '?u=' . $userId . '&t=' . self::unsubscribeToken($userId);
    }

    /** En-têtes de désinscription en un clic (Gmail, Outlook…). @return string[] */
    private static function unsubscribeHeaders(int $userId): array
    {
        return [
            'List-Unsubscribe: <' . self::unsubscribeUrl($userId) . '>',
            'List-Unsubscribe-Post: List-Unsubscribe=One-Click',
        ];
    }

    // -----------------------------------------------------------------
    // Utilitaires
    // -----------------------------------------------------------------

    /** URL absolue : les e-mails sont lus hors du site, Router::url() ne suffit pas. */
    public static function url(string $path): string
    {
        return rtrim((string) APP_CONFIG['app']['url'], '/') . '/' . ltrim($path, '/');
    }

    private static function firstName(string $name): string
    {
        $parts = preg_split('/\s+/', trim($name));
        return $parts[0] !== '' ? $parts[0] : $name;
    }

    private static function frenchDate(string $datetime): string
    {
        $months = ['janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'];
        $ts = strtotime($datetime);
        return (int) date('j', $ts) . ' ' . $months[(int) date('n', $ts) - 1];
    }
}
