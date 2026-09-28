<div class="container">
  <div class="page-header">
    <h1>Parcours de formation</h1>
    <p>Choisis un parcours et progresse à ton rythme, guidé par ton mentor IA.</p>
  </div>

  <div class="grid grid-2">
    <?php foreach ($tracks as $t): ?>
    <div class="track-card">
      <div class="track-icon <?= $t['color'] ?>"><?= View::e(mb_strtoupper(mb_substr($t['title'], 0, 1))) ?></div>
      <h3><?= View::e($t['title']) ?></h3>
      <p style="color:var(--muted);"><?= View::e($t['subtitle']) ?></p>
      <span class="badge badge-<?= $t['color'] ?>"><?= View::e(ucfirst($t['level'])) ?></span>
      <a class="btn <?= $t['enrolled'] ? 'btn-primary' : 'btn-outline' ?>" href="<?= Router::url('tracks/' . $t['slug']) ?>">
        <?= $t['enrolled'] ? 'Continuer' : 'Découvrir' ?>
      </a>
    </div>
    <?php endforeach; ?>
  </div>
</div>
