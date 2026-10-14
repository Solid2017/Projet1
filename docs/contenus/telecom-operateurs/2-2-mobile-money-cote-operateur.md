Pour l'abonné, le mobile money se résume à un menu USSD et quelques SMS. Pour l'opérateur et sa filiale de services financiers, c'est une activité complète, avec une plateforme informatique critique, un réseau de milliers d'agents, des partenaires bancaires, des obligations réglementaires strictes et une surveillance permanente de la fraude. Brahim rejoint l'équipe technique de la plateforme mobile money : voici ce qu'il découvre.

> **Objectifs de ce chapitre**
> - Comprendre l'architecture technique d'une plateforme mobile money
> - Comprendre la gestion du réseau d'agents et de la liquidité
> - Connaître les intégrations avec les partenaires
> - Comprendre les exigences de disponibilité et de sécurité
> - Connaître les obligations de conformité et la réconciliation

## L'architecture technique

| Composant | Rôle |
| --- | --- |
| **Passerelle USSD** | Reçoit les sessions USSD du réseau et les transmet à la plateforme ; renvoie les menus |
| **Plateforme mobile money** (le cœur) | Tient les comptes de monnaie électronique (portefeuilles), exécute les transactions, applique les règles (plafonds, frais, commissions) |
| **Passerelle SMS** | Envoie les confirmations de transaction |
| **Application mobile** et **API** | Canaux pour les smartphones et pour les partenaires (marchands, banques, agrégateurs) |
| **Module de gestion des agents** | Hiérarchie des distributeurs et agents, commissions |
| **Outils de lutte contre la fraude et LCB-FT** | Surveillance des transactions, alertes |
| **Entrepôt de données** et reporting | Analyses, états réglementaires |

La plateforme est **distincte** de la facturation télécom : l'argent électronique n'est pas du crédit téléphonique. Les deux systèmes communiquent seulement pour certains usages, comme l'achat de crédit avec son portefeuille mobile money.

> **Info** : chaque transaction est **atomique** : le débit d'un portefeuille et le crédit de l'autre se font ensemble, ou pas du tout. Une transaction à moitié exécutée, où l'argent quitte un compte sans arriver dans l'autre, est l'un des pires incidents possibles.

## La disponibilité, une exigence vitale

Pour des millions de personnes, le mobile money est **le** moyen de payer et de recevoir de l'argent. Une panne de quelques heures bloque des salaires, des achats de médicaments, des envois familiaux. La plateforme est donc conçue pour une très haute disponibilité :

- serveurs et bases de données **redondants**, avec bascule automatique ;
- **site de secours** capable de reprendre l'activité ;
- **supervision** permanente (temps de réponse, taux de transactions réussies, files d'attente de la passerelle USSD) ;
- mises à jour planifiées la nuit, testées et accompagnées d'un plan de retour arrière.

## La gestion du réseau d'agents

Le réseau d'agents est organisé en hiérarchie : **super-distributeurs**, **distributeurs**, **agents**. La plateforme gère :

- la **création** et la vérification des agents ;
- leurs **plafonds** et leurs droits ;
- le calcul et le versement des **commissions** ;
- les **transferts de float** entre niveaux de la hiérarchie.

La **liquidité** est un sujet central : chaque agent doit disposer d'assez d'espèces et de float pour servir ses clients. L'opérateur suit les niveaux de float des agents, repère ceux qui en manquent et organise le rééquilibrage, notamment dans les zones rurales éloignées des banques. Un agent sans liquidité, c'est un client qui ne peut pas retirer son argent.

## Les intégrations avec les partenaires

La plateforme est reliée à de nombreux partenaires, le plus souvent par **API** :

- **banques** : transferts entre comptes bancaires et portefeuilles, et compte de cantonnement ;
- **facturiers** : sociétés d'électricité et d'eau, bouquets TV, écoles, impôts ;
- **marchands** et **agrégateurs de paiement** ;
- **transferts internationaux** avec des partenaires de transfert d'argent ;
- **interopérabilité** avec les autres opérateurs et les systèmes interbancaires régionaux.

Chaque intégration suit un processus : contrat, spécifications techniques, environnement de test, recette, mise en production, puis **supervision** du flux et réconciliation régulière.

## La sécurité

- **Authentification** des clients par code PIN, jamais stocké en clair, avec blocage après plusieurs erreurs.
- **Chiffrement** des échanges avec les partenaires et protection des API (identifiants, signatures, listes d'adresses autorisées).
- **Séparation des tâches** et **double validation** pour les opérations internes sensibles : ajustement de solde, création de monnaie électronique contre dépôt bancaire, modification des tarifs.
- **Contrôle du changement de SIM** : blocage temporaire des opérations mobile money après un remplacement de carte SIM.
- **Journalisation** complète de toutes les actions, y compris celles des administrateurs.

> **Attention** : la **création de monnaie électronique** doit toujours correspondre à un dépôt réel sur le compte de cantonnement. Elle fait l'objet des contrôles les plus stricts : double validation, rapprochement quotidien avec le relevé bancaire, audit.

## Conformité et réconciliation

En tant qu'activité de services de paiement, le mobile money est encadré par la réglementation de la zone CEMAC, sous la supervision de la **BEAC** et de la **COBAC**. Cela implique notamment :

- l'**identification des clients** (KYC) et des plafonds selon le niveau d'identification ;
- la **lutte contre le blanchiment** : surveillance des transactions, déclarations de soupçon ;
- la **protection des fonds** des clients sur le compte de cantonnement ;
- des **rapports réguliers** au régulateur.

La **réconciliation** quotidienne est indispensable : la somme de tous les portefeuilles (clients, agents, marchands) doit correspondre exactement aux fonds conservés sur le compte de cantonnement. Les transactions avec chaque partenaire sont aussi rapprochées chaque jour, et tout écart est investigué.

## À toi de jouer

1. Dessine l'architecture de la plateforme mobile money, avec ses composants et ses partenaires, et indique les flux d'une transaction de paiement de facture d'électricité.
2. Liste 5 indicateurs que le NOC doit superviser en permanence sur la plateforme, avec un seuil d'alerte pour chacun.
3. Un incident technique a provoqué 120 transactions débitées chez l'expéditeur mais non créditées chez le destinataire. Rédige le plan d'action : détection, correction, communication aux clients, prévention.
4. Explique en 5 lignes pourquoi la réconciliation quotidienne entre portefeuilles et compte de cantonnement est indispensable.

> **Éléments de correction pour l'étape 3** : identifier précisément les transactions concernées dans les journaux ; corriger par des opérations tracées et doublement validées (crédit des destinataires ou remboursement des expéditeurs) ; informer les clients par SMS et le service client ; analyser la cause racine (atomicité non respectée, délai d'attente entre deux systèmes) et corriger le logiciel ; renforcer la supervision des transactions incomplètes.

## Vérifie tes acquis

1. Pourquoi une transaction mobile money doit-elle être atomique ?
2. Pourquoi bloque-t-on temporairement le mobile money après un changement de SIM ?
3. Que doit-on vérifier chaque jour lors de la réconciliation avec le compte de cantonnement ?

> **Réponses** : 1. Pour que l'argent ne puisse jamais quitter un compte sans arriver dans l'autre : débit et crédit se font ensemble ou pas du tout. 2. Pour limiter la fraude au changement de SIM, qui permet à un fraudeur de prendre le contrôle du compte de la victime. 3. Que la somme de tous les portefeuilles correspond exactement aux fonds réels conservés sur le compte de cantonnement.

## En résumé

- La plateforme comprend passerelles USSD et SMS, cœur transactionnel, API, gestion des agents, anti-fraude et reporting.
- Les transactions sont **atomiques** ; la **disponibilité** est vitale : redondance, site de secours, supervision.
- La gestion du **réseau d'agents** et de la **liquidité** conditionne le service aux clients.
- De nombreuses **intégrations** par API relient banques, facturiers, marchands et partenaires.
- Sécurité stricte, conformité **BEAC/COBAC** et **réconciliation** quotidienne protègent l'argent des clients.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi comment fonctionne une transaction atomique dans une base de données, avec un exemple de transfert d'argent. »
