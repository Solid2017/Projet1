<div class="container">
  <div class="page-header">
    <h1>Abonnement Mentor IA</h1>
    <p>Un accompagnement personnalisé et illimité (dans la limite raisonnable) pour progresser plus vite.</p>
  </div>

  <?php if ($error): ?><div class="alert alert-error" style="max-width:480px;"><?= View::e($error) ?></div><?php endif; ?>
  <?php if (!empty($success)): ?><div class="alert alert-success" style="max-width:480px;"><?= View::e($success) ?></div><?php endif; ?>

  <?php if ($subscription && $subscription['status'] === 'active' && strtotime($subscription['expires_at']) > time()): ?>
    <div class="card" style="max-width:480px;">
      <span class="badge badge-blue">Abonnement actif</span>
      <h3 style="margin-top:10px;">Ton accès au mentor est actif</h3>
      <p style="color:var(--muted);">Valable jusqu'au <?= View::e(date('d/m/Y', strtotime($subscription['expires_at']))) ?>.<?= $manual ? ' Tu peux le prolonger à tout moment avec un nouveau code.' : '' ?></p>
      <a class="btn btn-accent btn-block" href="<?= Router::url('chat') ?>">Discuter avec le mentor</a>
    </div>
  <?php endif; ?>

<?php if ($manual): ?>
  <?php
    $waText = function (string $planText) use ($user): string {
        return "Bonjour IgoTech IA, je souhaite m'abonner au Mentor IA (" . $planText . ").\n"
            . 'Mon compte : ' . $user['name'] . ' (' . $user['email'] . ')';
    };
    $planTexts = [
        'monthly' => 'formule mensuelle, ' . (int) $amount . ' FCFA',
        'annual' => 'formule annuelle, ' . (int) $amountAnnual . ' FCFA',
    ];
  ?>
  <div class="card" style="max-width:480px;">
    <ul style="color:var(--muted);margin:0 0 18px;padding-left:18px;line-height:1.8;">
      <li>Mentor IA disponible sur tous tes parcours</li>
      <li>Explications personnalisées, exercices, corrections</li>
      <li>Sans engagement : tu renouvelles seulement si tu le souhaites</li>
    </ul>

    <div class="field" id="plan-choice">
      <label class="radio-line"><input type="radio" name="plan" value="monthly" checked> Mensuel : <?= (int) $amount ?> FCFA / mois</label>
      <label class="radio-line"><input type="radio" name="plan" value="annual"> Annuel : <?= (int) $amountAnnual ?> FCFA / an <span class="badge badge-red" style="margin-left:6px;">2 mois offerts</span></label>
    </div>

    <ol class="pay-steps">
      <li><strong>Écris-nous sur WhatsApp</strong> : on t'indique le numéro Airtel Money ou Moov Money où envoyer ton paiement.</li>
      <li><strong>Fais le transfert</strong> depuis ton téléphone, puis envoie-nous la capture ou le SMS de confirmation.</li>
      <li><strong>Reçois ton code d'accès</strong> sur WhatsApp et saisis-le ci-dessous : le mentor se débloque aussitôt.</li>
    </ol>

    <?php if ($whatsappNumber !== ''): ?>
      <a class="btn btn-whatsapp btn-block" id="wa-pay" target="_blank" rel="noopener"
         data-monthly="<?= View::e(PaymentService::whatsappLink($whatsappNumber, $waText($planTexts['monthly']))) ?>"
         data-annual="<?= View::e(PaymentService::whatsappLink($whatsappNumber, $waText($planTexts['annual']))) ?>"
         href="<?= View::e(PaymentService::whatsappLink($whatsappNumber, $waText($planTexts['monthly']))) ?>">
        Payer via WhatsApp : +<?= View::e($whatsappNumber) ?>
      </a>
    <?php else: ?>
      <div class="alert alert-error" style="margin:0;">Le numéro WhatsApp de paiement n'est pas encore configuré. Réessaie plus tard.</div>
    <?php endif; ?>
  </div>

  <div class="card" style="max-width:480px;" id="code">
    <h3 style="margin-top:0;">J'ai reçu mon code</h3>
    <form method="post" action="<?= Router::url('subscribe/code') ?>">
      <?= Auth::csrfField() ?>
      <div class="field">
        <label for="access-code">Code d'accès</label>
        <input type="text" id="access-code" name="code" class="access-code-input" placeholder="IGO-XXXX-XXXX" autocomplete="off" autocapitalize="characters" spellcheck="false" maxlength="20" required>
      </div>
      <button class="btn btn-accent btn-block" type="submit">Activer mon accès au mentor</button>
    </form>
  </div>
<?php else: ?>
  <div class="card" style="max-width:480px;">
    <ul style="color:var(--muted);margin:0 0 18px;padding-left:18px;line-height:1.8;">
      <li>Mentor IA disponible sur tous tes parcours</li>
      <li>Explications personnalisées, exercices, corrections</li>
      <li>Résiliable à tout moment — simplement ne pas renouveler</li>
    </ul>

    <form method="post" action="<?= Router::url('subscribe/pay') ?>" id="subscribe-form">
      <?= Auth::csrfField() ?>

      <div class="field">
        <label class="radio-line"><input type="radio" name="plan" value="monthly" checked> Mensuel — <?= (int) $amount ?> FCFA / mois</label>
        <label class="radio-line"><input type="radio" name="plan" value="annual"> Annuel — <?= (int) $amountAnnual ?> FCFA / an <span class="badge badge-red" style="margin-left:6px;">2 mois offerts</span></label>
      </div>

      <div class="field">
        <label for="phone">Numéro Mobile Money (Airtel Money ou Moov Money)</label>
        <input type="tel" id="phone" name="phone" placeholder="ex: 66 12 34 56" required>
        <div class="hint">Tu choisiras Airtel Money ou Moov Money sur la page de paiement suivante.</div>
      </div>
      <button class="btn btn-accent btn-block" type="submit" id="subscribe-submit">Payer <?= (int) $amount ?> FCFA et débloquer le mentor</button>
    </form>
  </div>
<?php endif; ?>

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
  var radios = document.querySelectorAll('input[name=plan]');
  var submitBtn = document.getElementById('subscribe-submit');
  var waBtn = document.getElementById('wa-pay');
  radios.forEach(function (r) {
    r.addEventListener('change', function () {
      if (!r.checked) return;
      var isAnnual = r.value === 'annual';
      if (submitBtn) {
        submitBtn.textContent = isAnnual
          ? 'Payer ' + amountAnnual + ' FCFA et débloquer le mentor pour 1 an'
          : 'Payer ' + amountMonthly + ' FCFA et débloquer le mentor';
      }
      if (waBtn) {
        waBtn.href = waBtn.getAttribute(isAnnual ? 'data-annual' : 'data-monthly');
      }
    });
  });
})();
</script>
