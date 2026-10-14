<div class="container">
  <div class="page-header"><h1>Paiement</h1></div>

  <?php if ($success): ?>
    <div class="card" style="max-width:480px;">
      <div class="alert alert-success">Paiement confirmé, merci !</div>
      <h3>Ton abonnement est actif</h3>
      <?php if ($subscription): ?>
        <p style="color:var(--muted);">Valable jusqu'au <?= View::e(date('d/m/Y', strtotime($subscription['expires_at']))) ?>.</p>
      <?php endif; ?>
      <a class="btn btn-accent btn-block" href="<?= Router::url('chat') ?>">Discuter avec le mentor</a>
    </div>
  <?php else: ?>
    <div class="card" style="max-width:480px;">
      <div class="alert alert-error">Le paiement n'a pas pu être confirmé (annulé, refusé, ou encore en cours de traitement côté opérateur).</div>
      <a class="btn btn-outline btn-block" href="<?= Router::url('subscribe') ?>">Réessayer</a>
    </div>
  <?php endif; ?>
</div>
