Quand tu actives un forfait internet de 1 Go par USSD, ton solde est débité, le forfait s'active en quelques secondes, un SMS te le confirme, et chaque mégaoctet consommé est décompté. Derrière cette expérience se cachent les **systèmes informatiques de l'opérateur**, regroupés en deux familles : les **BSS**, tournés vers le client et le commerce, et les **OSS**, tournés vers le réseau. Ce sont des domaines riches en emplois pour les informaticiens.

> **Objectifs de ce chapitre**
> - Distinguer BSS et OSS
> - Comprendre la facturation en temps réel du prépayé
> - Suivre la chaîne de la consommation à la facturation
> - Comprendre le provisioning d'un service
> - Connaître le rôle du CRM et de la gestion du catalogue d'offres

## BSS et OSS

| Famille | Signification | Rôle | Exemples |
| --- | --- | --- | --- |
| **BSS** | *Business Support Systems* | Tout ce qui concerne le **client** et le **commerce** | Catalogue d'offres, facturation, CRM, gestion des commandes, recouvrement, distribution |
| **OSS** | *Operations Support Systems* | Tout ce qui concerne le **réseau** | Supervision, inventaire du réseau, gestion des incidents et des changements, gestion des performances |

Les deux sont reliés : quand un client souscrit une offre dans le BSS, le réseau doit être configuré pour lui fournir le service.

## Le prépayé et la facturation en temps réel

Au Tchad, comme dans la plupart des pays africains, la grande majorité des abonnés sont en **prépayé** : ils rechargent du crédit et le consomment. Il faut donc vérifier **avant et pendant** chaque usage que le client dispose d'un solde suffisant. C'est le rôle de l'**OCS** (*Online Charging System*, système de taxation en ligne) :

1. Le client lance un appel.
2. Le cœur de réseau interroge l'OCS : « Ce client peut-il appeler, et combien de temps ? »
3. L'OCS vérifie le solde, applique le **tarif** (destination, heure, forfait en cours) et **réserve** un crédit correspondant à quelques minutes.
4. Pendant l'appel, la réservation est renouvelée et décomptée.
5. Si le solde est épuisé, l'OCS demande la coupure de l'appel.
6. À la fin, l'OCS débite la consommation réelle et libère le reste.

Tout cela se passe en quelques millisecondes, des millions de fois par jour. L'OCS est donc un système **critique** : s'il tombe, plus personne ne peut appeler ni naviguer.

> **Info** : le même mécanisme s'applique à la data : l'OCS accorde des « tranches » de mégaoctets, décomptées du forfait ou du crédit principal.

## La chaîne de la consommation

Pour les usages facturés après coup (abonnés postpayés, entreprises, interconnexion avec les autres opérateurs, roaming), on suit une chaîne en plusieurs étapes :

1. **Collecte** : les équipements du réseau produisent des **CDR** (*Call Detail Records*), des enregistrements de chaque appel, SMS ou session data (numéros, date, durée, volume, cellule).
2. **Médiation** : un système collecte les CDR de tous les équipements, les vérifie, élimine les doublons et les met dans un format commun.
3. **Valorisation** (*rating*) : chaque événement reçoit un prix selon l'offre du client.
4. **Facturation** (*billing*) : les montants sont regroupés en factures, avec remises et taxes.
5. **Recouvrement** : suivi des paiements, relances, suspension en cas d'impayé.

> **Attention** : une erreur à n'importe quelle étape fait perdre de l'argent à l'opérateur ou facture à tort des clients. C'est pourquoi les opérateurs ont des équipes de **revenue assurance** (assurance des revenus) qui comparent les données de chaque étape pour détecter les **fuites de revenus**, par exemple des CDR perdus en médiation ou une offre mal paramétrée.

## Le catalogue d'offres

Les équipes marketing créent constamment de nouvelles offres : forfaits jour, semaine, mois, forfaits nuit, bonus de recharge, forfaits réseaux sociaux. Le **catalogue de produits** du BSS décrit chaque offre : prix, durée de validité, volumes, conditions, règles de priorité entre plusieurs forfaits actifs.

Le paramétrage d'une nouvelle offre est une opération délicate : il faut la **tester** dans un environnement de préproduction avant le lancement. Un forfait mal paramétré (validité infinie, volume illimité par erreur) peut coûter très cher en quelques heures.

## Le provisioning

Le **provisioning** est l'activation technique d'un service dans le réseau après une commande commerciale. Exemples :

- activation d'une nouvelle carte SIM : enregistrement de l'IMSI et du numéro dans la base des abonnés, avec les services autorisés ;
- activation de l'Internet mobile ou du roaming ;
- changement d'offre ;
- suspension d'une ligne volée.

Un système de **gestion des commandes** orchestre ces actions automatiquement entre le BSS et les équipements du réseau.

## Le CRM et la relation client

Le **CRM** (*Customer Relationship Management*) regroupe les informations sur chaque client : identité (enregistrement obligatoire des cartes SIM), offres souscrites, historique des interactions avec le service client, réclamations. Il est utilisé par les conseillers des agences et du centre d'appels, et alimente les campagnes marketing (par exemple, proposer un forfait adapté à un client qui consomme beaucoup de data).

## À toi de jouer

1. Classe ces systèmes en BSS ou OSS : OCS, supervision des sites, CRM, inventaire des équipements réseau, médiation, gestion des tickets d'incident, catalogue d'offres, gestion des performances radio.
2. Décris étape par étape ce qui se passe dans les systèmes quand un client achète par USSD un forfait internet de 1 Go à 1 000 FCFA, puis navigue.
3. Le marketing veut lancer un « forfait nuit » : 2 Go utilisables de minuit à 6 h, valable 1 jour. Liste les paramètres à définir dans le catalogue et les tests à réaliser avant le lancement.
4. L'équipe revenue assurance constate que le nombre de CDR data en sortie de médiation est inférieur de 3 % à celui des équipements réseau. Quelles hypothèses formules-tu et quelles vérifications proposes-tu ?

> **Éléments de correction pour l'étape 4** : des fichiers de CDR perdus ou rejetés en médiation (vérifier les fichiers en erreur), un équipement mal configuré dont les CDR ne sont pas collectés, une règle de dédoublonnage trop large. On compare les volumes équipement par équipement et heure par heure pour localiser l'écart.

## Vérifie tes acquis

1. Quelle est la différence entre BSS et OSS ?
2. Pourquoi l'OCS est-il un système critique ?
3. Qu'est-ce qu'un CDR ?

> **Réponses** : 1. Les BSS concernent le client et le commerce (offres, facturation, CRM), les OSS concernent l'exploitation du réseau. 2. Parce qu'il autorise et décompte en temps réel chaque appel et chaque session des clients prépayés : s'il tombe, les services s'arrêtent. 3. Un enregistrement détaillé d'un appel, d'un SMS ou d'une session data produit par le réseau.

## En résumé

- **BSS** : client et commerce ; **OSS** : réseau et exploitation.
- Le **prépayé** repose sur l'**OCS**, qui autorise et décompte en temps réel.
- La chaîne **CDR → médiation → valorisation → facturation → recouvrement** ; la **revenue assurance** traque les fuites.
- Le **catalogue d'offres** se paramètre et se teste avec soin.
- Le **provisioning** active les services dans le réseau ; le **CRM** gère la relation client.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi le rôle de la revenue assurance chez un opérateur avec trois exemples de fuites de revenus. »
