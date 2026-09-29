<div class="container">
  <div class="breadcrumb">
    <a href="<?= Router::url('tracks/' . $lesson['track_slug']) ?>"><?= View::e($lesson['track_title']) ?></a>
    / <?= View::e($lesson['module_title']) ?>
  </div>

  <div class="lesson-layout">
    <div class="lesson-content">
      <h1><?= View::e($lesson['title']) ?></h1>

      <?php if (!empty($lesson['video_url'])): ?>
        <p><a href="<?= View::e($lesson['video_url']) ?>" target="_blank" rel="noopener" class="btn btn-outline btn-sm">▶ Voir la vidéo complémentaire</a></p>
      <?php endif; ?>

      <?= View::markdown((string) $lesson['content']) ?>

      <div class="lesson-actions">
        <?php if ($status !== 'completed'): ?>
          <button class="btn btn-primary" data-complete-lesson="<?= (int) $lesson['id'] ?>">Marquer comme terminé</button>
        <?php else: ?>
          <span class="badge badge-blue" style="padding:10px 16px;">✓ Leçon terminée</span>
        <?php endif; ?>

        <?php if ($quiz): ?>
          <a class="btn btn-accent" href="<?= Router::url('quiz/' . $quiz['id']) ?>">Faire le quiz de validation</a>
        <?php endif; ?>

        <?php if ($next): ?>
          <a class="btn btn-outline" data-next-lesson href="<?= Router::url('lessons/' . $next['id']) ?>">Leçon suivante →</a>
        <?php endif; ?>
      </div>
    </div>

    <div class="lesson-side">
      <div class="card">
        <h3 style="font-size:1rem;">Besoin d'aide ?</h3>
        <p style="color:var(--muted);font-size:.9rem;">Le mentor IA peut t'expliquer cette leçon autrement ou te proposer un exercice.</p>
        <?php if (Auth::hasMentorAccess()): ?>
        <form method="post" action="<?= Router::url('chat/new') ?>">
          <?= Auth::csrfField() ?>
          <input type="hidden" name="track_id" value="<?= (int) $lesson['track_id'] ?>">
          <button class="btn btn-accent btn-block" type="submit">Demander au mentor</button>
        </form>
        <?php else: ?>
        <a class="btn btn-accent btn-block" href="<?= Router::url('subscribe') ?>">Débloquer le mentor (2000 FCFA/mois)</a>
        <?php endif; ?>
      </div>
    </div>
  </div>
</div>
