<div class="container">
  <div class="page-header"><h1>Profil mentor — <?= View::e($mentor['name']) ?></h1></div>

  <div class="admin-layout">
    <?php View::partial('admin/_nav', ['current' => 'users']); ?>

    <div>
      <div class="card" style="max-width:560px;">
        <form method="post" action="<?= Router::url('admin/users/' . $mentor['id'] . '/mentor') ?>">
          <?= Auth::csrfField() ?>

          <div class="field">
            <label for="mentor_bio">Présentation (affichée dans l'annuaire)</label>
            <textarea id="mentor_bio" name="mentor_bio" rows="4"><?= View::e($mentor['mentor_bio'] ?? '') ?></textarea>
          </div>

          <div class="field">
            <label for="whatsapp_number">Numéro WhatsApp de contact</label>
            <input type="tel" id="whatsapp_number" name="whatsapp_number" value="<?= View::e($mentor['whatsapp_number'] ?? '') ?>" placeholder="ex: 66 12 34 56">
          </div>

          <div class="field">
            <label>Domaines professionnels couverts</label>
            <div style="display:grid;grid-template-columns:1fr 1fr;gap:6px;margin-top:6px;">
              <?php foreach ($tracks as $t): ?>
              <label style="display:flex;align-items:center;gap:6px;font-weight:400;font-size:.9rem;">
                <input type="checkbox" name="track_ids[]" value="<?= (int) $t['id'] ?>" <?= in_array((int) $t['id'], $selectedTrackIds, true) ? 'checked' : '' ?>>
                <?= View::e($t['title']) ?>
              </label>
              <?php endforeach; ?>
            </div>
          </div>

          <button class="btn btn-primary btn-block" type="submit">Enregistrer</button>
        </form>
      </div>
    </div>
  </div>
</div>
