-- IgoTech IA — parcours ciblant les métiers IT des secteurs qui
-- recrutent le plus au Tchad et en Afrique centrale francophone :
-- banques, opérateurs télécom (Airtel, Moov, Orange) et organismes
-- de régulation.
-- À importer via phpMyAdmin, en plus de toutes les migrations déjà
-- en place (schema.sql, seed.sql, seed_more_tracks.sql,
-- migration_tracks_tchad.sql, ...).
-- N'insère que des parcours (aucun module/leçon) : à compléter depuis
-- l'espace Administration du site.
--
-- Choix des profils :
--  - Informatique bancaire : les banques présentes au Tchad (Ecobank,
--    Orabank, Société Générale Tchad, Commercial Bank Tchad, BSIC...)
--    recrutent en continu pour le core banking, la sécurité des
--    transactions et la conformité numérique (règles BEAC/COBAC).
--  - Télécom & opérateurs mobiles : Airtel et Moov sont présents au
--    Tchad, Orange domine un grand nombre de pays voisins — ce
--    parcours couvre les métiers techniques CÔTÉ OPÉRATEUR (réseau,
--    supervision, plateformes mobile money), distinct du parcours
--    "Mobile Money & Paiement Numérique" déjà en place qui vise plutôt
--    les agents et techniciens côté point de vente.
--  - Régulation & conformité numérique : les autorités de régulation
--    (comme l'ARCEP au Tchad pour les télécoms, ou les cellules de
--    conformité bancaire liées à la BEAC/COBAC) recrutent des profils
--    techniques capables d'auditer réseaux, systèmes et plateformes.

SET NAMES utf8mb4;

INSERT INTO tracks (slug, title, subtitle, description, icon, color, level, mentor_persona, is_published, position) VALUES

('informatique-bancaire', 'Informatique Bancaire & Finance Numérique', 'Core banking, sécurité des transactions et conformité',
 'Prépare-toi aux métiers IT recherchés par les banques (Ecobank, Orabank, Société Générale Tchad, Commercial Bank Tchad, BSIC...) : fonctionnement d''un système bancaire central (core banking), sécurisation des transactions et des accès, et notions de conformité réglementaire (BEAC/COBAC) appliquées aux systèmes d''information.',
 'bank', 'blue', 'intermediaire',
 'Tu es un mentor senior en informatique bancaire. Tu es rigoureux sur la sécurité (authentification, traçabilité, séparation des environnements) et la conformité réglementaire propre au secteur bancaire en zone BEAC/COBAC, tu expliques le fonctionnement d''un système core banking avec des exemples concrets, et tu insistes sur la fiabilité et l''auditabilité de tout ce qui touche à l''argent des clients.',
 1, 16),

('telecom-operateurs', 'Télécom & Opérateurs Mobiles', 'Métiers techniques chez Airtel, Moov, Orange',
 'Découvre les métiers IT et réseaux recherchés directement par les opérateurs de téléphonie mobile (Airtel, Moov, Orange) : supervision de réseau (NOC), plateformes BSS/OSS, systèmes de facturation et plateformes mobile money côté opérateur — une approche complémentaire au parcours Mobile Money orienté agents et points de vente.',
 'antenna', 'red', 'intermediaire',
 'Tu es un mentor senior ayant travaillé côté opérateur télécom (Airtel/Moov/Orange ou équivalent). Tu expliques le fonctionnement d''un réseau mobile et de sa supervision (NOC), les plateformes BSS/OSS (facturation, gestion des abonnés) et les systèmes mobile money vus du côté opérateur, avec des exemples concrets adaptés au contexte de l''Afrique centrale francophone.',
 1, 17),

('regulation-conformite-numerique', 'Régulation & Conformité Numérique', 'Audit technique pour autorités de régulation',
 'Comprends les métiers IT recherchés par les organismes de régulation (type ARCEP pour les télécoms, cellules de conformité bancaire BEAC/COBAC) : audit technique de réseaux et systèmes, contrôle du respect des normes et licences, et protection des données dans un cadre réglementaire.',
 'scale', 'blue', 'avance',
 'Tu es un mentor senior spécialisé en régulation et conformité numérique (télécoms et secteur financier en zone BEAC/CEMAC). Tu enseignes une démarche d''audit technique rigoureuse et neutre, tu expliques le rôle des autorités de régulation (comme l''ARCEP) et des normes de conformité réglementaire, et tu insistes sur l''indépendance et la traçabilité de tout contrôle.',
 1, 18);
