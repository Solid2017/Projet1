<div class="container">
  <div class="page-header"><h1>Utilisateurs</h1></div>

  <div class="admin-layout">
    <?php View::partial('admin/_nav', ['current' => 'users']); ?>

    <div>
      <table class="data-table">
        <thead><tr><th>Nom</th><th>E-mail</th><th>Rôle</th><th>Statut</th><th>Inscrit le</th><th></th></tr></thead>
        <tbody>
        <?php foreach ($users as $u): ?>
          <tr>
            <td><?= View::e($u['name']) ?></td>
            <td><?= View::e($u['email']) ?></td>
            <td><span class="badge <?= $u['role'] === 'admin' ? 'badge-red' : 'badge-blue' ?>"><?= View::e(ucfirst($u['role'])) ?></span></td>
            <td><?= $u['is_active'] ? '<span class="badge badge-blue">Actif</span>' : '<span class="badge badge-muted">Désactivé</span>' ?></td>
            <td><?= View::e(date('d/m/Y', strtotime($u['created_at']))) ?></td>
            <td style="text-align:right;white-space:nowrap;">
              <form class="inline-form" method="post" action="<?= Router::url('admin/users/' . $u['id'] . '/role') ?>">
                <?= Auth::csrfField() ?>
                <input type="hidden" name="role" value="<?= $u['role'] === 'admin' ? 'student' : 'admin' ?>">
                <button class="btn btn-sm btn-outline" type="submit"><?= $u['role'] === 'admin' ? 'Rétrograder' : 'Promouvoir admin' ?></button>
              </form>
              <form class="inline-form" method="post" action="<?= Router::url('admin/users/' . $u['id'] . '/toggle') ?>">
                <?= Auth::csrfField() ?>
                <button class="btn btn-sm btn-ghost" type="submit"><?= $u['is_active'] ? 'Désactiver' : 'Réactiver' ?></button>
              </form>
            </td>
          </tr>
        <?php endforeach; ?>
        </tbody>
      </table>
    </div>
  </div>
</div>
