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
    <ul style="color:var(--muted);margin:0 0 18px;padding-left:18px;line-height:1.8;">
      <li>Mentor IA disponible sur tous tes parcours</li>
      <li>Explications personnalisées, exercices, corrections</li>
      <li>Résiliable à tout moment — simplement ne pas renouveler</li>
    </ul>

    <form method="post" action="<?= Router::url('subscribe/pay') ?>" id="subscribe-form">
      <?= Auth::csrfField() ?>

      <div class="field">
        <label style="display:flex;align-items:center;gap:8px;font-weight:400;cursor:pointer;">
          <input type="radio" name="plan" value="monthly" checked>
          Mensuel — <?= (int) $amount ?> FCFA / mois
        </label>
        <label style="display:flex;align-items:center;gap:8px;font-weight:400;cursor:pointer;margin-top:8px;">
          <input type="radio" name="plan" value="annual">
          Annuel — <?= (int) $amountAnnual ?> FCFA / an <span class="badge badge-red" style="margin-left:6px;">2 mois offerts</span>
        </label>
      </div>

      <div class="field">
        <label for="phone">Numéro Mobile Money (Airtel Money ou Moov Money)</label>
        <input type="tel" id="phone" name="phone" placeholder="ex: 66 12 34 56" required>
        <div class="hint">Tu choisiras Airtel Money ou Moov Money sur la page de paiement suivante.</div>
      </div>
      <button class="btn btn-accent btn-block" type="submit" id="subscribe-submit">Payer <?= (int) $amount ?> FCFA et débloquer le mentor</button>
    </form>
  </div>

  <div class="card" style="max-width:480px;">
    <h3 style="font-size:1rem;">Tu connais quelqu'un que ça intéresse ?</h3>
    <p style="color:var(--muted);font-size:.9rem;">Parraine un ami : vous recevez chacun des jours d'abonnement offerts dès son premier paiement.</p>
    <a class="btn btn-outline btn-block" href="<?= Router::url('parrainage') ?>">Mon lien de parrainage</a>
  </div>
</div>
<script>
(function () {
  var amountMonthly = <?= (int) $amount ?>;
  var amountAnnual = <?= (int) $amountAnnual ?>;
  var radios = document.querySelectorAll('#subscribe-form input[name=plan]');
  var submitBtn = document.getElementById('subscribe-submit');
  radios.forEach(function (r) {
    r.addEventListener('change', function () {
      var isAnnual = r.value === 'annual' && r.checked;
      if (r.checked) {
        submitBtn.textContent = isAnnual
          ? 'Payer ' + amountAnnual + ' FCFA et débloquer le mentor pour 1 an'
          : 'Payer ' + amountMonthly + ' FCFA et débloquer le mentor';
      }
    });
  });
})();
</script>
