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
4. `database/migration_subscriptions.sql` (abonnement payant au mentor IA — voir section 5)
5. `database/migration_password_resets.sql` (mot de passe oublié)
6. `database/migration_paiement_manuel.sql` (paiement manuel par WhatsApp + codes d'accès — voir section 5)

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

### Option gratuite (recommandée au démarrage)

Le mentor peut fonctionner sans frais avec les offres gratuites de **Groq** (modèles Llama) et de **Google Gemini**, toutes deux compatibles avec le format OpenAI. Si le quota gratuit du jour d'un fournisseur est épuisé, la plateforme bascule automatiquement sur le suivant (`ai_fallbacks`).

1. Crée une clé gratuite Groq : https://console.groq.com/keys (compte gratuit, sans carte bancaire).
2. Crée une clé gratuite Gemini : https://aistudio.google.com/apikey (compte Google).
3. Copie les sections `ai` et `ai_fallbacks` de `config/config.sample.php` dans `config/config.php`, et remplace `CLE-GROQ` et `CLE-GEMINI` par tes clés.
4. Envoie un message au mentor IA pour tester. En cas de problème, `storage/app.log` indique quel fournisseur a échoué et pourquoi (clé invalide, quota épuisé, modèle introuvable).

À savoir :

- Les quotas gratuits sont **partagés par tous les apprenants** de la plateforme et se comptent par jour. Ils conviennent au lancement ; quand le nombre d'abonnés augmente, ajoute un fournisseur payant en secours (exemple commenté dans `config.sample.php`) ou passe à l'offre payante de Groq.
- Les noms de modèles et les limites changent régulièrement : vérifie-les dans la console de chaque fournisseur (pages *Models* et *Limits* de Groq, documentation de Google AI Studio). Un modèle retiré apparaît dans `storage/app.log` avec une erreur 404.
- Lis les conditions d'utilisation : avec l'offre gratuite de Gemini, Google peut utiliser les conversations pour améliorer ses produits. Rappelle aux apprenants de ne jamais écrire de mot de passe ni de donnée personnelle sensible au mentor.

### Autres fournisseurs

| Fournisseur | `provider` | Où obtenir la clé | Remarque |
|-------------|------------|-------------------|----------|
| Groq | `openai` | https://console.groq.com/keys | Gratuit avec quotas ; `base_url` : `https://api.groq.com/openai` |
| Google Gemini | `openai` | https://aistudio.google.com/apikey | Gratuit avec quotas ; `base_url` : `https://generativelanguage.googleapis.com/v1beta/openai` |
| OpenRouter | `openai` | https://openrouter.ai/keys | Modèles `:free` très limités par jour ; `base_url` : `https://openrouter.ai/api/v1` |
| Claude (Anthropic) | `anthropic` | https://console.anthropic.com | Payant, meilleure qualité pédagogique |
| OpenAI | `openai` | https://platform.openai.com | Payant |
| Ollama (local) | `ollama` | aucune clé nécessaire | Nécessite un serveur exécutant Ollama, accessible depuis l'hébergement (rarement possible sur un mutualisé) |

## 5. Activer l'abonnement payant au mentor IA (Mobile Money)

L'accès au mentor IA est réservé aux apprenants ayant un abonnement actif
(2000 FCFA/mois ou 20 000 FCFA/an par défaut). Deux modes de paiement, au
choix dans `config/config.php` → `'payment' => ['provider' => …]` :

### 5a. Paiement manuel par WhatsApp + code d'accès (recommandé au lancement)

Aucun contrat ni agrégateur : l'argent arrive directement sur ton compte
Airtel Money ou Moov Money.

1. Dans phpMyAdmin, importe `database/migration_paiement_manuel.sql`.
2. Dans `config/config.php`, section `payment` :
   ```php
   'payment' => [
       'provider'           => 'manual',
       'whatsapp_number'    => '23566000000', // ton numéro WhatsApp, format international sans le +
       'amount_fcfa'        => 2000,
       'amount_fcfa_annual' => 20000,
   ],
   ```
3. Le parcours, une fois en place :
   1. Sur la page **Abonnement**, l'apprenant choisit sa formule et clique sur
      **Payer via WhatsApp** : un message prérempli (formule, nom, e-mail du
      compte) s'ouvre vers ton numéro.
   2. Tu lui indiques ton numéro Airtel Money / Moov Money ; il fait le
      transfert et t'envoie la confirmation.
   3. Dans **Administration → Codes d'accès**, choisis la formule, saisis
      l'e-mail de son compte (le code ne marchera que pour lui) et la
      référence du transfert, puis **Générer le code**.
   4. Clique sur **Envoyer le code sur WhatsApp** : le message avec le code
      (`IGO-XXXX-XXXX`) et le lien d'activation est prêt à partir.
   5. L'apprenant saisit le code dans **J'ai reçu mon code** : son accès au
      mentor s'active immédiatement (ou se prolonge s'il est déjà abonné).
4. Chaque code ne sert qu'une fois. Un code envoyé par erreur peut être
   **annulé** tant qu'il n'a pas été utilisé. Après 5 codes faux en 15
   minutes, la saisie est bloquée temporairement (protection contre les
   tentatives au hasard).
5. Les paiements par code apparaissent dans **Administration → Abonnements**
   (canal « Code IGO-… ») et comptent dans le revenu du mois. Le parrainage
   est récompensé au premier code utilisé, comme pour un paiement en ligne.

### 5b. Paiement automatique via CinetPay (optionnel)

Le paiement se fait par **Airtel Money** ou **Moov Money**, via l'agrégateur
**CinetPay** (https://cinetpay.com). Vérifie d'abord avec CinetPay qu'ils
couvrent bien le Tchad (XAF) avec ces deux opérateurs pour ton compte.

1. Crée un compte sur https://cinetpay.com, complète la vérification KYC
   (documents d'entreprise/identité — nécessaire pour recevoir de vrais
   paiements) et active le **Tchad** dans les pays de collecte.
2. Dans le tableau de bord CinetPay : **Réglages → Clés API**, récupère ta
   `apikey` et ton `site_id`.
3. Dans `config/config.php`, section `payment` :
   ```php
   'payment' => [
       'provider'    => 'cinetpay',
       'api_key'     => 'ta-clé-api-cinetpay',
       'site_id'     => 'ton-site-id-cinetpay',
       'base_url'    => 'https://api-checkout.cinetpay.com',
       'currency'    => 'XAF',
       'amount_fcfa' => 2000,
       'amount_fcfa_annual' => 20000,
   ],
   ```
4. Dans le tableau de bord CinetPay, configure l'URL de notification
   (webhook) sur `https://ton-domaine.tld/payments/cinetpay/webhook` si
   l'interface le demande explicitement (sinon elle est déjà transmise à
   chaque paiement par l'application elle-même).
5. Teste un paiement réel avec un petit montant avant de communiquer sur le
   lancement. Si le paiement échoue, la réponse exacte de CinetPay est
   journalisée dans `storage/app.log` (ligne « Erreur initiation paiement »).
   Les codes d'accès de la section 5a restent utilisables en secours.

**Suivi des revenus** : l'onglet **Administration → Abonnements** affiche le
nombre d'abonnés actifs, le revenu du mois en cours et l'historique des
paiements.

**Maîtrise des coûts (marge)** : le modèle IA par défaut est
`claude-haiku-4-5-20251001`, nettement moins cher que Sonnet tout en restant
adapté à un mentorat pédagogique ; l'historique de conversation envoyé à
chaque appel est limité aux 16 derniers messages ; et chaque abonné est
limité à 40 messages/jour (modifiable dans
`ChatController::DAILY_MESSAGE_QUOTA`) pour éviter qu'un usage abusif ne
dépasse la marge dégagée par les 2000 FCFA/mois.

## 6. Activer "Mot de passe oublié" (envoi d'e-mail)

1. Dans LWSPanel : **Comptes e-mail**, crée une adresse dédiée (ex: `noreply@ton-domaine.tld`) avec un mot de passe.
2. Note le serveur SMTP sortant (souvent `mail.ton-domaine.tld`, vérifiable dans la section "Configuration du client mail" de LWSPanel).
3. Dans `config/config.php`, ajoute la section `mail` :
   ```php
   'mail' => [
       'host'       => 'mail.ton-domaine.tld',
       'port'       => 587,
       'encryption' => 'tls',
       'username'   => 'noreply@ton-domaine.tld',
       'password'   => 'le-mot-de-passe-de-cette-boite',
       'from_email' => 'noreply@ton-domaine.tld',
       'from_name'  => 'IgoTech IA',
   ],
   ```
4. Teste en cliquant sur **Mot de passe oublié ?** depuis la page de connexion. En cas d'échec, vérifie `storage/app.log` (les erreurs SMTP y sont journalisées) — les causes les plus fréquentes sont un mauvais `host`/`port`, ou l'adresse `from_email` qui ne correspond pas au compte `username`.

## 7. Vérifier l'installation

1. Ouvre `https://ton-domaine.tld/` : la page d'accueil doit s'afficher.
2. Crée un compte apprenant, inscris-toi à un parcours, ouvre une leçon.
3. Ouvre **Mentor IA** et envoie un message pour vérifier que la connexion au fournisseur IA fonctionne (sinon, vérifie `storage/app.log` et la configuration `ai`).
4. Connecte-toi avec le compte admin pour gérer les parcours, modules, leçons et utilisateurs depuis **Administration**.

## 8. Activer les e-mails automatiques de fidélisation

La plateforme envoie seule 9 e-mails de suivi (première question au mentor, première leçon, essai gratuit presque épuisé, fin d'abonnement, inactivité, résumé du lundi…). Chaque e-mail part une seule fois par personne, jamais plus d'un e-mail tous les 2 jours (sauf les rappels de fin d'abonnement), et chacun contient un lien de désinscription. Prérequis : la section `mail` de l'étape 6.

1. **Base de données** : dans phpMyAdmin, importe `database/migration_emails_fidelisation.sql`.
2. **Configuration** : ajoute dans `config/config.php` les sections `retention` et `cron` (copie-les depuis `config.sample.php`). Vérifie que `app.url` contient bien l'adresse publique du site (`https://ton-domaine.tld`) : elle sert à construire les liens des e-mails.
3. **Tester sans rien envoyer** : dans LWSPanel → **Tâches planifiées (cron)**, crée une tâche ponctuelle avec la commande ci-dessous (remplace le chemin par celui de ton site, visible dans le gestionnaire de fichiers) et regarde le résultat :
   ```
   php /home/ton-compte/www/cron/emails.php --dry-run
   ```
   Le résultat liste les e-mails qui partiraient, sans les envoyer.
4. **Programmer l'envoi** : crée une tâche qui s'exécute **toutes les heures** avec la commande :
   ```
   php /home/ton-compte/www/cron/emails.php
   ```
   Si ton offre ne propose que des tâches par URL, choisis une clé longue et aléatoire dans `'cron' => ['key' => '…']`, puis programme l'URL `https://ton-domaine.tld/cron/emails.php?key=TA_CLE`.
5. **Suivre les envois** : **Administration → E-mails** affiche le dernier passage de la tâche, les envois et échecs par type d'e-mail, les désinscriptions, et un aperçu de chaque modèle.

**Éviter les spams (important)** : dans LWSPanel → **Zone DNS** de ton domaine, vérifie que les enregistrements **SPF** et **DKIM** sont activés pour la messagerie LWS (souvent proposés en un clic). Sans eux, Gmail et Outlook classent une bonne partie des e-mails en indésirables. Ajoute aussi un enregistrement **DMARC** simple : `_dmarc` de type TXT, valeur `v=DMARC1; p=none;`.

Pour suspendre tous les envois sans supprimer la tâche planifiée : `'retention' => ['enabled' => false, …]`.

## Maintenance

- Les erreurs applicatives sont journalisées dans `storage/app.log` (protégé par `.htaccess`, à consulter via FTP/gestionnaire de fichiers).
- Pour ajouter du contenu, utilise l'interface **Administration** (aucun accès SSH nécessaire).
- Sauvegarde régulièrement la base de données via phpMyAdmin (export SQL).
