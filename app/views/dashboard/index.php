<div class="container">
  <div class="page-header">
    <h1>Bonjour <?= View::e($user['name']) ?> 👋</h1>
    <p><?= View::e($user['headline'] ?: 'Continue ta progression ou lance une conversation avec ton mentor IA.') ?></p>
  </div>

  <?php if (empty($enrolled)): ?>
    <div class="card" style="text-align:center;">
      <h2>Tu n'es inscrit à aucun parcours pour le moment</h2>
      <p>Choisis un parcours ci-dessous pour commencer ta formation avec l'accompagnement de ton mentor IA.</p>
      <a class="btn btn-primary" href="<?= Router::url('tracks') ?>">Découvrir les parcours</a>
    </div>
  <?php else: ?>
    <div class="section-title"><span class="dot"></span> Mes parcours en cours</div>
    <div class="grid grid-2">
      <?php foreach ($enrolled as $t): ?>
      <div class="track-card">
        <div class="track-icon <?= $t['color'] ?>"><?= View::e(mb_strtoupper(mb_substr($t['title'], 0, 1))) ?></div>
        <h3><?= View::e($t['title']) ?></h3>
        <p style="color:var(--muted);font-size:.9rem;"><?= View::e($t['subtitle']) ?></p>
        <div class="progress"><span style="width: <?= (int) $t['progress'] ?>%"></span></div>
        <div class="progress-label"><?= (int) $t['progress'] ?>% complété</div>
        <a class="btn btn-primary" href="<?= Router::url('tracks/' . $t['slug']) ?>">Continuer</a>
      </div>
      <?php endforeach; ?>
    </div>
  <?php endif; ?>

  <?php if (!empty($available)): ?>
    <div class="section-title"><span class="dot"></span> Autres parcours disponibles</div>
    <div class="grid grid-3">
      <?php foreach ($available as $t): ?>
      <div class="track-card">
        <div class="track-icon <?= $t['color'] ?>"><?= View::e(mb_strtoupper(mb_substr($t['title'], 0, 1))) ?></div>
        <h3><?= View::e($t['title']) ?></h3>
        <p style="color:var(--muted);font-size:.9rem;"><?= View::e($t['subtitle']) ?></p>
        <span class="badge badge-<?= $t['color'] ?>"><?= View::e(ucfirst($t['level'])) ?></span>
        <a class="btn btn-outline" href="<?= Router::url('tracks/' . $t['slug']) ?>">Découvrir</a>
      </div>
      <?php endforeach; ?>
    </div>
  <?php endif; ?>

  <div class="section-title"><span class="dot"></span> Mentor IA</div>
  <div class="card">
    <p>Une question sur un concept, besoin d'un exercice ou d'un plan de révision ? Ton mentor IA est disponible 24/7.</p>
    <a class="btn btn-accent" href="<?= Router::url('chat') ?>">Ouvrir le chat avec le mentor</a>
  </div>
</div>
