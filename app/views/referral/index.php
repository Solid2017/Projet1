<div class="container">
  <div class="page-header">
    <h1>Parraine un ami</h1>
    <p>Vous recevez chacun <?= (int) $rewardDays ?> jours d'abonnement offerts dès que ton filleul s'abonne pour la première fois.</p>
  </div>

  <div class="card" style="max-width:560px;">
    <h3 style="font-size:1rem;margin-bottom:10px;">Ton lien de parrainage</h3>
    <div class="field">
      <input type="text" id="referral-link" readonly value="<?= View::e($referralUrl) ?>" onclick="this.select()">
    </div>
    <div style="display:flex;gap:10px;flex-wrap:wrap;margin-top:12px;">
      <a class="btn btn-accent btn-sm" target="_blank" rel="noopener"
         href="https://wa.me/?text=<?= urlencode('Rejoins-moi sur IgoTech IA pour apprendre l\'informatique avec un mentor IA : ' . $referralUrl) ?>">
        Partager sur WhatsApp
      </a>
      <a class="btn btn-outline btn-sm" target="_blank" rel="noopener"
         href="https://www.facebook.com/sharer/sharer.php?u=<?= urlencode($referralUrl) ?>">
        Partager sur Facebook
      </a>
    </div>
  </div>

  <div class="stat-grid" style="margin-top:24px;max-width:560px;">
    <div class="stat-card"><div class="value"><?= (int) $rewardedCount ?></div><div class="label">Filleuls abonnés</div></div>
    <div class="stat-card"><div class="value"><?= (int) $pendingCount ?></div><div class="label">Filleuls inscrits, pas encore abonnés</div></div>
  </div>
</div>
