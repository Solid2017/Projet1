<div class="container">
  <div class="page-header"><h1>Utilisateurs</h1></div>

  <div class="admin-layout">
    <?php View::partial('admin/_nav', ['current' => 'users']); ?>

    <div>
      <p style="margin-bottom:12px;">
        <a class="btn btn-outline btn-sm" href="<?= Router::url('admin/users/whatsapp.csv') ?>">Exporter les numéros WhatsApp (CSV)</a>
      </p>
      <table class="data-table">
        <thead><tr><th>Nom</th><th>E-mail</th><th>WhatsApp</th><th>Rôle</th><th>Statut</th><th>Inscrit le</th><th></th></tr></thead>
        <tbody>
        <?php foreach ($users as $u): ?>
          <tr>
            <td><?= View::e($u['name']) ?></td>
            <td><?= View::e($u['email']) ?></td>
            <td><?= View::e($u['whatsapp_number'] ?? '—') ?></td>
            <td>
              <span class="badge <?= $u['role'] === 'admin' ? 'badge-red' : ($u['role'] === 'mentor' ? 'badge-blue' : 'badge-muted') ?>"><?= View::e(ucfirst($u['role'])) ?></span>
              <?php if ($u['role'] === 'mentor'): ?>
              <a href="<?= Router::url('admin/users/' . $u['id'] . '/mentor') ?>" style="font-size:.8rem;">Domaines</a>
              <?php endif; ?>
            </td>
            <td><?= $u['is_active'] ? '<span class="badge badge-blue">Actif</span>' : '<span class="badge badge-muted">Désactivé</span>' ?></td>
            <td><?= View::e(date('d/m/Y', strtotime($u['created_at']))) ?></td>
            <td style="text-align:right;white-space:nowrap;">
              <form class="inline-form" method="post" action="<?= Router::url('admin/users/' . $u['id'] . '/role') ?>">
                <?= Auth::csrfField() ?>
                <select name="role" onchange="this.form.submit()" style="padding:4px 8px;border-radius:6px;border:1px solid var(--border);">
                  <option value="student" <?= $u['role'] === 'student' ? 'selected' : '' ?>>Étudiant</option>
                  <option value="mentor" <?= $u['role'] === 'mentor' ? 'selected' : '' ?>>Mentor</option>
                  <option value="admin" <?= $u['role'] === 'admin' ? 'selected' : '' ?>>Admin</option>
                </select>
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
