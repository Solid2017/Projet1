Le réseau de l'agence de microfinance est « à plat » : les ordinateurs des guichets, le serveur de la base clients, l'imprimante et le Wi-Fi offert aux clients dans la salle d'attente sont tous connectés au même réseau. Si un seul appareil est infecté, tout le reste est à portée de l'attaquant. Halimé doit cloisonner. Ses deux outils : le **pare-feu** et la **segmentation**.

> **Objectifs de ce chapitre**
> - Comprendre le rôle d'un pare-feu et le fonctionnement de ses règles
> - Connaître les ports et protocoles les plus courants
> - Découper un réseau en zones (segmentation, VLAN, DMZ)
> - Appliquer le principe du moindre privilège au réseau

## Le pare-feu, un poste de contrôle

Un **pare-feu** (*firewall*) examine chaque connexion qui le traverse et décide de la laisser passer ou de la bloquer, selon des **règles**. Imagine le contrôle à l'entrée d'un bâtiment officiel : on vérifie qui entre, d'où il vient et où il va.

Il en existe deux grands types :

- le pare-feu **réseau** : un boîtier (ou un routeur) placé entre deux réseaux, par exemple entre le réseau de l'agence et Internet ;
- le pare-feu **local** : un logiciel sur chaque ordinateur, comme le pare-feu Windows ou `ufw` sous Linux.

Les deux sont complémentaires : on parle de **défense en profondeur**.

## Adresses, ports et protocoles

Une règle de pare-feu s'appuie sur quelques informations :

- l'adresse IP **source** (qui envoie) et **destination** (qui reçoit) ;
- le **protocole** : TCP ou UDP le plus souvent ;
- le **port** de destination, qui désigne le service visé sur la machine.

| Port | Service | Remarque |
| --- | --- | --- |
| 22 | SSH | Administration à distance des serveurs Linux |
| 53 | DNS | Résolution des noms de domaine |
| 80 / 443 | HTTP / HTTPS | Sites web |
| 3306 | MySQL | Ne doit **jamais** être ouvert sur Internet |
| 3389 | RDP | Bureau à distance Windows, très ciblé par les attaquants |

## Écrire des règles

Les règles sont lues **dans l'ordre**, et la première qui correspond s'applique. La bonne pratique est de tout interdire par défaut, puis d'autoriser uniquement ce qui est nécessaire :

| N° | Source | Destination | Port | Action |
| --- | --- | --- | --- | --- |
| 1 | Réseau guichets | Serveur applicatif | 443 | Autoriser |
| 2 | Poste d'administration | Serveurs | 22 | Autoriser |
| 3 | Réseau Wi-Fi clients | Internet | 80, 443 | Autoriser |
| 4 | Réseau Wi-Fi clients | Réseau interne | tous | Bloquer |
| 5 | Tout | Tout | tous | Bloquer (règle par défaut) |

Sous Linux, avec l'outil `ufw`, la même logique s'écrit en quelques commandes :

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow from 192.168.10.0/24 to any port 22
sudo ufw allow 443/tcp
sudo ufw enable
sudo ufw status numbered
```

> **Attention** : quand tu configures un pare-feu à distance par SSH, autorise **d'abord** ton accès SSH avant d'activer le blocage par défaut. Sinon, tu te retrouves enfermé dehors et il faudra se déplacer jusqu'au serveur.

## Segmenter le réseau

La **segmentation** consiste à découper le réseau en zones séparées, chacune avec son niveau de confiance. Le pare-feu contrôle les échanges entre zones. Sur un même équipement réseau, on crée ces zones avec des **VLAN** (réseaux locaux virtuels).

Pour l'agence, Halimé propose quatre zones :

- **Postes de travail** : les ordinateurs des agents.
- **Serveurs** : base clients, serveur de fichiers. Accès limité aux seuls services nécessaires.
- **Invités** : le Wi-Fi des clients, qui n'accède qu'à Internet.
- **DMZ** (zone démilitarisée) : les serveurs qui doivent être joignables depuis Internet, comme le site web. Si l'un d'eux est piraté, l'attaquant reste coincé dans cette zone.

> **Info** : les imprimantes, caméras de surveillance et autres objets connectés sont souvent mal sécurisés. Place-les dans leur propre zone, isolée des serveurs.

## Le principe du moindre privilège

Chaque utilisateur, programme ou machine ne doit avoir accès **qu'à ce dont il a strictement besoin**. Appliqué au réseau : un poste de guichet n'a aucune raison de se connecter à la base de données en direct sur le port 3306 ; il passe par l'application, sur le port 443.

## À toi de jouer

L'agence a la configuration suivante : 8 postes de guichet, 1 poste de comptabilité, 1 serveur de base de données, 1 serveur web public, 1 imprimante réseau et un Wi-Fi pour les clients.

1. Dessine (sur papier) un schéma avec les zones réseau que tu proposes.
2. Rédige le tableau des règles de pare-feu entre ces zones, en terminant par la règle « tout bloquer ».
3. Indique quels ports ne doivent en aucun cas être accessibles depuis Internet.

> **Éléments de correction** : au minimum quatre zones (postes, serveurs internes, DMZ pour le serveur web, invités), plus idéalement une zone pour l'imprimante. Le Wi-Fi clients n'accède qu'à Internet. Seuls les ports 80 et 443 du serveur web sont ouverts depuis Internet. Les ports 22, 3306 et 3389 ne doivent jamais l'être.

## Vérifie tes acquis

1. Dans quel ordre un pare-feu lit-il ses règles ?
2. À quoi sert une DMZ ?
3. Pourquoi le port 3306 ne doit-il jamais être ouvert sur Internet ?

> **Réponses** : 1. De haut en bas : la première règle qui correspond s'applique. 2. À isoler les serveurs accessibles depuis Internet pour qu'un piratage ne donne pas accès au réseau interne. 3. Parce qu'il expose directement la base de données MySQL aux attaques.

## En résumé

- Un **pare-feu** filtre les connexions selon des règles (source, destination, protocole, port).
- Bonne pratique : **tout bloquer par défaut**, puis autoriser le strict nécessaire.
- La **segmentation** découpe le réseau en zones (postes, serveurs, invités, DMZ) avec des VLAN.
- Le **moindre privilège** limite chaque accès au besoin réel.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi comment créer un réseau Wi-Fi invité isolé sur un routeur TP-Link ou MikroTik. »
