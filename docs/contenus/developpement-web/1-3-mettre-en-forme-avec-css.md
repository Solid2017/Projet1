Ta page Chez Achta Couture a une bonne structure, mais elle ressemble à un document des années 1990 : texte noir, fond blanc, aucune couleur. Dans ce chapitre, tu vas l'habiller avec le **CSS** (*Cascading Style Sheets*, « feuilles de style en cascade ») et la rendre agréable sur téléphone comme sur ordinateur.

> **Objectifs de ce chapitre**
> - Relier une feuille de style à une page HTML
> - Écrire des règles CSS avec des sélecteurs et des propriétés
> - Maîtriser les couleurs, les polices, les marges et le modèle de boîte
> - Mettre des éléments côte à côte avec Flexbox
> - Adapter la page aux téléphones avec une media query

## Relier le CSS à ta page

Le CSS s'écrit dans un fichier séparé. Dans ton dossier `chez-achta`, crée un fichier `style.css`, puis ajoute cette ligne dans le `<head>` de `index.html` :

```html
<link rel="stylesheet" href="style.css">
```

Une seule feuille de style peut habiller toutes les pages d'un site. Si demain Achta veut changer sa couleur principale, tu ne modifieras qu'un seul fichier.

## Anatomie d'une règle CSS

```css
h1 {
  color: #8B1E3F;
  font-size: 2rem;
}
```

- `h1` est le **sélecteur** : il désigne les éléments à styliser.
- Entre accolades, chaque ligne est une **déclaration** composée d'une **propriété** (`color`) et d'une **valeur** (`#8B1E3F`), séparées par deux-points et terminées par un point-virgule.

> **Attention** : un point-virgule oublié suffit à faire ignorer la déclaration suivante. Si un style « ne marche pas », vérifie d'abord la ponctuation.

## Les trois sélecteurs à connaître

| Sélecteur | Exemple | Cible |
| --- | --- | --- |
| Balise | `p { … }` | Tous les paragraphes |
| Classe | `.bouton { … }` | Les éléments qui ont `class="bouton"` |
| Identifiant | `#contact { … }` | L'unique élément qui a `id="contact"` |

En pratique, tu utiliseras surtout les **classes** : on peut les réutiliser sur autant d'éléments qu'on veut, et un même élément peut en avoir plusieurs.

```html
<a href="https://wa.me/23566000000" class="bouton bouton-whatsapp">Commander sur WhatsApp</a>
```

```css
.bouton {
  display: inline-block;
  padding: 12px 24px;
  border-radius: 999px;
  font-weight: bold;
  text-decoration: none;
}

.bouton-whatsapp {
  background-color: #128C4A;
  color: white;
}
```

## Les couleurs et les polices

Tu peux écrire une couleur de plusieurs façons : par son nom (`white`), en hexadécimal (`#8B1E3F`) ou en RGB (`rgb(139, 30, 63)`). L'hexadécimal est le plus courant ; des outils comme le sélecteur de couleur de Google (tape « color picker ») te donnent le code de n'importe quelle teinte.

Pour la police, commence par une pile de polices système, rapides car déjà installées sur l'appareil :

```css
body {
  font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
  font-size: 16px;
  line-height: 1.6;
  color: #1F2328;
  background-color: #FFF8F2;
}
```

> **Info** : l'unité `rem` est relative à la taille de texte de base (16 px en général). `2rem` vaut donc 32 px. Utiliser `rem` permet à la page de respecter les réglages de taille de texte de l'utilisateur.

## Le modèle de boîte

C'est **la** notion à comprendre en CSS : chaque élément est une boîte rectangulaire composée de quatre couches, de l'intérieur vers l'extérieur :

1. le **contenu** (le texte, l'image) ;
2. le **padding** : l'espace intérieur, entre le contenu et la bordure ;
3. la **bordure** (`border`) ;
4. la **marge** (`margin`) : l'espace extérieur, qui éloigne la boîte de ses voisines.

```css
.carte-service {
  padding: 20px;
  border: 1px solid #E6D5C8;
  border-radius: 12px;
  margin-bottom: 16px;
  background-color: white;
}
```

Ajoute cette règle au début de ta feuille de style. Elle évite bien des surprises en incluant le padding et la bordure dans la largeur des boîtes :

```css
* {
  box-sizing: border-box;
}
```

> **Astuce** : dans les outils de développement (F12), clique sur un élément dans l'onglet **Éléments** : un schéma coloré te montre sa marge, sa bordure et son padding. C'est le meilleur moyen de comprendre pourquoi un élément n'est pas à la place attendue.

## Centrer et limiter la largeur

Sur un grand écran, un texte qui s'étale sur toute la largeur est difficile à lire. On limite la largeur et on centre :

```css
main {
  max-width: 960px;
  margin: 0 auto;
  padding: 0 16px;
}
```

`margin: 0 auto` signifie « 0 en haut et en bas, automatique à gauche et à droite » : le navigateur partage l'espace restant, ce qui centre la boîte.

## Mettre des éléments côte à côte avec Flexbox

Par défaut, les blocs s'empilent les uns sous les autres. Pour aligner les liens du menu sur une ligne, on utilise **Flexbox** sur le parent :

```css
header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 12px;
  padding: 16px;
  background-color: #8B1E3F;
}

nav {
  display: flex;
  gap: 16px;
}

nav a {
  color: white;
  text-decoration: none;
}
```

- `display: flex` aligne les enfants sur une ligne.
- `justify-content: space-between` repousse le titre à gauche et le menu à droite.
- `align-items: center` les centre verticalement.
- `flex-wrap: wrap` autorise le passage à la ligne s'il n'y a plus de place.
- `gap` ajoute un espace régulier entre les éléments.

## Adapter la page aux téléphones

Une **media query** applique des règles seulement sous certaines conditions, par exemple quand l'écran est étroit. On écrit d'abord le style pour mobile, puis on l'enrichit pour les grands écrans. C'est l'approche *mobile first* :

```css
.galerie {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.galerie img {
  width: 100%;
  border-radius: 12px;
}

@media (min-width: 700px) {
  .galerie {
    flex-direction: row;
  }
}
```

Sur téléphone, les photos s'empilent ; dès que l'écran fait au moins 700 px de large, elles se mettent côte à côte.

> **Astuce** : dans les outils de développement, l'icône représentant un téléphone et une tablette (ou **Ctrl+Maj+M**) simule différents écrans. Teste toujours ta page en largeur 360 px, la taille d'un smartphone d'entrée de gamme.

## À toi de jouer

Habille la page Chez Achta Couture du chapitre précédent :

1. Relie un fichier `style.css` à `index.html`.
2. Choisis une couleur principale et une couleur de fond douce, et applique-les au `header` et au `body`.
3. Mets le menu sur une ligne avec Flexbox.
4. Transforme chaque service en « carte » avec la classe `carte-service` (padding, bordure arrondie, fond blanc).
5. Crée un bouton WhatsApp vert bien visible dans la section Contact.
6. Rends la galerie adaptative : photos empilées sur mobile, côte à côte sur ordinateur.
7. Vérifie le résultat en largeur 360 px dans les outils de développement.

> **Pour t'auto-évaluer** : ta page est réussie si, sur un écran de téléphone, rien ne déborde horizontalement, le texte reste lisible sans zoomer et le bouton WhatsApp se repère en moins de deux secondes.

## Vérifie tes acquis

1. Quelle est la différence entre `padding` et `margin` ?
2. Quel sélecteur choisir pour styliser trois boutons identiques : une balise, une classe ou un identifiant ?
3. Que fait la règle `@media (min-width: 700px) { … }` ?

> **Réponses** : 1. Le padding est l'espace intérieur d'une boîte, la marge l'espace extérieur qui l'éloigne des autres. 2. Une classe, car elle se réutilise sur plusieurs éléments. 3. Elle applique les règles qu'elle contient uniquement aux écrans d'au moins 700 px de large.

## En résumé

- Le CSS s'écrit dans un fichier séparé relié par `<link rel="stylesheet" href="style.css">`.
- Une règle = un sélecteur + des déclarations `propriété: valeur;`.
- Les **classes** sont les sélecteurs les plus utiles car réutilisables.
- Chaque élément est une boîte : contenu, padding, bordure, marge. Utilise `box-sizing: border-box`.
- **Flexbox** aligne des éléments sur une ligne ; les **media queries** adaptent la page à la taille de l'écran.

## Pour aller plus loin

- [La documentation CSS de MDN, en français](https://developer.mozilla.org/fr/docs/Web/CSS)
- [Flexbox Froggy](https://flexboxfroggy.com/#fr) : un jeu gratuit, en français, pour maîtriser Flexbox en aidant des grenouilles à rejoindre leur nénuphar.
