Tu connais maintenant les variables, les conditions et les fonctions. Il est temps de les brancher sur ta page ! Dans ce chapitre, tu vas apprendre à lire et modifier le contenu de la page avec JavaScript, et à réagir aux actions du visiteur : clics, saisies, envois de formulaire. À la fin, le site Chez Achta Couture aura un simulateur de devis qui calcule le prix en direct.

> **Objectifs de ce chapitre**
> - Comprendre ce qu'est le DOM
> - Sélectionner des éléments HTML depuis JavaScript
> - Modifier du texte, des classes et des styles
> - Réagir à des événements avec `addEventListener`
> - Lire et vérifier les valeurs d'un formulaire

## Le DOM, une représentation vivante de la page

Quand le navigateur charge ton HTML, il le transforme en un arbre d'objets en mémoire : le **DOM** (*Document Object Model*). Chaque balise devient un nœud de cet arbre, avec des parents et des enfants :

```text
document
└── html
    ├── head
    │   └── title
    └── body
        ├── header
        │   └── h1
        └── main
            └── section
```

JavaScript ne modifie pas ton fichier HTML : il modifie cet arbre. Et dès que l'arbre change, le navigateur met l'affichage à jour. C'est ce qui rend la page interactive sans la recharger.

## Sélectionner des éléments

La méthode la plus pratique est `document.querySelector()`. Elle accepte n'importe quel sélecteur CSS et renvoie le **premier** élément correspondant :

```js
const titre = document.querySelector("h1");
const bouton = document.querySelector("#btn-devis");
const premiereCarte = document.querySelector(".carte-service");
```

Pour récupérer **tous** les éléments correspondants, utilise `querySelectorAll()`, puis parcours-les avec une boucle :

```js
const cartes = document.querySelectorAll(".carte-service");
for (const carte of cartes) {
  console.log(carte.textContent);
}
```

> **Info** : si `querySelector` ne trouve rien, il renvoie `null`. L'erreur « Cannot read properties of null » dans la console signifie presque toujours que ton sélecteur est faux, ou que le script s'exécute avant que le HTML soit chargé.

## Modifier la page

### Le texte

```js
const titre = document.querySelector("h1");
titre.textContent = "Chez Achta Couture, tenues de fête";
```

### Les classes

Plutôt que de modifier le style directement, la bonne pratique est d'ajouter ou de retirer des **classes** définies dans ton CSS :

```js
const menu = document.querySelector("nav");
menu.classList.add("ouvert");      // ajoute la classe
menu.classList.remove("ouvert");   // la retire
menu.classList.toggle("ouvert");   // l'ajoute si elle est absente, la retire sinon
```

Ainsi, l'apparence reste dans le CSS et le comportement dans le JavaScript : chaque fichier a son rôle.

### Créer de nouveaux éléments

```js
const liste = document.querySelector("#liste-services");
const nouvelElement = document.createElement("li");
nouvelElement.textContent = "Location de tenues";
liste.append(nouvelElement);
```

> **Attention** : pour insérer un texte saisi par un visiteur, utilise toujours `textContent`, jamais `innerHTML`. Avec `innerHTML`, un visiteur malveillant pourrait injecter du code dans ta page : c'est une faille de sécurité appelée XSS.

## Réagir aux événements

Un **événement** est quelque chose qui se produit sur la page : un clic, une touche pressée, un formulaire envoyé. On l'« écoute » avec `addEventListener`, qui prend le nom de l'événement et une fonction à exécuter :

```js
const bouton = document.querySelector("#btn-horaires");
const horaires = document.querySelector("#horaires");

bouton.addEventListener("click", () => {
  horaires.classList.toggle("cache");
});
```

```css
.cache {
  display: none;
}
```

À chaque clic sur le bouton, les horaires apparaissent ou disparaissent.

Les événements que tu utiliseras le plus :

| Événement | Se produit quand… |
| --- | --- |
| `click` | on clique ou on touche l'élément |
| `input` | la valeur d'un champ change (à chaque caractère tapé) |
| `change` | on valide un choix (liste déroulante, case à cocher) |
| `submit` | un formulaire est envoyé |

## Travailler avec un formulaire

La propriété `value` donne le contenu d'un champ. Attention : c'est toujours une **chaîne de caractères**, même si le visiteur tape un nombre. Il faut la convertir avec `Number()` avant de calculer :

```js
const champQuantite = document.querySelector("#quantite");
const quantite = Number(champQuantite.value);
```

Pour un formulaire, on écoute l'événement `submit` et on bloque l'envoi par défaut (qui rechargerait la page) avec `event.preventDefault()` :

```js
const formulaire = document.querySelector("#form-contact");
const message = document.querySelector("#message-erreur");

formulaire.addEventListener("submit", (event) => {
  const telephone = document.querySelector("#telephone").value.trim();

  if (telephone.length < 8) {
    event.preventDefault();
    message.textContent = "Entre un numéro de téléphone valide (8 chiffres).";
  }
});
```

> **Info** : la vérification en JavaScript améliore le confort du visiteur, mais elle ne protège rien : n'importe qui peut la contourner. Il faudra **toujours** revérifier les données côté serveur, en PHP. Tu le feras dans le module 3.

## À toi de jouer : le simulateur de devis

Ajoute ce formulaire dans la page Chez Achta Couture :

```html
<section id="devis">
  <h2>Estimez le prix de votre tenue</h2>
  <form id="form-devis">
    <label for="modele">Modèle</label>
    <select id="modele">
      <option value="15000">Robe en bazin (15 000 FCFA)</option>
      <option value="25000">Boubou brodé (25 000 FCFA)</option>
      <option value="8000">Chemise en pagne (8 000 FCFA)</option>
    </select>

    <label for="quantite">Quantité</label>
    <input type="number" id="quantite" value="1" min="1">

    <label>
      <input type="checkbox" id="express"> Livraison express en 48 h (+20 %)
    </label>
  </form>
  <p>Prix estimé : <strong id="prix">15000</strong> FCFA</p>
</section>
```

Ta mission, dans `script.js` :

1. Sélectionne les trois champs et l'élément `#prix`.
2. Écris une fonction `mettreAJourPrix()` qui lit le modèle, la quantité et la case express, calcule le prix et l'affiche dans `#prix`.
3. Appelle cette fonction à chaque événement `input` sur le formulaire, pour que le prix change en direct.
4. Bonus : si la quantité est inférieure à 1, affiche « Quantité invalide » à la place du prix.

> **Correction possible** :

```js
const formDevis = document.querySelector("#form-devis");
const champModele = document.querySelector("#modele");
const champQuantite = document.querySelector("#quantite");
const caseExpress = document.querySelector("#express");
const affichagePrix = document.querySelector("#prix");

function mettreAJourPrix() {
  const prixUnitaire = Number(champModele.value);
  const quantite = Number(champQuantite.value);

  if (quantite < 1) {
    affichagePrix.textContent = "Quantité invalide";
    return;
  }

  let total = prixUnitaire * quantite;
  if (caseExpress.checked) {
    total = total * 1.2;
  }
  affichagePrix.textContent = Math.round(total).toLocaleString("fr-FR");
}

formDevis.addEventListener("input", mettreAJourPrix);
mettreAJourPrix();
```

`toLocaleString("fr-FR")` affiche le nombre avec des espaces entre les milliers : `30 000` au lieu de `30000`.

## Vérifie tes acquis

1. Que renvoie `document.querySelector(".carte")` s'il existe cinq éléments avec cette classe ?
2. Pourquoi faut-il convertir `champ.value` avec `Number()` avant un calcul ?
3. À quoi sert `event.preventDefault()` dans un écouteur `submit` ?

> **Réponses** : 1. Seulement le premier ; pour les cinq, il faut `querySelectorAll`. 2. Parce que `value` est toujours une chaîne : `"2" + "3"` donnerait `"23"` au lieu de 5. 3. À empêcher l'envoi du formulaire et le rechargement de la page, par exemple quand une saisie est invalide.

## En résumé

- Le **DOM** est l'arbre d'objets que le navigateur construit à partir du HTML ; JavaScript le modifie et l'affichage suit.
- `querySelector` sélectionne un élément, `querySelectorAll` tous les éléments correspondants.
- `textContent` modifie le texte ; `classList.add/remove/toggle` gère les classes.
- `addEventListener("click", fonction)` réagit aux actions du visiteur.
- Les valeurs des champs sont des chaînes : convertis-les avec `Number()`. La validation JavaScript ne remplace jamais la validation côté serveur.

## Pour aller plus loin

- [Introduction au DOM (MDN, en français)](https://developer.mozilla.org/fr/docs/Web/API/Document_Object_Model)
- Demande au mentor IA : « Comment ajouter un bouton qui envoie mon devis sur WhatsApp avec le prix calculé ? »
