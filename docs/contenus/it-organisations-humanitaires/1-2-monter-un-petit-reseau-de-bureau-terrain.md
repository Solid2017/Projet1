La connexion satellite de la base est installée. Adoum doit maintenant monter le **réseau local** du bureau : une quinzaine d'ordinateurs portables, une imprimante, des téléphones, une salle de réunion, et peut-être plus tard un local pour les partenaires. Le tout avec des contraintes fortes : électricité instable, chaleur, poussière, budget limité, et personne pour l'aider s'il tombe en panne la nuit.

> **Objectifs de ce chapitre**
> - Choisir les équipements d'un petit réseau de bureau
> - Planifier l'adressage IP et le Wi-Fi
> - Séparer les réseaux du personnel, des invités et de l'administration
> - Protéger les équipements contre les problèmes électriques et l'environnement
> - Documenter le réseau pour faciliter la maintenance

## Les équipements

| Équipement | Rôle | Conseil terrain |
| --- | --- | --- |
| **Routeur / pare-feu** | Relie le réseau local à Internet, distribue les adresses (DHCP), filtre le trafic | Choisir un modèle qui gère les VLAN et les quotas (MikroTik, Ubiquiti, pfSense sur un petit PC) |
| **Commutateur** (switch) | Relie les appareils câblés entre eux | Un modèle « manageable » permet de créer des VLAN |
| **Points d'accès Wi-Fi** | Fournissent le Wi-Fi | Plusieurs points d'accès gérés de façon centralisée valent mieux qu'un seul très puissant |
| **Onduleur** (UPS) | Fournit de l'électricité pendant les coupures et protège des surtensions | Indispensable pour le routeur, le switch et le terminal satellite |
| **Coffret ou baie** | Protège les équipements | Fermé, ventilé, à l'abri de la poussière |

> **Astuce** : standardise le matériel dans toutes les bases de l'organisation (même marque, mêmes modèles). Les pièces de rechange sont interchangeables, la configuration est identique, et un technicien d'une autre base peut aider à distance.

## Planifier l'adressage

Avant de brancher quoi que ce soit, on écrit le **plan d'adressage** :

| Réseau | VLAN | Plage d'adresses | Usage |
| --- | --- | --- | --- |
| Administration | 10 | 192.168.10.0/24 | Routeur, switch, points d'accès, imprimante |
| Personnel | 20 | 192.168.20.0/24 | Ordinateurs et téléphones professionnels |
| Invités | 30 | 192.168.30.0/24 | Partenaires et visiteurs, accès Internet seulement |

- Les équipements fixes (routeur, imprimante, points d'accès) reçoivent des **adresses fixes**, notées dans la documentation.
- Les autres appareils reçoivent leur adresse automatiquement par **DHCP**.
- Le réseau **invités** n'a accès qu'à Internet, avec un quota de bande passante, et jamais au réseau du personnel.

## Le Wi-Fi

- **Sécurité** : WPA2 ou WPA3 avec un mot de passe long, différent pour le personnel et les invités. Change le mot de passe invités régulièrement.
- **Nom de réseau** (SSID) : clair mais discret, sans le nom de l'organisation dans les zones où la discrétion est importante pour la sécurité.
- **Placement** : points d'accès en hauteur, au centre des zones à couvrir. Les murs en briques épaisses ou en banco atténuent fortement le signal.
- **Bandes** : 5 GHz pour les bureaux (plus rapide, moins encombrée), 2,4 GHz pour une portée plus grande.

> **Attention** : ne laisse jamais le mot de passe d'administration par défaut sur un routeur ou un point d'accès (souvent « admin »). C'est la première chose que testent les personnes malveillantes.

## L'électricité et l'environnement

Sur le terrain, la plupart des pannes réseau sont en réalité des problèmes électriques ou environnementaux :

- **Onduleur** pour tous les équipements réseau, avec une autonomie suffisante pour couvrir le démarrage du générateur ou les coupures courtes.
- **Protection contre la foudre et les surtensions** : parafoudres, mise à la terre correcte de l'antenne satellite et du bâtiment.
- **Chaleur** : les équipements souffrent au-delà de 40 °C. Les placer à l'ombre, dans un local ventilé, jamais en plein soleil ni sous une tôle surchauffée.
- **Poussière** : coffrets fermés, nettoyage régulier des ventilateurs.
- **Énergie solaire** : pour une base isolée, un système de panneaux et de batteries dimensionné pour le réseau et la communication assure le service même quand le générateur est arrêté.

## Les services utiles

- **Partage d'imprimante** sur le réseau du personnel.
- **Stockage partagé** : un petit serveur NAS ou un dossier synchronisé, avec une **sauvegarde** hors du bureau.
- **Mise en cache** des mises à jour pour ne pas télécharger 15 fois la même mise à jour de Windows par le satellite.
- **Supervision** simple : une alerte quand le lien Internet tombe ou que l'onduleur passe sur batterie.

## Documenter

Un réseau non documenté devient incompréhensible après le départ du technicien. Le **dossier réseau** de la base contient :

- un **schéma** du réseau (même dessiné à la main puis photographié) ;
- le **plan d'adressage** et la liste des équipements avec leur adresse, numéro de série et emplacement ;
- les **identifiants d'administration**, rangés dans un gestionnaire de mots de passe partagé de l'organisation, jamais sur un post-it ;
- les **contacts** des fournisseurs (satellite, électricité) ;
- une **procédure de redémarrage** pas à pas, que n'importe quel membre du personnel peut suivre en l'absence du technicien.

> **Info** : la procédure de redémarrage doit être affichée près de la baie, rédigée simplement : « 1. Vérifier que l'onduleur est allumé. 2. Débrancher le terminal satellite 30 secondes. 3. Le rebrancher et attendre 5 minutes… »

## À toi de jouer

Conçois le réseau de la base d'Adoum : 15 membres du personnel, une salle de réunion utilisée par des partenaires, une imprimante, un terminal satellite, et un bâtiment de deux pièces séparées par un mur épais.

1. Dresse la liste du matériel avec quantités et rôle de chaque élément.
2. Rédige le plan d'adressage avec au moins trois réseaux séparés.
3. Décris le placement des points d'accès Wi-Fi sur un plan schématique des deux pièces.
4. Décris la protection électrique (onduleur, parafoudre, solaire).
5. Rédige la procédure de redémarrage affichable, en 6 étapes maximum.

> **Pour t'auto-évaluer** : ton dossier est réussi si un autre technicien, arrivant dans la base sans t'avoir jamais rencontré, peut comprendre le réseau et le dépanner en lisant uniquement ta documentation.

## Vérifie tes acquis

1. Pourquoi séparer le réseau des invités de celui du personnel ?
2. Quels équipements doivent impérativement être branchés sur un onduleur ?
3. Que doit contenir la documentation d'un réseau de base terrain ?

> **Réponses** : 1. Pour que les visiteurs n'aient pas accès aux ordinateurs et données de l'organisation, et pour limiter leur consommation. 2. Le routeur, le switch, les points d'accès et le terminal satellite. 3. Un schéma, le plan d'adressage, la liste des équipements, les identifiants dans un coffre-fort numérique, les contacts fournisseurs et une procédure de redémarrage.

## En résumé

- Un petit réseau : **routeur/pare-feu**, **switch**, **points d'accès**, **onduleur**, matériel standardisé.
- Un **plan d'adressage** avec des réseaux séparés : administration, personnel, invités.
- Un Wi-Fi sécurisé, bien placé, sans mots de passe par défaut.
- **Électricité, chaleur et poussière** sont les premiers ennemis : onduleur, parafoudre, ventilation, solaire.
- Tout est **documenté**, y compris une procédure de redémarrage simple.

## Pour aller plus loin

- Demande au mentor IA : « Comment créer des VLAN pour le personnel et les invités sur un routeur MikroTik ? Donne-moi les étapes. »
