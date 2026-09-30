(function () {
  'use strict';

  var form = document.querySelector('[data-chat-form]');
  if (!form) { return; }

  var conversationId = form.getAttribute('data-chat-form');
  var textarea = form.querySelector('textarea');
  var messagesBox = document.querySelector('[data-chat-messages]');
  var submitBtn = form.querySelector('button[type=submit]');

  function scrollToBottom() {
    messagesBox.scrollTop = messagesBox.scrollHeight;
  }

  function escapeHtml(str) {
    var div = document.createElement('div');
    div.textContent = str;
    return div.innerHTML;
  }

  function appendMessage(role, html) {
    var empty = messagesBox.querySelector('.chat-empty');
    if (empty) { empty.remove(); }

    var bubble = document.createElement('div');
    bubble.className = 'msg ' + (role === 'user' ? 'msg-user' : 'msg-assistant');
    bubble.innerHTML = html;
    messagesBox.appendChild(bubble);
    scrollToBottom();
    return bubble;
  }

  textarea.addEventListener('input', function () {
    textarea.style.height = 'auto';
    textarea.style.height = Math.min(textarea.scrollHeight, 140) + 'px';
  });

  textarea.addEventListener('keydown', function (e) {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      form.requestSubmit ? form.requestSubmit() : form.dispatchEvent(new Event('submit', { cancelable: true }));
    }
  });

  form.addEventListener('submit', function (e) {
    e.preventDefault();
    var message = textarea.value.trim();
    if (!message) { return; }

    appendMessage('user', '<p>' + escapeHtml(message).replace(/\n/g, '<br>') + '</p>');
    textarea.value = '';
    textarea.style.height = 'auto';

    submitBtn.disabled = true;
    var typing = document.createElement('div');
    typing.className = 'chat-typing';
    typing.textContent = 'Le mentor réfléchit…';
    messagesBox.appendChild(typing);
    scrollToBottom();

    window.IgoTech.postJson('/api/chat/' + conversationId + '/send', { message: message })
      .then(function (res) {
        typing.remove();
        submitBtn.disabled = false;
        if (res.ok) {
          appendMessage('assistant', res.reply_html);
          if (res.trial_remaining !== null && res.trial_remaining !== undefined) {
            if (res.trial_remaining > 0) {
              appendMessage('assistant', '<p style="font-size:.8rem;color:var(--muted);">' + res.trial_remaining + ' message(s) d\'essai gratuit restant(s).</p>');
            } else {
              appendMessage('assistant', '<p>C\'était ton dernier message gratuit ! <a class="btn btn-accent btn-sm" href="/subscribe">S\'abonner pour 2000 FCFA/mois</a></p>');
            }
          }
        } else if (res.requires_subscription) {
          appendMessage('assistant', '<p>' + escapeHtml(res.error) + '</p><p><a class="btn btn-accent btn-sm" href="/subscribe">S\'abonner pour 2000 FCFA/mois</a></p>');
        } else {
          appendMessage('assistant', '<p>' + escapeHtml(res.reply || res.error || 'Erreur inconnue.') + '</p>');
        }
      })
      .catch(function () {
        typing.remove();
        submitBtn.disabled = false;
        appendMessage('assistant', '<p>Connexion impossible. Vérifie ta connexion et réessaie.</p>');
      });
  });

  scrollToBottom();
})();
