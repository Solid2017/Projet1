Une banque ne peut pas faire ce qu'elle veut : elle manipule l'argent des déposants et participe au financement de l'économie. Dans les six pays de la CEMAC (Cameroun, Centrafrique, Congo, Gabon, Guinée équatoriale et Tchad), les banques et les établissements de microfinance sont encadrés par des autorités régionales. Pour l'informaticien bancaire, la **conformité** n'est pas qu'une affaire de juristes : une grande partie des exigences se traduisent directement dans les systèmes d'information.

> **Objectifs de ce chapitre**
> - Connaître le rôle de la BEAC et de la COBAC
> - Comprendre les grandes familles d'exigences réglementaires
> - Comprendre la lutte contre le blanchiment et le financement du terrorisme
> - Identifier l'impact de la réglementation sur les systèmes d'information
> - Comprendre le rôle de la fonction conformité et du contrôle interne

> **Attention** : ce chapitre présente les grands principes. Les textes réglementaires évoluent et sont précis : en situation professionnelle, réfère-toi toujours aux règlements en vigueur et à la direction de la conformité de ton établissement.

## Les autorités

| Autorité | Rôle |
| --- | --- |
| **BEAC** (Banque des États de l'Afrique Centrale) | Banque centrale commune : émet le franc CFA d'Afrique centrale (XAF), conduit la politique monétaire, organise et supervise les systèmes de paiement |
| **COBAC** (Commission Bancaire de l'Afrique Centrale) | Superviseur bancaire régional : agrée et contrôle les banques et établissements de microfinance, édicte des règlements prudentiels, peut sanctionner |
| **Autorités nationales** | Le ministère des Finances, et pour la lutte contre le blanchiment une cellule de renseignement financier nationale qui reçoit les déclarations de soupçon |
| **GABAC** (Groupe d'Action contre le Blanchiment d'Argent en Afrique Centrale) | Organisme régional qui coordonne la lutte contre le blanchiment et le financement du terrorisme |

## Les grandes familles d'exigences

### Les règles prudentielles

Elles visent la **solidité** des établissements : niveau minimal de fonds propres, ratios de solvabilité et de liquidité, limitation des risques concentrés sur un seul client ou un seul secteur, classement et provisionnement des créances en souffrance. Le système d'information doit produire **automatiquement et de façon fiable** les données nécessaires au calcul de ces ratios.

### Le reporting réglementaire

Les établissements transmettent périodiquement au régulateur des **états** normalisés : situation comptable, ratios, crédits, risques. Ces états sont produits à partir du core banking selon le **plan comptable** applicable aux établissements de la zone. Une erreur de paramétrage comptable devient une erreur dans les états réglementaires.

### Le contrôle interne et la gestion des risques

Les établissements doivent disposer d'un dispositif de **contrôle interne**, avec des contrôles permanents et périodiques, une fonction **conformité** et une **gestion des risques** couvrant aussi les risques opérationnels et informatiques : continuité d'activité, sécurité des systèmes, externalisation.

### La protection des clients

Transparence des tarifs, information sur les conditions des crédits, traitement des réclamations, confidentialité des données (secret bancaire).

## La lutte contre le blanchiment et le financement du terrorisme

Le **blanchiment** consiste à faire paraître légal de l'argent issu d'activités criminelles (corruption, trafics). Le **financement du terrorisme** peut utiliser de l'argent d'origine légale ou illégale. Les établissements financiers sont en première ligne : on parle de **LCB-FT**.

Leurs obligations principales :

1. **Connaître son client** (KYC) : vérifier l'identité, l'adresse, l'activité, l'origine des fonds, et mettre à jour ces informations.
2. **Évaluer le risque** de chaque client : risque plus élevé pour certaines activités, certains pays ou les **personnes politiquement exposées** (PPE), par exemple de hauts responsables publics et leurs proches.
3. **Filtrer** les clients et les opérations sur les **listes de sanctions** (Nations unies et autres listes applicables).
4. **Surveiller les opérations** et repérer celles qui sont inhabituelles ou incohérentes avec le profil du client.
5. **Déclarer les soupçons** à la cellule de renseignement financier, sans en informer le client.
6. **Conserver** les documents et l'historique des opérations pendant la durée réglementaire.

> **Info** : un exemple de scénario de surveillance : un client déclaré comme petit commerçant, avec habituellement 300 000 FCFA de mouvements par mois, reçoit soudainement 15 virements de l'étranger pour un total de 40 000 000 FCFA, immédiatement retirés en espèces. Le système doit générer une **alerte** analysée par la conformité.

## L'impact sur les systèmes d'information

La réglementation se traduit en exigences très concrètes pour l'informatique :

| Exigence | Traduction dans les systèmes |
| --- | --- |
| KYC | Champs obligatoires dans la fiche client, numérisation des pièces, alertes sur les dossiers incomplets ou expirés |
| Filtrage des sanctions | Outil de filtrage connecté au core banking et aux virements, listes mises à jour automatiquement |
| Surveillance des opérations | Scénarios de détection paramétrés, gestion des alertes, traçabilité de leur traitement |
| Reporting | Requêtes et états fiables, contrôles de cohérence, historique des versions |
| Conservation | Archivage des données et documents pendant la durée exigée, avec possibilité de les retrouver |
| Continuité | Sauvegardes, site de secours, plans de reprise testés |
| Sécurité | Habilitations, journalisation, protection des données |

## La fonction conformité et le rôle de l'informaticien

La **direction de la conformité** veille au respect des règles et traite les alertes LCB-FT. L'**audit interne** vérifie périodiquement l'efficacité du dispositif. L'informaticien bancaire :

- **paramètre** et **maintient** les outils (filtrage, scénarios, reporting) ;
- **fournit** des extractions fiables aux équipes conformité et audit ;
- **garantit** la traçabilité et l'intégrité des données ;
- **alerte** quand une évolution du système risque d'affecter la conformité.

> **Astuce** : quand tu développes un nouveau produit ou un nouveau canal (par exemple l'ouverture de compte en ligne), associe la conformité **dès le début** du projet. Ajouter les contrôles à la fin coûte toujours plus cher, et peut retarder un lancement.

## À toi de jouer

1. Résume en un tableau le rôle de la BEAC, de la COBAC, du GABAC et de la cellule nationale de renseignement financier.
2. Liste les champs obligatoires de la fiche client d'une banque pour satisfaire le KYC, en distinguant particulier et entreprise.
3. Propose trois **scénarios de surveillance** LCB-FT adaptés à une banque tchadienne, avec pour chacun le seuil et la période.
4. La banque lance l'ouverture de compte depuis l'application mobile. Liste les exigences de conformité à intégrer dans le projet et leur traduction technique.

> **Exemples de scénarios pour l'étape 3** : dépôts en espèces fractionnés juste sous un seuil de déclaration sur une courte période ; activité d'un compte sans commune mesure avec le profil déclaré du client ; virements vers ou depuis des pays à haut risque ; compte dormant soudain réactivé avec de gros mouvements.

## Vérifie tes acquis

1. Quel est le rôle principal de la COBAC ?
2. Que signifie KYC et pourquoi est-ce important ?
3. Un employé doit-il prévenir le client lorsqu'une déclaration de soupçon est faite ?

> **Réponses** : 1. Agréer et superviser les banques et établissements de microfinance de la CEMAC, édicter des règles prudentielles et sanctionner. 2. *Know Your Customer*, connaître son client : c'est la base de la lutte contre le blanchiment et la fraude. 3. Non, il est interdit d'en informer le client.

## En résumé

- **BEAC** (banque centrale, systèmes de paiement) et **COBAC** (supervision bancaire) encadrent les établissements de la CEMAC.
- Exigences : règles **prudentielles**, **reporting**, **contrôle interne**, protection des clients.
- **LCB-FT** : KYC, évaluation du risque, filtrage des sanctions, surveillance, déclaration de soupçon, conservation.
- Chaque exigence se traduit dans les **systèmes d'information**.
- L'informaticien travaille main dans la main avec la **conformité**, dès le début des projets.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi les trois étapes du blanchiment d'argent (placement, empilement, intégration) avec des exemples. »
