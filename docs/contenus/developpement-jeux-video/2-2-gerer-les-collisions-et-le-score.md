La livreuse change de voie, mais il ne se passe encore rien : aucun obstacle, aucun danger, aucune récompense. Dans ce chapitre, tu vas compléter la boucle de gameplay de Sahel Runner : faire apparaître des obstacles et des pièces, détecter les collisions, compter le score et gérer la fin de partie.

> **Objectifs de ce chapitre**
> - Utiliser une Area2D pour détecter un contact
> - Connecter un signal à une fonction
> - Faire apparaître des objets avec un Timer
> - Afficher et mettre à jour un score
> - Gérer la fin de partie et le redémarrage
> - Sauvegarder le meilleur score

## Les zones de détection : Area2D

Pour savoir si la moto touche une pièce ou un obstacle, on utilise une **Area2D** : une zone qui détecte les corps qui y entrent, sans les bloquer physiquement.

Crée la scène `Piece` :

```text
Piece (Area2D)
├── Sprite2D
└── CollisionShape2D   (CircleShape2D)
```

Et la scène `Obstacle` sur le même modèle, avec l'image d'une charrette ou d'un nid-de-poule et une forme rectangulaire.

## Les signaux

Quand quelque chose se produit, un nœud émet un **signal**. L'Area2D émet le signal `body_entered` quand un corps entre dans sa zone. On le connecte à une fonction, soit dans l'onglet **Nœud → Signaux** de l'éditeur, soit par le code.

Script de la pièce :

```gdscript
extends Area2D

signal ramassee

const VITESSE_DEFILEMENT = 400.0

func _ready():
	body_entered.connect(_on_body_entered)

func _process(delta):
	position.y += VITESSE_DEFILEMENT * delta   # la pièce descend vers le joueur
	if position.y > 1400:
		queue_free()                           # sortie de l'écran : on la supprime

func _on_body_entered(body):
	if body.name == "Joueur":
		ramassee.emit()
		queue_free()
```

- Le signal personnalisé `ramassee` prévient le niveau qu'il faut ajouter des points.
- `queue_free()` supprime proprement le nœud. Supprimer les objets sortis de l'écran est indispensable : sinon, des milliers de pièces invisibles s'accumulent et le jeu ralentit.

Le script de l'obstacle est presque identique, mais il émet un signal `touche` au lieu de `ramassee`.

> **Info** : les signaux permettent aux scènes de rester **indépendantes** : la pièce ne connaît pas le système de score, elle annonce simplement qu'elle a été ramassée. Le niveau décide quoi en faire.

## Faire apparaître les objets

Dans la scène `Niveau`, ajoute un nœud **Timer** nommé `MinuteurApparition`, avec un temps d'attente de 0,8 seconde et l'option *Autostart* cochée. À chaque fin de minuterie, on crée un objet sur une voie au hasard :

```gdscript
extends Node2D

const SCENE_PIECE = preload("res://piece.tscn")
const SCENE_OBSTACLE = preload("res://obstacle.tscn")
const VOIES = [180.0, 360.0, 540.0]

var score = 0
var partie_en_cours = true

func _ready():
	$MinuteurApparition.timeout.connect(_faire_apparaitre)

func _faire_apparaitre():
	if not partie_en_cours:
		return
	var objet
	if randf() < 0.7:
		objet = SCENE_PIECE.instantiate()
		objet.ramassee.connect(_on_piece_ramassee)
	else:
		objet = SCENE_OBSTACLE.instantiate()
		objet.touche.connect(_on_obstacle_touche)
	objet.position = Vector2(VOIES.pick_random(), -100)
	add_child(objet)
```

- `preload` charge la scène une seule fois au démarrage.
- `instantiate()` crée une nouvelle copie de la scène ; `add_child()` l'ajoute au niveau.
- `randf()` renvoie un nombre aléatoire entre 0 et 1 : ici, 70 % de pièces et 30 % d'obstacles.

## Le score

Ajoute un nœud `CanvasLayer` contenant un `Label` nommé `LabelScore`, placé en haut de l'écran. Le `CanvasLayer` garde l'interface fixe à l'écran, même si la caméra bouge.

```gdscript
func _on_piece_ramassee():
	score += 10
	$CanvasLayer/LabelScore.text = "Score : %d" % score
	$SonPiece.play()
```

Un son court et clair (`AudioStreamPlayer` nommé `SonPiece`) rend la récompense bien plus satisfaisante : c'est le retour (*feedback*) vu au premier chapitre.

## La fin de partie

```gdscript
func _on_obstacle_touche():
	partie_en_cours = false
	$MinuteurApparition.stop()
	$CanvasLayer/LabelScore.text = "Livraison ratée ! Score : %d\nTouchez pour rejouer" % score
	get_tree().paused = true

func _unhandled_input(event):
	if not partie_en_cours and event is InputEventScreenTouch and event.pressed:
		get_tree().paused = false
		get_tree().reload_current_scene()
```

`get_tree().paused = true` met le jeu en pause. Pour que le niveau puisse encore recevoir le toucher de redémarrage, règle son mode de traitement (*Process → Mode*) sur **Always** dans l'inspecteur. `reload_current_scene()` relance une partie propre.

> **Attention** : teste la fin de partie dès que possible. Les bugs de redémarrage (score qui ne se remet pas à zéro, objets qui continuent d'apparaître) sont parmi les plus fréquents dans les premiers jeux.

## Augmenter la difficulté

Pour que la partie devienne progressivement plus intense, on accélère l'apparition des objets au fil du score :

```gdscript
	$MinuteurApparition.wait_time = max(0.35, 0.8 - score / 2000.0)
```

## Sauvegarder le meilleur score

Godot permet d'écrire dans un fichier propre au jeu, avec le chemin spécial `user://` :

```gdscript
const FICHIER_RECORD = "user://record.save"

func sauvegarder_record(valeur):
	var fichier = FileAccess.open(FICHIER_RECORD, FileAccess.WRITE)
	fichier.store_32(valeur)

func charger_record():
	if not FileAccess.file_exists(FICHIER_RECORD):
		return 0
	var fichier = FileAccess.open(FICHIER_RECORD, FileAccess.READ)
	return fichier.get_32()
```

Afficher « Nouveau record ! » quand le joueur bat son meilleur score est l'un des moteurs les plus puissants de la boucle moyenne.

## À toi de jouer

1. Crée les scènes `Piece` et `Obstacle` avec leurs scripts et leurs signaux.
2. Ajoute le minuteur d'apparition dans le niveau et vérifie que les objets apparaissent sur les trois voies.
3. Affiche le score et ajoute un son à chaque pièce ramassée.
4. Gère la fin de partie et le redémarrage par un toucher.
5. Ajoute l'augmentation progressive de la difficulté.
6. Sauvegarde et affiche le meilleur score.
7. Bonus : exporte ton jeu en APK Android (*Projet → Exporter*) et fais-le tester par trois personnes.

> **Pour t'auto-évaluer** : ton prototype est réussi si un testeur dit spontanément « encore une ! » après sa première partie. C'est le signe que ta boucle de gameplay fonctionne.

## Vérifie tes acquis

1. Quelle est la différence entre une Area2D et un CharacterBody2D ?
2. À quoi sert un signal ?
3. Pourquoi supprimer les objets qui sortent de l'écran ?

> **Réponses** : 1. L'Area2D détecte ce qui entre dans sa zone sans bloquer ; le CharacterBody2D est un corps contrôlé qui se déplace et entre en collision physiquement. 2. À prévenir d'autres nœuds qu'un événement s'est produit, sans que les scènes dépendent les unes des autres. 3. Pour éviter qu'ils s'accumulent inutilement en mémoire et ralentissent le jeu.

## En résumé

- Une **Area2D** détecte les contacts ; son signal `body_entered` déclenche une fonction.
- Les **signaux** gardent les scènes indépendantes les unes des autres.
- Un **Timer** et `instantiate()` font apparaître des objets ; `queue_free()` les supprime.
- Le **score**, les **sons** et la **fin de partie** complètent la boucle de gameplay.
- `user://` permet de **sauvegarder** le meilleur score.

## Pour aller plus loin

- Demande au mentor IA : « Comment ajouter un écran de menu principal et un bouton pause à mon jeu Godot 4 ? »
