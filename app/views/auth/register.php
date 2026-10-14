<div class="auth-shell">
  <div class="auth-card">
    <div class="brand"><img src="<?= Router::url('assets/img/logo.png') ?>" alt="" style="width:36px;height:36px;object-fit:contain;"><span><b>Igo</b><i>Tech</i> IA</span></div>
    <h1>Créer un compte</h1>
    <p class="subtitle">Rejoins IgoTech IA et démarre ton parcours accompagné par un mentor IA.</p>

    <?php if ($error): ?><div class="alert alert-error"><?= View::e($error) ?></div><?php endif; ?>
    <?php if (!empty($refCode)): ?><div class="alert alert-success">Tu as été invité·e par un parrain — vous recevrez tous les deux <?= Referral::REWARD_DAYS ?> jours offerts dès ton premier abonnement.</div><?php endif; ?>

    <form method="post" action="<?= Router::url('register') ?>">
      <?= Auth::csrfField() ?>
      <?php if (!empty($refCode)): ?><input type="hidden" name="ref_code" value="<?= View::e($refCode) ?>"><?php endif; ?>
      <div class="field">
        <label for="name">Nom complet</label>
        <input type="text" id="name" name="name" required autofocus value="<?= View::e($_POST['name'] ?? '') ?>">
      </div>
      <div class="field">
        <label for="email">Adresse e-mail</label>
        <input type="email" id="email" name="email" required value="<?= View::e($_POST['email'] ?? '') ?>">
      </div>
      <div class="field">
        <label for="whatsapp">Numéro WhatsApp</label>
        <input type="tel" id="whatsapp" name="whatsapp" required placeholder="ex: 66 12 34 56" value="<?= View::e($_POST['whatsapp'] ?? '') ?>">
        <div class="hint">Sert à t'ajouter au groupe WhatsApp des apprenants IgoTech IA.</div>
      </div>
      <div class="field">
        <label for="headline">Objectif (optionnel)</label>
        <input type="text" id="headline" name="headline" placeholder="Ex : devenir développeur web" value="<?= View::e($_POST['headline'] ?? '') ?>">
      </div>
      <div class="field">
        <label for="password">Mot de passe</label>
        <input type="password" id="password" name="password" required minlength="8">
        <div class="hint">8 caractères minimum.</div>
      </div>
      <button class="btn btn-primary btn-block" type="submit">Créer mon compte</button>
    </form>

    <p class="auth-switch">Déjà inscrit ? <a href="<?= Router::url('login') ?>">Connecte-toi</a></p>
  </div>
</div>
