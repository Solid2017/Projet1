<div class="container" style="padding-top:60px;padding-bottom:60px;">
  <div style="max-width:680px;margin:0 auto;text-align:center;">
    <img src="<?= Router::url('assets/img/logo.png') ?>" alt="IgoTech IA" style="width:90px;height:90px;object-fit:contain;margin:0 auto 24px;">
    <h1 style="font-size:2.3rem;">Ton mentor IA pour réussir dans l'informatique</h1>
    <p style="color:var(--muted);font-size:1.05rem;">
      IgoTech IA accompagne les jeunes diplômés et tout aspirant à une carrière tech avec des parcours
      structurés et un mentor IA disponible à tout moment pour expliquer, corriger et encourager.
    </p>
    <div style="display:flex;gap:14px;justify-content:center;margin-top:28px;">
      <a class="btn btn-primary" href="<?= Router::url('register') ?>">Commencer gratuitement</a>
      <a class="btn btn-outline" href="<?= Router::url('login') ?>">Se connecter</a>
    </div>
  </div>

  <div class="section-title" style="justify-content:center;"><span class="dot"></span> Parcours disponibles</div>
  <div class="grid grid-2">
    <?php foreach ($tracks as $t): ?>
    <div class="track-card">
      <div class="track-icon <?= $t['color'] ?>"><?= View::e(mb_strtoupper(mb_substr($t['title'], 0, 1))) ?></div>
      <h3><?= View::e($t['title']) ?></h3>
      <p style="color:var(--muted);"><?= View::e($t['subtitle']) ?></p>
      <span class="badge badge-<?= $t['color'] ?>"><?= View::e(ucfirst($t['level'])) ?></span>
    </div>
    <?php endforeach; ?>
  </div>

  <div class="section-title" style="justify-content:center;"><span class="dot"></span> Comment ça marche</div>
  <div class="grid grid-3">
    <div class="card">
      <h3>1. Choisis ton parcours</h3>
      <p style="color:var(--muted);">Développement web, data & IA, cybersécurité ou DevOps : avance à ton rythme.</p>
    </div>
    <div class="card">
      <h3>2. Apprends par la pratique</h3>
      <p style="color:var(--muted);">Leçons concrètes, exemples de code et quiz de validation à chaque étape.</p>
    </div>
    <div class="card">
      <h3>3. Progresse avec ton mentor IA</h3>
      <p style="color:var(--muted);">Pose tes questions, débloque-toi et prépare ta carrière avec un accompagnement continu.</p>
    </div>
  </div>
</div>
