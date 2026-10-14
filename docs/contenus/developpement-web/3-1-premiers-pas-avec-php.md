Jusqu'ici, tout ton code s'exécutait dans le navigateur du visiteur. Mais certaines choses ne peuvent se faire que sur le **serveur** : enregistrer une commande, envoyer un e-mail, vérifier un mot de passe, afficher les données d'un compte. C'est le rôle du **back-end**, et c'est là qu'intervient **PHP**.

PHP fait tourner environ trois quarts des sites web dont on connaît le langage serveur, dont tous les sites WordPress. C'est aussi le langage de la plateforme IgoTech IA sur laquelle tu apprends en ce moment !

> **Objectifs de ce chapitre**
> - Comprendre comment PHP génère une page côté serveur
> - Installer un serveur local et exécuter ton premier script
> - Utiliser les variables, tableaux, conditions et boucles en PHP
> - Découper un site avec `include`
> - Recevoir et afficher les données d'un formulaire en toute sécurité

## Comment fonctionne PHP ?

Souviens-toi du premier chapitre : le navigateur envoie une requête, le serveur renvoie du HTML. Avec une page `.php`, le serveur fait une étape de plus :

1. Le visiteur demande `contact.php`.
2. Le serveur repère l'extension `.php` et confie le fichier à l'interpréteur PHP.
3. PHP exécute le code et produit du HTML.
4. Le serveur envoie **uniquement ce HTML** au navigateur.

Le visiteur ne voit donc jamais ton code PHP, seulement son résultat. C'est pour ça qu'on peut y placer des mots de passe de base de données sans qu'ils soient visibles.

## Installer un serveur local

Pour exécuter du PHP, il faut un serveur. Sur ton ordinateur, deux solutions gratuites :

- **XAMPP** (Windows, Mac, Linux) : installe Apache, PHP et MySQL en une fois. Lance le panneau XAMPP, démarre **Apache**, puis place tes fichiers dans le dossier `htdocs`. Ton site est visible à l'adresse `http://localhost`.
- **Le serveur intégré de PHP**, si PHP est déjà installé : ouvre un terminal dans ton dossier et tape la commande ci-dessous, puis ouvre `http://localhost:8000`.

```bash
php -S localhost:8000
```

> **Info** : un hébergeur comme LWS fournit aussi PHP et MySQL. Tu pourras y mettre ton site en ligne une fois qu'il fonctionnera en local.

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
  <p>Nous sommes le <?php echo date('d/m/Y'); ?>.</p>
</body>
</html>
```

Le code PHP s'écrit entre `<?php` et `?>`. Ici, `echo` affiche la date du jour, calculée par le serveur au moment de la requête. Recharge la page demain : la date aura changé sans que tu modifies le fichier.

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
    <?= $tenue['nom'] ?> : <?= number_format($tenue['prix'], 0, ',', ' ') ?> FCFA
    <?php if ($tenue['prix'] > 20000): ?>
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
<?php include 'header.php'; ?>

<main>
  <h2>Nos services</h2>
  ...
</main>

<?php include 'footer.php'; ?>
```

Si Achta change son numéro de téléphone, tu ne le modifieras qu'une fois, dans `footer.php`.

## Recevoir les données d'un formulaire

Voici un formulaire de rendez-vous. L'attribut `action` indique le fichier PHP qui recevra les données, `method="post"` la méthode HTTP utilisée :

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
$nom = trim($_POST['nom'] ?? '');
$telephone = trim($_POST['telephone'] ?? '');

if ($nom === '' || strlen($telephone) < 8) {
    echo "<p>Merci de remplir correctement le formulaire.</p>";
    exit;
}
?>
<p>Merci <?= htmlspecialchars($nom) ?>, nous vous appelons au <?= htmlspecialchars($telephone) ?> pour fixer le rendez-vous.</p>
```

- `?? ''` donne une valeur par défaut si le champ n'a pas été envoyé.
- `trim()` retire les espaces en trop au début et à la fin.
- On **revérifie** les données côté serveur, même si le HTML a l'attribut `required`.

> **Attention** : n'affiche jamais une donnée reçue d'un visiteur sans la passer dans `htmlspecialchars()`. Sinon, quelqu'un pourrait taper `<script>…</script>` dans le champ nom et exécuter du code dans la page des autres visiteurs (faille XSS). C'est la règle de sécurité numéro un du développeur PHP.

Pour un formulaire de recherche, qui ne fait que lire des données, on utilise plutôt `method="get"` : les valeurs apparaissent alors dans l'URL (`recherche.php?q=robe`) et se lisent avec `$_GET['q']`.

## À toi de jouer

Transforme le site Chez Achta Couture en site PHP :

1. Renomme `index.html` en `index.php` et lance ton serveur local.
2. Déplace le `<header>` dans `header.php` et le `<footer>` dans `footer.php`, puis inclus-les avec `include`.
3. Crée un tableau `$tenues` (nom et prix) et affiche-le avec une boucle `foreach`, prix formatés avec `number_format()`.
4. Ajoute le formulaire de rendez-vous et crée `rendez-vous.php`, qui vérifie les champs et affiche un message de confirmation sécurisé avec `htmlspecialchars()`.
5. Teste en tapant `<b>Test</b>` dans le champ nom : le texte doit s'afficher tel quel, sans passer en gras.

> **Pour t'auto-évaluer** : clic droit sur la page, puis **Afficher le code source**. Tu ne dois voir aucune ligne PHP, seulement du HTML. Si c'est le cas, ton serveur exécute bien PHP.

## Vérifie tes acquis

1. Le visiteur peut-il voir ton code PHP en affichant le code source de la page ?
2. Comment récupère-t-on la valeur d'un champ `<input name="ville">` envoyé en `post` ?
3. Pourquoi utiliser `htmlspecialchars()` avant d'afficher une donnée saisie ?

> **Réponses** : 1. Non, il ne reçoit que le HTML produit par PHP. 2. Avec `$_POST['ville']`, de préférence `$_POST['ville'] ?? ''`. 3. Pour neutraliser le HTML ou le JavaScript qu'un visiteur aurait saisi et éviter les failles XSS.

## En résumé

- PHP s'exécute **sur le serveur** et envoie du HTML au navigateur ; le visiteur ne voit jamais le code.
- Le code s'écrit entre `<?php` et `?>` ; les variables commencent par `$` ; on concatène avec `.`.
- `foreach` parcourt les tableaux ; `include` réutilise des morceaux de page.
- Les données des formulaires arrivent dans `$_POST` (ou `$_GET`) : toujours les vérifier côté serveur.
- Toujours afficher les données des visiteurs avec `htmlspecialchars()`.

## Pour aller plus loin

- [Le manuel officiel de PHP, en français](https://www.php.net/manual/fr/)
- Demande au mentor IA : « Explique-moi la différence entre GET et POST avec un exemple de formulaire. »
