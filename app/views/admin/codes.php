<?php
$planLabel = fn (string $plan) => $plan === 'annual' ? 'Annuel (1 an)' : 'Mensuel (1 mois)';
$subscribeUrl = rtrim(APP_CONFIG['app']['url'] ?? '', '/') . Router::url('subscribe');
$codeMessage = function (array $c, string $name = '') use ($subscribeUrl): string {
    return 'Bonjour' . ($name !== '' ? ' ' . $name : '') . ', merci pour ton paiement de ' . (int) $c['amount_fcfa'] . " FCFA !\n\n"
        . 'Voici ton code d\'accès au Mentor IA (' . ($c['plan'] === 'annual' ? 'abonnement annuel' : 'abonnement mensuel') . ") :\n"
        . '*' . AccessCode::format($c['code']) . "*\n\n"
        . "Pour l'activer : connecte-toi sur " . $subscribeUrl . " puis saisis ce code dans « J'ai reçu mon code ».\n\n"
        . "L'équipe IgoTech IA";
};
?>
<div class="container">
  <div class="page-header">
    <h1>Codes d'accès</h1>
    <p>Paiement manuel : l'apprenant te contacte sur WhatsApp, fait son transfert Airtel Money ou Moov Money, puis tu génères ici son code et tu le lui envoies.</p>
  </div>

  <div class="admin-layout">
    <?php View::partial('admin/_nav', ['current' => 'codes']); ?>

    <div>
      <?php if (!$manual): ?>
        <div class="alert alert-error">Le paiement manuel n'est pas affiché aux apprenants : dans <code>config/config.php</code>, section <code>payment</code>, mets <code>'provider' =&gt; 'manual'</code>. Les codes générés ici fonctionnent quand même.</div>
      <?php endif; ?>
      <?php if ($error): ?><div class="alert alert-error"><?= View::e($error) ?></div><?php endif; ?>
      <?php if ($notice): ?><div class="alert alert-success"><?= View::e($notice) ?></div><?php endif; ?>

      <?php if ($new): ?>
        <div class="card code-new">
          <span class="badge badge-blue">Nouveau code</span>
          <div class="access-code" id="new-code"><?= View::e(AccessCode::format($new['code'])) ?></div>
          <p style="color:var(--muted);margin:0 0 14px;">
            <?= View::e($planLabel($new['plan'])) ?> · <?= (int) $new['amount_fcfa'] ?> FCFA
            <?php if ($new['reserved_email']): ?> · réservé à <strong><?= View::e($new['reserved_email']) ?></strong><?php endif; ?>
          </p>
          <div class="code-actions">
            <a class="btn btn-whatsapp" target="_blank" rel="noopener"
               href="<?= View::e(PaymentService::whatsappLink((string) ($new['learner_phone'] ?? ''), $codeMessage($new, (string) ($newLearner['name'] ?? '')))) ?>">
              Envoyer le code sur WhatsApp
            </a>
            <button type="button" class="btn btn-outline" data-copy="<?= View::e(AccessCode::format($new['code'])) ?>">Copier le code</button>
          </div>
          <?php if (empty($new['learner_phone'])): ?>
            <p class="hint" style="margin-top:10px;">Aucun numéro enregistré : WhatsApp te laissera choisir le contact.</p>
          <?php endif; ?>
          <?php if ($new['reserved_email'] && !$newLearner): ?>
            <p class="hint" style="margin-top:6px;color:var(--red-dark);">Aucun compte n'existe encore avec cette adresse : l'apprenant devra s'inscrire avec exactement cet e-mail pour utiliser le code.</p>
          <?php endif; ?>
        </div>
      <?php endif; ?>

      <div class="card">
        <h3 style="margin-top:0;">Générer un code après un paiement reçu</h3>
        <form method="post" action="<?= Router::url('admin/codes') ?>">
          <?= Auth::csrfField() ?>
          <div class="field">
            <label>Formule payée</label>
            <label class="radio-line"><input type="radio" name="plan" value="monthly" checked> Mensuel : <?= (int) $monthly['amount'] ?> FCFA, 1 mois</label>
            <label class="radio-line"><input type="radio" name="plan" value="annual"> Annuel : <?= (int) $annual['amount'] ?> FCFA, 1 an</label>
          </div>
          <div class="field">
            <label for="reserved_email">E-mail du compte de l'apprenant <span style="font-weight:400;color:var(--muted);">(recommandé)</span></label>
            <input type="email" id="reserved_email" name="reserved_email" placeholder="ex: amina@gmail.com">
            <div class="hint">Seul ce compte pourra utiliser le code : il ne peut pas être revendu ni partagé.</div>
          </div>
          <div class="field">
            <label for="learner_phone">WhatsApp de l'apprenant <span style="font-weight:400;color:var(--muted);">(facultatif)</span></label>
            <input type="tel" id="learner_phone" name="learner_phone" placeholder="ex: 66 12 34 56">
            <div class="hint">Pour lui envoyer le code en un clic. Si vide, repris de son compte quand il en a un.</div>
          </div>
          <div class="field">
            <label for="note">Référence du transfert <span style="font-weight:400;color:var(--muted);">(facultatif)</span></label>
            <input type="text" id="note" name="note" maxlength="255" placeholder="ex: Airtel Money, réf. CI241008.1423.A12345">
          </div>
          <button class="btn btn-accent" type="submit">Générer le code</button>
        </form>
      </div>

      <div class="section-title" style="margin-top:24px;"><span class="dot"></span> Derniers codes <span style="color:var(--muted);font-weight:400;font-size:.9rem;">· <?= (int) $unusedCount ?> en attente d'utilisation</span></div>
      <?php if (empty($codes)): ?>
        <div class="card"><p style="color:var(--muted);">Aucun code généré pour le moment.</p></div>
      <?php else: ?>
      <table class="data-table">
        <thead><tr><th>Code</th><th>Formule</th><th>Apprenant</th><th>Créé le</th><th>Statut</th><th></th></tr></thead>
        <tbody>
        <?php foreach ($codes as $c): ?>
          <tr>
            <td><code class="access-code-sm"><?= View::e(AccessCode::format($c['code'])) ?></code>
              <?php if ($c['note']): ?><br><span style="color:var(--muted);font-size:.8rem;"><?= View::e($c['note']) ?></span><?php endif; ?></td>
            <td><?= View::e($planLabel($c['plan'])) ?><br><span style="color:var(--muted);font-size:.8rem;"><?= (int) $c['amount_fcfa'] ?> FCFA</span></td>
            <td>
              <?php if ($c['used_by_name']): ?><?= View::e($c['used_by_name']) ?><br><span style="color:var(--muted);font-size:.8rem;"><?= View::e($c['used_by_email']) ?></span>
              <?php elseif ($c['reserved_email']): ?><span style="font-size:.85rem;">Réservé à <?= View::e($c['reserved_email']) ?></span>
              <?php else: ?><span style="color:var(--muted);">—</span><?php endif; ?>
            </td>
            <td><?= View::e(date('d/m/Y H:i', strtotime($c['created_at']))) ?></td>
            <td>
              <?php if ($c['used_at']): ?><span class="badge badge-blue">Utilisé le <?= View::e(date('d/m', strtotime($c['used_at']))) ?></span>
              <?php elseif ($c['revoked_at']): ?><span class="badge badge-red">Annulé</span>
              <?php else: ?><span class="badge badge-muted">En attente</span><?php endif; ?>
            </td>
            <td style="white-space:nowrap;">
              <?php if (!$c['used_at'] && !$c['revoked_at']): ?>
                <a class="btn btn-ghost btn-sm" target="_blank" rel="noopener" href="<?= View::e(PaymentService::whatsappLink((string) ($c['learner_phone'] ?? ''), $codeMessage($c))) ?>">Envoyer sur WhatsApp</a>
                <form class="inline-form" method="post" action="<?= Router::url('admin/codes/' . (int) $c['id'] . '/revoke') ?>" onsubmit="return confirm('Annuler ce code ? Il ne pourra plus être utilisé.');">
                  <?= Auth::csrfField() ?>
                  <button class="btn btn-ghost btn-sm" type="submit">Annuler</button>
                </form>
              <?php endif; ?>
            </td>
          </tr>
        <?php endforeach; ?>
        </tbody>
      </table>
      <?php endif; ?>
    </div>
  </div>
</div>
<script>
document.querySelectorAll('[data-copy]').forEach(function (btn) {
  btn.addEventListener('click', function () {
    var text = btn.getAttribute('data-copy');
    var done = function () { btn.textContent = 'Copié !'; setTimeout(function () { btn.textContent = 'Copier le code'; }, 1800); };
    if (navigator.clipboard) { navigator.clipboard.writeText(text).then(done, function () { window.prompt('Copie le code :', text); }); }
    else { window.prompt('Copie le code :', text); }
  });
});
</script>
