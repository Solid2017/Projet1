Au Tchad, des millions de personnes n'ont jamais ouvert de compte en banque, mais envoient et reçoivent de l'argent chaque semaine avec leur téléphone. Le **mobile money** (Airtel Money, Moov Money) a transformé la façon dont on paie, épargne et aide sa famille, de N'Djamena jusqu'aux villages les plus éloignés. Comprendre comment il fonctionne ouvre la porte à de nombreux métiers : agent, superviseur de réseau, conseiller client, analyste fraude, développeur d'intégrations.

Dans ce parcours, tu suis **Fatimé**, qui ouvre un point de service mobile money au marché de Moundou et veut comprendre le système de bout en bout.

> **Objectifs de ce chapitre**
> - Comprendre ce qu'est la monnaie électronique
> - Identifier les acteurs d'un système de mobile money
> - Suivre le trajet d'un transfert d'argent étape par étape
> - Connaître les principales opérations et leurs frais
> - Comprendre le rôle de la réglementation et de l'interopérabilité

## La monnaie électronique

Quand Fatimé dépose 10 000 FCFA en espèces chez un agent, son solde mobile money augmente de 10 000 FCFA. Ce solde est de la **monnaie électronique** : une valeur stockée sur un compte lié à son numéro de téléphone, qu'elle peut dépenser, envoyer ou retirer.

Point essentiel : chaque franc de monnaie électronique en circulation doit correspondre à un franc réel déposé sur un **compte de cantonnement** (ou compte de garantie) dans une banque. C'est ce qui garantit que les clients peuvent toujours récupérer leur argent en espèces.

> **Info** : le mobile money n'est pas une banque : il ne prête pas l'argent des clients. Les fonds sont conservés en garantie, ce qui le rend sûr, mais explique aussi pourquoi il ne verse généralement pas d'intérêts.

## Les acteurs

| Acteur | Rôle |
| --- | --- |
| **L'émetteur** | L'entité qui émet la monnaie électronique et gère la plateforme, souvent une filiale de l'opérateur télécom agréée pour cela |
| **La banque partenaire** | Conserve les fonds en garantie sur le compte de cantonnement |
| **Les agents** | Boutiques et points de service qui font l'échange espèces ↔ monnaie électronique |
| **Les distributeurs** (ou super-agents) | Gèrent un réseau d'agents et leur fournissent de la liquidité |
| **Les marchands** | Commerces, entreprises et administrations qui acceptent les paiements |
| **Les clients** | Particuliers qui détiennent un compte lié à leur numéro |
| **Le régulateur** | Au Tchad, dans la zone CEMAC, la **BEAC** et la **COBAC** encadrent les services de paiement |

## Le trajet d'un transfert

Mahamat, à N'Djamena, envoie 25 000 FCFA à sa mère à Abéché :

1. Mahamat compose le code USSD de son opérateur (ou ouvre l'application) et choisit « Transfert d'argent ».
2. Il saisit le numéro de sa mère, le montant, puis son **code PIN** secret.
3. La plateforme vérifie le PIN, le solde de Mahamat et les plafonds autorisés.
4. Elle **débite** le compte de Mahamat (montant + frais éventuels) et **crédite** celui de sa mère, dans la même opération : soit les deux se font, soit aucun.
5. Les deux reçoivent un **SMS de confirmation** avec un identifiant de transaction.
6. La mère peut garder l'argent sur son compte, payer un achat, ou se rendre chez un agent d'Abéché pour le retirer en espèces.

Aucun billet n'a voyagé entre N'Djamena et Abéché : seules des écritures ont changé dans la plateforme.

> **Attention** : l'identifiant de transaction reçu par SMS est la preuve d'une opération. Conseille toujours de le conserver, surtout pour les montants importants : c'est lui qu'on demandera en cas de réclamation.

## Les principales opérations

| Opération | Description | Qui paie des frais, en général |
| --- | --- | --- |
| **Dépôt** (*cash-in*) | Le client donne des espèces à un agent, son solde augmente | Souvent gratuit pour le client |
| **Retrait** (*cash-out*) | Le client retire des espèces chez un agent | Le client |
| **Transfert** (P2P) | D'un client à un autre | L'expéditeur, selon le montant |
| **Paiement marchand** | Achat chez un commerçant | Souvent le marchand (commission) |
| **Paiement de factures** | Électricité, eau, TV, frais de scolarité | Variable |
| **Achat de crédit** | Recharge téléphonique | Généralement gratuit |
| **Transfert international** | Réception depuis l'étranger ou envoi | Variable selon les corridors |

Les **grilles tarifaires** sont publiées par chaque opérateur et varient selon les tranches de montant. Elles changent régulièrement : consulte toujours la grille officielle en vigueur.

## Plafonds et identification

Pour limiter la fraude et le blanchiment d'argent, les comptes ont des **plafonds** (montant maximal par opération, par jour, par mois, et solde maximal). Ces plafonds dépendent du niveau d'**identification** du client : un compte ouvert avec une pièce d'identité vérifiée bénéficie de plafonds plus élevés. On parle de procédure **KYC** (*Know Your Customer*, connaître son client).

## L'interopérabilité

Pendant longtemps, un client Airtel Money ne pouvait pas envoyer directement de l'argent à un client Moov Money. L'**interopérabilité** permet ces échanges entre opérateurs, et entre mobile money et banques. Dans la zone CEMAC, le **GIMAC** (Groupement Interbancaire Monétique de l'Afrique Centrale) joue un rôle central dans ces échanges entre acteurs. Les services disponibles évoluent : renseigne-toi auprès des opérateurs sur ce qui est proposé aujourd'hui.

## À toi de jouer

1. Dessine le schéma des acteurs du mobile money et les flux entre eux (argent réel et monnaie électronique).
2. Décris, étape par étape, le trajet d'un paiement de facture d'électricité de 18 000 FCFA, du client jusqu'à la société d'électricité.
3. Relève la grille tarifaire officielle actuelle d'un opérateur (agence, site web ou application) et calcule les frais pour un transfert de 5 000, 50 000 et 200 000 FCFA.
4. Explique en cinq lignes, à une personne âgée qui n'a jamais utilisé le mobile money, pourquoi son argent est en sécurité et quelles précautions prendre.

> **Pour t'auto-évaluer** : ton explication de l'étape 4 est réussie si elle mentionne le code PIN à ne jamais partager, le SMS de confirmation à conserver, et l'agent officiel pour les retraits.

## Vérifie tes acquis

1. Qu'est-ce qui garantit que la monnaie électronique peut toujours être retirée en espèces ?
2. Quel est le rôle d'un agent ?
3. À quoi sert la procédure KYC ?

> **Réponses** : 1. Le fait que chaque franc électronique correspond à un franc réel conservé sur un compte de cantonnement en banque. 2. Échanger des espèces contre de la monnaie électronique et inversement (dépôts et retraits). 3. À vérifier l'identité des clients pour lutter contre la fraude et le blanchiment, ce qui permet des plafonds plus élevés.

## En résumé

- La **monnaie électronique** est garantie par des fonds réels conservés en banque.
- Acteurs : émetteur, banque partenaire, agents, distributeurs, marchands, clients, régulateur (BEAC, COBAC).
- Un transfert débite et crédite deux comptes dans une même opération, confirmée par SMS.
- Opérations : dépôt, retrait, transfert, paiement marchand, factures, crédit, international.
- **Plafonds**, **KYC** et **interopérabilité** encadrent et élargissent le service.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi la différence entre une banque et un émetteur de monnaie électronique, avec des exemples simples. »
