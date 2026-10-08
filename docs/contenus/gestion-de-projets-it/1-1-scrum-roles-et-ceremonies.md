Le ministère a commandé à une entreprise de N'Djamena une plateforme d'inscription en ligne aux concours de la fonction publique. Le cahier des charges fait 80 pages, le délai est de 6 mois. Avec une méthode classique, l'équipe développerait tout pendant 6 mois avant de montrer le résultat… au risque de découvrir trop tard que ce n'est pas ce qu'on attendait. Avec **Scrum**, elle livrera une version utilisable toutes les deux semaines et ajustera le tir en continu.

Dans ce parcours, tu suis **Zara**, cheffe de projet qui découvre les méthodes agiles sur ce projet.

> **Objectifs de ce chapitre**
> - Comprendre la différence entre cycle en V et approche agile
> - Connaître les trois rôles de Scrum
> - Connaître les événements (cérémonies) d'un sprint
> - Connaître les artefacts : backlog produit, backlog de sprint, incrément
> - Savoir quand Scrum est adapté, et quand il ne l'est pas

## Prédictif ou agile ?

L'approche **prédictive** (le cycle en V ou « en cascade ») enchaîne des phases : spécifications complètes, conception, développement, tests, livraison. Elle convient quand le besoin est parfaitement connu et stable, comme la construction d'un bâtiment.

L'approche **agile** découpe le projet en courtes itérations. À chaque itération, on livre une partie fonctionnelle du produit, on recueille les retours et on adapte la suite. Elle convient quand le besoin évolue ou n'est pas entièrement connu au départ, ce qui est le cas de la plupart des projets logiciels.

> **Info** : le **Manifeste agile** (2001) résume l'état d'esprit en quatre valeurs : les individus et leurs interactions plutôt que les processus et les outils ; un logiciel qui fonctionne plutôt qu'une documentation exhaustive ; la collaboration avec le client plutôt que la négociation contractuelle ; l'adaptation au changement plutôt que le suivi d'un plan.

## Scrum en une phrase

**Scrum** est le cadre agile le plus utilisé : une petite équipe livre un produit par **sprints**, des itérations de durée fixe (généralement 2 semaines, au maximum un mois), en s'inspectant et en s'adaptant régulièrement.

## Les trois rôles

### Le Product Owner

Il représente les utilisateurs et le client. Il décide **quoi** construire et dans quel ordre. Il gère le **backlog produit** (la liste ordonnée de tout ce qu'il faut faire) et maximise la valeur du produit. Sur le projet de Zara, c'est un agent du ministère, disponible chaque semaine.

### Le Scrum Master

Il aide l'équipe à appliquer Scrum et à s'améliorer. Il anime les événements, protège l'équipe des interruptions et lève les obstacles (un accès au serveur qui tarde, un service qui ne répond pas). Ce n'est **pas** un chef qui distribue les tâches.

### Les Developers

L'équipe qui réalise le travail : développeurs, testeurs, designers. Elle décide elle-même **comment** faire le travail et s'organise librement. Taille idéale : une dizaine de personnes au maximum.

> **Attention** : le Product Owner décide du **quoi**, l'équipe du **comment**. Un Product Owner qui impose la technique, ou une équipe qui change les priorités sans lui, sont deux signes de dysfonctionnement.

## Les événements du sprint

| Événement | Quand | Durée (sprint de 2 semaines) | Objectif |
| --- | --- | --- | --- |
| Sprint Planning | Début du sprint | 4 h max | Choisir l'objectif du sprint et les éléments à réaliser |
| Daily Scrum | Chaque jour, même heure | 15 min | Faire le point sur l'avancement vers l'objectif et les obstacles |
| Sprint Review | Fin du sprint | 2 h max | Montrer l'incrément aux parties prenantes et recueillir leurs retours |
| Sprint Retrospective | Après la review | 1 h 30 max | Améliorer la façon de travailler de l'équipe |

Le **Daily Scrum** n'est pas une réunion de compte rendu au chef : c'est un moment où l'équipe se synchronise. Beaucoup d'équipes s'appuient sur trois questions : qu'ai-je fait hier pour l'objectif ? que vais-je faire aujourd'hui ? qu'est-ce qui me bloque ?

La **rétrospective** est souvent la plus négligée, et pourtant la plus précieuse : on y décide d'une ou deux améliorations concrètes à essayer au sprint suivant.

## Les artefacts

- Le **Product Backlog** : la liste ordonnée de toutes les fonctionnalités, corrections et améliorations souhaitées. Elle évolue en permanence.
- Le **Sprint Backlog** : les éléments choisis pour le sprint en cours, et le plan pour les réaliser.
- L'**Incrément** : le résultat du sprint, un produit **utilisable** et testé, qui respecte la **définition de terminé** (*Definition of Done*) de l'équipe.

Exemple de définition de terminé : « Le code est relu par un collègue, les tests passent, la fonctionnalité est déployée en préproduction et validée par le Product Owner. »

## Quand Scrum n'est pas adapté

- Un besoin parfaitement connu et stable, avec une contrainte réglementaire forte : une approche prédictive peut suffire.
- Un client qui ne peut pas se rendre disponible pour donner son avis régulièrement : sans Product Owner engagé, Scrum perd son intérêt.
- Une équipe de support qui traite des demandes au fil de l'eau : la méthode **Kanban**, vue dans un prochain chapitre, est souvent plus adaptée.

## À toi de jouer

Le projet de Zara démarre. Prépare le **cadre Scrum** du projet :

1. Qui pourrait jouer le rôle de Product Owner côté ministère ? Quelles qualités et quelle disponibilité doit-il avoir ?
2. Propose la durée des sprints et justifie-la.
3. Construis le calendrier type d'un sprint de 2 semaines, avec le jour et l'heure de chaque événement.
4. Rédige la définition de terminé de l'équipe en 5 points.
5. Cite deux risques de ce projet que la démarche agile aide à réduire.

> **Exemple de réponse pour l'étape 5** : le risque de livrer une plateforme qui ne correspond pas aux attentes du ministère (réduit par la review toutes les deux semaines) et le risque de découvrir tardivement que le serveur ne supporte pas la charge le jour d'ouverture des inscriptions (réduit en livrant et testant tôt).

## Vérifie tes acquis

1. Qui décide de l'ordre des éléments du backlog produit ?
2. Quelle est la durée maximale du Daily Scrum ?
3. Quel est le but de la rétrospective ?

> **Réponses** : 1. Le Product Owner. 2. 15 minutes. 3. Améliorer la façon de travailler de l'équipe au sprint suivant.

## En résumé

- L'approche **agile** livre par petites itérations et s'adapte aux retours.
- **Scrum** : trois rôles (Product Owner, Scrum Master, Developers).
- Quatre événements : planning, daily, review, rétrospective, dans un **sprint** de durée fixe.
- Trois artefacts : product backlog, sprint backlog, incrément conforme à la définition de terminé.
- Scrum demande un Product Owner disponible et un besoin qui peut évoluer.

## Pour aller plus loin

- [Le Guide Scrum officiel, disponible en français](https://scrumguides.org/)
- Demande au mentor IA : « Joue le rôle d'un Product Owner exigeant et fais-moi animer un Sprint Planning. »
