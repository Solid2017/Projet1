<div class="auth-shell">
  <div class="auth-card">
    <div class="brand"><img src="<?= Router::url('assets/img/logo.png') ?>" alt="" style="width:36px;height:36px;object-fit:contain;"><span><b>Igo</b><i>Tech</i> IA</span></div>
    <h1>Mot de passe oublié</h1>
    <p class="subtitle">Indique ton e-mail, on t'envoie un lien pour le réinitialiser.</p>

    <?php if ($error): ?><div class="alert alert-error"><?= View::e($error) ?></div><?php endif; ?>

    <?php if ($sent): ?>
      <div class="alert alert-success">Si un compte existe avec cet e-mail, un lien de réinitialisation vient de t'être envoyé (valable 1 heure). Pense à vérifier tes spams.</div>
      <p class="auth-switch"><a href="<?= Router::url('login') ?>">Retour à la connexion</a></p>
    <?php else: ?>
    <form method="post" action="<?= Router::url('forgot-password') ?>">
      <?= Auth::csrfField() ?>
      <div class="field">
        <label for="email">Adresse e-mail</label>
        <input type="email" id="email" name="email" required autofocus>
      </div>
      <button class="btn btn-primary btn-block" type="submit">Envoyer le lien de réinitialisation</button>
    </form>
    <p class="auth-switch"><a href="<?= Router::url('login') ?>">Retour à la connexion</a></p>
    <?php endif; ?>
  </div>
</div>
