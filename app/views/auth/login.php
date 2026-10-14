<div class="auth-shell">
  <div class="auth-card">
    <div class="brand"><img src="<?= Router::url('assets/img/logo.png') ?>" alt="" style="width:36px;height:36px;object-fit:contain;"><span><b>Igo</b><i>Tech</i> IA</span></div>
    <h1>Connexion</h1>
    <p class="subtitle">Retrouve ton mentor IA et continue ta formation.</p>

    <?php if ($error): ?><div class="alert alert-error"><?= View::e($error) ?></div><?php endif; ?>

    <form method="post" action="<?= Router::url('login') ?>">
      <?= Auth::csrfField() ?>
      <div class="field">
        <label for="email">Adresse e-mail</label>
        <input type="email" id="email" name="email" required autofocus>
      </div>
      <div class="field">
        <label for="password">Mot de passe</label>
        <input type="password" id="password" name="password" required>
        <div class="hint" style="text-align:right;"><a href="<?= Router::url('forgot-password') ?>">Mot de passe oublié ?</a></div>
      </div>
      <button class="btn btn-primary btn-block" type="submit">Se connecter</button>
    </form>

    <p class="auth-switch">Pas encore de compte ? <a href="<?= Router::url('register') ?>">Inscris-toi</a></p>
  </div>
</div>
