<nav class="admin-nav">
  <a href="<?= Router::url('admin') ?>" class="<?= $current === 'dashboard' ? 'active' : '' ?>">Vue d'ensemble</a>
  <a href="<?= Router::url('admin/tracks') ?>" class="<?= $current === 'tracks' ? 'active' : '' ?>">Parcours</a>
  <a href="<?= Router::url('admin/users') ?>" class="<?= $current === 'users' ? 'active' : '' ?>">Utilisateurs</a>
  <a href="<?= Router::url('admin/subscriptions') ?>" class="<?= $current === 'subscriptions' ? 'active' : '' ?>">Abonnements</a>
  <a href="<?= Router::url('admin/emails') ?>" class="<?= $current === 'emails' ? 'active' : '' ?>">E-mails</a>
</nav>
