(function () {
  'use strict';

  function csrfToken() {
    var meta = document.querySelector('meta[name="csrf-token"]');
    return meta ? meta.getAttribute('content') : '';
  }

  window.IgoTech = window.IgoTech || {};
  window.IgoTech.csrfToken = csrfToken;

  window.IgoTech.postJson = function (url, data) {
    return fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
      },
      body: JSON.stringify(Object.assign({ csrf_token: csrfToken() }, data)),
    }).then(function (res) {
      return res.json();
    });
  };

  document.querySelectorAll('.account-menu').forEach(function (menu) {
    document.addEventListener('click', function (e) {
      if (menu.open && !menu.contains(e.target)) menu.open = false;
    });
    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape' && menu.open) {
        menu.open = false;
        menu.querySelector('summary').focus();
      }
    });
  });

  // -----------------------------------------------------------
  // Bouton "Marquer comme terminé" sur une leçon
  // -----------------------------------------------------------
  document.querySelectorAll('[data-complete-lesson]').forEach(function (btn) {
    btn.addEventListener('click', function () {
      var lessonId = btn.getAttribute('data-complete-lesson');
      btn.disabled = true;
      btn.textContent = 'Enregistrement…';

      window.IgoTech.postJson('/api/lessons/' + lessonId + '/complete', {})
        .then(function (res) {
          if (res.ok) {
            btn.textContent = '✓ Leçon terminée';
            var nextLink = document.querySelector('[data-next-lesson]');
            if (nextLink) { nextLink.classList.remove('btn-outline'); nextLink.classList.add('btn-primary'); }
          } else {
            btn.disabled = false;
            btn.textContent = 'Réessayer';
          }
        })
        .catch(function () {
          btn.disabled = false;
          btn.textContent = 'Réessayer';
        });
    });
  });

  // -----------------------------------------------------------
  // Quiz
  // -----------------------------------------------------------
  var quizForm = document.querySelector('[data-quiz-form]');
  if (quizForm) {
    quizForm.addEventListener('submit', function (e) {
      e.preventDefault();
      var quizId = quizForm.getAttribute('data-quiz-form');
      var answers = {};
      quizForm.querySelectorAll('input[type=radio]:checked').forEach(function (input) {
        answers[input.name.replace('answers[', '').replace(']', '')] = input.value;
      });

      var resultBox = document.querySelector('[data-quiz-result]');
      var submitBtn = quizForm.querySelector('button[type=submit]');
      submitBtn.disabled = true;

      window.IgoTech.postJson('/api/quiz/' + quizId + '/submit', { answers: answers })
        .then(function (res) {
          submitBtn.disabled = false;
          if (!res.ok) {
            resultBox.textContent = 'Une erreur est survenue, réessaie.';
            resultBox.className = 'quiz-result fail';
            return;
          }
          resultBox.className = 'quiz-result ' + (res.passed ? 'pass' : 'fail');
          resultBox.textContent = res.passed
            ? '✓ Bravo ! Score : ' + res.score_percent + '% (' + res.correct + '/' + res.total + ')'
            : 'Score : ' + res.score_percent + '% (' + res.correct + '/' + res.total + '). Relis la leçon et retente ta chance.';
          resultBox.style.display = 'block';
        });
    });
  }

  // -----------------------------------------------------------
  // Menu mobile simple
  // -----------------------------------------------------------
  var toggle = document.querySelector('[data-nav-toggle]');
  var links = document.querySelector('.nav-links');
  if (toggle && links) {
    toggle.addEventListener('click', function () {
      links.style.display = links.style.display === 'flex' ? 'none' : 'flex';
    });
  }
})();
