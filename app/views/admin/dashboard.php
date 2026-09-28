<div class="container">
  <div class="page-header"><h1>Administration</h1><p>Vue d'ensemble de la plateforme IgoTech IA.</p></div>

  <div class="admin-layout">
    <?php View::partial('admin/_nav', ['current' => 'dashboard']); ?>

    <div>
      <div class="stat-grid">
        <div class="stat-card"><div class="value"><?= (int) $stats['users'] ?></div><div class="label">Utilisateurs</div></div>
        <div class="stat-card"><div class="value"><?= (int) $stats['tracks'] ?></div><div class="label">Parcours</div></div>
        <div class="stat-card"><div class="value"><?= (int) $stats['lessons'] ?></div><div class="label">Leçons</div></div>
        <div class="stat-card"><div class="value"><?= (int) $stats['enrollments'] ?></div><div class="label">Inscriptions</div></div>
        <div class="stat-card"><div class="value"><?= (int) $stats['conversations'] ?></div><div class="label">Conversations mentor</div></div>
      </div>
    </div>
  </div>
</div>
