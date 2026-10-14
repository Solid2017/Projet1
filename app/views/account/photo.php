<div class="container">
  <div class="page-header">
    <h1>Ma photo de profil</h1>
    <p>Optionnel — elle permet à ton mentor et aux autres apprenants de te reconnaître.</p>
  </div>

  <div class="card" style="max-width:480px;">
    <?php if ($error): ?><div class="alert alert-error"><?= View::e($error) ?></div><?php endif; ?>

    <div style="text-align:center;margin-bottom:16px;">
      <?= View::avatar($user, 96) ?>
    </div>

    <form method="post" action="<?= Router::url('account/photo') ?>" enctype="multipart/form-data">
      <?= Auth::csrfField() ?>
      <div class="field">
        <label for="photo">Choisir une photo</label>
        <input type="file" id="photo" name="photo" accept="image/jpeg,image/png,image/webp" required>
        <div class="hint">JPG, PNG ou WebP, 3 Mo maximum.</div>
      </div>
      <button class="btn btn-primary btn-block" type="submit">Enregistrer ma photo</button>
    </form>
  </div>
</div>
