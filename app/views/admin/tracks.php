<div class="container">
  <div class="toolbar">
    <div><h1 style="margin:0;">Parcours</h1></div>
    <a class="btn btn-primary" href="<?= Router::url('admin/tracks/new') ?>">+ Nouveau parcours</a>
  </div>

  <div class="admin-layout">
    <?php View::partial('admin/_nav', ['current' => 'tracks']); ?>

    <div>
      <table class="data-table">
        <thead><tr><th>Titre</th><th>Niveau</th><th>Publié</th><th></th></tr></thead>
        <tbody>
        <?php foreach ($tracks as $t): ?>
          <tr>
            <td><a href="<?= Router::url('admin/tracks/' . $t['id']) ?>"><?= View::e($t['title']) ?></a></td>
            <td><span class="badge badge-<?= $t['color'] ?>"><?= View::e(ucfirst($t['level'])) ?></span></td>
            <td><?= $t['is_published'] ? '✓' : '—' ?></td>
            <td style="text-align:right;">
              <a class="btn btn-sm btn-outline" href="<?= Router::url('admin/tracks/' . $t['id'] . '/edit') ?>">Modifier</a>
              <form class="inline-form" method="post" action="<?= Router::url('admin/tracks/' . $t['id'] . '/delete') ?>" onsubmit="return confirm('Supprimer ce parcours et tout son contenu ?');">
                <?= Auth::csrfField() ?>
                <button class="btn btn-sm btn-ghost" type="submit">Supprimer</button>
              </form>
            </td>
          </tr>
        <?php endforeach; ?>
        </tbody>
      </table>
    </div>
  </div>
</div>
