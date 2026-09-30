-- IgoTech IA — photo de profil obligatoire pour tous les utilisateurs
-- À importer via phpMyAdmin, en plus des migrations déjà en place.

SET NAMES utf8mb4;

ALTER TABLE users
    ADD COLUMN avatar_path VARCHAR(255) NULL COMMENT 'Chemin relatif vers la photo de profil, ex: uploads/avatars/xxx.jpg' AFTER avatar_color;
