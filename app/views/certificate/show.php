<div class="container">
  <div class="card" style="max-width:640px;margin:32px auto;text-align:center;padding:48px 32px;border:2px solid var(--blue);">
    <img src="<?= Router::url('assets/img/logo.png') ?>" alt="" style="width:56px;height:56px;object-fit:contain;margin-bottom:16px;">
    <p style="color:var(--muted);text-transform:uppercase;letter-spacing:.08em;font-size:.8rem;font-weight:600;">Certificat de réussite</p>
    <h1 style="margin:12px 0;">IgoTech IA</h1>
    <p style="font-size:1.1rem;">Ce certificat atteste que</p>
    <p style="font-size:1.6rem;font-weight:800;color:var(--blue);margin:8px 0;"><?= View::e($certificate['user_name']) ?></p>
    <p style="font-size:1.1rem;">a complété avec succès le parcours</p>
    <p style="font-size:1.3rem;font-weight:700;color:var(--red);margin:8px 0;"><?= View::e($certificate['track_title']) ?></p>
    <p style="color:var(--muted);font-size:.9rem;margin-top:16px;">Délivré le <?= View::e(date('d/m/Y', strtotime($certificate['issued_at']))) ?> · Code de vérification : <?= View::e($certificate['code']) ?></p>

    <div style="display:flex;gap:10px;justify-content:center;flex-wrap:wrap;margin-top:24px;">
      <a class="btn btn-accent btn-sm" target="_blank" rel="noopener"
         href="https://www.linkedin.com/sharing/share-offsite/?url=<?= urlencode($shareUrl) ?>">
        Partager sur LinkedIn
      </a>
      <a class="btn btn-outline btn-sm" target="_blank" rel="noopener"
         href="https://www.facebook.com/sharer/sharer.php?u=<?= urlencode($shareUrl) ?>">
        Partager sur Facebook
      </a>
      <a class="btn btn-outline btn-sm" target="_blank" rel="noopener"
         href="https://wa.me/?text=<?= urlencode('J\'ai obtenu mon certificat ' . $certificate['track_title'] . ' sur IgoTech IA : ' . $shareUrl) ?>">
        Partager sur WhatsApp
      </a>
    </div>
  </div>
</div>
