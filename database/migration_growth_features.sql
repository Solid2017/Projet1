-- IgoTech IA — 5 actions "quick win" (essai gratuit, parrainage,
-- offre annuelle, certificats partageables)
-- À importer via phpMyAdmin, en plus des migrations déjà en place.

SET NAMES utf8mb4;

-- ---------------------------------------------------------------------
-- Parrainage : code unique par utilisateur + qui a parrainé qui
-- ---------------------------------------------------------------------
ALTER TABLE users
    ADD COLUMN referral_code VARCHAR(12) NULL UNIQUE AFTER avatar_color,
    ADD COLUMN referred_by INT UNSIGNED NULL AFTER referral_code,
    ADD CONSTRAINT fk_users_referred_by FOREIGN KEY (referred_by) REFERENCES users(id) ON DELETE SET NULL;

-- Génère un code de parrainage pour les comptes déjà existants (ex: admin de démo).
UPDATE users SET referral_code = UPPER(SUBSTRING(MD5(CONCAT(id, RAND())), 1, 8)) WHERE referral_code IS NULL;

CREATE TABLE IF NOT EXISTS referrals (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    referrer_id INT UNSIGNED NOT NULL,
    referred_id INT UNSIGNED NOT NULL UNIQUE,
    status ENUM('pending', 'rewarded') NOT NULL DEFAULT 'pending',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    rewarded_at DATETIME NULL,
    CONSTRAINT fk_referrals_referrer FOREIGN KEY (referrer_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_referrals_referred FOREIGN KEY (referred_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Offre annuelle : mémorise le plan choisi pour chaque paiement
-- ---------------------------------------------------------------------
ALTER TABLE payments
    ADD COLUMN plan ENUM('monthly', 'annual') NOT NULL DEFAULT 'monthly' AFTER amount_fcfa;
