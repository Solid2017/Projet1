# IgoTech IA

Plateforme de formation en local avec mentorat par IA, destinée aux jeunes
diplômés en informatique et à toute personne souhaitant se lancer dans une
carrière tech. L'IA agit comme mentor et formateur : elle explique les
notions, propose des exercices et répond aux questions des apprenants tout
au long de leurs parcours.

Construite en **JavaScript, PHP et MySQL**, sans framework ni dépendance
Composer, pour un déploiement simple sur un hébergement mutualisé
**LWSPanel** (voir [`docs/INSTALL_LWSPANEL.md`](docs/INSTALL_LWSPANEL.md)).

## Fonctionnalités

- **Parcours de formation** structurés en modules et leçons (Markdown, vidéo, quiz de validation), avec suivi de progression.
- **Mentor IA** conversationnel, contextualisé par parcours/leçon, compatible avec Claude (Anthropic), OpenAI/API compatible, ou un modèle local via Ollama.
- **Espace apprenant** : tableau de bord, inscription aux parcours, quiz notés, historique de conversations avec le mentor, modification du mot de passe.
- **Espace administration** : création/édition des parcours, modules, leçons et quiz, gestion des utilisateurs — sans accès serveur nécessaire.
- **Charte graphique** inspirée du logo IgoTech IA (rouge `#EE1111` / bleu `#1111EE`, formes organiques et arrondies).

## Stack technique

- **Back-end** : PHP 8+ (PDO, sessions, aucune dépendance externe) — structure MVC légère dans `app/`.
- **Base de données** : MySQL/MariaDB (`database/schema.sql`, `database/seed.sql`).
- **Front-end** : HTML/CSS/JS natifs (`assets/`), rendu côté serveur avec vues PHP.
- **IA** : passerelle HTTP (cURL) vers le fournisseur configuré (`app/services/AIService.php`).

## Démarrage local (développement)

```bash
cp config/config.sample.php config/config.php
# renseigner les identifiants MySQL locaux et la clé du fournisseur IA
mysql -u root -p -e "CREATE DATABASE igotech_ia CHARACTER SET utf8mb4"
mysql -u root -p igotech_ia < database/schema.sql
mysql -u root -p igotech_ia < database/seed.sql
php -S localhost:8000
```

Puis ouvre `http://localhost:8000`. Compte admin de démonstration :
`admin@igotech.ia` / `IgoTech2026!` (à changer après la première connexion,
depuis **Mot de passe** dans le menu une fois connecté).

## Déploiement en production (LWSPanel)

Voir le guide détaillé : [`docs/INSTALL_LWSPANEL.md`](docs/INSTALL_LWSPANEL.md).

## Structure du projet

```
index.php             Front-controller / routeur (à la racine du site)
.htaccess              Réécriture d'URL (mod_rewrite)
assets/                CSS, JS, logo (servis directement)
app/
  .htaccess            Bloque l'accès direct (Require all denied)
  bootstrap.php        Amorçage : config, autoload, session
  core/                Router, Database (PDO), Auth, Request, View
  models/              Accès aux données (User, Track, Lesson, Quiz, ...)
  services/            AIService (fournisseurs IA), MentorPromptBuilder
  controllers/         Logique des routes
  views/               Templates PHP + charte graphique
config/
  .htaccess            Bloque l'accès direct
  config.sample.php    Modèle de configuration (à copier en config.php)
database/
  .htaccess            Bloque l'accès direct
  schema.sql           Structure des tables
  seed.sql             Données de démonstration
  seed_more_tracks.sql Parcours supplémentaires (optionnel)
docs/
  INSTALL_LWSPANEL.md  Guide de déploiement
```

Tout se dépose **directement à la racine** de l'hébergement (`public_html/`
ou équivalent) : il n'y a pas de dossier `public/` séparé, donc aucun réglage
de « document root » à changer sur l'hébergeur — seuls `app/`, `config/` et
`database/` restent protégés par leurs propres `.htaccess`.
