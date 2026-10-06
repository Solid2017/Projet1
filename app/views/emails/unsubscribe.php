<?php
$query = '?u=' . (int) $userId . '&t=' . urlencode($token);
?>
<div class="auth-shell">
  <div class="card" style="max-width:520px;width:100%;text-align:center;">
    <?php if ($state === 'invalid'): ?>
      <h1 style="font-size:1.5rem;margin-bottom:10px;">Lien invalide</h1>
      <p style="color:var(--muted);">Ce lien de désinscription n'est pas valide ou a été modifié. Utilise le lien présent en bas de l'un de nos e-mails.</p>

    <?php elseif ($state === 'confirm'): ?>
      <h1 style="font-size:1.5rem;margin-bottom:10px;">Ne plus recevoir nos e-mails ?</h1>
      <p style="color:var(--muted);margin-bottom:22px;">
        Tu ne recevras plus les rappels et conseils d'IgoTech IA à l'adresse <strong><?= View::e($email) ?></strong>.
      </p>
      <form method="post" action="<?= Router::url('email/unsubscribe') . $query ?>">
        <button class="btn btn-primary btn-block" type="submit">Confirmer la désinscription</button>
      </form>

    <?php elseif ($state === 'done'): ?>
      <h1 style="font-size:1.5rem;margin-bottom:10px;">C'est noté</h1>
      <p style="color:var(--muted);margin-bottom:22px;">
        Tu ne recevras plus nos e-mails de suivi à l'adresse <strong><?= View::e($email) ?></strong>. Ton compte et ta progression restent intacts.
      </p>
      <form method="post" action="<?= Router::url('email/resubscribe') . $query ?>">
        <button class="btn btn-ghost btn-block" type="submit">Je me suis trompé, me réabonner</button>
      </form>

    <?php else: ?>
      <h1 style="font-size:1.5rem;margin-bottom:10px;">Ravi de te revoir !</h1>
      <p style="color:var(--muted);margin-bottom:22px;">Tu recevras de nouveau nos conseils et rappels à l'adresse <strong><?= View::e($email) ?></strong>.</p>
      <a class="btn btn-primary btn-block" href="<?= Router::url('dashboard') ?>">Aller sur IgoTech IA</a>
    <?php endif; ?>
  </div>
</div>
