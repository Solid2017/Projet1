<div class="container">
  <div class="page-header"><h1>Abonnements &amp; revenus</h1><p>Mentor IA — paiements Mobile Money (Airtel Money / Moov Money). Pour un paiement reçu sur WhatsApp, génère un code dans <a href="<?= Router::url('admin/codes') ?>">Codes d'accès</a>.</p></div>

  <div class="admin-layout">
    <?php View::partial('admin/_nav', ['current' => 'subscriptions']); ?>

    <div>
      <div class="stat-grid">
        <div class="stat-card"><div class="value"><?= (int) $activeCount ?></div><div class="label">Abonnés actifs</div></div>
        <div class="stat-card"><div class="value"><?= number_format((float) $revenueThisMonth, 0, ',', ' ') ?> FCFA</div><div class="label">Revenu ce mois-ci</div></div>
      </div>

      <div class="section-title" style="margin-top:24px;"><span class="dot"></span> Paiements récents</div>

      <?php if (empty($payments)): ?>
        <div class="card"><p style="color:var(--muted);">Aucun paiement pour le moment.</p></div>
      <?php else: ?>
      <table class="data-table">
        <thead><tr><th>Date</th><th>Apprenant</th><th>Montant</th><th>Canal</th><th>Statut</th></tr></thead>
        <tbody>
        <?php foreach ($payments as $p): ?>
          <tr>
            <td><?= View::e(date('d/m/Y H:i', strtotime($p['created_at']))) ?></td>
            <td><?= View::e($p['user_name']) ?><br><span style="color:var(--muted);font-size:.8rem;"><?= View::e($p['user_email']) ?></span></td>
            <td><?= (int) $p['amount_fcfa'] ?> FCFA</td>
            <td><?= View::e(($p['provider'] ?? '') === 'manual' ? 'Code ' . ($p['provider_reference'] ?? '') : ($p['channel'] ?? '—')) ?></td>
            <td>
              <?php if ($p['status'] === 'success'): ?><span class="badge badge-blue">Réussi</span>
              <?php elseif ($p['status'] === 'pending'): ?><span class="badge badge-muted">En attente</span>
              <?php else: ?><span class="badge badge-red">Échoué</span><?php endif; ?>
            </td>
          </tr>
        <?php endforeach; ?>
        </tbody>
      </table>
      <?php endif; ?>
    </div>
  </div>
</div>
