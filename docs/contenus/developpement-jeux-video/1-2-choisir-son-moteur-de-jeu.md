Hassan a son concept. Il pourrait tout programmer à partir de zéro : l'affichage, les collisions, les sons, l'adaptation à chaque téléphone… Des mois de travail avant de voir sa livreuse bouger. Les développeurs utilisent plutôt un **moteur de jeu**, un logiciel qui fournit tous ces outils de base. Encore faut-il choisir le bon.

> **Objectifs de ce chapitre**
> - Comprendre ce qu'apporte un moteur de jeu
> - Comparer Godot, Unity, Unreal Engine et les solutions web
> - Choisir un moteur selon le projet, les compétences et le matériel
> - Découvrir les notions de base de Godot : scènes et nœuds

## Ce que fait un moteur de jeu

Un moteur de jeu fournit :

- le **rendu** graphique en 2D et en 3D ;
- la **physique** et les **collisions** ;
- la gestion des **entrées** (toucher, clavier, manette) ;
- le **son** et la musique ;
- un **éditeur** visuel pour placer les éléments des niveaux ;
- l'**export** vers différentes plateformes (Android, iOS, Windows, navigateur web).

Le développeur se concentre sur ce qui rend son jeu unique : les règles, les niveaux, l'univers.

## Les principaux moteurs

| Moteur | Langage | Licence et coût | Points forts | Points d'attention |
| --- | --- | --- | --- | --- |
| **Godot** | GDScript (proche de Python), C# | Libre et gratuit (MIT), sans redevance | Très léger, excellent en 2D, fonctionne sur un ordinateur modeste | Communauté plus petite, moins d'outils commerciaux |
| **Unity** | C# | Gratuit sous conditions de revenus, puis payant | Énorme communauté, beaucoup de tutoriels, très utilisé en mobile | Éditeur plus lourd ; conditions de licence à vérifier |
| **Unreal Engine** | C++, Blueprints (visuel) | Gratuit, redevance au-delà d'un certain chiffre d'affaires | Graphismes 3D de très haut niveau | Très gourmand, peu adapté à un premier jeu mobile 2D |
| **Phaser** et autres moteurs web | JavaScript | Libre et gratuit | Jeux jouables directement dans le navigateur, sans installation | Performances limitées pour les jeux complexes |

> **Attention** : les conditions de licence et les seuils de revenus des moteurs commerciaux évoluent. Vérifie toujours les conditions actuelles sur le site officiel avant de te lancer dans un projet commercial.

## Comment choisir ?

Pose-toi ces questions :

- **2D ou 3D ?** Pour un jeu mobile 2D comme Sahel Runner, Godot, Unity et Phaser conviennent tous.
- **Quel matériel ?** Sur un ordinateur portable avec 4 Go de mémoire, Godot (moins de 200 Mo) sera bien plus confortable qu'Unreal.
- **Quelles compétences ?** Si tu connais Python, GDScript te semblera familier ; si tu connais JavaScript, Phaser ; C# mène naturellement à Unity.
- **Quel objectif professionnel ?** Les studios mobiles recrutent beaucoup sur Unity ; Godot gagne rapidement en popularité chez les indépendants.
- **Quel budget ?** Godot n'a aucun coût, aucune condition et aucune redevance.

> **Info** : les concepts appris dans un moteur (scènes, objets, collisions, boucle de jeu) se transfèrent très bien vers un autre. Le plus important est de commencer et de **terminer** un premier petit jeu.

Hassan choisit **Godot 4** : léger pour son ordinateur, gratuit, excellent en 2D, avec un langage proche de Python qu'il a déjà pratiqué.

## Les bases de Godot : nœuds et scènes

Godot organise tout en **nœuds** (*nodes*). Chaque nœud a une fonction précise :

| Nœud | Rôle |
| --- | --- |
| `Node2D` | Un élément positionné en 2D |
| `Sprite2D` | Affiche une image |
| `CharacterBody2D` | Un personnage contrôlé qui se déplace et entre en collision |
| `CollisionShape2D` | La forme utilisée pour détecter les collisions |
| `Area2D` | Une zone qui détecte ce qui y entre (une pièce à ramasser) |
| `Camera2D` | La caméra qui suit le joueur |
| `Label` | Affiche un texte (le score) |
| `AudioStreamPlayer` | Joue un son |

On assemble des nœuds en arbre pour former une **scène**. Par exemple, la scène `Joueur` :

```text
Joueur (CharacterBody2D)
├── Sprite2D           ← l'image de la livreuse à moto
├── CollisionShape2D   ← sa forme de collision
└── Camera2D           ← la caméra qui la suit
```

Une scène peut ensuite être **instanciée** (réutilisée) dans une autre : la scène `Niveau` contient le joueur, des obstacles et des pièces, chacun étant lui-même une scène. C'est très pratique : modifier la scène `Piece` met à jour toutes les pièces du jeu.

On ajoute du comportement en attachant un **script** GDScript à un nœud. Deux fonctions sont essentielles :

```gdscript
extends Node2D

func _ready():
	print("La scène est prête")   # exécuté une fois, au chargement

func _process(delta):
	pass                           # exécuté à chaque image (60 fois par seconde environ)
```

`delta` est le temps écoulé depuis l'image précédente, en secondes. On s'en sert pour que le jeu tourne à la même vitesse sur un téléphone rapide et sur un téléphone lent.

## À toi de jouer

1. Pour ton propre concept de jeu, remplis le tableau de choix : 2D ou 3D, matériel disponible, compétences, objectif, budget. Choisis un moteur et justifie ton choix en cinq lignes.
2. Télécharge Godot 4 sur le site officiel (aucune installation n'est nécessaire, c'est un seul fichier).
3. Crée un nouveau projet, puis une scène avec un `Node2D` racine, un `Sprite2D` affichant l'icône de Godot et un `Label` affichant le nom de ton jeu.
4. Attache un script qui écrit « Bienvenue ! » dans la console au démarrage.
5. Lance la scène avec **F6**.

> **Pour t'auto-évaluer** : sauras-tu expliquer à un camarade la différence entre un nœud et une scène ? Un nœud est une brique avec une fonction précise ; une scène est un assemblage de nœuds réutilisable.

## Vérifie tes acquis

1. Cite trois services fournis par un moteur de jeu.
2. Pourquoi Godot est-il adapté à un ordinateur modeste ?
3. Que représente le paramètre `delta` dans `_process(delta)` ?

> **Réponses** : 1. Par exemple le rendu graphique, la physique, les collisions, le son, la gestion des entrées, l'export multiplateforme. 2. Parce qu'il est très léger (moins de 200 Mo) et peu gourmand en ressources. 3. Le temps écoulé depuis l'image précédente, qui permet d'avoir la même vitesse quel que soit l'appareil.

## En résumé

- Un **moteur de jeu** fournit rendu, physique, entrées, son, éditeur et export.
- **Godot** (libre, léger, idéal en 2D), **Unity** (très répandu en mobile), **Unreal** (3D haut de gamme), **Phaser** (web).
- On choisit selon la 2D/3D, le matériel, les compétences, l'objectif et le budget.
- Dans Godot, les **nœuds** s'assemblent en **scènes** réutilisables, animées par des scripts GDScript.

## Pour aller plus loin

- [La documentation officielle de Godot](https://docs.godotengine.org/fr/stable/)
- Demande au mentor IA : « Explique-moi la différence entre _process et _physics_process dans Godot. »
