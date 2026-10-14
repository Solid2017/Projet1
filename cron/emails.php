<?php
/**
 * E-mails automatiques de fidélisation — à lancer toutes les heures.
 *
 * Ligne de commande (tâche cron LWSPanel) :
 *   php /chemin/vers/le/site/cron/emails.php
 *   php /chemin/vers/le/site/cron/emails.php --dry-run      (liste sans envoyer)
 *   php /chemin/vers/le/site/cron/emails.php --limit=20
 *
 * Par URL (si l'hébergement ne propose que des cron "URL") :
 *   https://votre-domaine.tld/cron/emails.php?key=VOTRE_CLE      (cron.key dans config.php)
 *   … &dry-run=1 pour tester sans envoyer
 */
declare(strict_types=1);

$isCli = PHP_SAPI === 'cli';
require dirname(__DIR__) . '/app/bootstrap.php';

if (!$isCli) {
    $expected = (string) (APP_CONFIG['cron']['key'] ?? '');
    if ($expected === '' || !hash_equals($expected, (string) ($_GET['key'] ?? ''))) {
        http_response_code(403);
        exit('Accès refusé.');
    }
    header('Content-Type: text/plain; charset=utf-8');
}

$args = $isCli ? array_slice($argv, 1) : [];
$dryRun = $isCli ? in_array('--dry-run', $args, true) : isset($_GET['dry-run']);
$limit = null;
foreach ($args as $arg) {
    if (str_starts_with($arg, '--limit=')) {
        $limit = max(1, (int) substr($arg, 8));
    }
}
if (!$isCli && isset($_GET['limit'])) {
    $limit = max(1, (int) $_GET['limit']);
}

// Verrou : empêche deux exécutions simultanées d'envoyer deux fois le même e-mail.
$lock = fopen(APP_ROOT . '/storage/cron_emails.lock', 'c');
if (!$lock || !flock($lock, LOCK_EX | LOCK_NB)) {
    echo "Une exécution est déjà en cours, rien à faire.\n";
    exit(0);
}

$started = microtime(true);
$report = RetentionMailer::run($dryRun, $limit);
$duration = round(microtime(true) - $started, 1);

foreach ($report['lines'] as $line) {
    echo $line . "\n";
}
$summary = sprintf(
    '[%s] E-mails de fidélisation%s : %d envoyé(s), %d échec(s) en %ss%s',
    date('Y-m-d H:i:s'),
    $dryRun ? ' (TEST, rien envoyé)' : '',
    $report['sent'],
    $report['failed'],
    $duration,
    $report['byKey'] ? ' — ' . http_build_query($report['byKey'], '', ', ') : ''
);
echo $summary . "\n";
if (!$dryRun) {
    @file_put_contents(APP_ROOT . '/storage/app.log', $summary . "\n", FILE_APPEND);
    @file_put_contents(APP_ROOT . '/storage/cron_emails_last_run.txt', date('Y-m-d H:i:s'));
}

flock($lock, LOCK_UN);
fclose($lock);
