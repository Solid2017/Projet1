<div class="auth-shell">
  <div class="auth-card">
    <div class="brand"><img src="<?= Router::url('assets/img/logo.png') ?>" alt="" style="width:36px;height:36px;object-fit:contain;"><span><b>Igo</b><i>Tech</i> IA</span></div>
    <h1>Nouveau mot de passe</h1>

    <?php if ($error): ?>
      <div class="alert alert-error"><?= View::e($error) ?></div>
      <p class="auth-switch"><a href="<?= Router::url('forgot-password') ?>">Redemander un lien</a></p>
    <?php else: ?>
    <form method="post" action="<?= Router::url('reset-password/' . $token) ?>">
      <?= Auth::csrfField() ?>
      <div class="field">
        <label for="password">Nouveau mot de passe</label>
        <input type="password" id="password" name="password" required minlength="8" autofocus>
        <div class="hint">8 caractères minimum.</div>
      </div>
      <div class="field">
        <label for="password_confirm">Confirmer le nouveau mot de passe</label>
        <input type="password" id="password_confirm" name="password_confirm" required minlength="8">
      </div>
      <button class="btn btn-primary btn-block" type="submit">Réinitialiser le mot de passe</button>
    </form>
    <?php endif; ?>
  </div>
</div>
