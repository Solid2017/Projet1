Mariam a compris le problème d'Amina : savoir à quelle heure se présenter au centre de santé pour ne pas perdre sa journée. Avant de concevoir des écrans colorés, elle va dessiner des **wireframes**, de simples schémas en noir et blanc, puis un **prototype** cliquable qu'elle pourra tester avec de vrais utilisateurs. Changer un croquis prend une minute ; changer une application développée prend des semaines.

> **Objectifs de ce chapitre**
> - Organiser les contenus et le parcours dans l'application
> - Dessiner des wireframes basse et moyenne fidélité
> - Créer un prototype cliquable avec Figma
> - Organiser un test utilisateur et en tirer des améliorations

## Organiser avant de dessiner

### Les tâches principales

On liste d'abord ce que l'utilisateur doit pouvoir faire, par ordre d'importance. Pour SantéRDV :

1. Trouver un centre de santé ouvert près de chez soi.
2. Prendre un rendez-vous ou un ticket de passage.
3. Être prévenu quand son tour approche.
4. Annuler ou déplacer un rendez-vous.

### Le flux utilisateur

Le **flux** (*user flow*) montre l'enchaînement des écrans pour accomplir une tâche :

```text
Accueil → Liste des centres → Fiche du centre → Choix du créneau → Confirmation (numéro de ticket + SMS)
```

Chaque étape en moins est une chance de plus que l'utilisateur aille au bout. Demande-toi pour chaque écran : est-il vraiment nécessaire ?

> **Astuce** : pour SantéRDV, Mariam décide qu'il n'est pas nécessaire de créer un compte pour prendre un ticket : un numéro de téléphone suffit. Chaque champ de formulaire supprimé fait gagner des utilisateurs.

## Le wireframe

Un **wireframe** est le plan d'un écran : il montre **où** se trouvent les éléments et leur importance, sans couleurs ni images définitives.

### Basse fidélité : sur papier

Commence au crayon, sur papier. Dessine chaque écran dans un rectangle au format téléphone. Utilise des conventions simples :

- un rectangle avec une croix pour une image ;
- des lignes ondulées pour du texte ;
- un rectangle avec un mot pour un bouton.

Dessine **plusieurs versions** de l'écran le plus important : la première idée est rarement la meilleure. Le papier est rapide, et personne n'hésite à critiquer un croquis.

### Moyenne fidélité : sur ordinateur

Une fois la direction choisie, on redessine proprement les écrans dans un outil comme **Figma** (gratuit dans sa version de base, utilisable dans le navigateur) avec des niveaux de gris, de vrais textes et des tailles réalistes.

> **Info** : utilise de **vrais contenus** dès le wireframe : un vrai nom de centre de santé, de vraies adresses, de vrais horaires. Les textes de remplissage comme « Lorem ipsum » cachent les problèmes, par exemple un nom de quartier trop long pour tenir sur une ligne.

## Les composants à connaître

| Élément | Usage |
| --- | --- |
| Barre de navigation | Accéder aux sections principales (en bas de l'écran sur mobile) |
| Liste | Afficher plusieurs éléments similaires (centres, créneaux) |
| Carte | Regrouper les informations d'un élément (nom, distance, horaires) |
| Bouton principal | L'action la plus importante de l'écran : **un seul** par écran |
| Bouton secondaire | Les actions moins importantes (Annuler, Retour) |
| Champ de saisie | Saisir une information, avec une étiquette toujours visible |
| Message de confirmation | Rassurer après une action importante |

## Le prototype

Un **prototype** relie les écrans entre eux pour simuler l'application : on clique sur un bouton, on arrive sur l'écran suivant. Dans Figma :

1. Passe en mode **Prototype**.
2. Sélectionne un bouton et tire une flèche vers l'écran de destination.
3. Choisis le déclencheur (« Au clic ») et l'animation.
4. Lance l'aperçu et partage le lien ; il s'ouvre aussi sur un téléphone avec l'application Figma.

Le prototype n'a pas besoin d'être complet : il suffit qu'il permette de réaliser les tâches que tu veux tester.

## Tester avec de vrais utilisateurs

Le **test utilisateur** est le moment de vérité. Il suffit de **cinq personnes** du public visé pour découvrir la majorité des problèmes importants.

1. Prépare 3 ou 4 **scénarios** réalistes : « Votre fille a mal à l'oreille. Trouvez un centre ouvert près de Chagoua et prenez un ticket pour cet après-midi. »
2. Demande à la personne de **penser à voix haute** pendant qu'elle utilise le prototype.
3. **Observe sans aider**, même si c'est difficile ! Si elle bloque, demande « Qu'est-ce que vous cherchez ? » plutôt que de montrer le bouton.
4. Note les hésitations, les erreurs, les phrases prononcées.
5. Classe ensuite les problèmes par gravité et corrige les plus graves en priorité.

> **Attention** : quand un utilisateur échoue, ce n'est jamais lui qui se trompe, c'est la conception qui doit s'améliorer. Ne dis jamais « Ah non, il fallait cliquer ici ».

## À toi de jouer

En reprenant le problème défini au chapitre précédent :

1. Liste les quatre tâches principales de ton application.
2. Dessine sur papier le flux de la tâche la plus importante.
3. Dessine trois versions différentes de l'écran principal, puis choisis-en une en justifiant ton choix.
4. Reproduis les écrans du flux dans Figma en niveaux de gris, avec de vrais contenus.
5. Relie-les en prototype cliquable.
6. Teste le prototype avec trois personnes à l'aide d'un scénario, et note les trois problèmes les plus importants observés, avec ta proposition de correction.

> **Pour t'auto-évaluer** : un bon prototype de test permet à un utilisateur d'accomplir la tâche principale sans aucune explication de ta part.

## Vérifie tes acquis

1. Pourquoi commencer par des wireframes sur papier ?
2. Combien de boutons principaux devrait-il y avoir sur un écran ?
3. Que faire si un utilisateur bloque pendant un test ?

> **Réponses** : 1. Parce que c'est rapide, peu coûteux et facile à modifier ou à critiquer. 2. Un seul. 3. Ne pas lui montrer la solution ; lui demander ce qu'il cherche, puis noter le problème pour améliorer la conception.

## En résumé

- On définit les **tâches** et les **flux** avant de dessiner.
- Le **wireframe** fixe la structure de l'écran, d'abord sur papier puis dans Figma.
- Utilise de **vrais contenus** dès les premières maquettes.
- Le **prototype** relie les écrans pour simuler l'application.
- Le **test utilisateur** avec cinq personnes révèle l'essentiel des problèmes.

## Pour aller plus loin

- [Le centre d'aide de Figma](https://help.figma.com/) pour apprendre l'outil pas à pas
- Demande au mentor IA : « Propose-moi un scénario de test utilisateur pour une application de prise de rendez-vous médical. »
