# Installer IgoTech IA sur un hébergement LWSPanel

Ce guide décrit le déploiement de la plateforme sur un hébergement mutualisé
géré par **LWSPanel** (ou tout hébergement Apache + PHP + MySQL similaire).

## Prérequis

- PHP **8.0 ou supérieur** (extensions `pdo_mysql` et `curl` activées — présentes par défaut chez la plupart des hébergeurs).
- Une base de données **MySQL/MariaDB**.
- Apache avec `mod_rewrite` activé (standard sur LWSPanel).
- Une clé API pour le fournisseur d'IA choisi (Anthropic, OpenAI, ou une instance Ollama accessible depuis le serveur).

## 1. Créer la base de données

Dans LWSPanel : **Bases de données MySQL** → créer une base (ex. `igotech_ia`) et un
utilisateur associé avec tous les privilèges sur cette base. Note bien le nom
de la base, l'utilisateur et le mot de passe : ils serviront à l'étape 3.

## 2. Importer le schéma

Depuis **phpMyAdmin** (fourni par LWSPanel), sélectionne ta base puis importe,
dans l'ordre :

1. `database/schema.sql` (structure des tables)
2. `database/seed.sql` (compte administrateur + parcours de démonstration)
3. `database/seed_more_tracks.sql` (parcours supplémentaires, optionnel)

> Le compte admin de démonstration est `admin@igotech.ia` / `IgoTech2026!`.
> **Change ce mot de passe immédiatement** après la première connexion,
> depuis le lien **Mot de passe** dans le menu une fois connecté.

## 3. Déployer les fichiers

Le projet est conçu pour être déposé **tel quel à la racine web** (`public_html/`,
ou le dossier racine de ton domaine/sous-domaine) — il n'y a **aucun réglage
de « document root » à changer** dans LWSPanel. `index.php`, `.htaccess` et
`assets/` sont directement à la racine ; les dossiers `app/`, `config/` et
`database/` sont protégés chacun par leur propre `.htaccess` (`Require all
denied`) qui bloque tout accès direct depuis le navigateur, même s'ils sont
côte à côte avec les fichiers publics.

1. Transfère tout le contenu du dépôt directement dans le dossier racine de ton domaine/sous-domaine (via FTP, Git ou le gestionnaire de fichiers LWSPanel) — pas dans un sous-dossier.
2. Copie `config/config.sample.php` vers `config/config.php` et renseigne :
   - Les identifiants MySQL de l'étape 1.
   - `app.url` avec l'URL réelle de ton site.
   - `app.secret_key` avec une chaîne aléatoire longue.
   - Le fournisseur IA (`ai.provider`, `ai.api_key`, `ai.model`).
3. Ajoute ton logo dans `assets/img/logo.png` (référencé directement par le code — pas de dossier `public/`).
4. Vérifie que `mod_rewrite` et l'interprétation des `.htaccess` (`AllowOverride All`) sont actifs — c'est le réglage par défaut sur LWSPanel. Sans ça, les URLs comme `/login` ou `/dashboard` renverront une erreur 404 générique d'Apache.
5. Vérifie que `https://ton-domaine.tld/config/config.php` et `https://ton-domaine.tld/database/schema.sql` renvoient bien une erreur **403 Forbidden** (et non le contenu du fichier) : ça confirme que les `.htaccess` de protection sont bien pris en compte.

## 4. Choisir le fournisseur du mentor IA

Dans `config/config.php`, section `ai` :

| Fournisseur | `provider`   | Où obtenir la clé                           | Remarque |
|-------------|--------------|----------------------------------------------|----------|
| Claude (Anthropic) | `anthropic` | https://console.anthropic.com | Recommandé, `model: claude-sonnet-5` |
| OpenAI / compatible | `openai`    | https://platform.openai.com   | Fonctionne aussi avec un proxy compatible OpenAI |
| Ollama (local)      | `ollama`    | aucune clé nécessaire          | Nécessite un serveur exécutant Ollama, accessible en réseau depuis l'hébergement (rarement possible sur un mutualisé classique) |

## 5. Vérifier l'installation

1. Ouvre `https://ton-domaine.tld/` : la page d'accueil doit s'afficher.
2. Crée un compte apprenant, inscris-toi à un parcours, ouvre une leçon.
3. Ouvre **Mentor IA** et envoie un message pour vérifier que la connexion au fournisseur IA fonctionne (sinon, vérifie `storage/app.log` et la configuration `ai`).
4. Connecte-toi avec le compte admin pour gérer les parcours, modules, leçons et utilisateurs depuis **Administration**.

## Maintenance

- Les erreurs applicatives sont journalisées dans `storage/app.log` (protégé par `.htaccess`, à consulter via FTP/gestionnaire de fichiers).
- Pour ajouter du contenu, utilise l'interface **Administration** (aucun accès SSH nécessaire).
- Sauvegarde régulièrement la base de données via phpMyAdmin (export SQL).
