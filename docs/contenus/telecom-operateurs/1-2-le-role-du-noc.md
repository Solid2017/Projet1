Il est 2 h du matin. Un site de la périphérie de N'Djamena vient de tomber en panne, et des milliers d'abonnés n'ont plus de réseau. Dans une salle remplie d'écrans, une alarme rouge s'affiche. L'équipe de nuit du **NOC** (*Network Operations Center*, centre de supervision réseau) doit comprendre ce qui se passe, agir, prévenir les bonnes personnes et faire revenir le service le plus vite possible. Le NOC est le poste de pilotage de l'opérateur, ouvert 24 heures sur 24, 7 jours sur 7.

> **Objectifs de ce chapitre**
> - Comprendre les missions d'un NOC
> - Gérer les alarmes : niveaux de gravité, corrélation, priorisation
> - Suivre le cycle de vie d'un incident et l'escalade
> - Connaître les indicateurs de qualité du réseau
> - Distinguer incident et changement planifié

## Les missions du NOC

- **Surveiller** en permanence l'état du réseau : sites, transmission, cœur de réseau, plateformes de services.
- **Détecter** les pannes et les dégradations, idéalement avant que les clients ne s'en plaignent.
- **Diagnostiquer** et résoudre à distance ce qui peut l'être (redémarrage d'un équipement, bascule sur un lien de secours).
- **Dépêcher** les équipes de terrain quand une intervention physique est nécessaire.
- **Escalader** vers les experts et les fournisseurs quand le problème dépasse le premier niveau.
- **Informer** le service client, la direction et parfois les partenaires.
- **Suivre** les indicateurs de qualité et produire des rapports.

## Les alarmes

Chaque équipement envoie des **alarmes** au système de supervision (**NMS**, *Network Management System*). Elles sont classées par gravité :

| Gravité | Signification | Exemple |
| --- | --- | --- |
| **Critique** | Service interrompu pour des clients | Site hors service, lien de transmission coupé |
| **Majeure** | Service fortement dégradé ou risque imminent | Batteries du site en décharge, plus que 2 heures d'autonomie |
| **Mineure** | Dégradation limitée | Une des trois cellules d'un site indisponible |
| **Avertissement** | À surveiller | Température élevée dans le local technique |

Un même problème génère souvent **beaucoup d'alarmes** : si un lien de transmission tombe, tous les sites qui en dépendent remontent une alarme. Le NOC doit identifier la **cause racine** (le lien) plutôt que de traiter vingt alarmes séparées. Les outils modernes font une partie de cette **corrélation** automatiquement.

> **Info** : au Tchad, une grande partie des alarmes des sites concerne l'**énergie** : coupure du réseau électrique, groupe électrogène en panne ou à court de carburant, batteries faibles. Anticiper ces alarmes (surveillance du niveau de carburant, de l'état des batteries) évite de nombreuses coupures.

## Le cycle de vie d'un incident

1. **Détection** : une alarme apparaît, ou un client signale un problème.
2. **Enregistrement** : un **ticket** est créé avec l'heure, la zone et l'impact.
3. **Qualification** : quel est l'impact (nombre d'abonnés, services touchés) ? Quelle priorité ?
4. **Diagnostic et action** : tests à distance, puis intervention à distance ou envoi d'une équipe.
5. **Escalade** si le délai ou la complexité le demande.
6. **Résolution** : le service est rétabli, on vérifie que les indicateurs sont revenus à la normale.
7. **Clôture** : le ticket est complété avec la cause et la solution.
8. **Analyse** : pour les incidents majeurs, une analyse post-incident identifie la cause racine et les actions pour éviter qu'il se reproduise.

## L'escalade

L'**escalade** fait intervenir un niveau supérieur de compétence ou de décision :

- **escalade fonctionnelle** : vers une équipe plus experte (niveau 1 du NOC, puis niveau 2 des ingénieurs spécialisés, puis niveau 3 du fournisseur d'équipement) ;
- **escalade hiérarchique** : vers les responsables, pour les incidents qui ont un fort impact ou qui durent.

Une **matrice d'escalade** écrite précise qui appeler, quand et pour quel type d'incident. Par exemple : site critique hors service depuis plus d'une heure, on prévient le responsable régional ; cœur de réseau touché, on prévient immédiatement la direction technique.

> **Attention** : pendant un incident majeur, la **communication** est aussi importante que la technique. Le service client doit savoir quoi répondre aux abonnés, et la direction doit recevoir des points réguliers, même quand il n'y a pas encore de solution.

## Les indicateurs de qualité

Le NOC suit des **indicateurs clés** (KPI) :

| Indicateur | Signification |
| --- | --- |
| **Disponibilité des sites** | Pourcentage du temps où les sites sont en service |
| **Taux de succès d'établissement des appels** | Part des tentatives d'appel qui aboutissent |
| **Taux de coupure d'appels** | Part des appels interrompus anormalement |
| **Taux de succès des sessions data** | Part des connexions Internet réussies |
| **Débit moyen** | Vitesse moyenne de l'Internet mobile |
| **MTTR** (*Mean Time To Repair*) | Temps moyen de rétablissement après une panne |

Ces indicateurs servent à piloter l'amélioration du réseau, et certains font l'objet d'exigences de qualité de service fixées par le régulateur.

## Incidents et changements planifiés

Toute intervention **planifiée** sur le réseau (mise à jour logicielle, remplacement d'un équipement, extension) suit une procédure de **gestion des changements** : demande, évaluation des risques, validation, planification dans une fenêtre de faible trafic (souvent la nuit), plan de retour arrière, information du NOC. Sans cela, le NOC risque de traiter comme une panne ce qui est en réalité une intervention, ou une intervention mal préparée peut provoquer une panne majeure.

## À toi de jouer

1. Classe ces alarmes par gravité et par ordre de priorité de traitement : température élevée sur un site rural ; lien de transmission coupé alimentant 12 sites ; une cellule hors service sur un site urbain ; batteries d'un site à 20 % avec groupe électrogène en panne.
2. Pour le lien de transmission coupé, décris les étapes du cycle de vie de l'incident, de la détection à l'analyse post-incident.
3. Rédige la matrice d'escalade d'un NOC : types d'incidents, délais, personnes à prévenir.
4. Rédige le message d'information au service client pour une coupure touchant trois quartiers de N'Djamena.

> **Éléments de correction pour l'étape 1** : priorité 1, le lien coupé (critique, 12 sites touchés) ; priorité 2, les batteries à 20 % sans groupe (majeure : le site va tomber, il faut envoyer une équipe tout de suite) ; priorité 3, la cellule hors service (mineure) ; priorité 4, la température (avertissement, à surveiller).

## Vérifie tes acquis

1. Pourquoi faut-il chercher la cause racine quand de nombreuses alarmes apparaissent en même temps ?
2. Que signifie MTTR ?
3. Pourquoi une intervention planifiée doit-elle être signalée au NOC ?

> **Réponses** : 1. Parce qu'un seul problème (un lien coupé) peut générer de nombreuses alarmes ; le résoudre règle toutes les autres. 2. *Mean Time To Repair*, le temps moyen de rétablissement après une panne. 3. Pour que le NOC ne la traite pas comme un incident et puisse réagir si elle se passe mal.

## En résumé

- Le **NOC** surveille le réseau 24 h/24, détecte, diagnostique, dépêche, escalade et informe.
- Les **alarmes** sont classées par gravité ; la **corrélation** identifie la cause racine.
- Chaque incident suit un **cycle de vie** tracé dans un ticket, jusqu'à l'analyse post-incident.
- Une **matrice d'escalade** et une bonne **communication** sont indispensables.
- Les **KPI** (disponibilité, coupures, MTTR…) pilotent la qualité ; les changements planifiés suivent une procédure.

## Pour aller plus loin

- Demande au mentor IA : « Propose-moi un modèle de rapport post-incident pour une coupure réseau majeure. »
