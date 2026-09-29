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
    // Paiement Mobile Money (Airtel Money / Moov Money) pour
    // l'abonnement au mentor IA — 2000 FCFA / mois.
    //
    // Recommandé : CinetPay (https://cinetpay.com), un agrégateur qui
    // gère Airtel Money, Moov Money, Orange Money et les cartes via une
    // seule API, sans qu'IgoTech ait besoin d'un compte marchand séparé
    // chez chaque opérateur. Crée un compte CinetPay, active le Tchad
    // dans tes pays de collecte, puis récupère "apikey" et "site_id"
    // dans Réglages > Clés API du tableau de bord CinetPay.
    //
    // ⚠️ Vérifie ces noms de champs dans la doc CinetPay au moment de
    // la mise en prod (https://docs.cinetpay.com) : un agrégateur de
    // paiement peut faire évoluer son API sans préavis, et ce fichier a
    // été écrit sans compte CinetPay actif pour le tester en conditions
    // réelles.
    // -------------------------------------------------------------
    'payment' => [
        'provider'    => 'cinetpay',
        'api_key'     => 'CHANGE-MOI',
        'site_id'     => 'CHANGE-MOI',
        'base_url'    => 'https://api-checkout.cinetpay.com',
        'currency'    => 'XAF', // XAF = franc CFA (zone BEAC, dont le Tchad)
        'amount_fcfa' => 2000,
    ],
];
