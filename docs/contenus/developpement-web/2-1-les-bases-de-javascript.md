HTML structure la page, CSS l'habille… mais pour l'instant, elle ne réagit à rien. **JavaScript** est le langage qui lui donne un comportement : calculer un prix, vérifier un formulaire, afficher un message. C'est aussi le langage le plus utilisé au monde, et l'un des plus demandés par les employeurs.

Dans ce chapitre, tu apprends les briques de base du langage. Au chapitre suivant, tu les utiliseras pour rendre la page Chez Achta Couture interactive.

> **Objectifs de ce chapitre**
> - Exécuter du JavaScript dans le navigateur
> - Stocker des informations dans des variables
> - Connaître les types de données principaux
> - Prendre des décisions avec des conditions
> - Répéter des actions avec des boucles
> - Regrouper du code dans des fonctions

## Où écrire du JavaScript ?

### Dans la console, pour tester

Ouvre les outils de développement (F12), onglet **Console**, et tape :

```js
console.log("Bonjour N'Djamena !");
```

Appuie sur Entrée : le message s'affiche. `console.log()` sera ton meilleur ami pour vérifier ce que fait ton code.

### Dans un fichier, pour ton site

Crée un fichier `script.js` et relie-le à ta page juste avant la balise `</body>` :

```html
  <script src="script.js"></script>
</body>
```

On le place en bas de page pour que le HTML soit déjà chargé quand le script s'exécute.

## Les variables : des boîtes avec une étiquette

Une **variable** stocke une valeur pour la réutiliser plus tard. On la déclare avec `let` si sa valeur peut changer, ou `const` si elle ne changera jamais :

```js
const nomAtelier = "Chez Achta Couture";
let nombreCommandes = 0;

nombreCommandes = nombreCommandes + 1;
console.log(nombreCommandes); // affiche 1
```

> **Astuce** : utilise `const` par défaut, et `let` seulement quand tu sais que la valeur va changer. Ça évite de modifier une valeur par erreur. Tu croiseras aussi `var` dans de vieux tutoriels : c'est l'ancienne façon de faire, évite-la.

Règles de nommage : pas d'espace ni d'accent, pas de chiffre au début. Par convention, on écrit en *camelCase* : `prixTotal`, `nomClient`.

Le texte après `//` est un **commentaire** : JavaScript l'ignore.

## Les types de données

| Type | Exemple | Usage |
| --- | --- | --- |
| Nombre (`number`) | `15000`, `2.5` | Prix, quantités, calculs |
| Chaîne (`string`) | `"Awa"`, `'robe'` | Texte, toujours entre guillemets |
| Booléen (`boolean`) | `true`, `false` | Vrai ou faux : connecté ou non, payé ou non |
| Tableau (`array`) | `["robe", "boubou"]` | Une liste de valeurs |
| Objet (`object`) | `{ nom: "Awa", age: 22 }` | Une fiche avec plusieurs informations |

### Calculer avec les nombres

```js
const prixRobe = 15000;
const prixBroderie = 5000;
const total = prixRobe + prixBroderie;
console.log(total); // 20000
```

Les opérateurs : `+`, `-`, `*` (multiplication), `/` (division) et `%` (reste de la division).

### Assembler du texte

Les **gabarits** (entre accents graves, touches **AltGr+7** sur un clavier AZERTY) permettent d'insérer des variables dans un texte avec `${ }` :

```js
const client = "Mahamat";
const montant = 20000;
console.log(`Merci ${client}, votre commande de ${montant} FCFA est enregistrée.`);
```

### Les tableaux et les objets

```js
const services = ["Couture sur mesure", "Retouches", "Broderie"];
console.log(services[0]);      // "Couture sur mesure" : on compte à partir de 0 !
console.log(services.length);  // 3

const commande = {
  client: "Achta",
  modele: "Robe en bazin",
  prix: 15000,
  payee: false
};
console.log(commande.modele);  // "Robe en bazin"
```

## Prendre des décisions : les conditions

`if` exécute un bloc de code seulement si une condition est vraie ; `else` gère le cas contraire :

```js
const montant = 45000;

if (montant >= 50000) {
  console.log("Livraison gratuite à N'Djamena !");
} else if (montant >= 20000) {
  console.log("Livraison à 1000 FCFA.");
} else {
  console.log("Livraison à 2000 FCFA.");
}
```

Les opérateurs de comparaison :

| Opérateur | Signification |
| --- | --- |
| `===` | strictement égal |
| `!==` | différent |
| `>` et `<` | plus grand, plus petit |
| `>=` et `<=` | plus grand ou égal, plus petit ou égal |
| `&&` | ET : les deux conditions sont vraies |
| `||` | OU : au moins une condition est vraie |

> **Attention** : utilise toujours `===` (trois signes égal) pour comparer. Le double égal `==` fait des conversions surprenantes : `"5" == 5` est vrai, alors que `"5" === 5` est faux, ce qui est le résultat attendu.

## Répéter des actions : les boucles

Pour parcourir tous les éléments d'un tableau, la boucle `for…of` est la plus lisible :

```js
const prix = [15000, 8000, 22000];
let total = 0;

for (const p of prix) {
  total = total + p;
}

console.log(`Total des commandes : ${total} FCFA`); // 45000
```

La boucle `for` classique sert quand tu connais le nombre de répétitions :

```js
for (let jour = 1; jour <= 7; jour++) {
  console.log(`Jour ${jour} : atelier ouvert`);
}
```

Elle se lit : « commence à 1 ; tant que `jour` est inférieur ou égal à 7 ; ajoute 1 à chaque tour ».

## Les fonctions : du code réutilisable

Une **fonction** regroupe des instructions sous un nom. On la définit une fois, puis on l'appelle autant de fois qu'on veut, avec des valeurs différentes :

```js
function calculerTotal(prix, quantite) {
  return prix * quantite;
}

console.log(calculerTotal(15000, 2)); // 30000
console.log(calculerTotal(5000, 3));  // 15000
```

- `prix` et `quantite` sont des **paramètres** : des variables qui reçoivent les valeurs passées à l'appel.
- `return` renvoie le résultat à l'endroit où la fonction a été appelée.

Tu verras aussi souvent l'écriture courte, dite **fonction fléchée** :

```js
const calculerTotal = (prix, quantite) => prix * quantite;
```

## À toi de jouer

Écris un petit programme de devis pour Chez Achta Couture, dans la console ou dans `script.js` :

1. Crée un tableau `panier` contenant trois objets, chacun avec un `article` et un `prix` (par exemple une robe à 15 000 FCFA, une retouche à 2 000 FCFA, une broderie à 5 000 FCFA).
2. Écris une fonction `calculerTotal(panier)` qui additionne les prix avec une boucle et renvoie le total.
3. Écris une fonction `fraisLivraison(total)` qui renvoie 0 si le total atteint 50 000 FCFA, 1 000 FCFA s'il atteint 20 000 FCFA, et 2 000 FCFA sinon.
4. Affiche dans la console : « Total : 22000 FCFA + livraison : 1000 FCFA = 23000 FCFA ».

> **Correction possible** :

```js
const panier = [
  { article: "Robe en bazin", prix: 15000 },
  { article: "Retouche", prix: 2000 },
  { article: "Broderie", prix: 5000 }
];

function calculerTotal(articles) {
  let total = 0;
  for (const ligne of articles) {
    total = total + ligne.prix;
  }
  return total;
}

function fraisLivraison(total) {
  if (total >= 50000) {
    return 0;
  } else if (total >= 20000) {
    return 1000;
  }
  return 2000;
}

const total = calculerTotal(panier);
const livraison = fraisLivraison(total);
console.log(`Total : ${total} FCFA + livraison : ${livraison} FCFA = ${total + livraison} FCFA`);
```

## Vérifie tes acquis

1. Quelle est la différence entre `let` et `const` ?
2. Que renvoie `["Awa", "Moussa", "Halimé"][1]` ?
3. Pourquoi préférer `===` à `==` ?

> **Réponses** : 1. Une variable déclarée avec `const` ne peut pas être réaffectée, contrairement à `let`. 2. `"Moussa"`, car on compte à partir de 0. 3. `==` convertit les types avant de comparer, ce qui donne des résultats inattendus ; `===` compare aussi le type.

## En résumé

- JavaScript s'écrit dans un fichier `.js` relié par `<script src="…">` en bas de page ; `console.log()` permet de tester.
- `const` pour les valeurs fixes, `let` pour celles qui changent.
- Types principaux : nombre, chaîne, booléen, tableau, objet.
- `if / else if / else` pour décider, `for…of` pour parcourir un tableau.
- Les **fonctions** regroupent du code réutilisable ; `return` renvoie le résultat.

## Pour aller plus loin

- [Le guide JavaScript de MDN, en français](https://developer.mozilla.org/fr/docs/Web/JavaScript/Guide)
- Demande au mentor IA : « Donne-moi trois exercices JavaScript sur les boucles, du plus facile au plus difficile, sans la solution. »
