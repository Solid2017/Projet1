Place à la programmation ! Dans ce chapitre, tu vas faire bouger la livreuse de Sahel Runner avec Godot 4 : d'abord au clavier pour tester sur ordinateur, puis au toucher pour le téléphone. Tu découvriras les vecteurs, la vitesse et la façon dont Godot gère le déplacement d'un personnage.

> **Objectifs de ce chapitre**
> - Créer la scène du joueur avec un CharacterBody2D
> - Comprendre les vecteurs de position et de vitesse
> - Lire les entrées du joueur avec les actions
> - Déplacer un personnage avec `move_and_slide()`
> - Gérer un déplacement par voies et un contrôle tactile

## La scène du joueur

Crée une nouvelle scène avec cette structure :

```text
Joueur (CharacterBody2D)
├── Sprite2D
└── CollisionShape2D
```

- Dans le `Sprite2D`, glisse l'image de ta livreuse (ou l'icône de Godot pour commencer).
- Dans le `CollisionShape2D`, choisis une forme `RectangleShape2D` qui couvre à peu près l'image.
- Enregistre la scène sous `joueur.tscn`.

## Les vecteurs

En 2D, une position est un **vecteur** à deux composantes : `x` (horizontal, vers la droite) et `y` (vertical, **vers le bas** dans Godot). Le coin en haut à gauche de l'écran est `(0, 0)`.

```gdscript
position = Vector2(200, 400)   # 200 pixels à droite, 400 pixels vers le bas
```

Une **vitesse** est aussi un vecteur : elle indique de combien de pixels le personnage se déplace **par seconde** dans chaque direction. `Vector2(300, 0)` signifie 300 pixels par seconde vers la droite.

> **Info** : attention au sens de l'axe vertical : dans Godot, comme dans la plupart des moteurs 2D, `y` augmente vers le **bas**. Pour monter, la vitesse verticale doit être négative.

## Les actions d'entrée

Plutôt que de tester directement une touche précise, Godot utilise des **actions** nommées, définies dans *Projet → Paramètres du projet → Contrôles* (*Input Map*). Les actions `ui_left`, `ui_right`, `ui_up` et `ui_down` existent déjà et sont associées aux flèches du clavier. Tu pourras ensuite associer d'autres touches ou boutons à la même action sans changer ton code.

## Un premier déplacement libre

Attache ce script au nœud `Joueur` :

```gdscript
extends CharacterBody2D

const VITESSE = 300.0

func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * VITESSE
	move_and_slide()
```

- `_physics_process` est appelée à intervalle régulier (60 fois par seconde par défaut) : c'est là qu'on gère les mouvements et la physique.
- `Input.get_vector` renvoie un vecteur de direction à partir des quatre actions, déjà normalisé : en diagonale, le personnage ne va pas plus vite.
- `velocity` est une propriété du `CharacterBody2D` : la vitesse souhaitée, en pixels par seconde.
- `move_and_slide()` déplace le personnage selon `velocity`, en tenant compte du temps écoulé et des collisions : il glisse le long des murs au lieu de s'y bloquer.

Crée une scène `Niveau` (un `Node2D`), instancie-y le joueur, et lance-la : la livreuse se déplace avec les flèches !

## Un déplacement par voies

Dans Sahel Runner, la route a trois voies : la moto avance toute seule et le joueur change de voie. On remplace donc le déplacement libre par celui-ci :

```gdscript
extends CharacterBody2D

const VOIES = [180.0, 360.0, 540.0]   # position x du centre de chaque voie
const VITESSE_LATERALE = 1200.0

var voie_actuelle = 1                  # on commence au milieu

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_left"):
		voie_actuelle = max(0, voie_actuelle - 1)
	if Input.is_action_just_pressed("ui_right"):
		voie_actuelle = min(VOIES.size() - 1, voie_actuelle + 1)

	position.x = move_toward(position.x, VOIES[voie_actuelle], VITESSE_LATERALE * delta)
```

- `is_action_just_pressed` ne réagit qu'au **moment** de l'appui, pas tant que la touche reste enfoncée : un appui égale un changement de voie.
- `move_toward` rapproche la position de la cible d'au plus `VITESSE_LATERALE * delta` pixels par image : le changement de voie est fluide plutôt qu'instantané.

Ici, c'est la **route** qui défilera vers le bas pour donner l'impression d'avancer : le joueur reste à la même hauteur. Tu le feras au chapitre suivant avec les obstacles.

## Le contrôle tactile

Sur téléphone, on détecte un **glissement de doigt**. Ajoute ces fonctions au script :

```gdscript
var debut_glissement = Vector2.ZERO

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			debut_glissement = event.position
		else:
			var ecart = event.position - debut_glissement
			if ecart.x < -50:
				voie_actuelle = max(0, voie_actuelle - 1)
			elif ecart.x > 50:
				voie_actuelle = min(VOIES.size() - 1, voie_actuelle + 1)
```

On mémorise la position du doigt quand il touche l'écran ; quand il se relève, on calcule l'écart horizontal. Au-delà de 50 pixels, on considère que c'est un glissement.

> **Astuce** : pour tester le tactile sur ordinateur, active *Projet → Paramètres du projet → Entrée → Pointage → Émuler le toucher depuis la souris* (en affichant les paramètres avancés). Le clic de la souris se comportera comme un doigt.

## À toi de jouer

1. Crée la scène `Joueur` avec le déplacement libre et teste-la.
2. Remplace-le par le déplacement en trois voies, d'abord au clavier.
3. Ajoute le contrôle tactile par glissement et teste-le avec l'émulation.
4. Ajoute un saut : quand on glisse vers le haut, la moto s'agrandit légèrement pendant 0,5 seconde (indice : modifie `scale` et utilise un `Timer` ou un `Tween`).
5. Ajuste `VITESSE_LATERALE` pour que le changement de voie soit à la fois rapide et agréable à l'œil.

> **Pour t'auto-évaluer** : fais tester ton prototype à quelqu'un sans rien lui expliquer. S'il comprend en moins de 10 secondes comment changer de voie, tes contrôles sont intuitifs.

## Vérifie tes acquis

1. Dans Godot, dans quel sens augmente la coordonnée `y` ?
2. Quelle est la différence entre `is_action_pressed` et `is_action_just_pressed` ?
3. Que fait `move_and_slide()` ?

> **Réponses** : 1. Vers le bas. 2. La première est vraie tant que la touche est enfoncée, la seconde seulement au moment de l'appui. 3. Elle déplace le CharacterBody2D selon sa vitesse en gérant les collisions et le temps écoulé.

## En résumé

- Un personnage contrôlé est un **CharacterBody2D** avec un sprite et une forme de collision.
- Positions et vitesses sont des **vecteurs** ; dans Godot, `y` augmente vers le bas.
- Les **actions** d'entrée découplent le code des touches physiques.
- `velocity` + `move_and_slide()` dans `_physics_process` gèrent le déplacement.
- Le tactile se gère dans `_input` avec `InputEventScreenTouch`.

## Pour aller plus loin

- Demande au mentor IA : « Comment ajouter une animation de virage à ma moto quand elle change de voie dans Godot 4 ? »
