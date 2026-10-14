<div class="container">
  <div class="breadcrumb"><a href="<?= Router::url('admin/tracks') ?>">← Parcours</a></div>
  <div class="toolbar">
    <div><h1 style="margin:0;"><?= View::e($track['title']) ?></h1></div>
    <a class="btn btn-outline btn-sm" href="<?= Router::url('admin/tracks/' . $track['id'] . '/edit') ?>">Modifier les infos du parcours</a>
  </div>

  <?php foreach ($modules as $i => $module): ?>
  <div class="module-block">
    <h3>
      <span>Module <?= $i + 1 ?> — <?= View::e($module['title']) ?></span>
      <span>
        <a class="btn btn-sm btn-outline" href="<?= Router::url('admin/modules/' . $module['id'] . '/lessons/new') ?>">+ Leçon</a>
        <form class="inline-form" method="post" action="<?= Router::url('admin/modules/' . $module['id'] . '/delete') ?>" onsubmit="return confirm('Supprimer ce module et ses leçons ?');">
          <?= Auth::csrfField() ?>
          <button class="btn btn-sm btn-ghost" type="submit">Supprimer</button>
        </form>
      </span>
    </h3>

    <details style="margin-bottom:10px;">
      <summary style="cursor:pointer;color:var(--muted);font-size:.85rem;">Modifier ce module</summary>
      <form method="post" action="<?= Router::url('admin/modules/' . $module['id']) ?>" style="margin-top:10px;">
        <?= Auth::csrfField() ?>
        <div class="field"><input type="text" name="title" value="<?= View::e($module['title']) ?>" required></div>
        <div class="field"><textarea name="description"><?= View::e($module['description'] ?? '') ?></textarea></div>
        <div class="field"><input type="number" name="position" value="<?= (int) $module['position'] ?>"></div>
        <button class="btn btn-sm btn-primary" type="submit">Enregistrer</button>
      </form>
    </details>

    <?php foreach ($module['lessons'] as $lesson): ?>
    <div class="lesson-row">
      <span><?= View::e($lesson['title']) ?> <span style="color:var(--muted);font-size:.8rem;">(<?= (int) $lesson['duration_minutes'] ?> min)</span></span>
      <span>
        <a class="btn btn-sm btn-outline" href="<?= Router::url('admin/lessons/' . $lesson['id'] . '/edit') ?>">Modifier</a>
        <form class="inline-form" method="post" action="<?= Router::url('admin/lessons/' . $lesson['id'] . '/delete') ?>" onsubmit="return confirm('Supprimer cette leçon ?');">
          <?= Auth::csrfField() ?>
          <button class="btn btn-sm btn-ghost" type="submit">Supprimer</button>
        </form>
      </span>
    </div>
    <?php endforeach; ?>
  </div>
  <?php endforeach; ?>

  <div class="card">
    <h3 style="margin-top:0;">+ Ajouter un module</h3>
    <form method="post" action="<?= Router::url('admin/tracks/' . $track['id'] . '/modules') ?>">
      <?= Auth::csrfField() ?>
      <div class="grid grid-2">
        <div class="field"><input type="text" name="title" placeholder="Titre du module" required></div>
        <div class="field"><input type="number" name="position" placeholder="Position" value="<?= count($modules) + 1 ?>"></div>
      </div>
      <div class="field"><textarea name="description" placeholder="Description (optionnel)"></textarea></div>
      <button class="btn btn-primary" type="submit">Ajouter le module</button>
    </form>
  </div>
</div>
