Dans une banque, la menace ne vient pas seulement de l'extérieur. Un agent qui crée un faux client et lui accorde un prêt, un employé qui consulte par curiosité le compte d'un ministre, un compte d'administrateur partagé entre plusieurs techniciens : beaucoup de fraudes bancaires viennent de l'**intérieur**. La sécurité des accès et des transactions est donc au cœur du métier de Mahamat.

> **Objectifs de ce chapitre**
> - Appliquer le principe du moindre privilège avec des profils d'habilitation
> - Mettre en place la séparation des tâches et le contrôle à quatre yeux
> - Gérer le cycle de vie des comptes utilisateurs
> - Protéger les comptes à privilèges
> - Sécuriser les transactions des clients sur les canaux numériques

## Le moindre privilège et les profils

Chaque utilisateur ne doit avoir accès qu'aux **fonctions strictement nécessaires** à son poste. Dans le core banking, on crée des **profils d'habilitation** par métier plutôt que d'attribuer des droits individuellement :

| Profil | Droits principaux | Interdits |
| --- | --- | --- |
| Caissier | Dépôts, retraits dans la limite de son plafond, consultation des soldes | Création de clients, crédits |
| Chargé de clientèle | Création et mise à jour des clients, ouverture de comptes | Opérations de caisse |
| Analyste crédit | Montage des dossiers de crédit | Validation finale de ses propres dossiers |
| Chef d'agence | Validations au-delà des plafonds | Paramétrage du système |
| Administrateur fonctionnel | Paramétrage des produits et des profils | Opérations sur les comptes des clients |

> **Info** : on parle de **contrôle d'accès basé sur les rôles** (RBAC). Quand un employé change de poste, on change son profil, et ses anciens droits disparaissent automatiquement.

## La séparation des tâches et les quatre yeux

La **séparation des tâches** interdit qu'une même personne puisse réaliser seule une opération sensible de bout en bout. Exemple : la personne qui **saisit** un virement important ne peut pas être celle qui le **valide**.

Le **contrôle à quatre yeux** (ou double validation) en est l'application : une opération sensible est saisie par un premier utilisateur, puis vérifiée et autorisée par un second, dans le système.

Opérations typiquement soumises aux quatre yeux :

- virements au-delà d'un certain montant ;
- déblocage d'un crédit ;
- modification des coordonnées d'un client (téléphone, adresse), car c'est une étape classique des fraudes ;
- annulation d'une opération ;
- modification du paramétrage (taux, frais, plafonds).

> **Attention** : la double validation ne sert à rien si le valideur clique sans regarder, ou si deux collègues se « prêtent » leurs codes. La sensibilisation et le contrôle régulier des validations sont indispensables.

## Le cycle de vie des comptes utilisateurs

| Étape | Bonne pratique |
| --- | --- |
| **Arrivée** | Compte créé sur demande écrite du responsable hiérarchique, avec le profil du poste |
| **Changement de poste** | Ancien profil retiré, nouveau profil attribué, jamais un cumul |
| **Absence longue** | Compte suspendu |
| **Départ** | Compte désactivé **le jour même**, accès distants compris |
| **Revue périodique** | Chaque trimestre, les responsables confirment la liste de leurs collaborateurs et de leurs droits |

Les **comptes partagés** (« guichet1 » utilisé par plusieurs caissiers) sont interdits : chaque action doit pouvoir être attribuée à une personne précise.

## Les comptes à privilèges

Les administrateurs des serveurs, des bases de données et du réseau disposent de droits très étendus. Ces **comptes à privilèges** sont la cible favorite des attaquants. Mesures essentielles :

- des **comptes nominatifs** pour chaque administrateur, distincts de leur compte de travail quotidien ;
- l'**authentification à deux facteurs** obligatoire ;
- un **coffre-fort** de mots de passe pour les comptes techniques, avec des mots de passe changés régulièrement ;
- l'**enregistrement** des sessions d'administration (solutions de gestion des accès à privilèges, PAM) ;
- l'accès aux serveurs uniquement depuis des **postes d'administration** dédiés.

## Sécuriser les transactions des clients

Pour la banque en ligne, l'application mobile et les cartes :

- **Authentification forte** du client : mot de passe ou code, plus un second facteur (code envoyé par SMS, application, biométrie du téléphone).
- **Confirmation** des opérations sensibles (ajout d'un bénéficiaire, gros virement) par un second facteur.
- **Plafonds** par opération et par jour, que le client peut parfois ajuster.
- **Notifications** en temps réel par SMS ou dans l'application pour chaque opération : le client détecte lui-même une opération qu'il n'a pas faite.
- **Chiffrement** des échanges (HTTPS, TLS) et protection de l'application contre la modification.
- **Surveillance anti-fraude** : détection des comportements inhabituels (connexion depuis un nouvel appareil suivie d'un gros virement, opérations à 3 h du matin).

> **Astuce** : la notification SMS de chaque opération est l'une des mesures les plus efficaces et les moins coûteuses contre la fraude : le client devient un détecteur. Assure-toi que le numéro de téléphone du client ne peut pas être modifié sans contrôle à quatre yeux.

## À toi de jouer

1. Construis la **matrice des habilitations** d'une agence : en lignes les profils (caissier, chargé de clientèle, analyste crédit, chef d'agence, contrôleur interne), en colonnes une dizaine de fonctions du core banking, avec pour chaque case : Saisir, Valider, Consulter ou Aucun accès.
2. Repère dans ta matrice les **conflits** de séparation des tâches à éviter.
3. Rédige la **procédure de départ** d'un employé, étape par étape, avec les responsables de chaque étape.
4. Un fraudeur a convaincu un agent de changer le numéro de téléphone d'un client, puis a vidé son compte via l'application mobile. Quelles mesures auraient permis d'éviter ou de détecter cette fraude ?

> **Éléments de correction pour l'étape 4** : contrôle à quatre yeux et vérification d'identité renforcée pour tout changement de numéro ; notification envoyée à l'ancien numéro lors du changement ; délai de sécurité ou plafonds réduits après un changement de numéro ou d'appareil ; surveillance anti-fraude des virements inhabituels ; revue des modifications sensibles par le contrôle interne.

## Vérifie tes acquis

1. Qu'est-ce que le contrôle à quatre yeux ?
2. Pourquoi les comptes partagés sont-ils interdits ?
3. Quand faut-il désactiver le compte d'un employé qui quitte la banque ?

> **Réponses** : 1. Une opération sensible est saisie par une personne puis validée par une seconde dans le système. 2. Parce qu'on ne peut plus attribuer chaque action à une personne précise. 3. Le jour même de son départ, y compris ses accès à distance.

## En résumé

- **Moindre privilège** : des profils d'habilitation par métier (RBAC).
- **Séparation des tâches** et **quatre yeux** pour les opérations sensibles, dont les changements de coordonnées.
- Un **cycle de vie** des comptes maîtrisé, des revues périodiques, aucun compte partagé.
- Les **comptes à privilèges** sont nominatifs, protégés par 2FA, enregistrés et gérés dans un coffre-fort.
- Côté clients : authentification forte, plafonds, **notifications** et surveillance anti-fraude.

## Pour aller plus loin

- Demande au mentor IA : « Aide-moi à construire une matrice de séparation des tâches pour le processus de crédit d'une banque. »
