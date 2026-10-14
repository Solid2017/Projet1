<div class="container">
  <div class="breadcrumb">
    <a href="<?= Router::url('lessons/' . $lesson['id']) ?>">← Retour à la leçon</a>
  </div>

  <div class="page-header">
    <h1><?= View::e($quiz['title']) ?></h1>
    <p>Score minimum pour valider : <?= (int) $quiz['pass_score_percent'] ?>%</p>
  </div>

  <form class="card" data-quiz-form="<?= (int) $quiz['id'] ?>">
    <?php foreach ($questions as $i => $q): ?>
    <div class="quiz-question">
      <h3><?= ($i + 1) ?>. <?= View::e($q['question']) ?></h3>
      <?php foreach ($q['options'] as $opt): ?>
      <label class="quiz-option">
        <input type="radio" name="answers[<?= (int) $q['id'] ?>]" value="<?= (int) $opt['id'] ?>" required>
        <?= View::e($opt['option_text']) ?>
      </label>
      <?php endforeach; ?>
    </div>
    <?php endforeach; ?>

    <button class="btn btn-primary" type="submit">Valider mes réponses</button>
    <div class="quiz-result" data-quiz-result style="display:none;"></div>
  </form>
</div>
