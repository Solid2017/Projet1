Dans ce chapitre, tu vas écrire ta toute première page web. Pour avoir un fil rouge concret, tu vas créer le site vitrine de **Chez Achta Couture**, un atelier de couture du quartier Moursal à N'Djamena. Tu le compléteras au fil du parcours avec du CSS, du JavaScript puis du PHP.

> **Objectifs de ce chapitre**
> - Comprendre ce qu'est une balise HTML et un attribut
> - Écrire la structure minimale d'une page
> - Utiliser les balises essentielles : titres, paragraphes, listes, liens, images
> - Organiser une page avec les balises de structure (header, main, footer)

## De quoi as-tu besoin ?

Juste deux outils gratuits :

- **Un éditeur de code** : [Visual Studio Code](https://code.visualstudio.com/) sur ordinateur. Sur téléphone Android, l'application **Acode** fonctionne très bien pour débuter.
- **Un navigateur** : Chrome ou Firefox.

Crée un dossier `chez-achta` sur ton ordinateur, puis à l'intérieur un fichier nommé `index.html`. Le nom `index` est spécial : c'est la page qu'un serveur affiche par défaut.

## Les balises : le vocabulaire du HTML

HTML signifie *HyperText Markup Language*, « langage de balisage ». Une **balise** entoure un contenu pour dire au navigateur ce qu'il représente :

```html
<p>Bienvenue chez Achta Couture !</p>
```

- `<p>` est la **balise ouvrante** (p comme paragraphe).
- `</p>` est la **balise fermante** : remarque la barre oblique.
- Le texte au milieu est le **contenu**. L'ensemble forme un **élément**.

Certaines balises n'ont pas de contenu, donc pas de balise fermante. On les appelle des balises **orphelines** :

```html
<img src="atelier.jpg" alt="L'atelier de couture d'Achta">
<br>
```

## Les attributs : des précisions sur une balise

Dans l'exemple de l'image, `src` et `alt` sont des **attributs**. Ils s'écrivent dans la balise ouvrante, sous la forme `nom="valeur"` :

- `src` indique le fichier de l'image ;
- `alt` donne un texte alternatif, lu par les lecteurs d'écran des personnes aveugles et affiché si l'image ne charge pas (fréquent avec une connexion lente).

> **Attention** : n'oublie jamais l'attribut `alt` sur une image. C'est une question d'accessibilité, et Google l'utilise aussi pour comprendre ta page.

## La structure minimale d'une page

Toute page HTML commence par ce squelette. Copie-le dans ton fichier `index.html` :

```html
<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chez Achta Couture | N'Djamena</title>
  </head>
  <body>
    <h1>Chez Achta Couture</h1>
    <p>Tenues sur mesure, pagnes et broderies depuis 2015.</p>
  </body>
</html>
```

Ligne par ligne :

- `<!DOCTYPE html>` annonce au navigateur que c'est du HTML moderne (HTML5).
- `<html lang="fr">` englobe toute la page et précise qu'elle est en français.
- `<head>` contient les informations *sur* la page, invisibles dans le corps : l'encodage, le titre de l'onglet, plus tard le lien vers le CSS.
- `<meta charset="UTF-8">` permet d'afficher correctement les accents (é, è, ç…).
- `<meta name="viewport" …>` adapte la page à l'écran des téléphones. Indispensable : la majorité de tes visiteurs viendront d'un smartphone.
- `<body>` contient tout ce qui s'affiche à l'écran.

Enregistre le fichier, puis double-clique dessus : il s'ouvre dans ton navigateur. Félicitations, c'est ta première page web !

> **Info** : l'indentation (les espaces en début de ligne) n'est pas obligatoire, mais elle rend le code lisible. Prends cette habitude dès maintenant, tes futurs collègues te remercieront.

## Les balises essentielles

### Les titres

Il existe six niveaux de titres, de `<h1>` (le plus important) à `<h6>`. Une page ne doit avoir qu'un seul `<h1>` : le titre principal.

```html
<h1>Chez Achta Couture</h1>
<h2>Nos services</h2>
<h3>Tenues de mariage</h3>
```

### Les paragraphes et la mise en valeur

```html
<p>Nous cousons des tenues <strong>sur mesure</strong> en <em>moins d'une semaine</em>.</p>
```

`<strong>` marque un texte important (affiché en gras) et `<em>` une insistance (affichée en italique).

### Les listes

Une liste à puces utilise `<ul>` (*unordered list*), une liste numérotée `<ol>` (*ordered list*). Chaque élément est dans un `<li>` :

```html
<h2>Nos services</h2>
<ul>
  <li>Couture sur mesure</li>
  <li>Retouches</li>
  <li>Broderie traditionnelle</li>
</ul>

<h2>Comment commander ?</h2>
<ol>
  <li>Choisissez votre modèle</li>
  <li>Venez prendre vos mesures</li>
  <li>Récupérez votre tenue</li>
</ol>
```

### Les liens

Le lien est l'invention qui a donné son nom au web (« la toile »). On utilise la balise `<a>` avec l'attribut `href` :

```html
<a href="https://wa.me/23566000000">Commander sur WhatsApp</a>
<a href="contact.html">Page contact</a>
<a href="tel:+23566000000">Appeler l'atelier</a>
```

Le premier lien pointe vers un autre site (lien **absolu**), le deuxième vers une page de ton propre dossier (lien **relatif**), le troisième lance un appel téléphonique depuis un smartphone.

### Les images

```html
<img src="images/robe-bazin.jpg" alt="Robe en bazin brodé bleu et or" width="600">
```

Range tes images dans un sous-dossier `images`. Pense à les **compresser** (par exemple avec [Squoosh](https://squoosh.app/)) : une photo de 4 Mo met longtemps à charger sur une connexion 3G.

## Organiser la page : les balises de structure

HTML5 propose des balises qui décrivent les grandes zones d'une page. Elles ne changent rien à l'affichage, mais elles rendent le code clair et aident Google et les lecteurs d'écran :

| Balise | Rôle |
| --- | --- |
| `<header>` | L'en-tête : logo, nom du site, menu |
| `<nav>` | Le menu de navigation |
| `<main>` | Le contenu principal, unique dans la page |
| `<section>` | Une partie thématique (Services, Contact…) |
| `<footer>` | Le pied de page : adresse, réseaux sociaux |

## À toi de jouer

Complète ta page `index.html` pour obtenir le site vitrine de Chez Achta Couture. Ta page doit contenir :

1. Un `<header>` avec le nom de l'atelier en `<h1>` et un menu `<nav>` de trois liens : Services, Galerie, Contact.
2. Un `<main>` avec une `<section>` « Nos services » contenant une liste à puces de quatre services.
3. Une `<section>` « Galerie » avec deux images (prends n'importe quelles photos et pense à l'attribut `alt`).
4. Une `<section>` « Contact » avec l'adresse de l'atelier, un lien WhatsApp et un lien téléphone.
5. Un `<footer>` avec la mention « © 2026 Chez Achta Couture ».

Voici le début de la solution pour te guider. Essaie d'écrire le reste toi-même avant de regarder le code d'un camarade :

```html
<body>
  <header>
    <h1>Chez Achta Couture</h1>
    <nav>
      <a href="#services">Services</a>
      <a href="#galerie">Galerie</a>
      <a href="#contact">Contact</a>
    </nav>
  </header>

  <main>
    <section id="services">
      <h2>Nos services</h2>
      <ul>
        <li>Couture sur mesure</li>
        <!-- complète la liste ici -->
      </ul>
    </section>
    <!-- sections Galerie et Contact -->
  </main>

  <footer>
    <p>© 2026 Chez Achta Couture</p>
  </footer>
</body>
```

> **Astuce** : le lien `href="#services"` fait défiler la page jusqu'à l'élément qui porte `id="services"`. Le texte entre `<!--` et `-->` est un **commentaire** : il est ignoré par le navigateur et sert à laisser des notes dans ton code.

Ta page sera encore très simple visuellement, avec du texte noir sur fond blanc. C'est normal : la mise en forme, c'est le travail du CSS, au prochain chapitre.

## Vérifie tes acquis

1. Quelle est la différence entre une balise et un attribut ?
2. Dans quelle partie de la page met-on la balise `<title>` ?
3. Pourquoi faut-il toujours remplir l'attribut `alt` d'une image ?

> **Réponses** : 1. La balise indique la nature d'un contenu (`<p>`, `<img>`) ; l'attribut apporte une précision à l'intérieur de la balise (`src`, `href`). 2. Dans le `<head>`. 3. Pour les personnes qui utilisent un lecteur d'écran, pour l'affichage si l'image ne charge pas et pour le référencement.

## En résumé

- Le HTML décrit la **structure** et le **sens** du contenu, pas son apparence.
- Un élément = balise ouvrante + contenu + balise fermante. Les attributs précisent la balise.
- Toute page part du même squelette : `<!DOCTYPE html>`, `<html>`, `<head>`, `<body>`.
- Balises essentielles : `<h1>` à `<h6>`, `<p>`, `<ul>`/`<ol>`/`<li>`, `<a>`, `<img>`.
- Les balises de structure (`<header>`, `<main>`, `<section>`, `<footer>`) organisent la page.

## Pour aller plus loin

- [La référence des éléments HTML (MDN, en français)](https://developer.mozilla.org/fr/docs/Web/HTML)
- Demande au mentor IA de relire ton code : colle ta page dans la conversation et demande « Quelles erreurs vois-tu dans mon HTML ? ».
