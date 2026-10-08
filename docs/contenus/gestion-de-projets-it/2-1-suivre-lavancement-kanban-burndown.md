« Où en est-on ? » C'est la question que le directeur général pose à Zara chaque lundi. Répondre « ça avance bien » ne suffit pas. Il faut des outils qui montrent, d'un coup d'œil, l'état réel du travail, les blocages et la tendance. Les plus utilisés en gestion de projet agile sont le **tableau Kanban** et le **graphique d'avancement** (*burndown chart*).

> **Objectifs de ce chapitre**
> - Organiser le travail avec un tableau Kanban
> - Limiter le travail en cours
> - Lire et construire un burndown chart
> - Suivre quelques indicateurs simples
> - Choisir un outil adapté à l'équipe

## Le tableau Kanban

**Kanban** (« étiquette » en japonais) est né dans les usines Toyota. Le principe : rendre le travail **visible** sur un tableau divisé en colonnes qui représentent les étapes. Chaque tâche est une carte qui se déplace de gauche à droite.

Un tableau simple pour l'équipe de Zara :

| À faire | En cours | En revue / test | Terminé |
| --- | --- | --- | --- |
| Paiement Mobile Money | Téléversement des pièces | Création de compte | Page d'accueil |
| Résultats en ligne | Filtre des dossiers | | Choix du concours |

Chaque carte indique la story, la personne qui s'en occupe et éventuellement une étiquette de couleur (bug, urgent, bloqué).

> **Astuce** : un tableau physique avec des post-it sur un mur, bien visible par toute l'équipe, fonctionne très bien et ne dépend ni de l'électricité ni de la connexion. Pour une équipe à distance, un outil en ligne prend le relais.

## Limiter le travail en cours

La règle la plus importante de Kanban, et la plus souvent oubliée : **limiter le nombre de tâches en cours** (*WIP limit*, *Work In Progress*). Par exemple : pas plus de 3 cartes dans la colonne « En cours ».

Pourquoi ? Parce qu'une équipe qui commence tout et ne finit rien n'avance pas. Passer d'une tâche à l'autre fait perdre du temps, et une tâche à 90 % n'apporte aucune valeur. Quand la colonne est pleine, on aide un collègue à terminer plutôt que de commencer autre chose.

> **Info** : « Arrêtez de commencer, commencez à finir » est la devise des équipes Kanban.

## Le burndown chart

Le **burndown chart** montre le travail **restant** au fil du temps. En Scrum, on le trace souvent pour un sprint :

- en abscisse, les jours du sprint ;
- en ordonnée, les points d'effort restants ;
- une **ligne idéale** descend régulièrement du total au départ jusqu'à zéro le dernier jour ;
- la **ligne réelle** est mise à jour chaque jour.

Exemple : un sprint de 10 jours avec 40 points.

| Jour | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Idéal | 40 | 36 | 32 | 28 | 24 | 20 | 16 | 12 | 8 | 4 |
| Réel | 40 | 40 | 37 | 37 | 37 | 29 | 24 | 21 | 13 | 5 |

### Lire le graphique

- La ligne réelle est **au-dessus** de l'idéale : l'équipe est en retard. Ici, du jour 2 au jour 5, rien n'a été terminé : il faut comprendre pourquoi (blocage, tâche sous-estimée, absence).
- La ligne réelle est **plate** pendant plusieurs jours : des tâches sont commencées mais pas terminées, ou l'équipe est bloquée.
- La ligne réelle **remonte** : du travail a été ajouté en cours de sprint, ce qui doit rester exceptionnel.
- La ligne réelle n'atteint pas zéro : certaines stories ne sont pas terminées. Elles retournent dans le backlog.

> **Attention** : le burndown est un outil pour l'équipe, pas un instrument de contrôle. S'il sert à juger les personnes, elles finiront par l'arranger pour qu'il soit joli, et il ne servira plus à rien.

## Quelques indicateurs utiles

- **Vélocité** : points terminés par sprint, en moyenne sur les 3 derniers sprints. Sert à prévoir combien de sprints restent.
- **Temps de cycle** : temps moyen entre le moment où une tâche est commencée et celui où elle est terminée. Plus il est court, plus l'équipe est fluide.
- **Nombre de bugs ouverts** : s'il augmente sprint après sprint, la qualité se dégrade.

Avec une vélocité de 30 points par sprint et 150 points restants dans le backlog, Zara peut annoncer environ 5 sprints, soit 10 semaines, tout en précisant que c'est une estimation qui sera affinée.

## Les outils

| Outil | Points forts |
| --- | --- |
| Tableau mural + post-it | Gratuit, très visible, sans connexion |
| Trello | Simple, gratuit pour les petites équipes, application mobile |
| Jira | Très complet, standard dans les entreprises tech, burndown intégré |
| GitHub Projects / GitLab | Lié directement au code et aux tickets |
| Tableur partagé | Suffisant pour démarrer, burndown en quelques formules |

Le meilleur outil est celui que **toute l'équipe utilise vraiment**, chaque jour.

## À toi de jouer

1. Crée un tableau Kanban (Trello, ou papier) pour un projet personnel ou de groupe, avec au moins 12 cartes et les colonnes À faire, En cours, En revue, Terminé.
2. Fixe une limite de travail en cours et respecte-la pendant une semaine.
3. Dans un tableur, construis le burndown du sprint ci-dessus (lignes idéale et réelle) sous forme de graphique.
4. Rédige en 5 lignes ton analyse de ce sprint pour la rétrospective : que s'est-il probablement passé et que proposer ?
5. Avec une vélocité de 25 points et un backlog restant de 120 points, combien de sprints de 2 semaines faut-il prévoir ?

> **Réponse de l'étape 5** : 120 ÷ 25 = 4,8, donc 5 sprints, soit environ 10 semaines, à présenter comme une estimation.

## Vérifie tes acquis

1. Pourquoi limiter le nombre de tâches en cours ?
2. Que signifie une ligne réelle qui reste plate plusieurs jours sur un burndown ?
3. Comment calcule-t-on la vélocité ?

> **Réponses** : 1. Pour finir les tâches avant d'en commencer d'autres et éviter les pertes de temps liées aux changements de tâche. 2. Que des tâches ne sont pas terminées : blocage, tâche trop grosse ou sous-estimée. 3. En faisant la moyenne des points terminés sur les derniers sprints.

## En résumé

- Le **tableau Kanban** rend le travail visible, colonne par colonne.
- **Limiter le travail en cours** fait avancer plus vite : commencer à finir.
- Le **burndown chart** compare le travail restant à une ligne idéale ; il révèle retards et blocages.
- **Vélocité**, **temps de cycle** et **bugs ouverts** sont des indicateurs simples et utiles.
- Le meilleur outil est celui que l'équipe utilise vraiment.

## Pour aller plus loin

- Demande au mentor IA : « Comment construire un burndown chart automatique dans Google Sheets ? Donne-moi les formules. »
