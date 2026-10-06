<?php
$labels = [];
foreach ($rules as $k => $r) {
    $labels[$k] = $r['label'];
}
?>
<div class="container">
  <div class="page-header"><h1>E-mails de fidélisation</h1><p>Relances automatiques envoyées chaque heure par la tâche planifiée <code>cron/emails.php</code>.</p></div>

  <div class="admin-layout">
    <?php View::partial('admin/_nav', ['current' => 'emails']); ?>

    <div>
      <div class="stat-grid">
        <div class="stat-card"><div class="value"><?= array_sum(array_map(fn ($c) => (int) $c['sent'], $counts)) ?></div><div class="label">Envoyés (30 jours)</div></div>
        <div class="stat-card"><div class="value"><?= array_sum(array_map(fn ($c) => (int) $c['failed'], $counts)) ?></div><div class="label">Échecs (30 jours)</div></div>
        <div class="stat-card"><div class="value"><?= (int) $optOuts ?></div><div class="label">Désinscrits</div></div>
        <div class="stat-card"><div class="value" style="font-size:1.05rem;"><?= $lastRun ? View::e(date('d/m H:i', strtotime($lastRun))) : '—' ?></div><div class="label">Dernier passage du cron</div></div>
      </div>

      <?php if (!$lastRun): ?>
        <div class="alert alert-error" style="margin-top:18px;">
          La tâche planifiée n'a encore jamais tourné. Dans LWSPanel → Tâches planifiées (cron), ajoute toutes les heures la commande :<br>
          <code>php <?= View::e($cronPath) ?></code><br>Le guide <code>docs/INSTALL_LWSPANEL.md</code> (section 8) détaille la mise en place.
        </div>
      <?php endif; ?>

      <div class="section-title" style="margin-top:24px;"><span class="dot"></span> Les 9 e-mails automatiques</div>
      <table class="data-table">
        <thead><tr><th>Déclencheur</th><th>Envoyés (30 j)</th><th>Échecs</th><th>Aperçu</th></tr></thead>
        <tbody>
        <?php foreach ($rules as $key => $rule): ?>
          <tr>
            <td><?= View::e($rule['label']) ?></td>
            <td><?= (int) ($counts[$key]['sent'] ?? 0) ?></td>
            <td><?= (int) ($counts[$key]['failed'] ?? 0) ?></td>
            <td><a href="<?= Router::url('admin/emails/preview/' . $key) ?>" target="_blank" rel="noopener">Voir l'e-mail</a></td>
          </tr>
        <?php endforeach; ?>
        </tbody>
      </table>

      <div class="section-title" style="margin-top:24px;"><span class="dot"></span> Derniers envois</div>
      <?php if (empty($recent)): ?>
        <div class="card"><p style="color:var(--muted);">Aucun e-mail envoyé pour le moment.</p></div>
      <?php else: ?>
      <table class="data-table">
        <thead><tr><th>Date</th><th>Destinataire</th><th>E-mail</th><th>Statut</th></tr></thead>
        <tbody>
        <?php foreach ($recent as $r): ?>
          <tr>
            <td><?= View::e(date('d/m/Y H:i', strtotime($r['sent_at']))) ?></td>
            <td><?= View::e($r['name']) ?><br><span style="color:var(--muted);font-size:.8rem;"><?= View::e($r['email']) ?></span></td>
            <td><?= View::e($labels[$r['email_key']] ?? $r['email_key']) ?></td>
            <td>
              <?php if ($r['status'] === 'sent'): ?><span class="badge badge-blue">Envoyé</span>
              <?php else: ?><span class="badge badge-red">Échec (<?= (int) $r['attempts'] ?>/3)</span><?php endif; ?>
            </td>
          </tr>
        <?php endforeach; ?>
        </tbody>
      </table>
      <?php endif; ?>
    </div>
  </div>
</div>
