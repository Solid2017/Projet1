Pourquoi joue-t-on « encore une partie » à certains jeux pendant des heures, alors qu'on abandonne d'autres au bout de cinq minutes ? Le secret tient souvent dans la **boucle de gameplay** : l'enchaînement d'actions que le joueur répète et qui lui procure du plaisir. Avant de programmer quoi que ce soit, un concepteur de jeu (*game designer*) définit cette boucle avec soin.

Dans ce parcours, tu suis **Hassan**, étudiant à N'Djamena, qui veut créer **Sahel Runner**, un jeu mobile où une jeune livreuse traverse la ville à moto pour livrer des colis en évitant les obstacles.

> **Objectifs de ce chapitre**
> - Comprendre la boucle de gameplay et ses trois temps
> - Distinguer boucle courte, moyenne et longue
> - Connaître les composantes d'un jeu : mécaniques, objectifs, retours
> - Concevoir une courbe de difficulté
> - Rédiger un document de conception d'une page

## La boucle de gameplay

Une boucle de gameplay se résume souvent à trois temps qui se répètent :

1. **Le défi** : le jeu propose une situation (un obstacle arrive, un ennemi apparaît).
2. **L'action** : le joueur réagit (sauter, esquiver, tirer, choisir).
3. **La récompense** : le jeu répond (points, pièces, son satisfaisant, progression), ce qui motive à recommencer.

Pour Sahel Runner : un obstacle apparaît (charrette, nid-de-poule, troupeau de chèvres), le joueur change de voie d'un glissement de doigt, il gagne des points et ramasse des pièces.

## Trois boucles imbriquées

| Boucle | Durée | Sahel Runner |
| --- | --- | --- |
| **Courte** | Quelques secondes | Esquiver un obstacle, ramasser une pièce |
| **Moyenne** | Quelques minutes | Terminer une livraison, battre son record |
| **Longue** | Des jours ou des semaines | Débloquer de nouvelles motos et de nouveaux quartiers de N'Djamena |

La boucle courte doit être **amusante en elle-même**. Les boucles moyenne et longue donnent envie de revenir. Si la boucle courte n'est pas plaisante, aucun système de récompense ne sauvera le jeu.

> **Info** : un exercice classique des concepteurs : « Si mon jeu ne contenait que la boucle courte, sans score ni niveaux, serait-il amusant 30 secondes ? » Si la réponse est non, il faut retravailler les sensations de base avant tout le reste.

## Les ingrédients d'un jeu

- Les **mécaniques** : les règles et les actions possibles (changer de voie, sauter, accélérer).
- Les **objectifs** : ce que le joueur cherche à accomplir (livrer le colis, atteindre 1 000 mètres).
- Les **contraintes** : ce qui rend l'objectif difficile (obstacles, temps limité, carburant).
- Les **retours** (*feedback*) : comment le jeu communique avec le joueur.

Les retours sont essentiels et souvent sous-estimés. Quand le joueur ramasse une pièce, il doit le **sentir** : un son clair, une petite animation, le compteur qui grossit un instant, une légère vibration du téléphone. Les développeurs appellent cela le *game feel* ou le « jus » (*juice*).

## La courbe de difficulté

Un jeu trop facile ennuie ; trop difficile, il décourage. Entre les deux se trouve l'état de **flow** : le joueur est totalement absorbé parce que le défi correspond à son niveau.

Pour y arriver :

- **Apprendre en jouant** : les premières secondes introduisent une seule mécanique à la fois, sans long tutoriel écrit.
- **Augmenter progressivement** : la vitesse augmente doucement, de nouveaux obstacles apparaissent au fil de la partie.
- **Alterner tension et repos** : après une séquence intense, un court moment plus calme.
- **Rendre l'échec acceptable** : une partie qui recommence en une seconde donne envie de réessayer.

> **Attention** : le concepteur connaît son jeu par cœur et le trouve toujours trop facile. Fais tester ton jeu par des personnes qui ne l'ont jamais vu, et observe-les sans les aider.

## Le contexte compte

Sahel Runner vise des joueurs au Tchad et en Afrique centrale. Cela guide la conception :

- des **parties courtes** (1 à 3 minutes), adaptées aux pauses et aux trajets ;
- un jeu **léger** et jouable **hors ligne**, pour les téléphones modestes et la data coûteuse ;
- un **univers familier** : rues de N'Djamena, motos-taxis, marchés, qui donne une identité forte face aux jeux étrangers.

## Le document de conception

Avant de coder, Hassan rédige un **document de conception** (*Game Design Document*) d'une page :

- **Concept** en une phrase : « Une livreuse traverse N'Djamena à moto en esquivant les obstacles pour livrer ses colis à temps. »
- **Public visé** et **plateforme** : joueurs occasionnels de 12 à 35 ans, Android.
- **Boucles** courte, moyenne et longue.
- **Contrôles** : glisser à gauche ou à droite pour changer de voie, glisser vers le haut pour sauter.
- **Conditions de victoire et de défaite**.
- **Progression** : ce qui se débloque.
- **Style visuel et sonore** : couleurs chaudes, musique inspirée des rythmes sahéliens.

## À toi de jouer

1. Choisis un jeu mobile que tu aimes et décris ses boucles courte, moyenne et longue.
2. Imagine ton propre concept de jeu inspiré du Tchad (marché, saison des pluies, lac Tchad, transport…).
3. Décris sa boucle courte en trois temps : défi, action, récompense.
4. Liste cinq retours (sons, animations, effets) qui rendront l'action satisfaisante.
5. Rédige le document de conception d'une page.
6. Prototype papier : dessine 5 situations de jeu sur des cartes et fais « jouer » un ami en lui demandant ce qu'il ferait à chaque fois.

> **Pour t'auto-évaluer** : si une personne comprend ton jeu et a envie d'y jouer après avoir lu seulement la phrase de concept, tu tiens une bonne idée.

## Vérifie tes acquis

1. Quels sont les trois temps d'une boucle de gameplay ?
2. Pourquoi la boucle courte est-elle la plus importante ?
3. Qu'est-ce que l'état de flow ?

> **Réponses** : 1. Le défi, l'action et la récompense. 2. Parce que c'est elle que le joueur vit en permanence : si elle n'est pas amusante, rien ne compense. 3. Un état d'absorption totale, quand la difficulté correspond au niveau du joueur.

## En résumé

- La **boucle de gameplay** répète défi, action, récompense.
- Boucles **courte** (secondes), **moyenne** (minutes) et **longue** (semaines) s'emboîtent.
- Mécaniques, objectifs, contraintes et **retours** sont les ingrédients d'un jeu.
- Une bonne **courbe de difficulté** mène au flow ; teste avec de vrais joueurs.
- Un **document de conception** d'une page fixe la vision avant de coder.

## Pour aller plus loin

- Demande au mentor IA : « Aide-moi à améliorer la boucle de gameplay de mon concept de jeu : [décris ton concept]. »
