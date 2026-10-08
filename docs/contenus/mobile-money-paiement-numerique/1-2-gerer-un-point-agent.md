Fatimé ouvre son point de service mobile money à Moundou. Elle découvre vite que le métier d'agent ne se résume pas à « faire des dépôts et des retraits » : il faut gérer deux caisses à la fois, anticiper les besoins de liquidité, tenir une comptabilité rigoureuse, accueillir les clients et se protéger des fraudes. Un agent bien organisé gagne correctement sa vie ; un agent désorganisé perd de l'argent sans comprendre pourquoi.

> **Objectifs de ce chapitre**
> - Comprendre la double caisse : espèces et float électronique
> - Gérer sa liquidité et anticiper les pics d'activité
> - Tenir un registre et faire la réconciliation quotidienne
> - Calculer ses commissions et sa rentabilité
> - Appliquer les règles de service et de conformité

## Devenir agent

Pour devenir agent, on signe un contrat avec l'opérateur ou avec un distributeur. On fournit généralement : une pièce d'identité, un local identifiable, parfois un registre de commerce, et un fonds de départ. L'agent reçoit un **numéro agent** distinct de son numéro personnel, avec ses propres codes.

> **Attention** : n'utilise jamais ton numéro agent pour tes opérations personnelles, et ton numéro personnel pour celles de tes clients. Mélanger les deux rend la comptabilité impossible et peut entraîner des sanctions.

## La double caisse

Un agent gère en permanence deux réserves :

- les **espèces** dans son tiroir-caisse ;
- le **float** : le solde de monnaie électronique de son compte agent.

Chaque opération déplace l'argent de l'une à l'autre :

| Opération du client | Espèces de l'agent | Float de l'agent |
| --- | --- | --- |
| **Dépôt** de 20 000 FCFA | +20 000 | −20 000 |
| **Retrait** de 15 000 FCFA | −15 000 | +15 000 |

La **somme** espèces + float reste stable (aux commissions près). Ce qui change, c'est la **répartition**. Si tous les clients de la journée font des dépôts, l'agent se retrouve avec beaucoup d'espèces et plus de float : il ne peut plus servir de nouveaux dépôts. C'est le problème de **liquidité**.

## Gérer la liquidité

Pour ne jamais refuser un client :

- **Connaître ses pics** : en début de mois, beaucoup de salariés et de familles qui reçoivent de l'argent viennent **retirer** (besoin d'espèces) ; les jours de marché, les commerçants viennent **déposer** leur recette (besoin de float).
- **Rééquilibrer** régulièrement auprès de son distributeur ou d'une agence bancaire : vendre du float contre des espèces, ou l'inverse.
- **Fixer des seuils** : par exemple, rééquilibrer dès que le float descend sous 100 000 FCFA ou que les espèces dépassent 500 000 FCFA.

> **Info** : trop d'espèces dans la boutique est aussi un **risque de vol**. Ne garde pas plus que ce dont tu as besoin et dépose l'excédent régulièrement, en variant tes horaires et tes trajets.

## Le registre et la réconciliation

Chaque opération est notée dans un **registre** (cahier ou tableur) :

| Heure | Type | Numéro client (partiel) | Montant | Identifiant de transaction | Pièce vérifiée |
| --- | --- | --- | --- | --- | --- |
| 08:42 | Retrait | 66 XX XX 12 | 30 000 | CI241008.0842.B5521 | Oui |
| 09:15 | Dépôt | 99 XX XX 87 | 10 000 | CI241008.0915.A1180 | — |

En fin de journée, l'agent fait la **réconciliation** :

1. Compter les espèces en caisse.
2. Relever le solde du float (par USSD ou application).
3. Comparer avec la situation attendue : espèces et float du matin + effet de chaque opération + commissions.
4. Rechercher immédiatement tout écart.

Un écart de quelques milliers de francs qu'on ne cherche pas le jour même devient une perte qu'on n'expliquera jamais.

## Les commissions et la rentabilité

L'agent est rémunéré par des **commissions** versées par l'opérateur sur chaque opération (souvent une partie des frais payés par le client). Les grilles exactes dépendent de l'opérateur et du contrat.

Pour savoir si son activité est rentable, Fatimé calcule chaque mois :

```text
Bénéfice = commissions du mois − (loyer + électricité + crédit téléphonique + salaire éventuel + autres frais)
```

> **Astuce** : beaucoup d'agents complètent leurs revenus avec des activités liées : vente de crédit, de cartes SIM, d'accessoires téléphoniques, photocopies. Le point mobile money attire du passage, autant en profiter.

## Bien servir et respecter les règles

- **Vérifier l'identité** du client pour les retraits et les montants importants, selon les règles de l'opérateur, et la consigner.
- **Ne jamais demander ni connaître le code PIN** d'un client : c'est lui qui le tape, discrètement.
- **Afficher** la grille tarifaire officielle de manière visible, et ne jamais facturer plus.
- **Donner le reçu** ou attendre que le client ait reçu son SMS de confirmation avant qu'il ne parte.
- **Signaler** les opérations suspectes (montants inhabituels, client qui semble agir sous la contrainte, multiples petits dépôts pour contourner les plafonds).

## À toi de jouer

Fatimé commence la journée avec 300 000 FCFA d'espèces et 400 000 FCFA de float. Voici ses opérations :

- 08:30 retrait de 50 000 ;
- 09:10 dépôt de 120 000 ;
- 10:45 retrait de 35 000 ;
- 14:20 dépôt de 200 000 ;
- 16:00 retrait de 80 000.

1. Calcule les espèces et le float après chaque opération (sans tenir compte des commissions).
2. À quel moment de la journée son float est-il le plus bas ? Pouvait-elle accepter un dépôt supplémentaire de 300 000 FCFA à 15 h ?
3. Conçois le modèle de registre de son point de service dans un tableur, avec une formule qui calcule automatiquement les soldes.
4. Rédige ses règles de rééquilibrage (seuils et actions).

> **Réponses des étapes 1 et 2** : après chaque opération, espèces / float : 250 000 / 450 000 ; 370 000 / 330 000 ; 335 000 / 365 000 ; 535 000 / 165 000 ; 455 000 / 245 000. Le float est au plus bas après le dépôt de 14 h 20 (165 000 FCFA) : à 15 h, elle ne pouvait pas accepter un dépôt de 300 000 FCFA sans rééquilibrer.

## Vérifie tes acquis

1. Que devient le float de l'agent lors d'un dépôt d'un client ?
2. Pourquoi faire la réconciliation chaque jour ?
3. Un client demande à l'agent de taper son code PIN à sa place. Que faire ?

> **Réponses** : 1. Il diminue du montant déposé. 2. Pour détecter et expliquer immédiatement tout écart avant qu'il ne devienne une perte inexpliquée. 3. Refuser poliment et l'inviter à le saisir lui-même, discrètement : un agent ne doit jamais connaître le PIN d'un client.

## En résumé

- L'agent gère une **double caisse** : espèces et **float** électronique.
- Dépôts et retraits déplacent la valeur d'une caisse à l'autre ; la **liquidité** doit être rééquilibrée.
- Un **registre** et une **réconciliation** quotidienne évitent les pertes inexpliquées.
- La rentabilité se calcule : commissions moins charges.
- Service de qualité et conformité : identité vérifiée, PIN jamais partagé, tarifs affichés, opérations suspectes signalées.

## Pour aller plus loin

- Demande au mentor IA : « Aide-moi à construire dans Google Sheets un registre d'agent mobile money avec calcul automatique des soldes. »
