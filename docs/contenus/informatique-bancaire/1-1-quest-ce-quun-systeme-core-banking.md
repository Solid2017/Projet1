Quand une cliente dépose 200 000 FCFA à son agence de Moundou, le montant apparaît instantanément sur son compte, consultable depuis l'agence de N'Djamena, l'application mobile ou un guichet automatique. Derrière cette simplicité se trouve le **core banking system** (système bancaire central) : le logiciel au cœur de toute banque, qui tient les comptes de tous les clients et enregistre chaque opération. Les informaticiens qui le maîtrisent sont très recherchés par les banques et les établissements de microfinance.

Dans ce parcours, tu suis **Mahamat**, jeune ingénieur recruté à la direction des systèmes d'information d'une banque commerciale de N'Djamena.

> **Objectifs de ce chapitre**
> - Comprendre le rôle d'un core banking system
> - Connaître ses principaux modules
> - Comprendre le traitement de fin de journée
> - Identifier les systèmes qui gravitent autour du core banking
> - Connaître les grands éditeurs et les métiers associés

## Le rôle du core banking

Le core banking est le **registre central** de la banque. Il :

- gère la **fiche de chaque client** et ses **comptes** ;
- enregistre **chaque opération** : dépôts, retraits, virements, frais, intérêts ;
- calcule les **soldes** en temps réel ;
- produit la **comptabilité** de la banque ;
- applique les **règles** : plafonds, frais, taux, autorisations.

Le mot « central » est important : toutes les agences et tous les canaux (guichet, distributeurs, application mobile, agents) consultent et mettent à jour **le même système**, en temps réel. Avant les systèmes centralisés, chaque agence tenait ses propres comptes et les rapprochements prenaient des jours.

## Les principaux modules

| Module | Rôle | Exemple |
| --- | --- | --- |
| **Clients** (CIF, fiche client unique) | Identité, documents, profil de risque | Création de la fiche d'Achta avec sa pièce d'identité |
| **Comptes** | Comptes courants, d'épargne, à terme | Ouverture d'un compte d'épargne |
| **Opérations de guichet** | Dépôts, retraits, change | Retrait de 50 000 FCFA au guichet |
| **Virements et paiements** | Virements internes, nationaux, internationaux | Paiement d'un fournisseur au Cameroun |
| **Crédits** | Demandes, déblocage, échéanciers, remboursements, impayés | Prêt de 2 000 000 FCFA sur 24 mois |
| **Comptabilité générale** | Écritures comptables, grand livre | Enregistrement automatique de chaque opération en débit et crédit |
| **Reporting** | États pour la direction et le régulateur | Rapport mensuel des crédits en souffrance |

> **Info** : chaque opération du core banking produit des **écritures comptables** en partie double : un compte est débité, un autre est crédité du même montant. Un retrait de 50 000 FCFA débite le compte du client et crédite la caisse de l'agence. C'est ce qui garantit que la banque est toujours « équilibrée ».

## Le traitement de fin de journée

Chaque soir, après la fermeture des agences, le core banking lance un ensemble de traitements automatiques appelé **fin de journée** (*End Of Day*, EOD) ou **batch** :

1. Clôture des caisses des agences.
2. Calcul et comptabilisation des **intérêts** courus sur les comptes et les crédits.
3. Prélèvement des **frais** de tenue de compte et des échéances de prêts.
4. Classement des crédits **impayés** selon leur retard.
5. Production des **états** et des fichiers d'échange avec d'autres systèmes.
6. Changement de la **date comptable** au jour suivant.

Le batch est une opération critique : s'il échoue, les agences ne peuvent pas ouvrir normalement le lendemain. Les équipes informatiques le surveillent de près, souvent la nuit, avec des **sauvegardes** avant et après.

> **Attention** : on ne modifie jamais directement les données du core banking dans la base de données pour « corriger » un solde. Toute correction passe par une **opération** tracée et validée dans l'application, avec l'écriture comptable correspondante. Une modification directe fausserait la comptabilité et constituerait une faute grave.

## L'écosystème autour du core banking

Le core banking ne travaille pas seul. Il échange en permanence avec de nombreux systèmes :

| Système | Rôle |
| --- | --- |
| **Monétique** | Cartes bancaires, distributeurs automatiques (GAB), terminaux de paiement |
| **Banque digitale** | Application mobile, banque en ligne, notifications SMS |
| **Mobile money** | Transferts entre comptes bancaires et portefeuilles mobile money |
| **SWIFT** | Messages des virements internationaux |
| **Systèmes interbancaires régionaux** | Échanges entre banques de la zone CEMAC, compensation et règlement |
| **Lutte contre le blanchiment** (LCB-FT) | Filtrage des noms sur les listes de sanctions, détection des opérations suspectes |
| **Reporting réglementaire** | États transmis à la BEAC et à la COBAC |
| **Gestion électronique des documents** | Numérisation des pièces d'identité et des contrats |

Toutes ces liaisons passent par des **interfaces** : fichiers échangés à heure fixe, API, files de messages. Une grande partie du travail des informaticiens bancaires consiste à faire fonctionner et à surveiller ces interfaces.

## Les grands éditeurs

Peu de banques développent leur propre core banking : elles achètent un progiciel et le paramètrent. Parmi les éditeurs présents en Afrique : **Temenos** (Transact, anciennement T24), **Oracle** (FLEXCUBE), **Sopra Banking Software** (Amplitude), ainsi que des éditeurs spécialisés dans la microfinance. Les concepts restent les mêmes d'un produit à l'autre.

## Les métiers

- **Administrateur fonctionnel** du core banking : paramètre les produits (frais, taux), gère les habilitations, assiste les utilisateurs.
- **Ingénieur d'exploitation** : surveille les traitements de nuit et les interfaces.
- **Développeur et intégrateur** : interfaces, rapports, API, application mobile.
- **Analyste reporting** : produit les états réglementaires et de gestion, souvent en SQL.
- **Chef de projet** : migrations de système, nouveaux produits, mises en conformité.

## À toi de jouer

1. Dessine le schéma de l'écosystème du core banking de la banque de Mahamat : le core banking au centre, et au moins six systèmes connectés, avec la nature des échanges.
2. Décris toutes les étapes, et les écritures comptables simplifiées, d'un dépôt de 200 000 FCFA au guichet de Moundou.
3. Classe les traitements de fin de journée par ordre logique et explique ce qui se passerait si le calcul des intérêts n'était pas effectué une nuit.
4. Un agent te demande de « modifier directement le solde d'un client dans la base » pour corriger une erreur de saisie. Rédige ta réponse et la bonne procédure.

> **Éléments de correction pour l'étape 2** : le caissier vérifie l'identité, saisit l'opération, compte les espèces ; le core banking crédite le compte de la cliente et débite le compte de caisse de l'agence de 200 000 FCFA ; le solde est immédiatement visible dans toutes les agences et sur l'application ; un reçu est remis, et éventuellement un SMS envoyé.

## Vérifie tes acquis

1. Pourquoi dit-on que le core banking est « central » ?
2. Que se passe-t-il pendant la fin de journée ?
3. Pourquoi ne jamais modifier directement un solde dans la base de données ?

> **Réponses** : 1. Parce que toutes les agences et tous les canaux utilisent le même système, en temps réel. 2. Clôture des caisses, calcul des intérêts, prélèvement des frais et échéances, classement des impayés, production des états et changement de date comptable. 3. Parce que cela fausserait la comptabilité et contournerait la traçabilité et les contrôles : toute correction doit passer par une opération tracée.

## En résumé

- Le **core banking** est le registre central : clients, comptes, opérations, comptabilité.
- Modules : clients, comptes, guichet, virements, crédits, comptabilité générale, reporting.
- Chaque opération produit des **écritures comptables** en partie double.
- La **fin de journée** (batch) calcule intérêts et frais et change la date comptable.
- Le core banking est relié à la monétique, au mobile money, à SWIFT, à la LCB-FT et au reporting réglementaire.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi la comptabilité en partie double avec 5 exemples d'opérations bancaires. »
