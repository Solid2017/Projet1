<div class="container">
  <div class="page-header">
    <h1>Abonnement Mentor IA</h1>
    <p>Un accompagnement personnalisé et illimité (dans la limite raisonnable) pour progresser plus vite.</p>
  </div>

  <?php if ($error): ?><div class="alert alert-error" style="max-width:480px;"><?= View::e($error) ?></div><?php endif; ?>

  <?php if ($subscription && $subscription['status'] === 'active' && strtotime($subscription['expires_at']) > time()): ?>
    <div class="card" style="max-width:480px;">
      <span class="badge badge-blue">Abonnement actif</span>
      <h3 style="margin-top:10px;">Ton accès au mentor est actif</h3>
      <p style="color:var(--muted);">Valable jusqu'au <?= View::e(date('d/m/Y', strtotime($subscription['expires_at']))) ?>.</p>
      <a class="btn btn-accent btn-block" href="<?= Router::url('chat') ?>">Discuter avec le mentor</a>
    </div>
  <?php endif; ?>

  <div class="card" style="max-width:480px;">
    <h3>Formule mensuelle — <?= (int) $amount ?> FCFA / mois</h3>
    <ul style="color:var(--muted);margin:12px 0 18px;padding-left:18px;line-height:1.8;">
      <li>Mentor IA disponible sur tous tes parcours</li>
      <li>Explications personnalisées, exercices, corrections</li>
      <li>Résiliable à tout moment — simplement ne pas renouveler</li>
    </ul>

    <form method="post" action="<?= Router::url('subscribe/pay') ?>">
      <?= Auth::csrfField() ?>
      <div class="field">
        <label for="phone">Numéro Mobile Money (Airtel Money ou Moov Money)</label>
        <input type="tel" id="phone" name="phone" placeholder="ex: 66 12 34 56" required>
        <div class="hint">Tu choisiras Airtel Money ou Moov Money sur la page de paiement suivante.</div>
      </div>
      <button class="btn btn-accent btn-block" type="submit">Payer <?= (int) $amount ?> FCFA et débloquer le mentor</button>
    </form>
  </div>
</div>
