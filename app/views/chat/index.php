<div class="chat-shell">
  <aside class="chat-sidebar">
    <h2>Conversations</h2>
    <form method="post" action="<?= Router::url('chat/new') ?>" style="margin:14px 0;">
      <?= Auth::csrfField() ?>
      <?php if (!empty($tracks)): ?>
      <div class="field" style="margin-bottom:10px;">
        <select name="track_id">
          <option value="">Mentor général</option>
          <?php foreach ($tracks as $t): ?>
          <option value="<?= (int) $t['id'] ?>">Mentor — <?= View::e($t['title']) ?></option>
          <?php endforeach; ?>
        </select>
      </div>
      <?php endif; ?>
      <button class="btn btn-accent btn-block btn-sm" type="submit">+ Nouvelle conversation</button>
    </form>

    <div class="chat-list">
      <?php foreach ($conversations as $c): ?>
      <a href="<?= Router::url('chat/' . $c['id']) ?>" class="<?= ($active && $active['id'] == $c['id']) ? 'active' : '' ?>">
        <?= View::e($c['title']) ?>
      </a>
      <?php endforeach; ?>
    </div>
  </aside>

  <div class="chat-main">
    <div class="chat-messages" data-chat-messages>
      <?php if (!$active): ?>
        <div class="chat-empty">
          <img src="<?= Router::url('assets/img/logo.png') ?>" alt="" style="width:64px;height:64px;object-fit:contain;">
          <h3>Ton mentor IA t'attend</h3>
          <p>Démarre une nouvelle conversation pour poser tes questions, obtenir des explications ou des exercices personnalisés.</p>
        </div>
      <?php elseif (empty($messages)): ?>
        <div class="chat-empty">
          <img src="<?= Router::url('assets/img/logo.png') ?>" alt="" style="width:64px;height:64px;object-fit:contain;">
          <p>Dis bonjour à ton mentor pour commencer !</p>
        </div>
      <?php else: ?>
        <?php foreach ($messages as $m): ?>
        <div class="msg <?= $m['role'] === 'user' ? 'msg-user' : 'msg-assistant' ?>">
          <?= $m['role'] === 'user' ? '<p>' . nl2br(View::e($m['content'])) . '</p>' : View::markdown($m['content']) ?>
        </div>
        <?php endforeach; ?>
      <?php endif; ?>
    </div>

    <?php if ($active): ?>
    <form class="chat-form" data-chat-form="<?= (int) $active['id'] ?>">
      <textarea placeholder="Écris ton message… (Entrée pour envoyer, Maj+Entrée pour un saut de ligne)" rows="1"></textarea>
      <button class="btn btn-primary" type="submit">Envoyer</button>
    </form>
    <?php endif; ?>
  </div>
</div>
