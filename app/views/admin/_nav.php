<nav class="admin-nav">
  <a href="<?= Router::url('admin') ?>" class="<?= $current === 'dashboard' ? 'active' : '' ?>">Vue d'ensemble</a>
  <a href="<?= Router::url('admin/tracks') ?>" class="<?= $current === 'tracks' ? 'active' : '' ?>">Parcours</a>
  <a href="<?= Router::url('admin/users') ?>" class="<?= $current === 'users' ? 'active' : '' ?>">Utilisateurs</a>
</nav>
