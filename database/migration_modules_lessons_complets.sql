-- IgoTech IA — contenu complet (modules + leçons + un quiz) pour les
-- 17 parcours qui n'avaient encore que leur fiche de présentation.
-- À importer via phpMyAdmin, après toutes les migrations déjà en
-- place (schema.sql, seed.sql, seed_more_tracks.sql,
-- migration_tracks_tchad.sql, migration_tracks_secteurs.sql).
--
-- Ne touche jamais aux IDs en dur : chaque parcours est retrouvé par
-- son "slug" (stable, jamais modifié par l'admin), donc cette
-- migration s'importe sans risque quel que soit l'ordre réel des IDs
-- sur ton serveur. Idempotence : si tu l'importes deux fois, les
-- modules/leçons seront dupliqués (comme n'importe quel INSERT) — ne
-- l'importe qu'une seule fois.
--
-- Pour chaque parcours : 2 modules, 2 leçons par module (4 leçons),
-- et un quiz de validation (2 questions) sur la toute première leçon.
-- C'est une base solide et cohérente que tu peux enrichir à volonté
-- depuis Administration → Parcours.

SET NAMES utf8mb4;

-- =====================================================================
-- Data & Intelligence Artificielle (data-ia)
-- =====================================================================
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Fondamentaux de la donnée', 'Comprendre ce qu''est la data science et manipuler ses premiers outils.', 1 FROM tracks WHERE slug = 'data-ia';
SET @m1 = LAST_INSERT_ID();
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Introduction au Machine Learning', 'Découvrir les grands principes du machine learning.', 2 FROM tracks WHERE slug = 'data-ia';
SET @m2 = LAST_INSERT_ID();

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m1, 'Qu''est-ce que la data science ?', 'Données, statistiques et IA : les bases.',
'# Qu''est-ce que la data science ?\n\nLa data science consiste à extraire de la connaissance utile à partir de données brutes, en combinant statistiques, programmation et connaissance du métier.\n\n## Les trois piliers\n\n- **Collecter** : récupérer des données fiables (bases de données, capteurs, fichiers).\n- **Analyser** : nettoyer, explorer et comprendre ce que racontent les chiffres.\n- **Modéliser** : construire des modèles pour prédire ou classer.\n\n## Exemple concret\n\nUne banque qui analyse l''historique de ses clients pour prédire qui risque de ne pas rembourser un crédit fait de la data science.\n\n## À retenir\n- La donnée brute n''a de valeur que correctement analysée.\n- Python est le langage le plus utilisé dans ce domaine.', 20, 1),
(@m1, 'Python pour la donnée : les bases', 'Manipuler des données avec Python et pandas.',
'# Python pour la donnée\n\nPython est devenu le langage standard de la data science grâce à ses bibliothèques, notamment **pandas** pour manipuler des tableaux de données.\n\n```python\nimport pandas as pd\n\ndf = pd.read_csv("ventes.csv")\nprint(df.head())\nprint(df["montant"].mean())\n```\n\nCe petit script charge un fichier de ventes, affiche les premières lignes et calcule la moyenne des montants.\n\n## À retenir\n- Un `DataFrame` pandas ressemble à un tableau Excel manipulable par le code.\n- Toujours commencer par regarder ses données (`head()`, `describe()`) avant de les analyser.', 25, 2);

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m2, 'Qu''est-ce que le machine learning ?', 'Apprentissage supervisé, non supervisé : les grands principes.',
'# Qu''est-ce que le machine learning ?\n\nLe machine learning permet à un programme d''apprendre des règles à partir d''exemples, plutôt que de les coder explicitement.\n\n## Deux grandes familles\n\n- **Apprentissage supervisé** : on montre des exemples avec la bonne réponse (ex : des e-mails étiquetés spam/non-spam) pour que le modèle apprenne à généraliser.\n- **Apprentissage non supervisé** : on laisse le modèle découvrir des structures cachées dans les données (ex : regrouper des clients similaires).\n\n## À retenir\n- Un modèle n''est jamais parfait : il faut toujours évaluer sa performance sur des données qu''il n''a jamais vues.\n- La qualité des données compte souvent plus que la complexité du modèle.', 20, 1),
(@m2, 'Entraîner un premier modèle simple', 'Un exemple concret de classification avec scikit-learn.',
'# Entraîner un premier modèle\n\nLa bibliothèque **scikit-learn** permet d''entraîner des modèles simples en quelques lignes.\n\n```python\nfrom sklearn.linear_model import LogisticRegression\n\nmodele = LogisticRegression()\nmodele.fit(X_entrainement, y_entrainement)\nprediction = modele.predict(X_test)\n```\n\nIci, `X_entrainement` contient les données d''exemple et `y_entrainement` les bonnes réponses associées. Une fois entraîné, le modèle peut prédire sur de nouvelles données (`X_test`).\n\n## Exercice\nCherche un petit jeu de données public (ex: fleurs Iris) et entraîne une régression logistique dessus.', 25, 2);

SET @lesson1_data_ia = (SELECT l.id FROM lessons l WHERE l.module_id = @m1 AND l.position = 1);
INSERT INTO quizzes (lesson_id, title, pass_score_percent) VALUES (@lesson1_data_ia, 'Quiz — Qu''est-ce que la data science ?', 60);
SET @quiz = LAST_INSERT_ID();
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Quel langage est le plus utilisé en data science ?', 1);
SET @q1 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q1, 'Python', 1, 1), (@q1, 'HTML', 0, 2), (@q1, 'CSS', 0, 3);
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Que fait la phase "modéliser" en data science ?', 2);
SET @q2 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q2, 'Construire un modèle pour prédire ou classer', 1, 1), (@q2, 'Supprimer toutes les données', 0, 2), (@q2, 'Créer une page web', 0, 3);

-- =====================================================================
-- Cybersécurité (cybersecurite)
-- =====================================================================
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Fondamentaux de la sécurité', 'Les principes de base pour protéger systèmes et données.', 1 FROM tracks WHERE slug = 'cybersecurite';
SET @m1 = LAST_INSERT_ID();
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Sécurité réseau et bonnes pratiques', 'Protéger un réseau et reconnaître les attaques courantes.', 2 FROM tracks WHERE slug = 'cybersecurite';
SET @m2 = LAST_INSERT_ID();

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m1, 'La triade CIA : confidentialité, intégrité, disponibilité', 'Le modèle de base de toute la cybersécurité.',
'# La triade CIA\n\nTout objectif de sécurité informatique se ramène à trois principes (CIA en anglais) :\n\n- **Confidentialité** : seules les personnes autorisées accèdent à l''information.\n- **Intégrité** : l''information n''est pas altérée sans autorisation.\n- **Disponibilité** : l''information et les services restent accessibles quand on en a besoin.\n\n## Exemple\nUn site bancaire piraté qui affiche de faux soldes viole l''intégrité ; un site inaccessible pendant une attaque viole la disponibilité.\n\n## À retenir\nToute mesure de sécurité (mot de passe, sauvegarde, pare-feu) sert toujours l''un de ces trois objectifs.', 20, 1),
(@m1, 'Mots de passe et authentification forte', 'Pourquoi un mot de passe seul ne suffit plus.',
'# Authentification forte\n\nUn mot de passe seul reste vulnérable (réutilisation, fuite de données, attaque par force brute). L''authentification à deux facteurs (2FA) ajoute une deuxième preuve d''identité.\n\n## Les trois facteurs possibles\n- Ce que tu **sais** (mot de passe, code PIN)\n- Ce que tu **possèdes** (téléphone, clé de sécurité)\n- Ce que tu **es** (empreinte digitale, reconnaissance faciale)\n\n## Bonnes pratiques\n- Un mot de passe unique et long par service (un gestionnaire de mots de passe aide beaucoup).\n- Active la 2FA partout où c''est possible (e-mail, banque, réseaux sociaux).', 20, 2);

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m2, 'Pare-feu et segmentation réseau', 'Contrôler qui peut parler à qui sur un réseau.',
'# Pare-feu et segmentation réseau\n\nUn pare-feu (firewall) filtre le trafic réseau selon des règles : il autorise ou bloque des connexions en fonction de leur origine, destination et port.\n\nLa **segmentation réseau** consiste à diviser un réseau en zones isolées (ex : réseau des employés séparé du réseau des visiteurs) pour qu''une compromission d''une zone ne se propage pas automatiquement aux autres.\n\n## À retenir\n- Le principe du moindre privilège : n''ouvrir que les accès strictement nécessaires.\n- Un réseau plat (tout connecté à tout) est beaucoup plus vulnérable qu''un réseau segmenté.', 20, 1),
(@m2, 'Reconnaître le phishing et l''ingénierie sociale', 'La première ligne de défense reste humaine.',
'# Phishing et ingénierie sociale\n\nLa majorité des attaques réussies exploitent la confiance humaine plutôt qu''une faille technique.\n\n## Signaux d''alerte d''un e-mail de phishing\n- Urgence artificielle ("votre compte sera bloqué dans 24h").\n- Adresse d''expéditeur qui imite légèrement une adresse connue.\n- Lien dont l''adresse réelle (au survol) ne correspond pas au texte affiché.\n- Demande d''informations sensibles (mot de passe, code de carte).\n\n## Réflexe à adopter\nEn cas de doute, ne clique jamais directement : contacte l''organisme par un canal officiel connu (site tapé toi-même, numéro officiel).', 15, 2);

SET @lesson1_cyber = (SELECT l.id FROM lessons l WHERE l.module_id = @m1 AND l.position = 1);
INSERT INTO quizzes (lesson_id, title, pass_score_percent) VALUES (@lesson1_cyber, 'Quiz — La triade CIA', 60);
SET @quiz = LAST_INSERT_ID();
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Que signifie le "I" de la triade CIA ?', 1);
SET @q1 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q1, 'Intégrité', 1, 1), (@q1, 'Internet', 0, 2), (@q1, 'Identité', 0, 3);
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Un site inaccessible lors d''une attaque viole quel principe ?', 2);
SET @q2 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q2, 'La disponibilité', 1, 1), (@q2, 'La confidentialité', 0, 2), (@q2, 'Aucun des deux', 0, 3);

-- =====================================================================
-- DevOps & Cloud (devops-cloud)
-- =====================================================================
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Versioning et intégration continue', 'Git et les bases de la CI/CD.', 1 FROM tracks WHERE slug = 'devops-cloud';
SET @m1 = LAST_INSERT_ID();
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Conteneurs et déploiement', 'Docker et le déploiement dans le cloud.', 2 FROM tracks WHERE slug = 'devops-cloud';
SET @m2 = LAST_INSERT_ID();

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m1, 'Git, les bases indispensables', 'Suivre et partager l''historique de son code.',
'# Git, les bases indispensables\n\nGit permet d''enregistrer l''historique des modifications d''un projet et de collaborer sans écraser le travail des autres.\n\n```bash\ngit init\ngit add .\ngit commit -m "Premier commit"\ngit push origin main\n```\n\n## Les commandes essentielles\n- `git status` : voir ce qui a changé.\n- `git commit` : enregistrer un instantané du code avec un message clair.\n- `git branch` : travailler sur une fonctionnalité sans toucher au code principal.\n\n## À retenir\nUn message de commit clair explique le **pourquoi**, pas seulement le quoi.', 20, 1),
(@m1, 'Qu''est-ce que la CI/CD ?', 'Automatiser les tests et le déploiement.',
'# Qu''est-ce que la CI/CD ?\n\n- **Intégration continue (CI)** : chaque modification de code déclenche automatiquement des tests, pour détecter les problèmes tôt.\n- **Déploiement continu (CD)** : si les tests passent, le code est automatiquement envoyé en production (ou prêt à l''être).\n\n## Pourquoi c''est important\nSans CI/CD, les erreurs ne sont découvertes que tard, souvent directement par les utilisateurs. Avec CI/CD, l''équipe est alertée en quelques minutes.\n\n## À retenir\nUn pipeline CI/CD typique : code poussé → tests automatiques → build → déploiement.', 20, 2);

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m2, 'Introduction à Docker', 'Faire tourner une application partout de la même façon.',
'# Introduction à Docker\n\nDocker permet d''empaqueter une application avec tout ce dont elle a besoin (dépendances, configuration) dans un **conteneur** qui fonctionne de façon identique sur n''importe quelle machine.\n\n```dockerfile\nFROM php:8.2-apache\nCOPY . /var/www/html/\nEXPOSE 80\n```\n\nCe `Dockerfile` décrit comment construire une image contenant une application PHP prête à être exécutée.\n\n## À retenir\n- Une **image** est un modèle figé ; un **conteneur** est une instance en cours d''exécution de cette image.\n- Docker résout le fameux "ça marche sur ma machine".', 25, 1),
(@m2, 'Déployer une application dans le cloud', 'Les grandes étapes d''une mise en production cloud.',
'# Déployer dans le cloud\n\nDéployer une application dans le cloud suit généralement ces étapes :\n\n1. Construire l''application (build).\n2. Faire tourner les tests automatisés.\n3. Déployer sur un environnement de préproduction.\n4. Valider, puis déployer en production.\n5. Surveiller (monitoring, alertes) après la mise en ligne.\n\n## À retenir\nUn déploiement réussi n''est jamais "terminé" à la mise en ligne : la supervision après déploiement est essentielle pour détecter vite un problème.', 20, 2);

SET @lesson1_devops = (SELECT l.id FROM lessons l WHERE l.module_id = @m1 AND l.position = 1);
INSERT INTO quizzes (lesson_id, title, pass_score_percent) VALUES (@lesson1_devops, 'Quiz — Git, les bases', 60);
SET @quiz = LAST_INSERT_ID();
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Quelle commande enregistre un instantané du code ?', 1);
SET @q1 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q1, 'git commit', 1, 1), (@q1, 'git delete', 0, 2), (@q1, 'git format', 0, 3);
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'À quoi sert une branche Git ?', 2);
SET @q2 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q2, 'Travailler sur une fonctionnalité sans toucher au code principal', 1, 1), (@q2, 'Supprimer l''historique', 0, 2), (@q2, 'Envoyer un e-mail', 0, 3);

-- =====================================================================
-- Développement Mobile (developpement-mobile)
-- =====================================================================
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Choisir son approche mobile', 'Natif ou multiplateforme : comprendre les options.', 1 FROM tracks WHERE slug = 'developpement-mobile';
SET @m1 = LAST_INSERT_ID();
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Premiers pas avec Flutter', 'Construire et publier une première application.', 2 FROM tracks WHERE slug = 'developpement-mobile';
SET @m2 = LAST_INSERT_ID();

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m1, 'Natif vs multiplateforme', 'Flutter, React Native, Swift, Kotlin : comment choisir ?',
'# Natif vs multiplateforme\n\n- **Natif** (Swift pour iOS, Kotlin pour Android) : performance et accès maximal aux fonctionnalités du téléphone, mais deux bases de code séparées à maintenir.\n- **Multiplateforme** (Flutter, React Native) : un seul code pour iOS et Android, développement plus rapide, au prix de quelques limitations sur les fonctionnalités très spécifiques.\n\n## Comment choisir ?\n- Petite équipe, besoin de rapidité → multiplateforme.\n- Application très spécialisée (jeu, usage intensif de capteurs) → natif.\n\n## À retenir\nIl n''y a pas de bon choix universel : tout dépend du projet et des contraintes de temps/budget.', 20, 1),
(@m1, 'Anatomie d''une application mobile', 'Interface, logique métier, stockage : les grandes couches.',
'# Anatomie d''une application mobile\n\nUne application mobile s''organise généralement en couches :\n\n- **Interface (UI)** : ce que l''utilisateur voit et touche.\n- **Logique métier** : les règles de l''application (calculs, validations).\n- **Stockage/réseau** : sauvegarde locale et communication avec un serveur (API).\n\n## À retenir\nSéparer clairement ces couches rend l''application plus facile à faire évoluer et à tester.', 15, 2);

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m2, 'Les widgets de base (Flutter)', 'Construire un premier écran.',
'# Les widgets de base\n\nEn Flutter, tout est un **widget** : un bouton, un texte, une mise en page sont tous des widgets qui s''emboîtent les uns dans les autres.\n\n```dart\nimport ''package:flutter/material.dart'';\n\nvoid main() => runApp(MaterialApp(\n  home: Scaffold(\n    appBar: AppBar(title: Text("Mon app")),\n    body: Center(child: Text("Bonjour IgoTech IA")),\n  ),\n));\n```\n\nCe code affiche un écran avec une barre de titre et un texte centré.\n\n## À retenir\nLa mise en page Flutter fonctionne en emboîtant des widgets (un peu comme des poupées russes).', 25, 1),
(@m2, 'Publier son application', 'Les grandes étapes pour arriver sur les stores.',
'# Publier son application\n\nAvant de publier sur l''App Store ou le Play Store :\n\n1. Tester soigneusement sur de vrais appareils.\n2. Préparer les visuels requis (icône, captures d''écran).\n3. Rédiger une description claire et des mots-clés pertinents.\n4. Créer un compte développeur (payant chez Apple, modique chez Google).\n5. Soumettre pour validation (Apple vérifie manuellement, Google plus automatiquement).\n\n## À retenir\nPrévois du temps pour la validation, en particulier côté Apple (plusieurs jours possibles).', 15, 2);

SET @lesson1_mobile = (SELECT l.id FROM lessons l WHERE l.module_id = @m1 AND l.position = 1);
INSERT INTO quizzes (lesson_id, title, pass_score_percent) VALUES (@lesson1_mobile, 'Quiz — Natif vs multiplateforme', 60);
SET @quiz = LAST_INSERT_ID();
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Quel est l''avantage principal du multiplateforme ?', 1);
SET @q1 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q1, 'Un seul code pour iOS et Android', 1, 1), (@q1, 'Accès total au matériel', 0, 2), (@q1, 'Toujours plus rapide à l''exécution', 0, 3);
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Swift est le langage natif de quelle plateforme ?', 2);
SET @q2 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q2, 'iOS', 1, 1), (@q2, 'Android', 0, 2), (@q2, 'Windows', 0, 3);

-- =====================================================================
-- Administration Systèmes & Réseaux (administration-systemes-reseaux)
-- =====================================================================
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Administration Linux', 'Les commandes et notions essentielles.', 1 FROM tracks WHERE slug = 'administration-systemes-reseaux';
SET @m1 = LAST_INSERT_ID();
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Réseaux et supervision', 'Comprendre un réseau et surveiller un serveur.', 2 FROM tracks WHERE slug = 'administration-systemes-reseaux';
SET @m2 = LAST_INSERT_ID();

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m1, 'Les commandes essentielles du terminal', 'Naviguer et agir en ligne de commande Linux.',
'# Les commandes essentielles\n\n```bash\nls -la          # lister les fichiers, y compris cachés\ncd /var/www     # se déplacer dans un dossier\ncat fichier.txt # afficher le contenu d''un fichier\ntop             # voir les processus en cours et leur consommation\n```\n\n## À retenir\n- La ligne de commande est plus rapide et plus fiable qu''une interface graphique pour administrer un serveur.\n- `man <commande>` affiche toujours le manuel d''une commande en cas de doute.', 20, 1),
(@m1, 'Gérer les utilisateurs et les permissions', 'Qui peut faire quoi sur un système Linux.',
'# Utilisateurs et permissions\n\nSous Linux, chaque fichier a un propriétaire, un groupe, et des permissions de lecture/écriture/exécution pour chacun.\n\n```bash\nchmod 644 fichier.txt   # lecture/écriture pour le propriétaire, lecture pour les autres\nchown www-data fichier  # change le propriétaire du fichier\n```\n\n## À retenir\nLe principe du moindre privilège s''applique aussi ici : ne donne jamais plus de droits que nécessaire (éviter `chmod 777`).', 20, 2);

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m2, 'Les bases du modèle TCP/IP', 'Comment les machines se parlent sur un réseau.',
'# Les bases du modèle TCP/IP\n\nChaque machine sur un réseau possède une **adresse IP**. Les communications passent par des **ports** (ex : port 80 pour le web, port 22 pour une connexion sécurisée SSH).\n\n## À retenir\n- Une adresse IP identifie une machine ; un port identifie un service sur cette machine.\n- `ping` permet de vérifier qu''une machine répond ; `traceroute` montre le chemin emprunté par les paquets.', 20, 1),
(@m2, 'Superviser un serveur', 'Logs et surveillance pour anticiper les problèmes.',
'# Superviser un serveur\n\nLes fichiers de **logs** (souvent dans `/var/log/`) enregistrent ce qui se passe sur un serveur : connexions, erreurs, avertissements.\n\n## Bonnes pratiques\n- Consulter régulièrement les logs plutôt qu''attendre qu''un utilisateur signale un problème.\n- Mettre en place des alertes automatiques (espace disque faible, service arrêté).\n\n## À retenir\nUn serveur bien supervisé permet de résoudre un problème avant qu''il n''affecte les utilisateurs.', 15, 2);

SET @lesson1_sysadmin = (SELECT l.id FROM lessons l WHERE l.module_id = @m1 AND l.position = 1);
INSERT INTO quizzes (lesson_id, title, pass_score_percent) VALUES (@lesson1_sysadmin, 'Quiz — Les commandes essentielles', 60);
SET @quiz = LAST_INSERT_ID();
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Quelle commande affiche les processus en cours ?', 1);
SET @q1 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q1, 'top', 1, 1), (@q1, 'cat', 0, 2), (@q1, 'cd', 0, 3);
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Où trouver l''aide détaillée d''une commande Linux ?', 2);
SET @q2 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q2, 'man <commande>', 1, 1), (@q2, 'help.com', 0, 2), (@q2, 'Il n''y en a pas', 0, 3);

-- =====================================================================
-- UX/UI Design (ux-ui-design)
-- =====================================================================
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Recherche utilisateur et conception', 'Comprendre les besoins avant de concevoir.', 1 FROM tracks WHERE slug = 'ux-ui-design';
SET @m1 = LAST_INSERT_ID();
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Principes visuels et accessibilité', 'Rendre une interface claire et accessible à tous.', 2 FROM tracks WHERE slug = 'ux-ui-design';
SET @m2 = LAST_INSERT_ID();

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m1, 'Comprendre les besoins utilisateurs', 'La conception commence avant l''écran.',
'# Comprendre les besoins utilisateurs\n\nConcevoir une bonne interface commence par comprendre qui va l''utiliser et pourquoi, pas par dessiner des écrans.\n\n## Méthodes simples\n- **Interviews** : poser des questions ouvertes à de vrais utilisateurs potentiels.\n- **Observation** : regarder comment les gens font aujourd''hui, sans ton produit.\n\n## À retenir\nUne belle interface qui résout le mauvais problème reste un échec. Toujours vérifier qu''on construit la bonne chose avant de bien la construire.', 20, 1),
(@m1, 'Du wireframe au prototype', 'Passer de l''idée à une maquette testable.',
'# Du wireframe au prototype\n\n- **Wireframe** : croquis simple en noir et blanc montrant l''organisation d''un écran, sans détail visuel.\n- **Prototype** : version cliquable (souvent avec un outil comme Figma) qui simule le comportement réel.\n\n## À retenir\nTester un prototype avec de vrais utilisateurs avant de coder permet de corriger les problèmes à moindre coût.', 20, 2);

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m2, 'Hiérarchie visuelle et typographie', 'Guider l''œil de l''utilisateur.',
'# Hiérarchie visuelle et typographie\n\nLa **hiérarchie visuelle** guide l''œil vers ce qui est important en premier (taille, couleur, contraste, espacement).\n\n## Quelques règles simples\n- Un titre plus grand et plus gras que le texte courant.\n- Pas plus de 2-3 tailles de police différentes par écran.\n- Un espace blanc généreux améliore la lisibilité plus qu''il ne la réduit.\n\n## À retenir\nSi tout est mis en avant avec la même intensité, rien ne l''est vraiment.', 15, 1),
(@m2, 'Concevoir pour l''accessibilité', 'Une interface utilisable par le plus grand nombre.',
'# Concevoir pour l''accessibilité\n\nL''accessibilité consiste à rendre une interface utilisable par des personnes aux capacités différentes (vue, audition, motricité).\n\n## Bonnes pratiques de base\n- Un contraste suffisant entre texte et fond.\n- Des boutons assez grands pour être cliqués facilement (surtout sur mobile).\n- Du texte alternatif sur les images importantes.\n\n## À retenir\nL''accessibilité profite en réalité à tout le monde (ex : contraste utile en plein soleil).', 15, 2);

SET @lesson1_ux = (SELECT l.id FROM lessons l WHERE l.module_id = @m1 AND l.position = 1);
INSERT INTO quizzes (lesson_id, title, pass_score_percent) VALUES (@lesson1_ux, 'Quiz — Comprendre les besoins utilisateurs', 60);
SET @quiz = LAST_INSERT_ID();
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Que faut-il faire avant de dessiner un écran ?', 1);
SET @q1 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q1, 'Comprendre les besoins des utilisateurs', 1, 1), (@q1, 'Choisir une police', 0, 2), (@q1, 'Écrire le code', 0, 3);
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Qu''est-ce qu''un wireframe ?', 2);
SET @q2 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q2, 'Un croquis simple sans détail visuel', 1, 1), (@q2, 'Le code final de l''application', 0, 2), (@q2, 'Une base de données', 0, 3);

-- =====================================================================
-- Gestion de Projets IT (gestion-de-projets-it)
-- =====================================================================
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Méthodes agiles', 'Scrum et la gestion itérative de projet.', 1 FROM tracks WHERE slug = 'gestion-de-projets-it';
SET @m1 = LAST_INSERT_ID();
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Pilotage et communication', 'Suivre l''avancement et communiquer efficacement.', 2 FROM tracks WHERE slug = 'gestion-de-projets-it';
SET @m2 = LAST_INSERT_ID();

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m1, 'Scrum : rôles et cérémonies', 'Le cadre agile le plus utilisé dans l''IT.',
'# Scrum : rôles et cérémonies\n\n## Les rôles\n- **Product Owner** : définit les priorités du produit.\n- **Scrum Master** : facilite le processus et lève les obstacles.\n- **Équipe de développement** : réalise le travail.\n\n## Les cérémonies clés\n- **Sprint planning** : on choisit ce qu''on va faire sur les 1-2 prochaines semaines.\n- **Daily standup** : point rapide quotidien (15 min max).\n- **Rétrospective** : on discute de ce qui a bien/mal fonctionné pour s''améliorer.\n\n## À retenir\nScrum fonctionne par cycles courts (sprints) permettant d''ajuster rapidement le cap.', 20, 1),
(@m1, 'Rédiger un backlog efficace', 'Prioriser ce qui compte vraiment.',
'# Rédiger un backlog efficace\n\nLe backlog est la liste priorisée de tout ce qui reste à faire sur un projet.\n\n## Une bonne tâche ("user story") suit souvent ce format\n> En tant que [utilisateur], je veux [action] afin de [bénéfice].\n\nExemple : "En tant qu''apprenant, je veux recevoir un rappel par WhatsApp afin de ne pas oublier ma leçon du jour."\n\n## À retenir\nUn backlog trop long et jamais trié perd toute son utilité : priorise sans relâche.', 15, 2);

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m2, 'Suivre l''avancement (Kanban, burndown)', 'Visualiser où en est le projet.',
'# Suivre l''avancement\n\n- **Tableau Kanban** : colonnes "À faire / En cours / Terminé" pour visualiser le flux de travail.\n- **Burndown chart** : graphique montrant le travail restant au fil du temps, pour voir si le projet est dans les temps.\n\n## À retenir\nCes outils servent à rendre visible l''état réel du projet, pas à remplir de la paperasse : s''ils ne sont pas tenus à jour, ils ne servent à rien.', 15, 1),
(@m2, 'Communiquer avec les parties prenantes', 'Adapter son message selon son interlocuteur.',
'# Communiquer avec les parties prenantes\n\nUn développeur et un directeur ne parlent pas le même langage technique. L''art du chef de projet est de traduire l''un vers l''autre.\n\n## Bonnes pratiques\n- Face à une personne non technique, parler en impact (coût, délai, risque) plutôt qu''en détails techniques.\n- Communiquer les mauvaises nouvelles tôt, jamais à la dernière minute.\n\n## À retenir\nUne mauvaise nouvelle annoncée tôt reste gérable ; la même nouvelle cachée devient une crise.', 15, 2);

SET @lesson1_gp = (SELECT l.id FROM lessons l WHERE l.module_id = @m1 AND l.position = 1);
INSERT INTO quizzes (lesson_id, title, pass_score_percent) VALUES (@lesson1_gp, 'Quiz — Scrum : rôles et cérémonies', 60);
SET @quiz = LAST_INSERT_ID();
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Qui définit les priorités du produit en Scrum ?', 1);
SET @q1 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q1, 'Le Product Owner', 1, 1), (@q1, 'Le client final uniquement', 0, 2), (@q1, 'Personne, l''équipe décide seule', 0, 3);
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Combien de temps dure en général un daily standup ?', 2);
SET @q2 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q2, 'Environ 15 minutes', 1, 1), (@q2, '2 heures', 0, 2), (@q2, 'Une journée entière', 0, 3);

-- =====================================================================
-- Qualité & Tests Logiciels (qualite-tests-logiciels)
-- =====================================================================
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Stratégie de test', 'Les types de tests et comment bien les écrire.', 1 FROM tracks WHERE slug = 'qualite-tests-logiciels';
SET @m1 = LAST_INSERT_ID();
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Tests automatisés', 'Automatiser pour tester plus vite et plus souvent.', 2 FROM tracks WHERE slug = 'qualite-tests-logiciels';
SET @m2 = LAST_INSERT_ID();

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m1, 'Les types de tests', 'Unitaire, intégration, bout en bout : les différences.',
'# Les types de tests\n\n- **Test unitaire** : vérifie une petite partie isolée du code (une fonction).\n- **Test d''intégration** : vérifie que plusieurs parties fonctionnent correctement ensemble.\n- **Test de bout en bout (E2E)** : simule un vrai parcours utilisateur du début à la fin.\n\n## À retenir\nPlus un test est "petit" (unitaire), plus il est rapide et facile à localiser en cas d''échec ; les tests E2E sont plus lents mais plus proches de la réalité.', 20, 1),
(@m1, 'Écrire un cas de test efficace', 'Un bon test de ce qui doit marcher — et de ce qui ne doit pas.',
'# Écrire un cas de test efficace\n\nUn bon cas de test précise clairement :\n\n1. Les **conditions de départ** (ex : un utilisateur connecté).\n2. L''**action** réalisée (ex : cliquer sur "Valider").\n3. Le **résultat attendu** (ex : un message de confirmation s''affiche).\n\n## À retenir\nNe teste pas seulement le cas idéal ("happy path") : teste aussi les cas limites et les erreurs (champ vide, valeur incorrecte).', 15, 2);

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m2, 'Introduction aux tests automatisés', 'Faire vérifier le code par le code.',
'# Introduction aux tests automatisés\n\nUn test automatisé est un petit programme qui vérifie qu''une partie du code fonctionne comme prévu, et peut être relancé à volonté.\n\n```php\nfunction test_addition() {\n    assert(addition(2, 3) === 5);\n}\n```\n\n## À retenir\nL''intérêt principal n''est pas de gagner du temps une fois, mais de pouvoir tout re-vérifier automatiquement après chaque changement de code (non-régression).', 20, 1),
(@m2, 'Suivre et reproduire une anomalie', 'Un bug mal décrit ne peut pas être corrigé.',
'# Suivre et reproduire une anomalie\n\nUn bon rapport de bug permet à quelqu''un d''autre de reproduire le problème sans poser de questions.\n\n## Les informations indispensables\n- Les étapes exactes pour reproduire le problème.\n- Le résultat observé vs le résultat attendu.\n- L''environnement (navigateur, appareil, version).\n\n## À retenir\n"Ça ne marche pas" n''est jamais un rapport de bug exploitable.', 15, 2);

SET @lesson1_qa = (SELECT l.id FROM lessons l WHERE l.module_id = @m1 AND l.position = 1);
INSERT INTO quizzes (lesson_id, title, pass_score_percent) VALUES (@lesson1_qa, 'Quiz — Les types de tests', 60);
SET @quiz = LAST_INSERT_ID();
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Quel test vérifie une seule petite partie du code ?', 1);
SET @q1 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q1, 'Le test unitaire', 1, 1), (@q1, 'Le test de bout en bout', 0, 2), (@q1, 'Aucun test ne fait cela', 0, 3);
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Que simule un test de bout en bout (E2E) ?', 2);
SET @q2 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q2, 'Un vrai parcours utilisateur complet', 1, 1), (@q2, 'Une seule fonction isolée', 0, 2), (@q2, 'Le design de l''interface', 0, 3);

-- =====================================================================
-- Développement de Jeux Vidéo (developpement-jeux-video)
-- =====================================================================
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Concevoir un jeu', 'Gameplay et choix du moteur de jeu.', 1 FROM tracks WHERE slug = 'developpement-jeux-video';
SET @m1 = LAST_INSERT_ID();
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Programmer son premier prototype', 'Les premières briques de code d''un jeu.', 2 FROM tracks WHERE slug = 'developpement-jeux-video';
SET @m2 = LAST_INSERT_ID();

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m1, 'La boucle de gameplay', 'Ce qui fait qu''un jeu donne envie de continuer.',
'# La boucle de gameplay\n\nLa boucle de gameplay (game loop) est le cycle répété d''actions qui constitue l''expérience de jeu : action → résultat → récompense → nouvelle action.\n\n## Exemple\nDans un jeu de plateforme : courir/sauter (action) → éviter un obstacle (résultat) → gagner un point (récompense) → continuer vers l''obstacle suivant.\n\n## À retenir\nUn bon jeu a une boucle de gameplay simple à comprendre, mais avec une marge de progression (nouveaux défis, nouvelles capacités).', 20, 1),
(@m1, 'Choisir son moteur de jeu', 'Unity et Godot : deux options accessibles.',
'# Choisir son moteur de jeu\n\n- **Unity** : très répandu, énorme communauté, bon pour 2D comme 3D, utilise le langage C#.\n- **Godot** : gratuit et open source, léger, langage proche de Python (GDScript), excellent pour débuter.\n\n## À retenir\nPour un premier projet, le plus important est de choisir un moteur et de s''y tenir plutôt que de chercher le moteur "parfait".', 15, 2);

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m2, 'Déplacer un personnage', 'La première interaction la plus fondamentale.',
'# Déplacer un personnage\n\nVoici un exemple simplifié en GDScript (Godot) pour déplacer un personnage avec les touches directionnelles :\n\n```gdscript\nfunc _process(delta):\n    var direction = Input.get_axis("ui_left", "ui_right")\n    position.x += direction * vitesse * delta\n```\n\n## À retenir\nLa notion de `delta` (temps écoulé depuis la dernière image) est essentielle : elle garantit que le jeu se comporte pareil, que l''ordinateur soit rapide ou lent.', 20, 1),
(@m2, 'Gérer les collisions et le score', 'Détecter les contacts et récompenser le joueur.',
'# Gérer les collisions et le score\n\nUn moteur de jeu détecte automatiquement quand deux objets se touchent (collision), ce qui permet de déclencher des actions : perdre une vie, ramasser une pièce, gagner un point.\n\n## À retenir\nSépare toujours la détection de collision (ce qui se touche) de la réaction (ce qui se passe ensuite) : ça rend le code plus facile à faire évoluer.', 20, 2);

SET @lesson1_jeux = (SELECT l.id FROM lessons l WHERE l.module_id = @m1 AND l.position = 1);
INSERT INTO quizzes (lesson_id, title, pass_score_percent) VALUES (@lesson1_jeux, 'Quiz — La boucle de gameplay', 60);
SET @quiz = LAST_INSERT_ID();
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Que signifie "boucle de gameplay" ?', 1);
SET @q1 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q1, 'Le cycle répété action-résultat-récompense', 1, 1), (@q1, 'Un bug qui bloque le jeu', 0, 2), (@q1, 'Le générique de fin', 0, 3);
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Quel moteur de jeu est gratuit et open source ?', 2);
SET @q2 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q2, 'Godot', 1, 1), (@q2, 'Unity uniquement', 0, 2), (@q2, 'Aucun ne l''est', 0, 3);

-- =====================================================================
-- Maintenance Informatique & Support Technique (maintenance-informatique)
-- =====================================================================
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Matériel et diagnostic', 'Assembler, diagnostiquer et réparer un ordinateur.', 1 FROM tracks WHERE slug = 'maintenance-informatique';
SET @m1 = LAST_INSERT_ID();
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Logiciels et réseau de base', 'Installer un système et dépanner une connexion.', 2 FROM tracks WHERE slug = 'maintenance-informatique';
SET @m2 = LAST_INSERT_ID();

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m1, 'Assembler et diagnostiquer un ordinateur', 'Les composants essentiels et leur rôle.',
'# Assembler et diagnostiquer un ordinateur\n\n## Les composants essentiels\n- **Carte mère** : relie tous les composants entre eux.\n- **Processeur (CPU)** : exécute les calculs.\n- **Mémoire vive (RAM)** : stockage temporaire pendant l''utilisation.\n- **Disque dur/SSD** : stockage permanent.\n- **Alimentation** : fournit l''électricité à tout le reste.\n\n## Méthode de diagnostic\nQuand un ordinateur ne démarre pas, vérifie dans l''ordre : alimentation branchée → câbles internes bien connectés → RAM bien enfoncée → écran branché correctement.\n\n## À retenir\nUn diagnostic méthodique (du plus simple au plus complexe) évite de perdre du temps.', 25, 1),
(@m1, 'Résoudre les pannes courantes', 'Les problèmes les plus fréquents et leurs solutions.',
'# Résoudre les pannes courantes\n\n## Problèmes fréquents\n- **Ordinateur lent** : trop de programmes au démarrage, disque presque plein, poussière excessive (surchauffe).\n- **Écran noir au démarrage** : câble vidéo, carte graphique mal insérée.\n- **Surchauffe fréquente au Tchad** : la poussière et la chaleur ambiante bouchent les ventilateurs ; un nettoyage régulier est indispensable.\n\n## À retenir\nAu Tchad, le nettoyage régulier de la poussière à l''intérieur du boîtier est une des causes les plus sous-estimées de panne.', 20, 2);

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m2, 'Installer un système d''exploitation', 'Les étapes d''une installation propre.',
'# Installer un système d''exploitation\n\n## Étapes générales\n1. Sauvegarder les données importantes de l''utilisateur.\n2. Créer une clé USB d''installation (Windows, ou une distribution Linux légère).\n3. Démarrer sur la clé USB (menu de démarrage, souvent F12 ou Échap).\n4. Suivre l''assistant d''installation, partitionner le disque si besoin.\n5. Installer les pilotes (drivers) nécessaires après l''installation.\n\n## À retenir\nToujours sauvegarder avant de réinstaller : une erreur de partition efface les données.', 25, 1),
(@m2, 'Dépanner une connexion réseau', 'Retrouver une connexion internet qui ne fonctionne plus.',
'# Dépanner une connexion réseau\n\n## Méthode simple\n1. Vérifier que le Wi-Fi/câble est bien activé sur l''appareil.\n2. Redémarrer le modem/routeur (souvent suffisant).\n3. Vérifier si le problème vient de l''appareil ou de la connexion elle-même (un autre appareil capte-t-il le réseau ?).\n4. Vérifier les identifiants Wi-Fi (mot de passe correct, bonne box).\n\n## À retenir\n"Redémarrer la box" résout une grande partie des problèmes de connexion au quotidien.', 15, 2);

SET @lesson1_maintenance = (SELECT l.id FROM lessons l WHERE l.module_id = @m1 AND l.position = 1);
INSERT INTO quizzes (lesson_id, title, pass_score_percent) VALUES (@lesson1_maintenance, 'Quiz — Assembler et diagnostiquer un ordinateur', 60);
SET @quiz = LAST_INSERT_ID();
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Quel composant stocke les données de façon permanente ?', 1);
SET @q1 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q1, 'Le disque dur/SSD', 1, 1), (@q1, 'La mémoire vive (RAM)', 0, 2), (@q1, 'Le processeur', 0, 3);
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Quelle est la première chose à vérifier si l''ordinateur ne démarre pas ?', 2);
SET @q2 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q2, 'Que l''alimentation est branchée', 1, 1), (@q2, 'Le système d''exploitation', 0, 2), (@q2, 'La couleur du boîtier', 0, 3);

-- =====================================================================
-- Mobile Money & Paiement Numérique (mobile-money-paiement-numerique)
-- =====================================================================
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Comprendre le mobile money', 'Le fonctionnement d''un point agent au quotidien.', 1 FROM tracks WHERE slug = 'mobile-money-paiement-numerique';
SET @m1 = LAST_INSERT_ID();
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Sécurité et intégrations', 'Prévenir la fraude et comprendre les bases techniques.', 2 FROM tracks WHERE slug = 'mobile-money-paiement-numerique';
SET @m2 = LAST_INSERT_ID();

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m1, 'Comment fonctionne un paiement mobile money ?', 'Du dépôt en espèces au transfert électronique.',
'# Comment fonctionne un paiement mobile money ?\n\nLe mobile money permet de transformer de l''argent liquide en argent électronique (et inversement) directement depuis un téléphone, sans compte bancaire classique.\n\n## Le cycle de base\n1. Le client dépose de l''argent liquide chez un agent (**cash-in**).\n2. Son compte mobile money est crédité électroniquement.\n3. Il peut transférer, payer, ou retirer en liquide ailleurs (**cash-out**).\n\n## À retenir\nAirtel Money et Moov Money sont les deux acteurs principaux au Tchad ; le principe reste le même d''un opérateur à l''autre.', 20, 1),
(@m1, 'Gérer un point agent', 'La liquidité, le nerf de la guerre d''un agent.',
'# Gérer un point agent\n\nUn agent mobile money doit toujours avoir assez de liquide (pour les retraits) ET assez de solde électronique (pour les dépôts) : c''est l''équilibre de **liquidité**.\n\n## Bonnes pratiques\n- Rééquilibrer régulièrement entre espèces et solde électronique auprès d''un super-agent/distributeur.\n- Toujours vérifier la confirmation SMS avant de remettre de l''argent liquide.\n\n## À retenir\nUn agent à court de liquide OU de solde électronique ne peut plus servir ses clients : anticipe toujours.', 20, 2);

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m2, 'Prévenir la fraude', 'Les arnaques les plus courantes en mobile money.',
'# Prévenir la fraude\n\n## Fraudes fréquentes\n- **Faux SMS de confirmation** : le fraudeur montre un faux message prétendant avoir payé, pour obtenir de l''argent liquide sans paiement réel.\n- **Appels se faisant passer pour l''opérateur** : demandant un code secret (jamais à communiquer).\n\n## Règle d''or\nNe jamais se fier à un message affiché par le client : toujours vérifier la confirmation directement sur son propre terminal/application agent.', 20, 1),
(@m2, 'Notions d''API et d''USSD', 'Comment les systèmes se parlent techniquement.',
'# Notions d''API et d''USSD\n\n- **USSD** : le menu qui s''affiche quand on compose un code comme `*123#` sur un téléphone basique, sans connexion internet.\n- **API** : une interface permettant à un logiciel (ex: une plateforme comme IgoTech IA) de dialoguer avec le système d''un opérateur ou d''un agrégateur de paiement (ex: CinetPay).\n\n## À retenir\nL''USSD sert l''utilisateur final sur téléphone basique ; l''API sert les systèmes informatiques entre eux (site web, application).', 20, 2);

SET @lesson1_momo = (SELECT l.id FROM lessons l WHERE l.module_id = @m1 AND l.position = 1);
INSERT INTO quizzes (lesson_id, title, pass_score_percent) VALUES (@lesson1_momo, 'Quiz — Comment fonctionne le mobile money ?', 60);
SET @quiz = LAST_INSERT_ID();
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Comment appelle-t-on le dépôt d''espèces chez un agent ?', 1);
SET @q1 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q1, 'Le cash-in', 1, 1), (@q1, 'Le cash-out', 0, 2), (@q1, 'Le roaming', 0, 3);
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Quels sont les deux principaux opérateurs mobile money au Tchad ?', 2);
SET @q2 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q2, 'Airtel Money et Moov Money', 1, 1), (@q2, 'Visa et Mastercard', 0, 2), (@q2, 'PayPal et Stripe', 0, 3);

-- =====================================================================
-- Bureautique & Gestion de Données (bureautique-gestion-donnees)
-- =====================================================================
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Tableurs avancés', 'Maîtriser Excel/Google Sheets au-delà des bases.', 1 FROM tracks WHERE slug = 'bureautique-gestion-donnees';
SET @m1 = LAST_INSERT_ID();
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Organiser ses données', 'Structurer et fiabiliser ses informations.', 2 FROM tracks WHERE slug = 'bureautique-gestion-donnees';
SET @m2 = LAST_INSERT_ID();

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m1, 'Formules essentielles d''Excel/Google Sheets', 'Les fonctions qui font gagner le plus de temps.',
'# Formules essentielles\n\n```\n=SOMME(A1:A10)         -> additionne une plage de cellules\n=RECHERCHEV(B2;Feuil2!A:C;3;FAUX)  -> recherche une valeur dans un autre tableau\n=SI(C2>1000;"Oui";"Non")  -> condition simple\n```\n\n## À retenir\n`RECHERCHEV` (ou `VLOOKUP`) est probablement la fonction la plus utile pour relier deux tableaux entre eux, par exemple une liste de noms et une liste de montants.', 20, 1),
(@m1, 'Tableaux croisés dynamiques', 'Résumer des milliers de lignes en quelques clics.',
'# Tableaux croisés dynamiques\n\nUn tableau croisé dynamique permet de résumer rapidement de grandes quantités de données : par exemple, le total des ventes par mois et par produit, sans écrire une seule formule.\n\n## À retenir\nSi tu te surprends à compter ou additionner manuellement des lignes dans un grand tableau, un tableau croisé dynamique fera le travail en quelques secondes.', 20, 2);

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m2, 'Structurer une base de données simple', 'Une ligne, une information ; une colonne, un type.',
'# Structurer une base de données simple\n\n## Règles de base\n- Une ligne par enregistrement (ex : un client par ligne).\n- Une colonne par information (nom, téléphone, date — jamais mélangées dans une seule cellule).\n- Pas de cellules fusionnées dans un tableau de données : ça casse les tris et les formules.\n\n## À retenir\nUn tableau bien structuré se trie, se filtre et s''analyse facilement ; un tableau "joli" mais mal structuré devient vite inutilisable.', 20, 1),
(@m2, 'Bonnes pratiques de saisie', 'Une donnée fiable vaut mieux qu''une donnée rapide.',
'# Bonnes pratiques de saisie\n\n## Erreurs fréquentes à éviter\n- Mélanger les formats de date (01/02/2026 vs 1 février 2026) dans la même colonne.\n- Laisser des espaces avant/après un texte (ex: " Awa" au lieu de "Awa").\n- Dupliquer des enregistrements par erreur.\n\n## À retenir\nUne validation de données (listes déroulantes, formats imposés) évite une grande partie des erreurs de saisie dès la source.', 15, 2);

SET @lesson1_bureau = (SELECT l.id FROM lessons l WHERE l.module_id = @m1 AND l.position = 1);
INSERT INTO quizzes (lesson_id, title, pass_score_percent) VALUES (@lesson1_bureau, 'Quiz — Formules essentielles', 60);
SET @quiz = LAST_INSERT_ID();
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Quelle formule additionne une plage de cellules ?', 1);
SET @q1 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q1, '=SOMME(A1:A10)', 1, 1), (@q1, '=SI(A1;A10)', 0, 2), (@q1, '=COULEUR(A1)', 0, 3);
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'À quoi sert RECHERCHEV (VLOOKUP) ?', 2);
SET @q2 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q2, 'Rechercher une valeur dans un autre tableau', 1, 1), (@q2, 'Changer la couleur d''une cellule', 0, 2), (@q2, 'Supprimer une ligne', 0, 3);

-- =====================================================================
-- Support IT pour Organisations Humanitaires & ONG (it-organisations-humanitaires)
-- =====================================================================
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Connectivité terrain', 'Rester connecté dans des zones isolées.', 1 FROM tracks WHERE slug = 'it-organisations-humanitaires';
SET @m1 = LAST_INSERT_ID();
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Collecte et protection des données', 'Outils de collecte et éthique des données sensibles.', 2 FROM tracks WHERE slug = 'it-organisations-humanitaires';
SET @m2 = LAST_INSERT_ID();

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m1, 'Connectivité satellite et radio', 'Rester connecté là où il n''y a pas de réseau mobile.',
'# Connectivité satellite et radio\n\nDans les zones isolées (camps de réfugiés, bureaux terrain éloignés), les organisations humanitaires utilisent souvent :\n\n- **VSAT** : antenne satellite fournissant une connexion internet indépendante du réseau mobile local.\n- **Radio HF/VHF** : communication vocale de secours quand même le satellite est indisponible.\n\n## À retenir\nUn bureau terrain humanitaire prévoit toujours un moyen de communication de secours : la connectivité n''est jamais garantie à 100%.', 20, 1),
(@m1, 'Monter un petit réseau de bureau terrain', 'Partager une connexion entre plusieurs postes.',
'# Monter un petit réseau de bureau terrain\n\n## Éléments de base\n- Une source internet (VSAT, 4G) connectée à un routeur.\n- Un onduleur (UPS) indispensable pour protéger le matériel des coupures électriques fréquentes.\n- Un switch si plusieurs postes doivent se connecter en filaire.\n\n## À retenir\nDans un contexte où l''électricité est instable, protéger le matériel (onduleur, parafoudre) est aussi important que la connexion elle-même.', 20, 2);

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m2, 'Outils de collecte de données terrain', 'KoboToolbox et ODK, les standards du secteur.',
'# Outils de collecte de données terrain\n\n**KoboToolbox** et **ODK** permettent de créer des formulaires de collecte utilisables hors ligne sur smartphone ou tablette, puis synchronisés dès qu''une connexion est disponible.\n\n## À retenir\nCes outils sont devenus un standard du secteur humanitaire : savoir les utiliser (créer un formulaire, l''administrer sur le terrain) est une compétence très recherchée.', 20, 1),
(@m2, 'Protection des données des bénéficiaires', 'Les données humanitaires sont particulièrement sensibles.',
'# Protection des données des bénéficiaires\n\nLes données collectées sur des populations vulnérables (réfugiés, personnes déplacées) exigent une vigilance particulière : leur divulgation peut mettre des vies en danger.\n\n## Principes de base\n- **Minimisation** : ne collecter que les données réellement nécessaires.\n- **Accès restreint** : seules les personnes autorisées consultent les données sensibles.\n- **Anonymisation** quand c''est possible pour les analyses globales.\n\n## À retenir\nEn contexte humanitaire, la protection des données n''est pas qu''une question technique : c''est une question de sécurité physique des personnes.', 20, 2);

SET @lesson1_humanit = (SELECT l.id FROM lessons l WHERE l.module_id = @m1 AND l.position = 1);
INSERT INTO quizzes (lesson_id, title, pass_score_percent) VALUES (@lesson1_humanit, 'Quiz — Connectivité satellite et radio', 60);
SET @quiz = LAST_INSERT_ID();
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Quel équipement fournit internet via satellite ?', 1);
SET @q1 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q1, 'Le VSAT', 1, 1), (@q1, 'Le switch', 0, 2), (@q1, 'L''onduleur', 0, 3);
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Pourquoi un onduleur (UPS) est-il important en bureau terrain ?', 2);
SET @q2 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q2, 'Il protège le matériel des coupures électriques', 1, 1), (@q2, 'Il augmente la vitesse internet', 0, 2), (@q2, 'Il remplace le satellite', 0, 3);

-- =====================================================================
-- Marketing Digital & Réseaux Sociaux (marketing-digital-reseaux-sociaux)
-- =====================================================================
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Présence en ligne', 'Exister efficacement sur les canaux que tes clients utilisent déjà.', 1 FROM tracks WHERE slug = 'marketing-digital-reseaux-sociaux';
SET @m1 = LAST_INSERT_ID();
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Contenu et mesure de résultats', 'Créer du contenu et savoir si ça fonctionne.', 2 FROM tracks WHERE slug = 'marketing-digital-reseaux-sociaux';
SET @m2 = LAST_INSERT_ID();

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m1, 'Créer une page professionnelle efficace', 'Les éléments indispensables d''une page Facebook pro.',
'# Créer une page professionnelle efficace\n\n## Éléments indispensables\n- Une photo de profil claire (logo ou photo du produit).\n- Une description courte expliquant immédiatement ce que tu proposes.\n- Un moyen de contact visible (numéro, WhatsApp).\n\n## À retenir\nUn visiteur décide en quelques secondes s''il te fait confiance : une page incomplète ou mal présentée fait fuir plus qu''un simple manque de "likes".', 15, 1),
(@m1, 'WhatsApp Business pour son activité', 'Le canal le plus utilisé au quotidien.',
'# WhatsApp Business pour son activité\n\nWhatsApp Business ajoute des fonctionnalités utiles à une activité : messages automatiques d''absence, catalogue de produits, étiquettes pour organiser ses clients.\n\n## À retenir\nPour beaucoup de petites entreprises tchadiennes, WhatsApp Business EST le site web : autant le soigner (photo, description, réponses rapides).', 15, 2);

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m2, 'Créer du contenu avec un smartphone', 'Pas besoin de matériel professionnel pour commencer.',
'# Créer du contenu avec un smartphone\n\n## Conseils simples\n- Filme/photographie avec une bonne lumière naturelle (face à une fenêtre, jamais à contre-jour).\n- Garde les vidéos courtes (15-30 secondes) pour les réseaux sociaux.\n- Montre le produit/service en situation réelle plutôt qu''une simple photo posée.\n\n## À retenir\nUn contenu authentique filmé au smartphone fonctionne souvent mieux qu''une publicité trop "parfaite" et impersonnelle.', 15, 1),
(@m2, 'Suivre ses résultats simplement', 'Savoir si ses efforts portent leurs fruits.',
'# Suivre ses résultats simplement\n\nPas besoin d''outils coûteux pour commencer à mesurer :\n\n- Nombre de messages WhatsApp reçus suite à une publication.\n- Statistiques natives gratuites de Facebook (vues, clics, partages).\n- Nombre de ventes directement liées à une publication ou une promotion.\n\n## À retenir\nLe seul chiffre qui compte vraiment à la fin, c''est l''effet sur les ventes — pas le nombre de "likes".', 15, 2);

SET @lesson1_marketing = (SELECT l.id FROM lessons l WHERE l.module_id = @m1 AND l.position = 1);
INSERT INTO quizzes (lesson_id, title, pass_score_percent) VALUES (@lesson1_marketing, 'Quiz — Créer une page professionnelle efficace', 60);
SET @quiz = LAST_INSERT_ID();
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Que doit-on pouvoir comprendre en quelques secondes sur une page pro ?', 1);
SET @q1 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q1, 'Ce que propose l''activité', 1, 1), (@q1, 'L''historique complet de l''entreprise', 0, 2), (@q1, 'Rien, ce n''est pas important', 0, 3);
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Quel canal est souvent LE site web des petites entreprises tchadiennes ?', 2);
SET @q2 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q2, 'WhatsApp Business', 1, 1), (@q2, 'LinkedIn', 0, 2), (@q2, 'Un blog personnel', 0, 3);

-- =====================================================================
-- Informatique Bancaire & Finance Numérique (informatique-bancaire)
-- =====================================================================
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Comprendre le core banking', 'Le système nerveux central d''une banque.', 1 FROM tracks WHERE slug = 'informatique-bancaire';
SET @m1 = LAST_INSERT_ID();
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Conformité et audit', 'Les règles propres au secteur bancaire.', 2 FROM tracks WHERE slug = 'informatique-bancaire';
SET @m2 = LAST_INSERT_ID();

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m1, 'Qu''est-ce qu''un système core banking ?', 'Le logiciel qui gère tous les comptes d''une banque.',
'# Qu''est-ce qu''un système core banking ?\n\nLe **core banking** est le système central qui gère les comptes clients, les transactions, les soldes et les intérêts d''une banque, en temps réel.\n\n## Caractéristiques essentielles\n- **Disponibilité quasi permanente** : une panne empêche directement les clients d''accéder à leur argent.\n- **Cohérence stricte** : un virement doit débiter un compte et créditer l''autre de façon indivisible (jamais l''un sans l''autre).\n\n## À retenir\nDans un système bancaire, une transaction "à moitié faite" n''est jamais acceptable : c''est tout ou rien.', 20, 1),
(@m1, 'Sécuriser les accès et les transactions', 'La sécurité n''est pas une option dans la banque.',
'# Sécuriser les accès et les transactions\n\n## Principes clés\n- **Séparation des droits** : la personne qui crée une transaction ne doit pas être la seule à pouvoir l''approuver (double validation).\n- **Traçabilité complète** : chaque action sur un compte doit être enregistrée avec qui, quoi, quand.\n- **Chiffrement** des données sensibles, en transit et au repos.\n\n## À retenir\nLa règle du "quatre yeux" (deux personnes minimum pour valider une opération sensible) est un standard du secteur bancaire.', 20, 2);

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m2, 'Notions de conformité BEAC/COBAC', 'Le cadre réglementaire de la zone CEMAC.',
'# Notions de conformité BEAC/COBAC\n\nDans la zone CEMAC (dont fait partie le Tchad), les banques sont supervisées par la **BEAC** (Banque des États de l''Afrique Centrale) et la **COBAC** (Commission Bancaire de l''Afrique Centrale), qui fixent des règles de sécurité, de reporting et de lutte contre le blanchiment d''argent.\n\n## À retenir\nUn système d''information bancaire doit être conçu pour produire facilement les rapports exigés par le régulateur, pas seulement pour fonctionner au quotidien.', 20, 1),
(@m2, 'Traçabilité et journalisation', 'Pouvoir reconstituer ce qui s''est passé, toujours.',
'# Traçabilité et journalisation\n\nUn **journal d''audit** (audit log) enregistre chaque action importante sur un système bancaire : connexions, consultations, modifications.\n\n## À retenir\nEn cas de litige ou de contrôle réglementaire, c''est souvent ce journal qui permet de prouver ce qui s''est réellement passé : il ne doit jamais pouvoir être modifié après coup.', 15, 2);

SET @lesson1_banque = (SELECT l.id FROM lessons l WHERE l.module_id = @m1 AND l.position = 1);
INSERT INTO quizzes (lesson_id, title, pass_score_percent) VALUES (@lesson1_banque, 'Quiz — Qu''est-ce qu''un système core banking ?', 60);
SET @quiz = LAST_INSERT_ID();
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Que doit toujours garantir une transaction bancaire ?', 1);
SET @q1 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q1, 'La cohérence totale (tout ou rien)', 1, 1), (@q1, 'Rien de particulier', 0, 2), (@q1, 'Un affichage coloré', 0, 3);
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Quels organismes régulent les banques en zone CEMAC ?', 2);
SET @q2 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q2, 'La BEAC et la COBAC', 1, 1), (@q2, 'L''ARCEP', 0, 2), (@q2, 'Aucun organisme', 0, 3);

-- =====================================================================
-- Télécom & Opérateurs Mobiles (telecom-operateurs)
-- =====================================================================
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Réseaux mobiles', 'Comment un réseau mobile fonctionne et se surveille.', 1 FROM tracks WHERE slug = 'telecom-operateurs';
SET @m1 = LAST_INSERT_ID();
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Plateformes opérateur', 'Facturation, abonnés et mobile money côté opérateur.', 2 FROM tracks WHERE slug = 'telecom-operateurs';
SET @m2 = LAST_INSERT_ID();

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m1, 'Comment fonctionne un réseau mobile (2G à 5G) ?', 'Des antennes au cœur de réseau.',
'# Comment fonctionne un réseau mobile ?\n\nUn réseau mobile repose sur des **antennes** (stations de base) couvrant chacune une zone, reliées à un **cœur de réseau** qui gère les appels, les SMS et la connexion internet.\n\n## Les générations\n- **2G** : voix et SMS.\n- **3G/4G** : internet mobile.\n- **5G** : débits très élevés, faible latence, pour de nouveaux usages (objets connectés).\n\n## À retenir\nPlus il y a d''antennes proches les unes des autres, meilleure est la couverture — mais chaque antenne a une capacité limitée d''utilisateurs simultanés.', 20, 1),
(@m1, 'Le rôle du NOC (supervision réseau)', 'La salle qui surveille le réseau 24h/24.',
'# Le rôle du NOC\n\nLe **NOC** (Network Operations Center) est l''équipe qui surveille en permanence l''état du réseau d''un opérateur : antennes en panne, saturation, incidents.\n\n## À retenir\nUn technicien NOC doit réagir vite : chaque minute de panne réseau impacte potentiellement des milliers de clients en simultané.', 20, 2);

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m2, 'BSS/OSS : facturation et gestion des abonnés', 'Les systèmes qui gèrent chaque client.',
'# BSS/OSS : facturation et gestion des abonnés\n\n- **BSS** (Business Support Systems) : facturation, gestion des forfaits, du crédit et des abonnés.\n- **OSS** (Operations Support Systems) : gestion technique du réseau lui-même (configuration, supervision).\n\n## À retenir\nQuand un client recharge son crédit et que le solde se met à jour instantanément, c''est le BSS qui travaille en coulisses.', 20, 1),
(@m2, 'Mobile money côté opérateur', 'La plateforme derrière Airtel Money et Moov Money.',
'# Mobile money côté opérateur\n\nCôté opérateur, une plateforme mobile money gère en temps réel les comptes électroniques de millions d''utilisateurs, avec des exigences de disponibilité et de sécurité proches de celles d''une banque.\n\n## À retenir\nCes plateformes doivent gérer un volume de transactions énorme tout en garantissant qu''aucun franc ne soit créé ou perdu par erreur dans le système.', 20, 2);

SET @lesson1_telecom = (SELECT l.id FROM lessons l WHERE l.module_id = @m1 AND l.position = 1);
INSERT INTO quizzes (lesson_id, title, pass_score_percent) VALUES (@lesson1_telecom, 'Quiz — Comment fonctionne un réseau mobile ?', 60);
SET @quiz = LAST_INSERT_ID();
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Quelle génération réseau a introduit l''internet mobile ?', 1);
SET @q1 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q1, 'La 3G', 1, 1), (@q1, 'La 2G uniquement', 0, 2), (@q1, 'Aucune', 0, 3);
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Que surveille le NOC d''un opérateur télécom ?', 2);
SET @q2 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q2, 'L''état du réseau en permanence', 1, 1), (@q2, 'Uniquement la comptabilité', 0, 2), (@q2, 'Les réseaux sociaux de l''entreprise', 0, 3);

-- =====================================================================
-- Régulation & Conformité Numérique (regulation-conformite-numerique)
-- =====================================================================
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Rôle de la régulation', 'Pourquoi et comment un secteur est régulé.', 1 FROM tracks WHERE slug = 'regulation-conformite-numerique';
SET @m1 = LAST_INSERT_ID();
INSERT INTO modules (track_id, title, description, position)
SELECT id, 'Audit et protection des données', 'Contrôler techniquement le respect des règles.', 2 FROM tracks WHERE slug = 'regulation-conformite-numerique';
SET @m2 = LAST_INSERT_ID();

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m1, 'Qu''est-ce qu''une autorité de régulation (ARCEP) ?', 'Le rôle d''arbitre du secteur des télécoms.',
'# Qu''est-ce qu''une autorité de régulation ?\n\nUne autorité comme l''**ARCEP** (régulateur des télécoms) veille à ce que les opérateurs respectent leurs obligations : qualité de service, couverture du territoire, concurrence loyale entre opérateurs, protection des consommateurs.\n\n## À retenir\nLe régulateur n''est ni l''opérateur ni le client : il sert l''intérêt général du secteur, avec un rôle de contrôle technique et juridique.', 20, 1),
(@m1, 'Licences et conformité technique', 'Ce que les opérateurs doivent respecter pour opérer.',
'# Licences et conformité technique\n\nPour opérer légalement, un opérateur télécom doit obtenir une **licence** qui l''engage à respecter des obligations précises : usage correct des fréquences radio, qualité de service minimale, sécurité des données des abonnés.\n\n## À retenir\nUne partie du travail d''un régulateur consiste à vérifier techniquement (pas seulement sur papier) que ces engagements sont vraiment respectés sur le terrain.', 20, 2);

INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position) VALUES
(@m2, 'Mener un audit technique', 'Vérifier, preuves à l''appui, sans parti pris.',
'# Mener un audit technique\n\nUn audit technique consiste à vérifier objectivement qu''un système ou un réseau respecte des règles précises, en s''appuyant sur des preuves (mesures, journaux, configurations) plutôt que sur des déclarations.\n\n## À retenir\nUn bon auditeur documente toujours comment il est arrivé à sa conclusion : un audit non reproductible n''a aucune valeur probante.', 20, 1),
(@m2, 'Protection des données personnelles', 'Un enjeu de régulation de plus en plus central.',
'# Protection des données personnelles\n\nLa régulation de la protection des données vérifie que les entreprises (banques, opérateurs télécom...) collectent, stockent et utilisent les données personnelles de façon légale et sécurisée.\n\n## Principes vérifiés en audit\n- Consentement réel de la personne concernée.\n- Sécurité du stockage (chiffrement, accès restreint).\n- Durée de conservation limitée et justifiée.\n\n## À retenir\nCe domaine devient un axe majeur de régulation partout dans le monde, y compris en Afrique centrale.', 20, 2);

SET @lesson1_regul = (SELECT l.id FROM lessons l WHERE l.module_id = @m1 AND l.position = 1);
INSERT INTO quizzes (lesson_id, title, pass_score_percent) VALUES (@lesson1_regul, 'Quiz — Qu''est-ce qu''une autorité de régulation ?', 60);
SET @quiz = LAST_INSERT_ID();
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Que vérifie une autorité de régulation télécom ?', 1);
SET @q1 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q1, 'La qualité de service et la concurrence loyale', 1, 1), (@q1, 'Uniquement les prix des téléphones', 0, 2), (@q1, 'Rien, c''est un rôle symbolique', 0, 3);
INSERT INTO quiz_questions (quiz_id, question, position) VALUES (@quiz, 'Que doit obtenir un opérateur pour exercer légalement ?', 2);
SET @q2 = LAST_INSERT_ID();
INSERT INTO quiz_options (question_id, option_text, is_correct, position) VALUES
(@q2, 'Une licence', 1, 1), (@q2, 'Aucun document particulier', 0, 2), (@q2, 'Un brevet international', 0, 3);
