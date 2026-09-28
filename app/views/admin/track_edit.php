<div class="container">
  <div class="breadcrumb"><a href="<?= Router::url('admin/tracks') ?>">← Parcours</a></div>
  <div class="page-header"><h1><?= $track ? 'Modifier le parcours' : 'Nouveau parcours' ?></h1></div>

  <form class="card" method="post" action="<?= $track ? Router::url('admin/tracks/' . $track['id']) : Router::url('admin/tracks') ?>" style="max-width:720px;">
    <?= Auth::csrfField() ?>

    <div class="field">
      <label>Titre</label>
      <input type="text" name="title" required value="<?= View::e($track['title'] ?? '') ?>">
    </div>
    <div class="field">
      <label>Slug (URL) — laisser vide pour générer automatiquement</label>
      <input type="text" name="slug" value="<?= View::e($track['slug'] ?? '') ?>">
    </div>
    <div class="field">
      <label>Sous-titre</label>
      <input type="text" name="subtitle" value="<?= View::e($track['subtitle'] ?? '') ?>">
    </div>
    <div class="field">
      <label>Description</label>
      <textarea name="description"><?= View::e($track['description'] ?? '') ?></textarea>
    </div>

    <div class="grid grid-2">
      <div class="field">
        <label>Couleur</label>
        <select name="color">
          <option value="blue" <?= (($track['color'] ?? '') === 'blue') ? 'selected' : '' ?>>Bleu</option>
          <option value="red" <?= (($track['color'] ?? '') === 'red') ? 'selected' : '' ?>>Rouge</option>
        </select>
      </div>
      <div class="field">
        <label>Niveau</label>
        <select name="level">
          <?php foreach (['debutant' => 'Débutant', 'intermediaire' => 'Intermédiaire', 'avance' => 'Avancé'] as $val => $label): ?>
          <option value="<?= $val ?>" <?= (($track['level'] ?? 'debutant') === $val) ? 'selected' : '' ?>><?= $label ?></option>
          <?php endforeach; ?>
        </select>
      </div>
    </div>

    <div class="field">
      <label>Persona du mentor IA pour ce parcours</label>
      <textarea name="mentor_persona" placeholder="Ex : Tu es un mentor senior en..."><?= View::e($track['mentor_persona'] ?? '') ?></textarea>
      <div class="hint">Ces instructions sont ajoutées au prompt système du mentor IA lorsqu'un apprenant discute dans le contexte de ce parcours.</div>
    </div>

    <div class="grid grid-2">
      <div class="field">
        <label>Position (ordre d'affichage)</label>
        <input type="number" name="position" value="<?= (int) ($track['position'] ?? 0) ?>">
      </div>
      <div class="field">
        <label class="checkbox-row" style="margin-top:30px;">
          <input type="checkbox" name="is_published" value="1" <?= (!$track || $track['is_published']) ? 'checked' : '' ?>>
          Publié (visible par les apprenants)
        </label>
      </div>
    </div>

    <button class="btn btn-primary" type="submit"><?= $track ? 'Enregistrer' : 'Créer le parcours' ?></button>
  </form>
</div>
