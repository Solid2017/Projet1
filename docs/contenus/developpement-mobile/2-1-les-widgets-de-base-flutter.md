Achta a choisi **Flutter** pour MarchéTchad. En Flutter, tout ce que tu vois à l'écran est un **widget** : un texte, un bouton, une marge, une liste, et même l'écran entier. On construit une interface en emboîtant des widgets les uns dans les autres, comme des briques. Dans ce chapitre, tu vas créer ton premier écran : la liste des prix d'un marché.

> **Objectifs de ce chapitre**
> - Créer et lancer un projet Flutter
> - Comprendre l'arbre de widgets
> - Utiliser les widgets de mise en page essentiels
> - Distinguer StatelessWidget et StatefulWidget
> - Afficher une liste et réagir à un appui

## Créer un projet

Après avoir installé Flutter (voir la documentation officielle), une commande crée le projet :

```bash
flutter create marche_tchad
cd marche_tchad
flutter run
```

Le code de l'application se trouve dans `lib/main.dart`. Pendant que l'application tourne, enregistre une modification : grâce au **hot reload** (rechargement à chaud), elle apparaît à l'écran en moins d'une seconde, sans perdre l'état de l'application.

> **Info** : si ton ordinateur est trop modeste pour l'émulateur Android, branche directement un téléphone Android en activant le **débogage USB** dans les options pour développeurs. C'est souvent plus rapide.

## Ton premier écran

Remplace le contenu de `lib/main.dart` par :

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MarcheTchadApp());
}

class MarcheTchadApp extends StatelessWidget {
  const MarcheTchadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MarchéTchad',
      theme: ThemeData(colorSchemeSeed: Colors.orange),
      home: Scaffold(
        appBar: AppBar(title: const Text('Marché central de N\'Djamena')),
        body: const Center(
          child: Text('Bienvenue sur MarchéTchad'),
        ),
      ),
    );
  }
}
```

- `MaterialApp` : la racine de l'application, avec le thème et l'écran d'accueil.
- `Scaffold` : la structure d'un écran (barre du haut, corps, bouton flottant…).
- `AppBar`, `Center`, `Text` : des widgets imbriqués grâce aux propriétés `child`, `body`, `title`.
- La méthode `build()` décrit ce qu'il faut afficher ; Flutter l'appelle quand il faut redessiner.

## Les widgets de mise en page

| Widget | Rôle |
| --- | --- |
| `Column` | Empile ses enfants verticalement |
| `Row` | Aligne ses enfants horizontalement |
| `Padding` | Ajoute une marge intérieure autour de son enfant |
| `Container` | Boîte avec taille, couleur, bordure, marge |
| `Expanded` | Prend tout l'espace restant dans une `Row` ou une `Column` |
| `ListView` | Liste qui défile |
| `Card` | Carte avec ombre et coins arrondis |

Exemple d'une ligne de prix :

```dart
Padding(
  padding: const EdgeInsets.all(12),
  child: Row(
    children: const [
      Icon(Icons.grass),
      SizedBox(width: 12),
      Expanded(child: Text('Mil (le coro)')),
      Text('1 000 FCFA', style: TextStyle(fontWeight: FontWeight.bold)),
    ],
  ),
)
```

## Afficher une liste de prix

On décrit les données avec une classe, puis `ListView.builder` construit une ligne par élément. Il ne crée que les lignes visibles à l'écran, ce qui économise la mémoire sur les téléphones modestes :

```dart
class Prix {
  final String produit;
  final int montant;
  const Prix(this.produit, this.montant);
}

const prixDuJour = [
  Prix('Mil (coro)', 1000),
  Prix('Sorgho (coro)', 900),
  Prix('Sucre (kg)', 900),
  Prix('Huile (litre)', 1500),
];

ListView.builder(
  itemCount: prixDuJour.length,
  itemBuilder: (context, index) {
    final p = prixDuJour[index];
    return ListTile(
      title: Text(p.produit),
      trailing: Text('${p.montant} FCFA'),
    );
  },
)
```

> **Attention** : les prix indiqués dans ces exemples sont fictifs. Dans la vraie application, ils viendront de l'API du serveur.

## Stateless ou Stateful ?

- Un **StatelessWidget** n'a pas d'état qui change : il affiche toujours la même chose pour les mêmes paramètres (un titre, une icône).
- Un **StatefulWidget** possède un **état** qui peut évoluer (un compteur, un produit mis en favori, des données chargées). Quand on modifie l'état avec `setState()`, Flutter redessine le widget.

```dart
class BoutonFavori extends StatefulWidget {
  const BoutonFavori({super.key});

  @override
  State<BoutonFavori> createState() => _BoutonFavoriState();
}

class _BoutonFavoriState extends State<BoutonFavori> {
  bool suivi = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(suivi ? Icons.star : Icons.star_border),
      onPressed: () {
        setState(() {
          suivi = !suivi;
        });
      },
    );
  }
}
```

À chaque appui, `setState` inverse la valeur de `suivi` et l'étoile se remplit ou se vide.

> **Astuce** : garde le plus de widgets possible en Stateless et isole l'état dans de petits widgets Stateful. Ton code sera plus simple à comprendre et plus rapide.

## Réagir à un appui et naviguer

```dart
ListTile(
  title: Text(p.produit),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailProduitPage(prix: p)),
    );
  },
)
```

`Navigator.push` pose un nouvel écran sur la pile ; le bouton retour du téléphone le retire automatiquement.

## À toi de jouer

1. Crée le projet `marche_tchad` et lance-le sur un émulateur ou un téléphone.
2. Affiche la liste d'au moins six produits avec leur prix, chacun dans une `Card`.
3. Ajoute une étoile « suivre » sur chaque ligne avec un StatefulWidget.
4. Crée un écran `DetailProduitPage` qui affiche le nom et le prix du produit en grand, et ouvre-le à l'appui sur une ligne.
5. Bonus : affiche en haut de l'écran la date du jour et un sélecteur de marché (`DropdownButton`).

> **Pour t'auto-évaluer** : fais pivoter le téléphone et réduis la taille de l'écran de l'émulateur : rien ne doit déborder (pas de bandes jaunes et noires, le signal d'erreur de dépassement de Flutter).

## Vérifie tes acquis

1. Quel widget sert à empiler des éléments verticalement ?
2. Que fait `setState()` ?
3. Pourquoi préférer `ListView.builder` pour une longue liste ?

> **Réponses** : 1. `Column`. 2. Il modifie l'état d'un StatefulWidget et demande à Flutter de le redessiner. 3. Parce qu'il ne construit que les éléments visibles, ce qui économise mémoire et batterie.

## En résumé

- En Flutter, **tout est widget** ; l'interface est un arbre de widgets imbriqués.
- `MaterialApp` et `Scaffold` posent la structure ; `Column`, `Row`, `Padding`, `Expanded` organisent la mise en page.
- **Stateless** pour l'affichage fixe, **Stateful** + `setState()` pour ce qui change.
- `ListView.builder` affiche efficacement des listes ; `Navigator.push` ouvre un nouvel écran.
- Le **hot reload** accélère énormément le développement.

## Pour aller plus loin

- [La documentation officielle de Flutter](https://docs.flutter.dev/)
- Demande au mentor IA : « Comment charger mes prix depuis une API JSON en Flutter avec le package http ? »
