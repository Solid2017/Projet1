-- IgoTech IA — paiement manuel par Mobile Money + codes d'accès
-- À importer via phpMyAdmin, en plus des fichiers déjà en place.
-- N'ajoute qu'une nouvelle table, aucune donnée existante n'est touchée.
--
-- Fonctionnement : l'apprenant contacte IgoTech IA sur WhatsApp, fait son
-- transfert Airtel Money / Moov Money, puis l'administrateur génère un
-- code (Administration → Codes d'accès) qu'il lui envoie. L'apprenant
-- saisit ce code sur la page Abonnement : son accès au mentor s'active.

SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS access_codes (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    code CHAR(8) NOT NULL UNIQUE COMMENT 'Affiché sous la forme IGO-XXXX-XXXX',
    plan ENUM('monthly', 'annual') NOT NULL DEFAULT 'monthly',
    months TINYINT UNSIGNED NOT NULL DEFAULT 1,
    amount_fcfa INT UNSIGNED NOT NULL,
    reserved_email VARCHAR(190) NULL COMMENT 'Si renseigné, seul ce compte peut utiliser le code',
    learner_phone VARCHAR(30) NULL,
    note VARCHAR(255) NULL COMMENT 'Ex: référence du transfert Airtel/Moov',
    created_by INT UNSIGNED NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    used_by INT UNSIGNED NULL,
    used_at DATETIME NULL,
    revoked_at DATETIME NULL,
    KEY idx_access_codes_created (created_at),
    CONSTRAINT fk_access_codes_used_by FOREIGN KEY (used_by) REFERENCES users(id) ON DELETE SET NULL,
    CONSTRAINT fk_access_codes_created_by FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
