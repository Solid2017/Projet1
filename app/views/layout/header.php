<!doctype html>
<html lang="fr">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>IgoTech IA — Mentor IA pour carrières informatiques</title>
<meta name="csrf-token" content="<?= View::e(Auth::csrfToken()) ?>">
<link rel="icon" type="image/png" href="<?= Router::url('assets/img/logo.png') ?>">
<link rel="stylesheet" href="<?= Router::url('assets/css/style.css') ?>">
</head>
<body>
<nav class="navbar">
  <div class="container">
    <a class="brand" href="<?= Router::url($user ? 'dashboard' : '') ?>">
      <img src="<?= Router::url('assets/img/logo.png') ?>" alt="" style="width:34px;height:34px;object-fit:contain;">
      <span><b>Igo</b><i>Tech</i> IA</span>
    </a>
    <?php if ($user): ?>
    <div class="nav-links">
      <a href="<?= Router::url('dashboard') ?>">Tableau de bord</a>
      <a href="<?= Router::url('tracks') ?>">Parcours</a>
      <a href="<?= Router::url('chat') ?>">Mentor IA</a>
      <a href="<?= Router::url('mentors') ?>">Trouver un mentor</a>
      <a href="<?= Router::url('parrainage') ?>">Parrainage</a>
      <?php if ($user['role'] === 'admin'): ?>
      <a href="<?= Router::url('admin') ?>">Administration</a>
      <?php endif; ?>
    </div>
    <div class="nav-right">
      <?= View::avatar($user, 32) ?>
      <span style="font-weight:600;font-size:.9rem;"><?= View::e($user['name']) ?></span>
      <a class="btn btn-ghost btn-sm" href="<?= Router::url('account/password') ?>">Mot de passe</a>
      <a class="btn btn-ghost btn-sm" href="<?= Router::url('logout') ?>">Déconnexion</a>
    </div>
    <?php else: ?>
    <div class="nav-right" style="margin-left:auto;">
      <a class="btn btn-outline btn-sm" href="<?= Router::url('login') ?>">Connexion</a>
      <a class="btn btn-primary btn-sm" href="<?= Router::url('register') ?>">Créer un compte</a>
    </div>
    <?php endif; ?>
  </div>
</nav>
