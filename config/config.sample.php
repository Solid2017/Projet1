<?php
/**
 * IgoTech IA — configuration
 *
 * Copie ce fichier en "config.php" (même dossier) puis renseigne tes
 * propres valeurs. "config.php" est ignoré par Git (voir .gitignore)
 * afin de ne jamais committer de secrets.
 */

return [
    // -------------------------------------------------------------
    // Base de données MySQL (identifiants fournis par LWSPanel)
    // -------------------------------------------------------------
    'db' => [
        'host'    => 'localhost',
        'name'    => 'igotech_ia',
        'user'    => 'igotech_user',
        'pass'    => 'change-me',
        'charset' => 'utf8mb4',
    ],

    // -------------------------------------------------------------
    // Application
    // -------------------------------------------------------------
    'app' => [
        'name'        => 'IgoTech IA',
        'url'         => 'https://votre-domaine.tld',
        // Change cette valeur : elle sert à signer les sessions/CSRF.
        'secret_key'  => 'CHANGE-MOI-avec-une-chaine-longue-et-aleatoire',
        'debug'       => false,
    ],

    // -------------------------------------------------------------
    // Mentor IA — fournisseur du modèle de langage
    //
    // provider: "anthropic" | "openai" | "ollama"
    //   - "anthropic": API Claude (https://console.anthropic.com)
    //   - "openai"   : API OpenAI ou toute API compatible OpenAI
    //   - "ollama"   : modèle exécuté en local (ex: sur un serveur
    //                  dédié séparé du mutualisé LWSPanel), pas de clé
    //                  API nécessaire.
    // -------------------------------------------------------------
    'ai' => [
        'provider'    => 'anthropic',
        'api_key'     => 'CHANGE-MOI',
        // claude-haiku-4-5-20251001 : moins cher (~5x que Sonnet), tout à
        // fait suffisant pour du mentorat pédagogique. C'est ce qui rend
        // l'abonnement à 2000 FCFA/mois rentable. Repasse sur un modèle
        // Sonnet si tu veux des réponses plus poussées, au prix d'une
        // marge plus faible par abonné.
        'model'       => 'claude-haiku-4-5-20251001',
        'base_url'    => 'https://api.anthropic.com',
        // Pour 'ollama', ex: 'http://127.0.0.1:11434'
        'temperature' => 0.6,
        'max_tokens'  => 1024,
    ],

    // -------------------------------------------------------------
    // Paiement de l'abonnement au mentor IA — 2000 FCFA / mois.
    //
    // 'manual' (recommandé au lancement) : l'apprenant clique sur
    // « Payer via WhatsApp », tu lui indiques le numéro Airtel Money /
    // Moov Money où envoyer l'argent, puis tu génères son code d'accès
    // dans Administration → Codes d'accès et tu le lui envoies. Il saisit
    // le code sur la page Abonnement : le mentor se débloque aussitôt.
    // Aucun contrat ni agrégateur nécessaire.
    //
    // 'cinetpay' : paiement automatique via l'agrégateur CinetPay
    // (https://cinetpay.com). Nécessite un compte marchand validé et le
    // Tchad activé dans tes pays de collecte ; renseigne alors "api_key"
    // et "site_id" (Réglages > Clés API du tableau de bord CinetPay).
    // -------------------------------------------------------------
    'payment' => [
        'provider'    => 'manual', // 'manual' ou 'cinetpay'
        // Numéro WhatsApp qui reçoit les demandes de paiement (format
        // international, ex: '23566000000'). Si vide, le numéro de la
        // section 'social' ci-dessous est utilisé.
        'whatsapp_number' => '',
        'amount_fcfa' => 2000,
        // Offre annuelle : 20 000 FCFA = 10 mois payés, 2 mois offerts.
        'amount_fcfa_annual' => 20000,

        // Uniquement pour 'cinetpay' :
        'api_key'     => 'CHANGE-MOI',
        'site_id'     => 'CHANGE-MOI',
        'base_url'    => 'https://api-checkout.cinetpay.com',
        'currency'    => 'XAF', // XAF = franc CFA (zone BEAC, dont le Tchad)
    ],

    // -------------------------------------------------------------
    // Réseaux sociaux / communauté — affichés dans le pied de page et
    // utilisés pour l'e-mail automatique de bienvenue. Laisse une valeur
    // vide ('') pour ne pas afficher le lien correspondant.
    // -------------------------------------------------------------
    'social' => [
        'whatsapp_number' => '', // ex: '23566000000' (format international, sans le +)
        'whatsapp_group_invite_link' => '', // lien d'invitation du groupe WhatsApp des apprenants
        'facebook_url' => '',
    ],

    // -------------------------------------------------------------
    // Envoi d'e-mails (réinitialisation de mot de passe) via la boîte
    // mail fournie par ton hébergement LWSPanel.
    //
    // Dans LWSPanel : Comptes e-mail → crée une adresse dédiée (ex:
    // noreply@ton-domaine.tld) avec un mot de passe. Le "host" est
    // généralement "mail.ton-domaine.tld" (vérifie dans la section
    // "Configuration du client mail" de LWSPanel — le nom exact peut
    // varier selon l'hébergeur).
    // -------------------------------------------------------------
    'mail' => [
        'host'       => 'mail.votre-domaine.tld',
        'port'       => 587,        // 587 (STARTTLS, recommandé) ou 465 (SSL direct)
        'encryption' => 'tls',      // 'tls' ou 'ssl'
        'username'   => 'noreply@votre-domaine.tld',
        'password'   => 'CHANGE-MOI',
        'from_email' => 'noreply@votre-domaine.tld',
        'from_name'  => 'IgoTech IA',
    ],

    // -------------------------------------------------------------
    // E-mails automatiques de fidélisation (cron/emails.php, toutes
    // les heures). Voir docs/INSTALL_LWSPANEL.md, section 8.
    // -------------------------------------------------------------
    'retention' => [
        'enabled'       => true,
        'max_per_run'   => 100,  // e-mails max par passage (limite d'envoi de l'hébergeur)
        'min_gap_hours' => 48,   // délai minimum entre deux e-mails pour une même personne
        'weekly_digest' => true, // résumé de la semaine, le lundi à partir de 8h
    ],

    // Clé secrète pour lancer le cron par URL (cron/emails.php?key=…).
    // Inutile si ta tâche planifiée lance la commande php directement.
    'cron' => [
        'key' => '',
    ],
];
