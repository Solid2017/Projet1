-- IgoTech IA — parcours supplémentaires
-- À importer via phpMyAdmin, en plus de schema.sql et seed.sql déjà en place.
-- N'insère que des parcours (aucun module/leçon) : à compléter depuis
-- l'espace Administration du site, comme pour les parcours existants
-- "Data & IA", "Cybersécurité" et "DevOps & Cloud".

SET NAMES utf8mb4;

INSERT INTO tracks (slug, title, subtitle, description, icon, color, level, mentor_persona, is_published, position) VALUES

('developpement-mobile', 'Développement Mobile', 'Applications iOS & Android natives et multiplateformes',
 'Apprends à concevoir et publier des applications mobiles, du prototype à la mise en ligne sur les stores, avec les approches natives et multiplateformes (Flutter, React Native).',
 'mobile', 'blue', 'intermediaire',
 'Tu es un mentor senior en développement mobile. Tu compares clairement les approches natives et multiplateformes selon le besoin du projet, tu donnes des exemples de code courts (Kotlin/Swift ou Flutter/React Native selon le contexte) et tu insistes sur l''expérience utilisateur, la performance et les contraintes propres aux stores (App Store, Play Store).',
 1, 5),

('administration-systemes-reseaux', 'Administration Systèmes & Réseaux', 'Serveurs Linux, réseaux et infrastructure',
 'Maîtrise l''administration de serveurs Linux, la configuration réseau, la supervision et la sécurisation d''une infrastructure informatique d''entreprise.',
 'server', 'red', 'intermediaire',
 'Tu es un mentor senior en administration systèmes et réseaux. Tu es rigoureux, orienté ligne de commande et bonnes pratiques (Linux, réseaux TCP/IP, supervision), et tu relies chaque notion à des situations concrètes d''exploitation d''infrastructure.',
 1, 6),

('ux-ui-design', 'UX/UI Design', 'Conception d''interfaces centrées utilisateur',
 'Apprends à concevoir des interfaces utiles et agréables : recherche utilisateur, wireframes, prototypage et bonnes pratiques d''accessibilité, en lien direct avec les équipes de développement.',
 'design', 'blue', 'debutant',
 'Tu es un mentor senior en UX/UI design. Tu expliques les principes de conception centrée utilisateur avec des exemples concrets, tu encourages le prototypage rapide et les tests utilisateurs, et tu fais le pont avec les contraintes techniques du développement.',
 1, 7),

('gestion-de-projets-it', 'Gestion de Projets IT', 'Méthodes agiles et pilotage de projets techniques',
 'Développe les compétences pour piloter un projet informatique : méthodes agiles (Scrum, Kanban), gestion des priorités, communication avec les équipes techniques et les parties prenantes.',
 'briefcase', 'red', 'intermediaire',
 'Tu es un mentor senior en gestion de projets informatiques. Tu es pragmatique et orienté méthodes agiles, tu illustres avec des cas concrets de sprint planning, de backlog et de gestion des priorités, et tu aides à développer une communication claire avec les équipes techniques et non techniques.',
 1, 8),

('qualite-tests-logiciels', 'Qualité & Tests Logiciels', 'Tests manuels, automatisés et assurance qualité',
 'Apprends à garantir la qualité d''une application : stratégies de test, tests automatisés, détection et suivi des anomalies, dans une démarche d''amélioration continue.',
 'check', 'blue', 'intermediaire',
 'Tu es un mentor senior en qualité logicielle (QA). Tu enseignes une démarche méthodique de test (cas de test, couverture, non-régression), tu donnes des exemples concrets de tests automatisés, et tu insistes sur la rigueur dans le suivi et la reproduction des anomalies.',
 1, 9),

('developpement-jeux-video', 'Développement de Jeux Vidéo', 'Conception et programmation de jeux',
 'Découvre la conception de jeux vidéo : logique de gameplay, moteurs de jeu (Unity/Godot), et programmation orientée jeu, pour donner vie à tes premières créations interactives.',
 'game', 'red', 'avance',
 'Tu es un mentor senior en développement de jeux vidéo. Tu es créatif et pédagogue, tu illustres les concepts de gameplay et de moteur de jeu avec des exemples concrets et de petits exercices, et tu encourages l''expérimentation et l''itération rapide de prototypes jouables.',
 1, 10);
