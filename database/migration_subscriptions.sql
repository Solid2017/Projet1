-- IgoTech IA — abonnement payant au mentor IA (Mobile Money)
-- À importer via phpMyAdmin, en plus des fichiers déjà en place.
-- N'ajoute que deux nouvelles tables, aucune donnée existante n'est touchée.

SET NAMES utf8mb4;

-- ---------------------------------------------------------------------
-- Abonnements au mentor IA (2000 FCFA / mois par défaut)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS subscriptions (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    status ENUM('active', 'expired', 'cancelled') NOT NULL DEFAULT 'active',
    started_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    expires_at DATETIME NOT NULL,
    amount_fcfa INT UNSIGNED NOT NULL DEFAULT 2000,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_subscriptions_user_status (user_id, status, expires_at),
    CONSTRAINT fk_subscriptions_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Journal des paiements Mobile Money (Airtel Money / Moov Money via
-- un agrégateur comme CinetPay)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS payments (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    transaction_id VARCHAR(64) NOT NULL UNIQUE,
    provider VARCHAR(40) NOT NULL DEFAULT 'cinetpay',
    channel VARCHAR(40) NULL COMMENT 'ex: AIRTEL_MONEY, MOOV_MONEY',
    phone VARCHAR(30) NULL,
    amount_fcfa INT UNSIGNED NOT NULL,
    status ENUM('pending', 'success', 'failed') NOT NULL DEFAULT 'pending',
    provider_reference VARCHAR(120) NULL,
    raw_response TEXT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_payments_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
