Une ONG ouvre une base dans l'Est du Tchad pour accompagner des réfugiés et les communautés qui les accueillent. Pas de fibre, une couverture mobile faible ou inexistante, et pourtant l'équipe doit envoyer ses rapports, échanger avec la coordination à N'Djamena, et surtout pouvoir communiquer en cas d'urgence sécuritaire. Le technicien IT humanitaire doit choisir et combiner plusieurs moyens de communication : **satellite** pour les données, **radio** pour la sécurité, **mobile** quand il existe.

Dans ce parcours, tu suis **Adoum**, technicien IT d'une ONG internationale, chargé d'équiper une nouvelle base à l'Est du pays.

> **Objectifs de ce chapitre**
> - Connaître les solutions de connectivité terrain et leurs usages
> - Comparer les technologies satellite (VSAT, LEO, terminaux portables)
> - Comprendre le rôle des radios HF et VHF dans la sécurité
> - Concevoir une solution de connectivité redondante
> - Connaître le rôle de la coordination des télécommunications d'urgence

## Les options de connectivité

| Solution | Débit | Latence | Coût | Usage typique |
| --- | --- | --- | --- | --- |
| **Réseau mobile 3G/4G** | Moyen à bon | Faible | Faible | Là où la couverture existe ; souvent une box 4G avec antenne extérieure |
| **VSAT géostationnaire** | Moyen | Élevée (environ 600 ms) | Élevé | Connexion fixe d'un bureau, historiquement très utilisée par les ONG |
| **Satellite en orbite basse** (LEO, par exemple Starlink, là où il est autorisé) | Élevé | Faible | Moyen | Bureau ou base, installation rapide |
| **Terminaux satellites portables** (BGAN, Iridium, Thuraya) | Faible | Élevée | Très élevé à l'usage | Missions mobiles, urgences, voix et messages courts |
| **Radio HF** | Voix, données très faibles | — | Équipement seulement | Communications de sécurité à longue distance |
| **Radio VHF** | Voix | — | Équipement seulement | Communications locales : véhicules, base, ville |

> **Attention** : l'utilisation des équipements satellites et radio est **réglementée**. Fréquences radio, autorisations d'importation et licences d'exploitation doivent être obtenues auprès des autorités tchadiennes compétentes. Renseigne-toi sur les règles en vigueur avant tout déploiement.

## Le satellite en pratique

### La latence

Un satellite **géostationnaire** est à environ 36 000 km d'altitude : un aller-retour du signal prend plus d'une demi-seconde. Cela suffit pour les e-mails et la navigation, mais gêne les appels vidéo et certaines applications. Les satellites en **orbite basse** (quelques centaines de kilomètres) offrent une latence proche de celle de la fibre.

### L'installation

- **Dégager la vue du ciel** : pas d'arbre ni de bâtiment dans la direction du satellite (ou au-dessus de l'antenne pour l'orbite basse).
- **Fixer solidement** l'antenne : les vents de sable et les orages de la saison des pluies sont violents.
- **Protéger l'électronique** de la chaleur et de la poussière.
- **Alimenter** de manière stable : onduleur, et souvent panneaux solaires avec batteries.

### Le budget data

Les forfaits satellites peuvent coûter cher. Un technicien maîtrise la consommation :

- bloquer les mises à jour automatiques en journée, les planifier la nuit ;
- limiter les vidéos haute définition et le stockage en ligne automatique des photos ;
- utiliser un **pare-feu** ou un **contrôleur** qui attribue un quota par utilisateur ou par usage.

> **Astuce** : la première cause de facture satellite explosée est souvent la synchronisation automatique de photos et de vidéos des téléphones personnels du personnel connectés au Wi-Fi du bureau. Sépare le réseau du personnel et celui du travail.

## La radio : l'outil de sécurité

Dans les zones à risque, la radio est le **moyen de communication de sécurité principal** : elle ne dépend ni d'un opérateur, ni d'Internet, ni d'un forfait.

- La **VHF** couvre quelques kilomètres à quelques dizaines de kilomètres : radios portatives, radios dans les véhicules, et une station de base au bureau. Un **relais** installé en hauteur étend la portée.
- La **HF** porte à des centaines de kilomètres, voire plus, en utilisant la réflexion sur l'ionosphère : elle relie une base isolée au bureau de coordination.

L'organisation repose sur des **procédures** : indicatifs d'appel pour chaque véhicule et personne, vacations (appels réguliers) à heures fixes, suivi des mouvements de véhicules, alphabet phonétique pour épeler, et messages courts et clairs.

> **Info** : l'alphabet phonétique international (Alpha, Bravo, Charlie, Delta…) évite les confusions de lettres à la radio, surtout avec un signal brouillé. C'est l'une des premières choses que l'on apprend au personnel.

## Concevoir une solution redondante

Sur le terrain, tout tombe en panne un jour : antenne arrachée par le vent, générateur en panne, forfait épuisé, antenne relais de l'opérateur coupée. On conçoit donc des **moyens de secours** :

| Besoin | Moyen principal | Secours |
| --- | --- | --- |
| Internet du bureau | Satellite en orbite basse | Box 4G si couverture, sinon VSAT ou terminal portable |
| Communication de sécurité | Radio VHF et HF | Téléphone satellite |
| Électricité | Réseau ou générateur | Panneaux solaires et batteries |

## La coordination des télécommunications d'urgence

Lors d'une crise humanitaire, les organisations ne travaillent pas seules. Le **Cluster Télécommunications d'Urgence** (*Emergency Telecommunications Cluster*, ETC), coordonné par le Programme alimentaire mondial (PAM), peut fournir des services de connectivité et de radio partagés aux acteurs humanitaires dans les zones d'intervention. Le technicien IT d'une ONG travaille en lien avec ces mécanismes de coordination.

## À toi de jouer

L'ONG d'Adoum ouvre une base de 15 personnes dans une zone sans couverture 4G fiable, avec 4 véhicules qui se déplacent dans un rayon de 80 km.

1. Propose une solution de connectivité Internet principale et une solution de secours, en justifiant.
2. Propose une solution de communication de sécurité pour la base et les véhicules.
3. Liste les éléments à vérifier avant l'installation (autorisations, emplacement, électricité, sécurité).
4. Rédige trois règles d'utilisation d'Internet pour limiter la consommation de data.
5. Rédige la procédure de vacation radio quotidienne (heures, ordre des appels, informations à transmettre).

> **Éléments de correction** : Internet principal par satellite en orbite basse si autorisé, sinon VSAT ; secours par terminal portable satellite. Sécurité : VHF avec relais pour les véhicules dans un rayon de 80 km, HF avec le bureau de coordination, téléphone satellite dans chaque véhicule pour les urgences. Ne pas oublier l'énergie solaire et les autorisations.

## Vérifie tes acquis

1. Pourquoi la latence d'un satellite géostationnaire est-elle élevée ?
2. Pourquoi la radio reste-t-elle indispensable même avec une bonne connexion Internet ?
3. Quelle organisation coordonne le Cluster Télécommunications d'Urgence ?

> **Réponses** : 1. Parce que le satellite est à environ 36 000 km : le signal parcourt une très longue distance. 2. Parce qu'elle ne dépend ni d'un opérateur ni d'Internet, ce qui la rend fiable en cas de crise ou de panne. 3. Le Programme alimentaire mondial (PAM).

## En résumé

- Le terrain combine **mobile**, **satellite** (VSAT, orbite basse, terminaux portables) et **radio** (VHF, HF).
- Le satellite exige une bonne installation, une alimentation stable et une **maîtrise de la consommation**.
- La **radio** est l'outil de sécurité : procédures, indicatifs, vacations, alphabet phonétique.
- On conçoit toujours des **moyens de secours** pour la connectivité, la sécurité et l'électricité.
- Autorisations nationales et coordination humanitaire (ETC) encadrent les déploiements.

## Pour aller plus loin

- Demande au mentor IA : « Comment calculer la taille d'une installation solaire pour alimenter un terminal satellite, un routeur et deux ordinateurs ? »
