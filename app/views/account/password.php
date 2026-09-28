<div class="container">
  <div class="page-header">
    <h1>Modifier mon mot de passe</h1>
    <p>Connecté en tant que <?= View::e($user['name']) ?> (<?= View::e($user['email']) ?>)</p>
  </div>

  <div class="card" style="max-width:480px;">
    <?php if ($error): ?><div class="alert alert-error"><?= View::e($error) ?></div><?php endif; ?>
    <?php if ($success): ?><div class="alert alert-success"><?= View::e($success) ?></div><?php endif; ?>

    <form method="post" action="<?= Router::url('account/password') ?>">
      <?= Auth::csrfField() ?>
      <div class="field">
        <label for="current_password">Mot de passe actuel</label>
        <input type="password" id="current_password" name="current_password" required autofocus>
      </div>
      <div class="field">
        <label for="new_password">Nouveau mot de passe</label>
        <input type="password" id="new_password" name="new_password" required minlength="8">
        <div class="hint">8 caractères minimum.</div>
      </div>
      <div class="field">
        <label for="new_password_confirm">Confirmer le nouveau mot de passe</label>
        <input type="password" id="new_password_confirm" name="new_password_confirm" required minlength="8">
      </div>
      <button class="btn btn-primary btn-block" type="submit">Mettre à jour le mot de passe</button>
    </form>
  </div>
</div>
