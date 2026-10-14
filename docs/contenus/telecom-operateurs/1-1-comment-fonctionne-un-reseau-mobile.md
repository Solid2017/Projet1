Quand tu appelles ta famille depuis N'Djamena vers Sarh, ta voix parcourt en une fraction de seconde des antennes, des liaisons hertziennes ou en fibre, des centres de commutation et des serveurs. Comprendre ce chemin est la base de tous les métiers des télécoms : ingénieur radio, technicien de maintenance des sites, ingénieur transmission, ingénieur cœur de réseau, superviseur NOC.

Dans ce parcours, tu suis **Brahim**, jeune ingénieur qui vient d'intégrer la direction technique d'un opérateur mobile tchadien.

> **Objectifs de ce chapitre**
> - Comprendre l'architecture d'un réseau mobile : accès radio, transmission, cœur de réseau
> - Connaître le principe des cellules et du handover
> - Comparer les générations 2G, 3G, 4G et 5G
> - Comprendre le rôle des fréquences et de la carte SIM
> - Connaître les défis du déploiement au Tchad

## Les trois grandes parties du réseau

| Partie | Rôle | Éléments |
| --- | --- | --- |
| **Réseau d'accès radio** | Relier les téléphones au réseau par ondes radio | Antennes et stations de base sur les pylônes (sites) |
| **Réseau de transmission** (*backhaul*) | Relier les sites entre eux et au cœur de réseau | Faisceaux hertziens, fibre optique, parfois satellite |
| **Cœur de réseau** | Gérer les abonnés, établir les appels et les sessions data, relier aux autres réseaux et à Internet | Serveurs et commutateurs dans les centres techniques |

## Les cellules

Le territoire est découpé en **cellules** : la zone couverte par une antenne. Un **site** (un pylône) porte souvent trois antennes orientées dans des directions différentes, donc trois cellules, ou **secteurs**.

- En ville, les cellules sont **petites** et nombreuses : beaucoup d'utilisateurs se partagent la capacité.
- En zone rurale, elles sont **grandes** pour couvrir de vastes espaces avec peu de sites.

Quand tu te déplaces pendant un appel, ton téléphone passe d'une cellule à l'autre sans coupure : c'est le **handover** (transfert intercellulaire).

> **Info** : la capacité d'une cellule est **partagée**. C'est pourquoi l'Internet mobile ralentit à l'heure de pointe dans un marché ou un stade : des centaines de personnes se partagent la même antenne.

## Les générations

| Génération | Apport principal | Débits typiques | Équipement radio |
| --- | --- | --- | --- |
| **2G** (GSM) | Appels et SMS numériques ; data très lente (GPRS, EDGE) | Quelques dizaines de kbit/s | BTS |
| **3G** (UMTS) | Internet mobile utilisable | Quelques Mbit/s | NodeB |
| **4G** (LTE) | Internet mobile rapide, tout en IP | Plusieurs dizaines de Mbit/s | eNodeB |
| **5G** | Très hauts débits, latence très faible, objets connectés massifs | Centaines de Mbit/s et plus | gNodeB |

Les générations **coexistent** : la 2G reste essentielle pour la voix, les SMS et l'USSD (donc le mobile money) sur les téléphones simples et dans les zones rurales ; la 4G porte l'essentiel de l'Internet mobile dans les villes.

## Le cœur de réseau

Le cœur de réseau :

- **identifie et authentifie** les abonnés grâce à la carte SIM et à la base des abonnés (HLR en 2G/3G, HSS en 4G, UDM en 5G) ;
- **localise** les abonnés pour pouvoir leur acheminer les appels ;
- **établit** les appels et les sessions data ;
- **relie** le réseau aux autres opérateurs (interconnexion), à l'international et à Internet ;
- **collecte** les informations de consommation pour la facturation.

En 4G, le cœur de réseau s'appelle **EPC** (*Evolved Packet Core*) ; en 5G, le **5GC**, construit sur des fonctions logicielles.

## La carte SIM

La **carte SIM** contient l'identité de l'abonné (l'**IMSI**) et une **clé secrète** partagée avec le réseau. À chaque connexion, le réseau envoie une question que seule une SIM authentique peut résoudre avec cette clé : c'est l'**authentification**. La clé ne circule jamais sur les ondes. Le numéro de téléphone (le **MSISDN**) est associé à l'IMSI dans la base des abonnés.

> **Attention** : c'est pour cette raison que la fraude au changement de carte SIM est si grave : le fraudeur obtient une SIM authentique associée au numéro de la victime. L'enregistrement et la vérification d'identité lors des remplacements de SIM sont des contrôles essentiels pour l'opérateur.

## Les fréquences

Les ondes radio utilisent des **bandes de fréquences**, ressource rare attribuée par l'État à chaque opérateur via le régulateur. Règle générale :

- les **basses fréquences** (par exemple autour de 800 ou 900 MHz) portent **loin** et traversent bien les murs : idéales pour couvrir les zones rurales ;
- les **hautes fréquences** (1 800 MHz, 2 600 MHz, 3,5 GHz) offrent **plus de capacité** mais portent moins loin : idéales en ville.

## Les défis du terrain au Tchad

- **Un territoire immense** et peu densément peuplé : couvrir les zones rurales coûte cher pour peu d'abonnés.
- **L'énergie** : beaucoup de sites ne sont pas raccordés au réseau électrique. Ils fonctionnent avec des **groupes électrogènes**, des **panneaux solaires** et des **batteries**, dont la maintenance et l'approvisionnement en carburant sont un enjeu majeur.
- **La chaleur et le sable** : les équipements doivent être protégés, refroidis et nettoyés.
- **La transmission** : la fibre optique se déploie progressivement ; de nombreux sites sont reliés par faisceaux hertziens, et les plus isolés parfois par satellite.
- **La sécurité** des sites et du carburant.

## À toi de jouer

1. Dessine le schéma du trajet d'un appel entre deux abonnés du même opérateur, l'un à N'Djamena, l'autre à Sarh, en nommant chaque partie du réseau traversée.
2. Explique pourquoi un opérateur utiliserait la bande 800 MHz pour couvrir une zone rurale et la bande 1 800 MHz en centre-ville.
3. Un village se plaint : « On capte le réseau mais Internet est inutilisable le soir. » Propose deux hypothèses et la vérification à faire pour chacune.
4. Liste les équipements d'un site rural alimenté sans réseau électrique et les tâches de maintenance régulières associées.

> **Éléments de correction pour l'étape 3** : saturation de la cellule aux heures de pointe (vérifier le taux d'utilisation de la cellule le soir) ; capacité insuffisante de la transmission du site, par exemple un faisceau hertzien de faible débit (vérifier l'occupation du lien de transmission). On peut aussi soupçonner une couverture seulement 2G dans le village.

## Vérifie tes acquis

1. Quelles sont les trois grandes parties d'un réseau mobile ?
2. Qu'est-ce que le handover ?
3. Pourquoi la 2G reste-t-elle importante au Tchad ?

> **Réponses** : 1. Le réseau d'accès radio, le réseau de transmission et le cœur de réseau. 2. Le passage d'une cellule à une autre sans coupure pendant un appel ou une session. 3. Parce qu'elle porte la voix, les SMS et l'USSD (donc le mobile money) sur tous les téléphones, y compris en zone rurale.

## En résumé

- Un réseau mobile = **accès radio** + **transmission** + **cœur de réseau**.
- Le territoire est découpé en **cellules** ; le **handover** assure la continuité.
- 2G, 3G, 4G et 5G **coexistent**, chacune avec ses usages.
- La **SIM** authentifie l'abonné grâce à une clé secrète ; les **fréquences** sont attribuées par l'État.
- Au Tchad : grandes distances, énergie hors réseau, chaleur et transmission sont les défis majeurs.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi la différence entre un faisceau hertzien et une liaison en fibre optique pour relier des sites mobiles. »
