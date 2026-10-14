-- IgoTech IA — numéro WhatsApp obligatoire à l'inscription + rôle
-- "mentor" pour l'annuaire des mentors physiques classés par domaine.
-- À importer via phpMyAdmin, en plus des migrations déjà en place.

SET NAMES utf8mb4;

ALTER TABLE users
    MODIFY COLUMN role ENUM('student', 'mentor', 'admin') NOT NULL DEFAULT 'student',
    ADD COLUMN whatsapp_number VARCHAR(30) NULL AFTER email,
    ADD COLUMN mentor_bio TEXT NULL COMMENT 'Présentation affichée dans l''annuaire des mentors' AFTER headline;

-- ---------------------------------------------------------------------
-- Domaines professionnels d'un mentor (un mentor peut couvrir plusieurs
-- parcours, ex: "Cybersécurité" + "Administration Systèmes & Réseaux")
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS mentor_domains (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    mentor_id INT UNSIGNED NOT NULL,
    track_id INT UNSIGNED NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_mentor_track (mentor_id, track_id),
    CONSTRAINT fk_mentor_domains_mentor FOREIGN KEY (mentor_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_mentor_domains_track FOREIGN KEY (track_id) REFERENCES tracks(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
