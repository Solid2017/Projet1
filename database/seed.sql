-- IgoTech IA — données de démonstration
-- Compte admin: admin@igotech.ia / mot de passe: IgoTech2026!
-- (hash généré avec password_hash PHP — à changer immédiatement après import)

SET NAMES utf8mb4;

INSERT INTO users (name, email, password_hash, role, headline, avatar_color) VALUES
('Admin IgoTech', 'admin@igotech.ia', '$2y$12$87RXYKg.Z6Tsxkg9vLZeduCkpbhO1PYFlZs8N.PAk3esIr70zL2Ym', 'admin', 'Fondateur & formateur', '#EE1111');

INSERT INTO tracks (slug, title, subtitle, description, icon, color, level, mentor_persona, is_published, position) VALUES
('developpement-web', 'Développement Web Full-Stack', 'HTML, CSS, JavaScript, PHP & bases de données',
 'Deviens développeur web full-stack : construis des sites et applications complètes, du front-end au back-end, jusqu''au déploiement.',
 'code', 'blue', 'debutant',
 'Tu es un mentor senior en développement web full-stack, pédagogue et concret. Tu expliques avec des exemples de code courts, tu encourages la pratique par petits projets et tu relies chaque notion à des cas d''usage réels du métier de développeur web.',
 1, 1),
('data-ia', 'Data & Intelligence Artificielle', 'Python, data science et machine learning',
 'Apprends à manipuler la donnée, construire des modèles de machine learning et comprendre les fondamentaux de l''IA appliquée.',
 'chart', 'red', 'intermediaire',
 'Tu es un mentor senior en data science et IA. Tu vulgarises les concepts mathématiques et statistiques, tu proposes des exercices avec des jeux de données simples, et tu insistes sur la rigueur méthodologique (biais, validation, éthique des données).',
 1, 2),
('cybersecurite', 'Cybersécurité', 'Sécurité offensive et défensive',
 'Comprends les fondamentaux de la sécurité informatique : réseaux, systèmes, bonnes pratiques et introduction au pentest éthique.',
 'shield', 'blue', 'intermediaire',
 'Tu es un mentor senior en cybersécurité, rigoureux sur l''éthique et la légalité. Tu enseignes uniquement dans un cadre autorisé et défensif, expliques les mécanismes d''attaque pour mieux les contrer, et rappelles systématiquement les bonnes pratiques responsables.',
 1, 3),
('devops-cloud', 'DevOps & Cloud', 'CI/CD, conteneurs et infrastructure',
 'Maîtrise les outils et pratiques DevOps modernes : versioning, intégration continue, conteneurisation et déploiement cloud.',
 'cloud', 'red', 'avance',
 'Tu es un mentor senior DevOps. Tu es pragmatique, orienté outillage (Git, CI/CD, Docker, supervision) et tu insistes sur l''automatisation et la fiabilité des déploiements.',
 1, 4);

INSERT INTO modules (track_id, title, description, position) VALUES
(1, 'Les fondamentaux du web', 'Comprendre comment fonctionne le web et structurer une page.', 1),
(1, 'JavaScript pour l''interactivité', 'Rendre les pages web dynamiques et interactives.', 2),
(1, 'Back-end avec PHP & MySQL', 'Construire un serveur, une API et une base de données.', 3);

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(1, 'Comment fonctionne le web ?', 'Client, serveur, HTTP, navigateur.',
 '# Comment fonctionne le web ?\n\nQuand tu tapes une adresse dans ton navigateur, plusieurs étapes se déroulent :\n\n1. **DNS** : le nom de domaine est traduit en adresse IP.\n2. **Requête HTTP** : ton navigateur (le *client*) envoie une requête au *serveur*.\n3. **Réponse** : le serveur renvoie du HTML, CSS et JavaScript.\n4. **Rendu** : le navigateur affiche la page.\n\n## À retenir\n- Le web repose sur le protocole **HTTP/HTTPS**.\n- Une page web = HTML (structure) + CSS (style) + JavaScript (comportement).\n\n## Exercice\nOuvre les outils de développement de ton navigateur (F12), onglet *Réseau*, et recharge une page. Observe les requêtes envoyées.',
 20, 1),
(1, 'Structurer une page avec HTML', 'Balises sémantiques et bonnes pratiques.',
 '# Structurer une page avec HTML\n\nHTML (HyperText Markup Language) sert à structurer le contenu.\n\n```html\n<!DOCTYPE html>\n<html lang="fr">\n<head>\n  <meta charset="UTF-8">\n  <title>Ma page</title>\n</head>\n<body>\n  <header><h1>Bienvenue</h1></header>\n  <main><p>Contenu principal</p></main>\n  <footer>© 2026</footer>\n</body>\n</html>\n```\n\nPrivilégie toujours les balises sémantiques (`header`, `main`, `nav`, `footer`, `article`) plutôt que des `div` génériques : c''est plus accessible et plus lisible.',
 25, 2),
(2, 'Les bases de JavaScript', 'Variables, fonctions, conditions et boucles.',
 '# Les bases de JavaScript\n\n```js\nlet nom = "Awa";\nfunction saluer(personne) {\n  return `Bonjour ${personne} !`;\n}\nconsole.log(saluer(nom));\n```\n\nJavaScript est le langage qui rend une page **interactive** : validation de formulaire, animations, appels vers un serveur (fetch), etc.',
 30, 1),
(3, 'Premiers pas avec PHP', 'Variables, requêtes SQL préparées avec PDO.',
 '# Premiers pas avec PHP\n\nPHP s''exécute côté serveur. Voici comment se connecter en sécurité à une base MySQL avec PDO :\n\n```php\n$pdo = new PDO("mysql:host=localhost;dbname=igotech;charset=utf8mb4", $user, $pass);\n$stmt = $pdo->prepare("SELECT * FROM users WHERE email = ?");\n$stmt->execute([$email]);\n$user = $stmt->fetch();\n```\n\n**Toujours** utiliser des requêtes préparées pour éviter les injections SQL.',
 30, 1);

INSERT INTO quizzes (lesson_id, title, pass_score_percent) VALUES
(1, 'Quiz — Comment fonctionne le web ?', 60);

INSERT INTO quiz_questions (quiz_id, question, position) VALUES
(1, 'Que traduit le DNS ?', 1),
(1, 'Quel langage sert à structurer le contenu d''une page ?', 2);

INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(1, 'Un nom de domaine en adresse IP', 1, 1),
(1, 'Une adresse IP en nom de domaine', 0, 2),
(1, 'Un mot de passe en hash', 0, 3),
(2, 'CSS', 0, 1),
(2, 'HTML', 1, 2),
(2, 'JavaScript', 0, 3);
