<div class="container">
  <div class="page-header">
    <h1>Trouver un mentor</h1>
    <p>Des professionnels tchadiens, classés par domaine, disponibles pour un accompagnement humain en complément du mentor IA.</p>
  </div>

  <?php if (empty($byTrack)): ?>
    <div class="card" style="text-align:center;">
      <p>Aucun mentor n'est encore référencé dans l'annuaire. Reviens bientôt !</p>
    </div>
  <?php else: ?>
    <?php foreach ($byTrack as $group): ?>
    <div class="section-title"><span class="dot"></span> <?= View::e($group['track']['title']) ?></div>
    <div class="grid grid-2">
      <?php foreach ($group['mentors'] as $mentor): ?>
      <div class="card">
        <div style="display:flex;align-items:center;gap:12px;margin-bottom:8px;">
          <span class="avatar" style="background: <?= View::e($mentor['avatar_color']) ?>;width:40px;height:40px;font-size:1rem;"><?= View::e(mb_strtoupper(mb_substr($mentor['name'], 0, 1))) ?></span>
          <div>
            <strong><?= View::e($mentor['name']) ?></strong>
          </div>
        </div>
        <?php if (!empty($mentor['mentor_bio'])): ?>
          <p style="color:var(--muted);font-size:.9rem;"><?= View::e($mentor['mentor_bio']) ?></p>
        <?php endif; ?>
        <?php if (!empty($mentor['whatsapp_number'])): ?>
          <a class="btn btn-accent btn-sm" target="_blank" rel="noopener"
             href="https://wa.me/<?= View::e($mentor['whatsapp_number']) ?>?text=<?= urlencode('Bonjour ' . $mentor['name'] . ', je te contacte via IgoTech IA.') ?>">
            Contacter sur WhatsApp
          </a>
        <?php endif; ?>
      </div>
      <?php endforeach; ?>
    </div>
    <?php endforeach; ?>
  <?php endif; ?>
</div>
