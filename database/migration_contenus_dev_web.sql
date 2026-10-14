-- IgoTech IA — contenus détaillés du parcours « Développement Web Full-Stack »
-- 4 leçons réécrites + 3 nouvelles leçons (CSS, DOM, MySQL/PDO).
-- À importer via phpMyAdmin (onglet Importer ou SQL), après les fichiers
-- déjà en place. Les leçons sont retrouvées par leur titre et le slug du
-- parcours : aucun ID en dur. Sans danger si importé deux fois (les
-- leçons existantes sont mises à jour, les nouvelles ne sont pas dupliquées).
--
-- Si tu as renommé une leçon ou un module depuis l'administration, la
-- ligne correspondante ne trouvera rien : copie alors le contenu à la main
-- depuis docs/contenus/developpement-web/.

SET NAMES utf8mb4;

-- Comment fonctionne le web ?
UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Client, serveur, DNS, requêtes et codes HTTP : ce qui se passe quand tu ouvres une page.',
    l.duration_minutes = 25,
    l.content = 'Chaque jour, tu ouvres Facebook, WhatsApp Web ou le site de ta banque sans y penser. Pourtant, entre le moment où tu tapes une adresse et celui où la page s''affiche, une dizaine d''étapes se déroulent en moins d''une seconde. Comprendre ces étapes, c''est la base de tout le métier de développeur web : tu sauras ensuite exactement où agit chaque ligne de code que tu écriras.

> **Objectifs de ce chapitre**
> - Comprendre la différence entre Internet et le web
> - Savoir ce que font le client, le serveur et le DNS
> - Lire une requête et une réponse HTTP
> - Connaître le rôle de HTML, CSS et JavaScript

## Internet et le web, ce n''est pas la même chose

**Internet** est le réseau physique : des fibres optiques (qui relient le Tchad aux grands câbles sous-marins de l''océan Atlantique), des antennes 4G, des routeurs. C''est la route.

**Le web** est un service qui circule sur cette route, comme les voitures. WhatsApp, les e-mails ou les jeux en ligne sont d''autres services qui utilisent la même route.

Le web a été inventé en 1989 par Tim Berners-Lee avec trois idées : des pages écrites en **HTML**, des adresses pour les retrouver (les **URL**) et un langage pour les demander (le protocole **HTTP**).

## Le client et le serveur

Sur le web, deux ordinateurs discutent :

- **Le client** : c''est ton navigateur (Chrome, Firefox, Opera Mini…). Il *demande* une page.
- **Le serveur** : c''est un ordinateur allumé en permanence dans un centre de données. Il *répond* en envoyant la page.

Pense à un restaurant à N''Djamena : tu es le client, tu passes commande au serveur, qui va en cuisine et te rapporte ton plat. Le navigateur passe commande, le serveur web prépare la page et la renvoie.

## Ce qui se passe quand tu tapes une adresse

Prenons l''adresse `https://ia.igotech.com/parcours`.

1. **Lecture de l''URL** : le navigateur repère le protocole (`https`), le nom de domaine (`ia.igotech.com`) et le chemin (`/parcours`).
2. **Résolution DNS** : un ordinateur ne connaît que des adresses IP (par exemple `203.0.113.10`). Le **DNS** est l''annuaire d''Internet : il traduit le nom de domaine en adresse IP.
3. **Connexion sécurisée** : avec HTTPS, le navigateur et le serveur se mettent d''accord sur une clé de chiffrement. Plus personne ne peut lire ce qui circule entre eux.
4. **Requête HTTP** : le navigateur envoie sa commande au serveur.
5. **Réponse HTTP** : le serveur renvoie un code de statut et le contenu de la page.
6. **Rendu** : le navigateur lit le HTML, télécharge le CSS, les images et le JavaScript, puis dessine la page à l''écran.

> **Info** : le cadenas à côté de l''adresse signifie que la connexion est en HTTPS. Ne saisis jamais un mot de passe ou un code Mobile Money sur un site sans cadenas.

## À quoi ressemble une requête HTTP ?

Une requête est un simple texte. Voici celle que ton navigateur envoie pour la page des parcours :

```http
GET /parcours HTTP/1.1
Host: ia.igotech.com
User-Agent: Mozilla/5.0 (Android 13)
Accept-Language: fr-FR
```

La première ligne contient l''essentiel : la **méthode** (`GET`, « donne-moi »), le **chemin** demandé et la version du protocole. Les lignes suivantes sont des **en-têtes** qui donnent des détails (le site visé, le type de téléphone, la langue préférée).

Les deux méthodes que tu utiliseras tout le temps :

| Méthode | Sert à | Exemple |
| --- | --- | --- |
| `GET` | Lire une page ou une donnée | Afficher la liste des parcours |
| `POST` | Envoyer des données au serveur | Valider un formulaire d''inscription |

## Et la réponse ?

```http
HTTP/1.1 200 OK
Content-Type: text/html; charset=UTF-8

<!DOCTYPE html>
<html lang="fr">
  ...
</html>
```

Le nombre `200` est le **code de statut**. Il indique au navigateur comment s''est passée la commande :

| Code | Signification | Quand tu le verras |
| --- | --- | --- |
| `200` | Tout va bien | La page s''affiche normalement |
| `301` | Déplacé définitivement | Une ancienne adresse redirige vers la nouvelle |
| `404` | Introuvable | Lien cassé ou faute de frappe dans l''URL |
| `403` | Accès interdit | Fichier protégé, comme un fichier de configuration |
| `500` | Erreur du serveur | Le code PHP du site a planté |

> **Astuce** : retiens que les codes en 4xx sont des erreurs du côté client (mauvaise demande) et les codes en 5xx des erreurs du côté serveur (le site a un problème).

## Les trois langages du navigateur

Une page web est presque toujours faite de trois couches. Imagine une maison :

- **HTML** est la structure : les murs, les pièces, les portes. Il dit « ceci est un titre, ceci est un paragraphe, ceci est un bouton ».
- **CSS** est la décoration : la peinture, les rideaux. Il dit « ce titre est bleu, ce bouton est arrondi ».
- **JavaScript** est l''électricité : il rend la maison vivante. Il dit « quand on clique sur ce bouton, affiche un message ».

Côté serveur, d''autres langages comme **PHP** préparent la page avant de l''envoyer : par exemple, aller chercher dans une base de données la liste de tes leçons terminées. Tu les découvriras dans le module 3.

## Front-end, back-end, full-stack

- Le **développeur front-end** travaille sur ce que l''utilisateur voit : HTML, CSS, JavaScript.
- Le **développeur back-end** travaille sur le serveur : PHP, bases de données, sécurité.
- Le **développeur full-stack** sait faire les deux. C''est l''objectif de ce parcours.

## À toi de jouer

Tu vas observer de vrais échanges HTTP avec les outils de développement de ton navigateur. Fais l''exercice sur un ordinateur, ou sur Chrome pour Android en mode « Version pour ordinateur ».

1. Ouvre un site que tu connais, par exemple `https://ia.igotech.com`.
2. Appuie sur **F12** (ou clic droit, puis **Inspecter**) et ouvre l''onglet **Réseau** (*Network*).
3. Recharge la page avec **F5**.
4. Clique sur la toute première ligne de la liste : c''est la page HTML elle-même.
5. Note la **méthode**, le **code de statut** et la valeur de l''en-tête `Content-Type`.
6. Maintenant, tape une adresse qui n''existe pas, par exemple `https://ia.igotech.com/page-imaginaire`. Quel code de statut obtiens-tu ?

> **Correction** : la première requête est un `GET` qui renvoie `200` avec `Content-Type: text/html`. La page imaginaire renvoie `404`. Tu remarqueras aussi des dizaines d''autres requêtes : une pour chaque image, feuille CSS et fichier JavaScript de la page.

## Vérifie tes acquis

1. Quel service traduit `ia.igotech.com` en adresse IP ?
2. Quelle méthode HTTP utilise un formulaire d''inscription ?
3. Un site affiche une erreur 500. Le problème vient-il de ton téléphone ou du site ?

> **Réponses** : 1. Le DNS. 2. `POST`, car on envoie des données au serveur. 3. Du site : les codes 5xx sont des erreurs du serveur.

## En résumé

- Internet est le réseau ; le web est un service qui l''utilise.
- Le navigateur (client) envoie une **requête HTTP** ; le serveur renvoie une **réponse** avec un **code de statut**.
- Le **DNS** traduit les noms de domaine en adresses IP.
- **HTTPS** chiffre l''échange : c''est le cadenas dans la barre d''adresse.
- Une page = **HTML** (structure) + **CSS** (style) + **JavaScript** (comportement).

## Pour aller plus loin

- [La documentation HTTP de MDN, en français](https://developer.mozilla.org/fr/docs/Web/HTTP) : méthodes, en-têtes et codes de statut expliqués en détail.
- Demande au mentor IA : « Explique-moi le rôle du DNS avec un exemple tchadien. »'
WHERE t.slug = 'developpement-web' AND l.title = 'Comment fonctionne le web ?';

-- Structurer une page avec HTML
UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Balises, attributs et structure d''une page : crée le site vitrine de Chez Achta Couture.',
    l.duration_minutes = 30,
    l.content = 'Dans ce chapitre, tu vas écrire ta toute première page web. Pour avoir un fil rouge concret, tu vas créer le site vitrine de **Chez Achta Couture**, un atelier de couture du quartier Moursal à N''Djamena. Tu le compléteras au fil du parcours avec du CSS, du JavaScript puis du PHP.

> **Objectifs de ce chapitre**
> - Comprendre ce qu''est une balise HTML et un attribut
> - Écrire la structure minimale d''une page
> - Utiliser les balises essentielles : titres, paragraphes, listes, liens, images
> - Organiser une page avec les balises de structure (header, main, footer)

## De quoi as-tu besoin ?

Juste deux outils gratuits :

- **Un éditeur de code** : [Visual Studio Code](https://code.visualstudio.com/) sur ordinateur. Sur téléphone Android, l''application **Acode** fonctionne très bien pour débuter.
- **Un navigateur** : Chrome ou Firefox.

Crée un dossier `chez-achta` sur ton ordinateur, puis à l''intérieur un fichier nommé `index.html`. Le nom `index` est spécial : c''est la page qu''un serveur affiche par défaut.

## Les balises : le vocabulaire du HTML

HTML signifie *HyperText Markup Language*, « langage de balisage ». Une **balise** entoure un contenu pour dire au navigateur ce qu''il représente :

```html
<p>Bienvenue chez Achta Couture !</p>
```

- `<p>` est la **balise ouvrante** (p comme paragraphe).
- `</p>` est la **balise fermante** : remarque la barre oblique.
- Le texte au milieu est le **contenu**. L''ensemble forme un **élément**.

Certaines balises n''ont pas de contenu, donc pas de balise fermante. On les appelle des balises **orphelines** :

```html
<img src="atelier.jpg" alt="L''atelier de couture d''Achta">
<br>
```

## Les attributs : des précisions sur une balise

Dans l''exemple de l''image, `src` et `alt` sont des **attributs**. Ils s''écrivent dans la balise ouvrante, sous la forme `nom="valeur"` :

- `src` indique le fichier de l''image ;
- `alt` donne un texte alternatif, lu par les lecteurs d''écran des personnes aveugles et affiché si l''image ne charge pas (fréquent avec une connexion lente).

> **Attention** : n''oublie jamais l''attribut `alt` sur une image. C''est une question d''accessibilité, et Google l''utilise aussi pour comprendre ta page.

## La structure minimale d''une page

Toute page HTML commence par ce squelette. Copie-le dans ton fichier `index.html` :

```html
<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chez Achta Couture | N''Djamena</title>
  </head>
  <body>
    <h1>Chez Achta Couture</h1>
    <p>Tenues sur mesure, pagnes et broderies depuis 2015.</p>
  </body>
</html>
```

Ligne par ligne :

- `<!DOCTYPE html>` annonce au navigateur que c''est du HTML moderne (HTML5).
- `<html lang="fr">` englobe toute la page et précise qu''elle est en français.
- `<head>` contient les informations *sur* la page, invisibles dans le corps : l''encodage, le titre de l''onglet, plus tard le lien vers le CSS.
- `<meta charset="UTF-8">` permet d''afficher correctement les accents (é, è, ç…).
- `<meta name="viewport" …>` adapte la page à l''écran des téléphones. Indispensable : la majorité de tes visiteurs viendront d''un smartphone.
- `<body>` contient tout ce qui s''affiche à l''écran.

Enregistre le fichier, puis double-clique dessus : il s''ouvre dans ton navigateur. Félicitations, c''est ta première page web !

> **Info** : l''indentation (les espaces en début de ligne) n''est pas obligatoire, mais elle rend le code lisible. Prends cette habitude dès maintenant, tes futurs collègues te remercieront.

## Les balises essentielles

### Les titres

Il existe six niveaux de titres, de `<h1>` (le plus important) à `<h6>`. Une page ne doit avoir qu''un seul `<h1>` : le titre principal.

```html
<h1>Chez Achta Couture</h1>
<h2>Nos services</h2>
<h3>Tenues de mariage</h3>
```

### Les paragraphes et la mise en valeur

```html
<p>Nous cousons des tenues <strong>sur mesure</strong> en <em>moins d''une semaine</em>.</p>
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

Le lien est l''invention qui a donné son nom au web (« la toile »). On utilise la balise `<a>` avec l''attribut `href` :

```html
<a href="https://wa.me/23566000000">Commander sur WhatsApp</a>
<a href="contact.html">Page contact</a>
<a href="tel:+23566000000">Appeler l''atelier</a>
```

Le premier lien pointe vers un autre site (lien **absolu**), le deuxième vers une page de ton propre dossier (lien **relatif**), le troisième lance un appel téléphonique depuis un smartphone.

### Les images

```html
<img src="images/robe-bazin.jpg" alt="Robe en bazin brodé bleu et or" width="600">
```

Range tes images dans un sous-dossier `images`. Pense à les **compresser** (par exemple avec [Squoosh](https://squoosh.app/)) : une photo de 4 Mo met longtemps à charger sur une connexion 3G.

## Organiser la page : les balises de structure

HTML5 propose des balises qui décrivent les grandes zones d''une page. Elles ne changent rien à l''affichage, mais elles rendent le code clair et aident Google et les lecteurs d''écran :

| Balise | Rôle |
| --- | --- |
| `<header>` | L''en-tête : logo, nom du site, menu |
| `<nav>` | Le menu de navigation |
| `<main>` | Le contenu principal, unique dans la page |
| `<section>` | Une partie thématique (Services, Contact…) |
| `<footer>` | Le pied de page : adresse, réseaux sociaux |

## À toi de jouer

Complète ta page `index.html` pour obtenir le site vitrine de Chez Achta Couture. Ta page doit contenir :

1. Un `<header>` avec le nom de l''atelier en `<h1>` et un menu `<nav>` de trois liens : Services, Galerie, Contact.
2. Un `<main>` avec une `<section>` « Nos services » contenant une liste à puces de quatre services.
3. Une `<section>` « Galerie » avec deux images (prends n''importe quelles photos et pense à l''attribut `alt`).
4. Une `<section>` « Contact » avec l''adresse de l''atelier, un lien WhatsApp et un lien téléphone.
5. Un `<footer>` avec la mention « © 2026 Chez Achta Couture ».

Voici le début de la solution pour te guider. Essaie d''écrire le reste toi-même avant de regarder le code d''un camarade :

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

> **Astuce** : le lien `href="#services"` fait défiler la page jusqu''à l''élément qui porte `id="services"`. Le texte entre `<!--` et `-->` est un **commentaire** : il est ignoré par le navigateur et sert à laisser des notes dans ton code.

Ta page sera encore très simple visuellement, avec du texte noir sur fond blanc. C''est normal : la mise en forme, c''est le travail du CSS, au prochain chapitre.

## Vérifie tes acquis

1. Quelle est la différence entre une balise et un attribut ?
2. Dans quelle partie de la page met-on la balise `<title>` ?
3. Pourquoi faut-il toujours remplir l''attribut `alt` d''une image ?

> **Réponses** : 1. La balise indique la nature d''un contenu (`<p>`, `<img>`) ; l''attribut apporte une précision à l''intérieur de la balise (`src`, `href`). 2. Dans le `<head>`. 3. Pour les personnes qui utilisent un lecteur d''écran, pour l''affichage si l''image ne charge pas et pour le référencement.

## En résumé

- Le HTML décrit la **structure** et le **sens** du contenu, pas son apparence.
- Un élément = balise ouvrante + contenu + balise fermante. Les attributs précisent la balise.
- Toute page part du même squelette : `<!DOCTYPE html>`, `<html>`, `<head>`, `<body>`.
- Balises essentielles : `<h1>` à `<h6>`, `<p>`, `<ul>`/`<ol>`/`<li>`, `<a>`, `<img>`.
- Les balises de structure (`<header>`, `<main>`, `<section>`, `<footer>`) organisent la page.

## Pour aller plus loin

- [La référence des éléments HTML (MDN, en français)](https://developer.mozilla.org/fr/docs/Web/HTML)
- Demande au mentor IA de relire ton code : colle ta page dans la conversation et demande « Quelles erreurs vois-tu dans mon HTML ? ».'
WHERE t.slug = 'developpement-web' AND l.title = 'Structurer une page avec HTML';

-- Mettre en forme avec CSS (nouvelle leçon)
INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position)
SELECT m.id, 'Mettre en forme avec CSS', 'Sélecteurs, modèle de boîte, Flexbox et media queries pour un site beau sur téléphone.', 'Ta page Chez Achta Couture a une bonne structure, mais elle ressemble à un document des années 1990 : texte noir, fond blanc, aucune couleur. Dans ce chapitre, tu vas l''habiller avec le **CSS** (*Cascading Style Sheets*, « feuilles de style en cascade ») et la rendre agréable sur téléphone comme sur ordinateur.

> **Objectifs de ce chapitre**
> - Relier une feuille de style à une page HTML
> - Écrire des règles CSS avec des sélecteurs et des propriétés
> - Maîtriser les couleurs, les polices, les marges et le modèle de boîte
> - Mettre des éléments côte à côte avec Flexbox
> - Adapter la page aux téléphones avec une media query

## Relier le CSS à ta page

Le CSS s''écrit dans un fichier séparé. Dans ton dossier `chez-achta`, crée un fichier `style.css`, puis ajoute cette ligne dans le `<head>` de `index.html` :

```html
<link rel="stylesheet" href="style.css">
```

Une seule feuille de style peut habiller toutes les pages d''un site. Si demain Achta veut changer sa couleur principale, tu ne modifieras qu''un seul fichier.

## Anatomie d''une règle CSS

```css
h1 {
  color: #8B1E3F;
  font-size: 2rem;
}
```

- `h1` est le **sélecteur** : il désigne les éléments à styliser.
- Entre accolades, chaque ligne est une **déclaration** composée d''une **propriété** (`color`) et d''une **valeur** (`#8B1E3F`), séparées par deux-points et terminées par un point-virgule.

> **Attention** : un point-virgule oublié suffit à faire ignorer la déclaration suivante. Si un style « ne marche pas », vérifie d''abord la ponctuation.

## Les trois sélecteurs à connaître

| Sélecteur | Exemple | Cible |
| --- | --- | --- |
| Balise | `p { … }` | Tous les paragraphes |
| Classe | `.bouton { … }` | Les éléments qui ont `class="bouton"` |
| Identifiant | `#contact { … }` | L''unique élément qui a `id="contact"` |

En pratique, tu utiliseras surtout les **classes** : on peut les réutiliser sur autant d''éléments qu''on veut, et un même élément peut en avoir plusieurs.

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

Tu peux écrire une couleur de plusieurs façons : par son nom (`white`), en hexadécimal (`#8B1E3F`) ou en RGB (`rgb(139, 30, 63)`). L''hexadécimal est le plus courant ; des outils comme le sélecteur de couleur de Google (tape « color picker ») te donnent le code de n''importe quelle teinte.

Pour la police, commence par une pile de polices système, rapides car déjà installées sur l''appareil :

```css
body {
  font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
  font-size: 16px;
  line-height: 1.6;
  color: #1F2328;
  background-color: #FFF8F2;
}
```

> **Info** : l''unité `rem` est relative à la taille de texte de base (16 px en général). `2rem` vaut donc 32 px. Utiliser `rem` permet à la page de respecter les réglages de taille de texte de l''utilisateur.

## Le modèle de boîte

C''est **la** notion à comprendre en CSS : chaque élément est une boîte rectangulaire composée de quatre couches, de l''intérieur vers l''extérieur :

1. le **contenu** (le texte, l''image) ;
2. le **padding** : l''espace intérieur, entre le contenu et la bordure ;
3. la **bordure** (`border`) ;
4. la **marge** (`margin`) : l''espace extérieur, qui éloigne la boîte de ses voisines.

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

> **Astuce** : dans les outils de développement (F12), clique sur un élément dans l''onglet **Éléments** : un schéma coloré te montre sa marge, sa bordure et son padding. C''est le meilleur moyen de comprendre pourquoi un élément n''est pas à la place attendue.

## Centrer et limiter la largeur

Sur un grand écran, un texte qui s''étale sur toute la largeur est difficile à lire. On limite la largeur et on centre :

```css
main {
  max-width: 960px;
  margin: 0 auto;
  padding: 0 16px;
}
```

`margin: 0 auto` signifie « 0 en haut et en bas, automatique à gauche et à droite » : le navigateur partage l''espace restant, ce qui centre la boîte.

## Mettre des éléments côte à côte avec Flexbox

Par défaut, les blocs s''empilent les uns sous les autres. Pour aligner les liens du menu sur une ligne, on utilise **Flexbox** sur le parent :

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
- `flex-wrap: wrap` autorise le passage à la ligne s''il n''y a plus de place.
- `gap` ajoute un espace régulier entre les éléments.

## Adapter la page aux téléphones

Une **media query** applique des règles seulement sous certaines conditions, par exemple quand l''écran est étroit. On écrit d''abord le style pour mobile, puis on l''enrichit pour les grands écrans. C''est l''approche *mobile first* :

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

Sur téléphone, les photos s''empilent ; dès que l''écran fait au moins 700 px de large, elles se mettent côte à côte.

> **Astuce** : dans les outils de développement, l''icône représentant un téléphone et une tablette (ou **Ctrl+Maj+M**) simule différents écrans. Teste toujours ta page en largeur 360 px, la taille d''un smartphone d''entrée de gamme.

## À toi de jouer

Habille la page Chez Achta Couture du chapitre précédent :

1. Relie un fichier `style.css` à `index.html`.
2. Choisis une couleur principale et une couleur de fond douce, et applique-les au `header` et au `body`.
3. Mets le menu sur une ligne avec Flexbox.
4. Transforme chaque service en « carte » avec la classe `carte-service` (padding, bordure arrondie, fond blanc).
5. Crée un bouton WhatsApp vert bien visible dans la section Contact.
6. Rends la galerie adaptative : photos empilées sur mobile, côte à côte sur ordinateur.
7. Vérifie le résultat en largeur 360 px dans les outils de développement.

> **Pour t''auto-évaluer** : ta page est réussie si, sur un écran de téléphone, rien ne déborde horizontalement, le texte reste lisible sans zoomer et le bouton WhatsApp se repère en moins de deux secondes.

## Vérifie tes acquis

1. Quelle est la différence entre `padding` et `margin` ?
2. Quel sélecteur choisir pour styliser trois boutons identiques : une balise, une classe ou un identifiant ?
3. Que fait la règle `@media (min-width: 700px) { … }` ?

> **Réponses** : 1. Le padding est l''espace intérieur d''une boîte, la marge l''espace extérieur qui l''éloigne des autres. 2. Une classe, car elle se réutilise sur plusieurs éléments. 3. Elle applique les règles qu''elle contient uniquement aux écrans d''au moins 700 px de large.

## En résumé

- Le CSS s''écrit dans un fichier séparé relié par `<link rel="stylesheet" href="style.css">`.
- Une règle = un sélecteur + des déclarations `propriété: valeur;`.
- Les **classes** sont les sélecteurs les plus utiles car réutilisables.
- Chaque élément est une boîte : contenu, padding, bordure, marge. Utilise `box-sizing: border-box`.
- **Flexbox** aligne des éléments sur une ligne ; les **media queries** adaptent la page à la taille de l''écran.

## Pour aller plus loin

- [La documentation CSS de MDN, en français](https://developer.mozilla.org/fr/docs/Web/CSS)
- [Flexbox Froggy](https://flexboxfroggy.com/#fr) : un jeu gratuit, en français, pour maîtriser Flexbox en aidant des grenouilles à rejoindre leur nénuphar.', 30, 3
FROM modules m
JOIN tracks t ON t.id = m.track_id
WHERE t.slug = 'developpement-web' AND m.title = 'Les fondamentaux du web'
  AND NOT EXISTS (SELECT 1 FROM lessons l2 WHERE l2.module_id = m.id AND l2.title = 'Mettre en forme avec CSS')
LIMIT 1;

-- Les bases de JavaScript
UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Variables, types, conditions, boucles et fonctions, avec un calculateur de devis en FCFA.',
    l.duration_minutes = 35,
    l.content = 'HTML structure la page, CSS l''habille… mais pour l''instant, elle ne réagit à rien. **JavaScript** est le langage qui lui donne un comportement : calculer un prix, vérifier un formulaire, afficher un message. C''est aussi le langage le plus utilisé au monde, et l''un des plus demandés par les employeurs.

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
console.log("Bonjour N''Djamena !");
```

Appuie sur Entrée : le message s''affiche. `console.log()` sera ton meilleur ami pour vérifier ce que fait ton code.

### Dans un fichier, pour ton site

Crée un fichier `script.js` et relie-le à ta page juste avant la balise `</body>` :

```html
  <script src="script.js"></script>
</body>
```

On le place en bas de page pour que le HTML soit déjà chargé quand le script s''exécute.

## Les variables : des boîtes avec une étiquette

Une **variable** stocke une valeur pour la réutiliser plus tard. On la déclare avec `let` si sa valeur peut changer, ou `const` si elle ne changera jamais :

```js
const nomAtelier = "Chez Achta Couture";
let nombreCommandes = 0;

nombreCommandes = nombreCommandes + 1;
console.log(nombreCommandes); // affiche 1
```

> **Astuce** : utilise `const` par défaut, et `let` seulement quand tu sais que la valeur va changer. Ça évite de modifier une valeur par erreur. Tu croiseras aussi `var` dans de vieux tutoriels : c''est l''ancienne façon de faire, évite-la.

Règles de nommage : pas d''espace ni d''accent, pas de chiffre au début. Par convention, on écrit en *camelCase* : `prixTotal`, `nomClient`.

Le texte après `//` est un **commentaire** : JavaScript l''ignore.

## Les types de données

| Type | Exemple | Usage |
| --- | --- | --- |
| Nombre (`number`) | `15000`, `2.5` | Prix, quantités, calculs |
| Chaîne (`string`) | `"Awa"`, `''robe''` | Texte, toujours entre guillemets |
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

Les **gabarits** (entre accents graves, touches **AltGr+7** sur un clavier AZERTY) permettent d''insérer des variables dans un texte avec `${ }` :

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
  console.log("Livraison gratuite à N''Djamena !");
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

Pour parcourir tous les éléments d''un tableau, la boucle `for…of` est la plus lisible :

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

Une **fonction** regroupe des instructions sous un nom. On la définit une fois, puis on l''appelle autant de fois qu''on veut, avec des valeurs différentes :

```js
function calculerTotal(prix, quantite) {
  return prix * quantite;
}

console.log(calculerTotal(15000, 2)); // 30000
console.log(calculerTotal(5000, 3));  // 15000
```

- `prix` et `quantite` sont des **paramètres** : des variables qui reçoivent les valeurs passées à l''appel.
- `return` renvoie le résultat à l''endroit où la fonction a été appelée.

Tu verras aussi souvent l''écriture courte, dite **fonction fléchée** :

```js
const calculerTotal = (prix, quantite) => prix * quantite;
```

## À toi de jouer

Écris un petit programme de devis pour Chez Achta Couture, dans la console ou dans `script.js` :

1. Crée un tableau `panier` contenant trois objets, chacun avec un `article` et un `prix` (par exemple une robe à 15 000 FCFA, une retouche à 2 000 FCFA, une broderie à 5 000 FCFA).
2. Écris une fonction `calculerTotal(panier)` qui additionne les prix avec une boucle et renvoie le total.
3. Écris une fonction `fraisLivraison(total)` qui renvoie 0 si le total atteint 50 000 FCFA, 1 000 FCFA s''il atteint 20 000 FCFA, et 2 000 FCFA sinon.
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

- JavaScript s''écrit dans un fichier `.js` relié par `<script src="…">` en bas de page ; `console.log()` permet de tester.
- `const` pour les valeurs fixes, `let` pour celles qui changent.
- Types principaux : nombre, chaîne, booléen, tableau, objet.
- `if / else if / else` pour décider, `for…of` pour parcourir un tableau.
- Les **fonctions** regroupent du code réutilisable ; `return` renvoie le résultat.

## Pour aller plus loin

- [Le guide JavaScript de MDN, en français](https://developer.mozilla.org/fr/docs/Web/JavaScript/Guide)
- Demande au mentor IA : « Donne-moi trois exercices JavaScript sur les boucles, du plus facile au plus difficile, sans la solution. »'
WHERE t.slug = 'developpement-web' AND l.title = 'Les bases de JavaScript';

-- Rendre une page interactive avec le DOM (nouvelle leçon)
INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position)
SELECT m.id, 'Rendre une page interactive avec le DOM', 'Sélectionner et modifier la page, réagir aux clics et aux formulaires : un simulateur de prix en direct.', 'Tu connais maintenant les variables, les conditions et les fonctions. Il est temps de les brancher sur ta page ! Dans ce chapitre, tu vas apprendre à lire et modifier le contenu de la page avec JavaScript, et à réagir aux actions du visiteur : clics, saisies, envois de formulaire. À la fin, le site Chez Achta Couture aura un simulateur de devis qui calcule le prix en direct.

> **Objectifs de ce chapitre**
> - Comprendre ce qu''est le DOM
> - Sélectionner des éléments HTML depuis JavaScript
> - Modifier du texte, des classes et des styles
> - Réagir à des événements avec `addEventListener`
> - Lire et vérifier les valeurs d''un formulaire

## Le DOM, une représentation vivante de la page

Quand le navigateur charge ton HTML, il le transforme en un arbre d''objets en mémoire : le **DOM** (*Document Object Model*). Chaque balise devient un nœud de cet arbre, avec des parents et des enfants :

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

JavaScript ne modifie pas ton fichier HTML : il modifie cet arbre. Et dès que l''arbre change, le navigateur met l''affichage à jour. C''est ce qui rend la page interactive sans la recharger.

## Sélectionner des éléments

La méthode la plus pratique est `document.querySelector()`. Elle accepte n''importe quel sélecteur CSS et renvoie le **premier** élément correspondant :

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

> **Info** : si `querySelector` ne trouve rien, il renvoie `null`. L''erreur « Cannot read properties of null » dans la console signifie presque toujours que ton sélecteur est faux, ou que le script s''exécute avant que le HTML soit chargé.

## Modifier la page

### Le texte

```js
const titre = document.querySelector("h1");
titre.textContent = "Chez Achta Couture, tenues de fête";
```

### Les classes

Plutôt que de modifier le style directement, la bonne pratique est d''ajouter ou de retirer des **classes** définies dans ton CSS :

```js
const menu = document.querySelector("nav");
menu.classList.add("ouvert");      // ajoute la classe
menu.classList.remove("ouvert");   // la retire
menu.classList.toggle("ouvert");   // l''ajoute si elle est absente, la retire sinon
```

Ainsi, l''apparence reste dans le CSS et le comportement dans le JavaScript : chaque fichier a son rôle.

### Créer de nouveaux éléments

```js
const liste = document.querySelector("#liste-services");
const nouvelElement = document.createElement("li");
nouvelElement.textContent = "Location de tenues";
liste.append(nouvelElement);
```

> **Attention** : pour insérer un texte saisi par un visiteur, utilise toujours `textContent`, jamais `innerHTML`. Avec `innerHTML`, un visiteur malveillant pourrait injecter du code dans ta page : c''est une faille de sécurité appelée XSS.

## Réagir aux événements

Un **événement** est quelque chose qui se produit sur la page : un clic, une touche pressée, un formulaire envoyé. On l''« écoute » avec `addEventListener`, qui prend le nom de l''événement et une fonction à exécuter :

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
| `click` | on clique ou on touche l''élément |
| `input` | la valeur d''un champ change (à chaque caractère tapé) |
| `change` | on valide un choix (liste déroulante, case à cocher) |
| `submit` | un formulaire est envoyé |

## Travailler avec un formulaire

La propriété `value` donne le contenu d''un champ. Attention : c''est toujours une **chaîne de caractères**, même si le visiteur tape un nombre. Il faut la convertir avec `Number()` avant de calculer :

```js
const champQuantite = document.querySelector("#quantite");
const quantite = Number(champQuantite.value);
```

Pour un formulaire, on écoute l''événement `submit` et on bloque l''envoi par défaut (qui rechargerait la page) avec `event.preventDefault()` :

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

> **Info** : la vérification en JavaScript améliore le confort du visiteur, mais elle ne protège rien : n''importe qui peut la contourner. Il faudra **toujours** revérifier les données côté serveur, en PHP. Tu le feras dans le module 3.

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

1. Sélectionne les trois champs et l''élément `#prix`.
2. Écris une fonction `mettreAJourPrix()` qui lit le modèle, la quantité et la case express, calcule le prix et l''affiche dans `#prix`.
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

1. Que renvoie `document.querySelector(".carte")` s''il existe cinq éléments avec cette classe ?
2. Pourquoi faut-il convertir `champ.value` avec `Number()` avant un calcul ?
3. À quoi sert `event.preventDefault()` dans un écouteur `submit` ?

> **Réponses** : 1. Seulement le premier ; pour les cinq, il faut `querySelectorAll`. 2. Parce que `value` est toujours une chaîne : `"2" + "3"` donnerait `"23"` au lieu de 5. 3. À empêcher l''envoi du formulaire et le rechargement de la page, par exemple quand une saisie est invalide.

## En résumé

- Le **DOM** est l''arbre d''objets que le navigateur construit à partir du HTML ; JavaScript le modifie et l''affichage suit.
- `querySelector` sélectionne un élément, `querySelectorAll` tous les éléments correspondants.
- `textContent` modifie le texte ; `classList.add/remove/toggle` gère les classes.
- `addEventListener("click", fonction)` réagit aux actions du visiteur.
- Les valeurs des champs sont des chaînes : convertis-les avec `Number()`. La validation JavaScript ne remplace jamais la validation côté serveur.

## Pour aller plus loin

- [Introduction au DOM (MDN, en français)](https://developer.mozilla.org/fr/docs/Web/API/Document_Object_Model)
- Demande au mentor IA : « Comment ajouter un bouton qui envoie mon devis sur WhatsApp avec le prix calculé ? »', 35, 2
FROM modules m
JOIN tracks t ON t.id = m.track_id
WHERE t.slug = 'developpement-web' AND m.title = 'JavaScript pour l''interactivité'
  AND NOT EXISTS (SELECT 1 FROM lessons l2 WHERE l2.module_id = m.id AND l2.title = 'Rendre une page interactive avec le DOM')
LIMIT 1;

-- Premiers pas avec PHP
UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Exécuter du code côté serveur, découper un site avec include et traiter un formulaire en toute sécurité.',
    l.duration_minutes = 40,
    l.content = 'Jusqu''ici, tout ton code s''exécutait dans le navigateur du visiteur. Mais certaines choses ne peuvent se faire que sur le **serveur** : enregistrer une commande, envoyer un e-mail, vérifier un mot de passe, afficher les données d''un compte. C''est le rôle du **back-end**, et c''est là qu''intervient **PHP**.

PHP fait tourner environ trois quarts des sites web dont on connaît le langage serveur, dont tous les sites WordPress. C''est aussi le langage de la plateforme IgoTech IA sur laquelle tu apprends en ce moment !

> **Objectifs de ce chapitre**
> - Comprendre comment PHP génère une page côté serveur
> - Installer un serveur local et exécuter ton premier script
> - Utiliser les variables, tableaux, conditions et boucles en PHP
> - Découper un site avec `include`
> - Recevoir et afficher les données d''un formulaire en toute sécurité

## Comment fonctionne PHP ?

Souviens-toi du premier chapitre : le navigateur envoie une requête, le serveur renvoie du HTML. Avec une page `.php`, le serveur fait une étape de plus :

1. Le visiteur demande `contact.php`.
2. Le serveur repère l''extension `.php` et confie le fichier à l''interpréteur PHP.
3. PHP exécute le code et produit du HTML.
4. Le serveur envoie **uniquement ce HTML** au navigateur.

Le visiteur ne voit donc jamais ton code PHP, seulement son résultat. C''est pour ça qu''on peut y placer des mots de passe de base de données sans qu''ils soient visibles.

## Installer un serveur local

Pour exécuter du PHP, il faut un serveur. Sur ton ordinateur, deux solutions gratuites :

- **XAMPP** (Windows, Mac, Linux) : installe Apache, PHP et MySQL en une fois. Lance le panneau XAMPP, démarre **Apache**, puis place tes fichiers dans le dossier `htdocs`. Ton site est visible à l''adresse `http://localhost`.
- **Le serveur intégré de PHP**, si PHP est déjà installé : ouvre un terminal dans ton dossier et tape la commande ci-dessous, puis ouvre `http://localhost:8000`.

```bash
php -S localhost:8000
```

> **Info** : un hébergeur comme LWS fournit aussi PHP et MySQL. Tu pourras y mettre ton site en ligne une fois qu''il fonctionnera en local.

## Ton premier script

Crée un fichier `bonjour.php` :

```php
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Mon premier PHP</title>
</head>
<body>
  <h1>Bonjour depuis le serveur !</h1>
  <p>Nous sommes le <?php echo date(''d/m/Y''); ?>.</p>
</body>
</html>
```

Le code PHP s''écrit entre `<?php` et `?>`. Ici, `echo` affiche la date du jour, calculée par le serveur au moment de la requête. Recharge la page demain : la date aura changé sans que tu modifies le fichier.

## La syntaxe de base

Si tu as suivi le module JavaScript, tu vas te sentir en terrain connu. Les principales différences : les variables commencent par `$`, chaque instruction se termine **obligatoirement** par un point-virgule, et on assemble du texte avec un point `.`.

```php
<?php
$atelier = "Chez Achta Couture";
$prixRobe = 15000;
$quantite = 2;
$total = $prixRobe * $quantite;

echo "<p>Bienvenue chez $atelier</p>";
echo "<p>Total : " . $total . " FCFA</p>";
```

> **Astuce** : entre guillemets doubles, PHP remplace les variables par leur valeur (`"Bienvenue chez $atelier"`). Entre apostrophes, il ne le fait pas. Quand le fichier ne contient que du PHP, on omet le `?>` final.

### Les tableaux

```php
<?php
$services = ["Couture sur mesure", "Retouches", "Broderie"];

$tenues = [
    ["nom" => "Robe en bazin", "prix" => 15000],
    ["nom" => "Boubou brodé", "prix" => 25000],
    ["nom" => "Chemise en pagne", "prix" => 8000],
];
```

Le second est un tableau de tableaux **associatifs** : chaque valeur a un nom (`"nom"`, `"prix"`), comme les objets en JavaScript.

### Conditions et boucles

```php
<ul>
<?php foreach ($tenues as $tenue): ?>
  <li>
    <?= $tenue[''nom''] ?> : <?= number_format($tenue[''prix''], 0, '','', '' '') ?> FCFA
    <?php if ($tenue[''prix''] > 20000): ?>
      <strong>(modèle premium)</strong>
    <?php endif; ?>
  </li>
<?php endforeach; ?>
</ul>
```

- `foreach` parcourt le tableau ; à chaque tour, `$tenue` contient une ligne.
- `<?= … ?>` est le raccourci de `<?php echo … ?>`.
- La syntaxe avec deux-points (`foreach (…):` … `endforeach;`) est la plus lisible quand on mélange PHP et HTML.
- `number_format()` affiche `25 000` au lieu de `25000`.

### Les fonctions

```php
<?php
function fraisLivraison(int $total): int
{
    if ($total >= 50000) {
        return 0;
    }
    return $total >= 20000 ? 1000 : 2000;
}

echo fraisLivraison(30000); // 1000
```

## Ne pas se répéter avec include

Un site a souvent le même en-tête et le même pied de page sur toutes ses pages. Au lieu de les copier partout, on les place dans des fichiers séparés :

```php
<?php include ''header.php''; ?>

<main>
  <h2>Nos services</h2>
  ...
</main>

<?php include ''footer.php''; ?>
```

Si Achta change son numéro de téléphone, tu ne le modifieras qu''une fois, dans `footer.php`.

## Recevoir les données d''un formulaire

Voici un formulaire de rendez-vous. L''attribut `action` indique le fichier PHP qui recevra les données, `method="post"` la méthode HTTP utilisée :

```html
<form action="rendez-vous.php" method="post">
  <label for="nom">Votre nom</label>
  <input type="text" id="nom" name="nom" required>

  <label for="telephone">Téléphone</label>
  <input type="tel" id="telephone" name="telephone" required>

  <button type="submit">Demander un rendez-vous</button>
</form>
```

Dans `rendez-vous.php`, PHP range les données reçues dans le tableau `$_POST`, avec comme clés les attributs `name` des champs :

```php
<?php
$nom = trim($_POST[''nom''] ?? '''');
$telephone = trim($_POST[''telephone''] ?? '''');

if ($nom === '''' || strlen($telephone) < 8) {
    echo "<p>Merci de remplir correctement le formulaire.</p>";
    exit;
}
?>
<p>Merci <?= htmlspecialchars($nom) ?>, nous vous appelons au <?= htmlspecialchars($telephone) ?> pour fixer le rendez-vous.</p>
```

- `?? ''''` donne une valeur par défaut si le champ n''a pas été envoyé.
- `trim()` retire les espaces en trop au début et à la fin.
- On **revérifie** les données côté serveur, même si le HTML a l''attribut `required`.

> **Attention** : n''affiche jamais une donnée reçue d''un visiteur sans la passer dans `htmlspecialchars()`. Sinon, quelqu''un pourrait taper `<script>…</script>` dans le champ nom et exécuter du code dans la page des autres visiteurs (faille XSS). C''est la règle de sécurité numéro un du développeur PHP.

Pour un formulaire de recherche, qui ne fait que lire des données, on utilise plutôt `method="get"` : les valeurs apparaissent alors dans l''URL (`recherche.php?q=robe`) et se lisent avec `$_GET[''q'']`.

## À toi de jouer

Transforme le site Chez Achta Couture en site PHP :

1. Renomme `index.html` en `index.php` et lance ton serveur local.
2. Déplace le `<header>` dans `header.php` et le `<footer>` dans `footer.php`, puis inclus-les avec `include`.
3. Crée un tableau `$tenues` (nom et prix) et affiche-le avec une boucle `foreach`, prix formatés avec `number_format()`.
4. Ajoute le formulaire de rendez-vous et crée `rendez-vous.php`, qui vérifie les champs et affiche un message de confirmation sécurisé avec `htmlspecialchars()`.
5. Teste en tapant `<b>Test</b>` dans le champ nom : le texte doit s''afficher tel quel, sans passer en gras.

> **Pour t''auto-évaluer** : clic droit sur la page, puis **Afficher le code source**. Tu ne dois voir aucune ligne PHP, seulement du HTML. Si c''est le cas, ton serveur exécute bien PHP.

## Vérifie tes acquis

1. Le visiteur peut-il voir ton code PHP en affichant le code source de la page ?
2. Comment récupère-t-on la valeur d''un champ `<input name="ville">` envoyé en `post` ?
3. Pourquoi utiliser `htmlspecialchars()` avant d''afficher une donnée saisie ?

> **Réponses** : 1. Non, il ne reçoit que le HTML produit par PHP. 2. Avec `$_POST[''ville'']`, de préférence `$_POST[''ville''] ?? ''''`. 3. Pour neutraliser le HTML ou le JavaScript qu''un visiteur aurait saisi et éviter les failles XSS.

## En résumé

- PHP s''exécute **sur le serveur** et envoie du HTML au navigateur ; le visiteur ne voit jamais le code.
- Le code s''écrit entre `<?php` et `?>` ; les variables commencent par `$` ; on concatène avec `.`.
- `foreach` parcourt les tableaux ; `include` réutilise des morceaux de page.
- Les données des formulaires arrivent dans `$_POST` (ou `$_GET`) : toujours les vérifier côté serveur.
- Toujours afficher les données des visiteurs avec `htmlspecialchars()`.

## Pour aller plus loin

- [Le manuel officiel de PHP, en français](https://www.php.net/manual/fr/)
- Demande au mentor IA : « Explique-moi la différence entre GET et POST avec un exemple de formulaire. »'
WHERE t.slug = 'developpement-web' AND l.title = 'Premiers pas avec PHP';

-- Enregistrer des données avec MySQL et PDO (nouvelle leçon)
INSERT INTO lessons (module_id, title, summary, content, duration_minutes, position)
SELECT m.id, 'Enregistrer des données avec MySQL et PDO', 'Tables, requêtes SQL, connexion PDO et requêtes préparées contre les injections SQL.', 'Au chapitre précédent, le formulaire de rendez-vous affichait un message de confirmation… puis oubliait tout. Achta ne pouvait pas retrouver les demandes de ses clientes. Pour **garder** des informations, il faut une **base de données**. Dans ce chapitre, tu vas créer une table MySQL, y enregistrer les rendez-vous depuis PHP, puis les afficher dans une page de gestion.

> **Objectifs de ce chapitre**
> - Comprendre ce qu''est une base de données relationnelle
> - Créer une base et une table avec phpMyAdmin
> - Écrire les quatre requêtes SQL fondamentales
> - Connecter PHP à MySQL avec PDO
> - Utiliser des requêtes préparées pour se protéger des injections SQL

## Une base de données, c''est quoi ?

Imagine le grand cahier dans lequel Achta note ses commandes : une ligne par cliente, avec des colonnes pour le nom, le téléphone, le modèle et la date. Une base de données **relationnelle** comme MySQL range les informations exactement ainsi, dans des **tables** :

| id | nom | telephone | modele | cree_le |
| --- | --- | --- | --- | --- |
| 1 | Halimé Mahamat | 66 12 34 56 | Robe en bazin | 2026-10-02 09:14 |
| 2 | Awa Djibrine | 99 87 65 43 | Boubou brodé | 2026-10-03 16:40 |

- Une **table** regroupe des données de même nature (les rendez-vous, les clientes, les produits…).
- Chaque **colonne** a un nom et un type (texte, nombre, date).
- Chaque **ligne** est un enregistrement.
- La colonne `id` est la **clé primaire** : un numéro unique attribué automatiquement à chaque ligne.

Pour parler à la base, on utilise le langage **SQL** (*Structured Query Language*).

## Créer la base et la table

Avec XAMPP, démarre **MySQL** dans le panneau, puis ouvre `http://localhost/phpmyadmin`. Chez un hébergeur comme LWS, phpMyAdmin est accessible depuis ton espace client.

1. Clique sur **Nouvelle base de données**, nomme-la `chez_achta` et choisis l''interclassement `utf8mb4_unicode_ci` (pour gérer correctement les accents et les emojis).
2. Ouvre l''onglet **SQL** et exécute cette requête :

```sql
CREATE TABLE rendez_vous (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    telephone VARCHAR(20) NOT NULL,
    modele VARCHAR(100) NULL,
    cree_le DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```

- `INT UNSIGNED AUTO_INCREMENT` : un nombre entier positif qui augmente tout seul.
- `VARCHAR(100)` : du texte de 100 caractères maximum.
- `NOT NULL` : la colonne est obligatoire.
- `DEFAULT CURRENT_TIMESTAMP` : la date et l''heure sont remplies automatiquement.

## Les quatre requêtes SQL fondamentales

On les appelle souvent **CRUD** : *Create, Read, Update, Delete*.

```sql
-- Ajouter une ligne (Create)
INSERT INTO rendez_vous (nom, telephone, modele) VALUES (''Halimé Mahamat'', ''66123456'', ''Robe en bazin'');

-- Lire des lignes (Read)
SELECT nom, telephone FROM rendez_vous WHERE modele = ''Robe en bazin'' ORDER BY cree_le DESC;

-- Modifier une ligne (Update)
UPDATE rendez_vous SET telephone = ''66000000'' WHERE id = 1;

-- Supprimer une ligne (Delete)
DELETE FROM rendez_vous WHERE id = 1;
```

> **Attention** : un `UPDATE` ou un `DELETE` sans `WHERE` s''applique à **toutes** les lignes de la table. Relis toujours ta clause `WHERE` avant d''exécuter ces requêtes. Et fais des sauvegardes régulières (onglet **Exporter** de phpMyAdmin).

Essaie ces requêtes dans l''onglet SQL de phpMyAdmin avant de passer à la suite.

## Connecter PHP à MySQL avec PDO

**PDO** (*PHP Data Objects*) est l''outil intégré à PHP pour dialoguer avec une base de données. Crée un fichier `db.php` qui ouvre la connexion :

```php
<?php
$pdo = new PDO(
    ''mysql:host=localhost;dbname=chez_achta;charset=utf8mb4'',
    ''root'',   // utilisateur (XAMPP : root)
    '''',       // mot de passe (XAMPP : vide par défaut)
    [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]
);
```

- La première chaîne (le **DSN**) indique le type de base, le serveur, le nom de la base et l''encodage.
- `ERRMODE_EXCEPTION` fait apparaître clairement les erreurs SQL au lieu de les ignorer en silence.
- `FETCH_ASSOC` renvoie chaque ligne sous forme de tableau associatif : `$ligne[''nom'']`.

> **Info** : en ligne, ton hébergeur te donne un nom d''utilisateur et un mot de passe spécifiques. Ne mets jamais ce fichier dans un dépôt Git public.

## Enregistrer un rendez-vous : les requêtes préparées

Voici la règle d''or : **ne colle jamais une donnée envoyée par un visiteur directement dans une requête SQL.** Imagine ce code dangereux :

```php
// NE JAMAIS FAIRE ÇA
$pdo->query("SELECT * FROM rendez_vous WHERE nom = ''" . $_POST[''nom''] . "''");
```

Un visiteur malveillant pourrait taper dans le champ nom un morceau de SQL, comme `'' OR ''1''=''1`, et modifier le sens de ta requête pour lire ou effacer toute la table. C''est l''**injection SQL**, l''une des attaques les plus courantes au monde.

La solution : les **requêtes préparées**. On écrit la requête avec des marqueurs `?`, puis on envoie les valeurs séparément. La base sait alors que ce sont des données, jamais du code :

```php
<?php
require ''db.php'';

$nom = trim($_POST[''nom''] ?? '''');
$telephone = trim($_POST[''telephone''] ?? '''');
$modele = trim($_POST[''modele''] ?? '''');

if ($nom === '''' || strlen($telephone) < 8) {
    exit(''Merci de remplir correctement le formulaire.'');
}

$requete = $pdo->prepare(''INSERT INTO rendez_vous (nom, telephone, modele) VALUES (?, ?, ?)'');
$requete->execute([$nom, $telephone, $modele]);
?>
<p>Merci <?= htmlspecialchars($nom) ?>, votre demande est enregistrée. Nous vous appelons très vite !</p>
```

`prepare()` envoie le modèle de requête, `execute()` y injecte les valeurs en toute sécurité, dans l''ordre des `?`.

## Afficher les rendez-vous

Crée une page `admin-rendez-vous.php` pour Achta :

```php
<?php
require ''db.php'';

$rendezVous = $pdo->query(''SELECT * FROM rendez_vous ORDER BY cree_le DESC'')->fetchAll();
?>
<h1>Demandes de rendez-vous (<?= count($rendezVous) ?>)</h1>
<table>
  <tr><th>Date</th><th>Nom</th><th>Téléphone</th><th>Modèle</th></tr>
  <?php foreach ($rendezVous as $rdv): ?>
    <tr>
      <td><?= date(''d/m/Y H:i'', strtotime($rdv[''cree_le''])) ?></td>
      <td><?= htmlspecialchars($rdv[''nom'']) ?></td>
      <td><?= htmlspecialchars($rdv[''telephone'']) ?></td>
      <td><?= htmlspecialchars($rdv[''modele''] ?? '''') ?></td>
    </tr>
  <?php endforeach; ?>
</table>
```

- `query()` suffit ici car la requête ne contient aucune donnée venant d''un visiteur.
- `fetchAll()` récupère toutes les lignes dans un tableau.
- On utilise encore `htmlspecialchars()` à l''affichage : ces données ont été saisies par des visiteurs.

Pour lire **une** ligne précise, par exemple depuis l''URL `rendez-vous-detail.php?id=3`, on reprend une requête préparée et `fetch()` :

```php
$requete = $pdo->prepare(''SELECT * FROM rendez_vous WHERE id = ?'');
$requete->execute([(int) ($_GET[''id''] ?? 0)]);
$rdv = $requete->fetch(); // false si aucune ligne ne correspond
```

> **Attention** : en vrai, une page comme `admin-rendez-vous.php` doit être protégée par un mot de passe, sinon n''importe qui pourrait lire les numéros de téléphone des clientes. Tu apprendras à gérer les connexions avec les sessions PHP dans la suite du parcours.

## À toi de jouer

1. Crée la base `chez_achta` et la table `rendez_vous` dans phpMyAdmin.
2. Crée `db.php` avec ta connexion PDO.
3. Modifie `rendez-vous.php` du chapitre précédent pour enregistrer chaque demande avec une requête préparée. Ajoute au formulaire une liste déroulante `modele`.
4. Crée `admin-rendez-vous.php` qui affiche toutes les demandes, de la plus récente à la plus ancienne.
5. Bonus : ajoute sur chaque ligne un lien « Appeler » (`tel:`) et un lien « WhatsApp » (`https://wa.me/235…`) construits à partir du numéro.
6. Test de sécurité : envoie le formulaire avec le nom `Test'' OR ''1''=''1`. La demande doit s''enregistrer telle quelle, sans erreur, et s''afficher comme un nom normal.

> **Pour t''auto-évaluer** : envoie trois demandes depuis le formulaire, puis vérifie qu''elles apparaissent à la fois dans phpMyAdmin (onglet **Afficher** de la table) et dans ta page d''administration.

## Vérifie tes acquis

1. Que se passe-t-il si tu exécutes `DELETE FROM rendez_vous;` sans `WHERE` ?
2. Pourquoi utilise-t-on `prepare()` et `execute()` plutôt que de construire la requête avec `.` ?
3. Quelle méthode PDO récupère toutes les lignes d''un résultat ?

> **Réponses** : 1. Toutes les lignes de la table sont supprimées. 2. Pour séparer le code SQL des données et empêcher les injections SQL. 3. `fetchAll()` (et `fetch()` pour une seule ligne).

## En résumé

- Une base de données relationnelle range les informations dans des **tables** (colonnes + lignes) ; la **clé primaire** identifie chaque ligne.
- Les quatre requêtes SQL de base : `INSERT`, `SELECT`, `UPDATE`, `DELETE`. Jamais d''`UPDATE` ou de `DELETE` sans `WHERE`.
- **PDO** connecte PHP à MySQL ; active `ERRMODE_EXCEPTION` et `FETCH_ASSOC`.
- Toute donnée venant d''un visiteur passe par une **requête préparée** (`prepare` + `execute`).
- À l''affichage, on protège toujours les données avec `htmlspecialchars()`.

## Pour aller plus loin

- [La documentation PDO du manuel PHP, en français](https://www.php.net/manual/fr/book.pdo.php)
- Demande au mentor IA : « Comment ajouter un statut "confirmé / annulé" à mes rendez-vous et le modifier depuis la page d''administration ? »', 40, 2
FROM modules m
JOIN tracks t ON t.id = m.track_id
WHERE t.slug = 'developpement-web' AND m.title = 'Back-end avec PHP & MySQL'
  AND NOT EXISTS (SELECT 1 FROM lessons l2 WHERE l2.module_id = m.id AND l2.title = 'Enregistrer des données avec MySQL et PDO')
LIMIT 1;
