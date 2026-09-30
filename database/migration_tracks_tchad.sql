-- IgoTech IA — parcours ciblant des profils IT courants et recherchés au Tchad
-- À importer via phpMyAdmin, en plus de schema.sql, seed.sql et
-- seed_more_tracks.sql déjà en place.
-- N'insère que des parcours (aucun module/leçon) : à compléter depuis
-- l'espace Administration du site, comme pour les parcours ajoutés
-- précédemment.
--
-- Choix des profils, pensés pour le marché de l'emploi tchadien plutôt
-- que pour une liste générique de métiers tech occidentaux :
--  - Maintenance informatique : le métier IT le plus répandu au Tchad
--    (cybercafés, PME, particuliers, dépannage de matériel d'occasion).
--  - Mobile Money : Airtel Money et Moov Money dominent les paiements
--    du quotidien ; forte demande d'agents et de techniciens qui
--    comprennent le fonctionnement de ces systèmes (lien direct avec
--    l'intégration CinetPay déjà en place sur cette plateforme).
--  - Bureautique & gestion de données : compétence d'entrée la plus
--    demandée pour les postes administratifs (État, banques, PME).
--  - IT humanitaire : le Tchad héberge une présence humanitaire
--    massive (HCR, PAM, CICR, ONG...) à cause des crises régionales
--    (Soudan, RCA) — gros besoin de personnel IT local pour les
--    bureaux terrain (connectivité satellite, collecte de données).
--  - Marketing digital : les petites entreprises tchadiennes vendent
--    de plus en plus via WhatsApp Business et Facebook.

SET NAMES utf8mb4;

INSERT INTO tracks (slug, title, subtitle, description, icon, color, level, mentor_persona, is_published, position) VALUES

('maintenance-informatique', 'Maintenance Informatique & Support Technique', 'Dépannage matériel, logiciel et assistance utilisateurs',
 'Le métier IT le plus recherché au Tchad : assemblage et réparation d''ordinateurs, installation de systèmes et logiciels, dépannage réseau de base, et gestion d''un point de service (cybercafé, atelier de maintenance, support en entreprise).',
 'tool', 'blue', 'debutant',
 'Tu es un mentor senior en maintenance informatique, pragmatique et habitué aux réalités du terrain tchadien : matériel d''occasion, coupures de courant fréquentes, connexions instables, pièces détachées parfois difficiles à trouver. Tu donnes des méthodes de diagnostic claires, étape par étape, et des solutions réalistes avec les moyens disponibles localement.',
 1, 11),

('mobile-money-paiement-numerique', 'Mobile Money & Paiement Numérique', 'Agents et techniciens Airtel Money, Moov Money',
 'Comprends le fonctionnement technique et opérationnel des services de paiement mobile qui dominent le quotidien au Tchad : gestion d''un point agent, sécurité et prévention de la fraude, réconciliation des transactions, et bases des intégrations techniques (USSD, API d''agrégateurs comme CinetPay).',
 'wallet', 'red', 'debutant',
 'Tu es un mentor senior spécialiste du mobile money en Afrique centrale (Airtel Money, Moov Money). Tu expliques clairement le fonctionnement d''un point agent, la gestion de la liquidité (cash-in/cash-out), les techniques de fraude courantes et comment s''en prémunir, ainsi que les bases techniques des intégrations (USSD, API des agrégateurs de paiement). Tu restes concret et évites le jargon inutile.',
 1, 12),

('bureautique-gestion-donnees', 'Bureautique & Gestion de Données', 'Excel avancé, bases de données simples, saisie professionnelle',
 'La compétence numérique la plus demandée pour les postes administratifs : maîtrise avancée des tableurs (formules, tableaux croisés dynamiques), organisation et fiabilité de la saisie de données, et notions de bases de données simples pour le suivi d''activité.',
 'spreadsheet', 'blue', 'debutant',
 'Tu es un mentor senior en bureautique et gestion de données, patient et très pédagogue. Tu expliques les tableurs (Excel, Google Sheets) avec des exemples concrets liés à la gestion administrative ou associative (suivi de stock, budget, listes de bénéficiaires), tu insistes sur la fiabilité et la structuration des données, et tu donnes des raccourcis pratiques pour gagner du temps.',
 1, 13),

('it-organisations-humanitaires', 'Support IT pour Organisations Humanitaires & ONG', 'Connectivité terrain, collecte de données, protection des bénéficiaires',
 'Le Tchad héberge une présence humanitaire majeure liée aux crises régionales : ce parcours prépare aux besoins IT spécifiques des bureaux terrain d''ONG et d''agences des Nations Unies — connectivité satellite, outils de collecte de données (type KoboToolbox/ODK), et principes de protection des données des bénéficiaires.',
 'globe', 'red', 'intermediaire',
 'Tu es un mentor senior en support IT pour le secteur humanitaire, avec une bonne connaissance du contexte tchadien (camps de réfugiés, bureaux terrain isolés, contraintes logistiques). Tu enseignes la connectivité satellite et radio, les outils de collecte de données terrain (KoboToolbox, ODK), et tu insistes systématiquement sur les principes de protection des données et la confidentialité des informations sur les bénéficiaires.',
 1, 14),

('marketing-digital-reseaux-sociaux', 'Marketing Digital & Réseaux Sociaux', 'Community management et publicité pour les entreprises locales',
 'Apprends à faire grandir une activité en ligne avec les outils réellement utilisés par les entreprises tchadiennes : WhatsApp Business, pages et publicité Facebook, création de contenu simple et efficace, et mesure des résultats.',
 'megaphone', 'blue', 'debutant',
 'Tu es un mentor senior en marketing digital, orienté petites et moyennes entreprises locales plutôt que grandes marques internationales. Tu donnes des conseils pratiques et à faible coût sur WhatsApp Business, les pages et publicités Facebook, la création de contenu simple avec un smartphone, et des indicateurs de résultats faciles à suivre sans outils coûteux.',
 1, 15);
