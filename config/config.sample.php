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
        'model'       => 'claude-sonnet-5',
        'base_url'    => 'https://api.anthropic.com',
        // Pour 'ollama', ex: 'http://127.0.0.1:11434'
        'temperature' => 0.6,
        'max_tokens'  => 1024,
    ],
];
