<div class="container">
  <div class="breadcrumb"><a href="<?= Router::url('tracks') ?>">Parcours</a> / <?= View::e($track['title']) ?></div>

  <div class="page-header" style="display:flex;justify-content:space-between;align-items:flex-start;gap:20px;flex-wrap:wrap;">
    <div>
      <span class="badge badge-<?= $track['color'] ?>"><?= View::e(ucfirst($track['level'])) ?></span>
      <h1><?= View::e($track['title']) ?></h1>
      <p><?= View::e($track['subtitle']) ?></p>
    </div>
    <div style="min-width:220px;">
      <?php if ($enrolled): ?>
        <div class="progress"><span style="width: <?= (int) $progress ?>%"></span></div>
        <div class="progress-label"><?= (int) $progress ?>% complété</div>
        <?php if ($certificate): ?>
        <a class="btn btn-primary btn-block" style="margin-top:12px;" href="<?= Router::url('certificate/' . $certificate['code']) ?>">🎓 Voir et partager mon certificat</a>
        <?php endif; ?>
        <?php if (Auth::canUseMentor()): ?>
        <form method="post" action="<?= Router::url('chat/new') ?>" style="margin-top:12px;">
          <?= Auth::csrfField() ?>
          <input type="hidden" name="track_id" value="<?= (int) $track['id'] ?>">
          <button class="btn btn-accent btn-block" type="submit">Discuter avec le mentor de ce parcours</button>
        </form>
        <?php if (!Auth::hasMentorAccess()): ?>
        <p style="text-align:center;font-size:.8rem;color:var(--muted);margin-top:6px;"><?= (int) Auth::freeTrialRemaining() ?> message(s) d'essai gratuit restant(s)</p>
        <?php endif; ?>
        <?php else: ?>
        <a class="btn btn-accent btn-block" style="margin-top:12px;" href="<?= Router::url('subscribe') ?>">Débloquer le mentor (2000 FCFA/mois)</a>
        <?php endif; ?>
      <?php else: ?>
        <form method="post" action="<?= Router::url('tracks/' . $track['slug'] . '/enroll') ?>">
          <?= Auth::csrfField() ?>
          <button class="btn btn-primary btn-block" type="submit">S'inscrire à ce parcours</button>
        </form>
      <?php endif; ?>
    </div>
  </div>

  <?php if ($track['description']): ?><div class="card"><?= View::e($track['description']) ?></div><?php endif; ?>

  <div class="section-title"><span class="dot"></span> Programme</div>

  <?php foreach ($modules as $i => $module): ?>
  <div class="card">
    <h3>Module <?= $i + 1 ?> — <?= View::e($module['title']) ?></h3>
    <?php if ($module['description']): ?><p style="color:var(--muted);"><?= View::e($module['description']) ?></p><?php endif; ?>
    <?php foreach ($module['lessons'] as $lesson): $status = $statuses[$lesson['id']] ?? 'not_started'; ?>
    <div class="lesson-row">
      <div>
        <?php if ($status === 'completed'): ?><span class="badge badge-blue">✓ Terminé</span>
        <?php elseif ($status === 'in_progress'): ?><span class="badge badge-red">En cours</span>
        <?php else: ?><span class="badge badge-muted">À faire</span><?php endif; ?>
        <strong style="margin-left:8px;"><?= View::e($lesson['title']) ?></strong>
        <span style="color:var(--muted);font-size:.85rem;"> — <?= (int) $lesson['duration_minutes'] ?> min</span>
      </div>
      <?php if ($enrolled): ?>
        <a class="btn btn-sm btn-outline" href="<?= Router::url('lessons/' . $lesson['id']) ?>">Ouvrir</a>
      <?php endif; ?>
    </div>
    <?php endforeach; ?>
  </div>
  <?php endforeach; ?>
</div>
