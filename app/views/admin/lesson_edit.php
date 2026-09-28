<div class="container">
  <div class="breadcrumb"><a href="<?= Router::url('admin/tracks/' . $module['track_id']) ?>">← <?= View::e($module['title']) ?></a></div>
  <div class="page-header"><h1><?= $lesson ? 'Modifier la leçon' : 'Nouvelle leçon' ?></h1></div>

  <form class="card" method="post" action="<?= $lesson ? Router::url('admin/lessons/' . $lesson['id']) : Router::url('admin/modules/' . $module['id'] . '/lessons') ?>">
    <?= Auth::csrfField() ?>

    <div class="field">
      <label>Titre</label>
      <input type="text" name="title" required value="<?= View::e($lesson['title'] ?? '') ?>">
    </div>
    <div class="field">
      <label>Résumé court</label>
      <input type="text" name="summary" value="<?= View::e($lesson['summary'] ?? '') ?>">
    </div>
    <div class="field">
      <label>Contenu (Markdown)</label>
      <textarea name="content" rows="16" style="font-family:monospace;"><?= View::e($lesson['content'] ?? '') ?></textarea>
      <div class="hint">Supporte : # titres, **gras**, `code`, blocs ```code```, listes à puces -, liens [texte](url).</div>
    </div>
    <div class="field">
      <label>URL vidéo (optionnel)</label>
      <input type="url" name="video_url" value="<?= View::e($lesson['video_url'] ?? '') ?>">
    </div>
    <div class="grid grid-2">
      <div class="field">
        <label>Durée (minutes)</label>
        <input type="number" name="duration_minutes" value="<?= (int) ($lesson['duration_minutes'] ?? 15) ?>">
      </div>
      <div class="field">
        <label>Position</label>
        <input type="number" name="position" value="<?= (int) ($lesson['position'] ?? 0) ?>">
      </div>
    </div>

    <button class="btn btn-primary" type="submit"><?= $lesson ? 'Enregistrer' : 'Créer la leçon' ?></button>
  </form>
</div>
