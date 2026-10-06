-- IgoTech IA — e-mails automatiques de fidélisation
-- À importer via phpMyAdmin, en plus des migrations déjà en place.
-- Le script cron/emails.php s'appuie sur ces deux éléments :
--   * email_log : chaque e-mail envoyé (ou tenté) une seule fois par personne
--   * users.email_opt_out : lien de désinscription présent dans chaque e-mail

SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS email_log (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    email_key VARCHAR(40) NOT NULL COMMENT 'Type d''e-mail, ex: first_question, sub_expiring',
    ref_key VARCHAR(64) NOT NULL DEFAULT '' COMMENT 'Distingue les envois répétables (id d''abonnement, semaine, module…)',
    status ENUM('sent', 'failed') NOT NULL DEFAULT 'sent',
    attempts TINYINT UNSIGNED NOT NULL DEFAULT 1,
    sent_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_email_once (user_id, email_key, ref_key),
    KEY idx_email_user_sent (user_id, status, sent_at),
    KEY idx_email_sent_at (sent_at),
    CONSTRAINT fk_email_log_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE users
    ADD COLUMN email_opt_out TINYINT(1) NOT NULL DEFAULT 0 AFTER is_active;
