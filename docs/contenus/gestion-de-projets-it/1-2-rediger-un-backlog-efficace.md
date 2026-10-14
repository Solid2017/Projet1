Le cahier des charges du ministère est un long document en prose. L'équipe de Zara ne peut pas travailler à partir de 80 pages : elle a besoin d'une liste d'éléments courts, compréhensibles, estimables et classés par priorité. C'est le **backlog produit**, et sa qualité conditionne celle de tout le projet.

> **Objectifs de ce chapitre**
> - Écrire des user stories centrées sur l'utilisateur
> - Rédiger des critères d'acceptation vérifiables
> - Découper un besoin trop gros
> - Estimer les efforts en points
> - Prioriser le backlog

## La user story

Une **user story** décrit un besoin du point de vue de l'utilisateur, en une phrase :

```text
En tant que [type d'utilisateur],
je veux [action],
afin de [bénéfice].
```

Exemples pour la plateforme des concours :

- « En tant que candidat, je veux créer mon compte avec mon numéro de téléphone, afin de m'inscrire sans adresse e-mail. »
- « En tant que candidat, je veux téléverser une photo de mon diplôme, afin de compléter mon dossier sans me déplacer. »
- « En tant qu'agent du ministère, je veux filtrer les dossiers incomplets, afin de relancer les candidats concernés. »

La partie **« afin de »** est essentielle : elle explique le pourquoi et permet à l'équipe de proposer parfois une meilleure solution.

> **Astuce** : une user story n'est pas une spécification complète. C'est un rappel de conversation : les détails se discutent entre le Product Owner et l'équipe au moment de la réaliser.

## Les critères d'acceptation

Chaque story est complétée par des **critères d'acceptation** : les conditions précises et vérifiables qui permettent de dire qu'elle est terminée. Le format **Étant donné / Quand / Alors** est très utilisé :

```text
Étant donné un candidat sur la page d'inscription,
quand il saisit un numéro de téléphone tchadien valide et un mot de passe de 8 caractères minimum,
alors son compte est créé et il reçoit un code de confirmation par SMS.

Étant donné un numéro déjà utilisé par un autre compte,
quand le candidat tente de s'inscrire,
alors un message lui indique que ce numéro est déjà enregistré et lui propose de se connecter.
```

> **Attention** : un critère comme « l'inscription doit être rapide et simple » n'est pas vérifiable. Remplace-le par un fait mesurable : « l'inscription se fait en 3 écrans maximum ».

## La règle INVEST

Une bonne user story respecte les critères **INVEST** :

| Lettre | Critère | Signification |
| --- | --- | --- |
| I | Indépendante | Peut être réalisée sans attendre une autre story, autant que possible |
| N | Négociable | Les détails se discutent, ce n'est pas un contrat figé |
| V | Valeur | Apporte quelque chose à un utilisateur ou au client |
| E | Estimable | L'équipe comprend assez bien pour estimer l'effort |
| S | *Small* (petite) | Réalisable en quelques jours, bien à l'intérieur d'un sprint |
| T | Testable | On peut vérifier qu'elle est terminée |

## Découper les stories trop grosses

« En tant que candidat, je veux m'inscrire à un concours » est trop gros : c'est une **épopée** (*epic*). On la découpe, de préférence par tranches qui apportent chacune de la valeur :

1. Créer un compte avec son numéro de téléphone.
2. Remplir ses informations personnelles.
3. Choisir le concours et la ville d'examen.
4. Téléverser les pièces justificatives.
5. Recevoir un récapitulatif de candidature par SMS.
6. Payer les frais d'inscription par Mobile Money.

> **Info** : découpe par **parcours utilisateur** (verticalement), pas par couches techniques (« faire la base de données », puis « faire l'interface »). Une story technique isolée n'apporte aucune valeur visible à la fin du sprint.

## Estimer l'effort

Les équipes Scrum estiment souvent en **points d'effort**, une mesure **relative** de la difficulté (complexité, quantité de travail, incertitude), plutôt qu'en heures. On utilise une suite proche de Fibonacci : 1, 2, 3, 5, 8, 13. Plus le nombre est grand, plus l'incertitude est grande ; au-delà de 13, on découpe.

Le **planning poker** est une technique simple : chaque membre de l'équipe choisit secrètement une carte, puis tout le monde la montre en même temps. Si les estimations sont très différentes, ceux qui ont donné la plus haute et la plus basse expliquent leur raisonnement, puis on revote. Ces discussions révèlent souvent un malentendu ou un risque oublié.

Après quelques sprints, l'équipe connaît sa **vélocité** : le nombre moyen de points qu'elle termine par sprint. Cela permet de prévoir.

## Prioriser

Le Product Owner classe le backlog par ordre de priorité. Une méthode simple, **MoSCoW** :

- **Must have** : indispensable, sans quoi le produit n'a pas de sens (créer un compte, s'inscrire à un concours).
- **Should have** : important mais contournable pour la première version (modifier son dossier après validation).
- **Could have** : appréciable si le temps le permet (choix de la langue arabe).
- **Won't have (this time)** : explicitement exclu de cette version (application mobile native).

## À toi de jouer

Le ministère ajoute un besoin : « Les candidats doivent pouvoir connaître leurs résultats en ligne. »

1. Rédige au moins **4 user stories** (candidat et agent du ministère) pour ce besoin.
2. Écris 2 critères d'acceptation au format Étant donné / Quand / Alors pour la story la plus importante, dont un cas d'erreur.
3. Vérifie chaque story avec la grille INVEST et corrige-les si nécessaire.
4. Estime-les en points, seul ou avec des camarades par planning poker.
5. Classe-les avec MoSCoW.

> **Exemple de story** : « En tant que candidat, je veux recevoir un SMS dès que les résultats sont publiés, afin de ne pas consulter le site tous les jours. »

## Vérifie tes acquis

1. Quelles sont les trois parties d'une user story ?
2. Pourquoi estimer en points plutôt qu'en heures ?
3. Que signifie le « M » de MoSCoW ?

> **Réponses** : 1. Le type d'utilisateur, l'action souhaitée, le bénéfice attendu. 2. Parce que les points mesurent une difficulté relative, plus facile à estimer collectivement que des durées précises, et qu'ils intègrent l'incertitude. 3. *Must have* : indispensable.

## En résumé

- Une **user story** : « En tant que…, je veux…, afin de… ».
- Des **critères d'acceptation** vérifiables, au format Étant donné / Quand / Alors.
- La grille **INVEST** vérifie la qualité des stories ; les épopées se **découpent** par parcours utilisateur.
- On estime en **points** relatifs (planning poker) et on suit la **vélocité**.
- On priorise avec **MoSCoW** ; le backlog évolue en permanence.

## Pour aller plus loin

- Demande au mentor IA : « Relis mes user stories et signale celles qui ne respectent pas INVEST. »
