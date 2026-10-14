Au chapitre précédent, le formulaire de rendez-vous affichait un message de confirmation… puis oubliait tout. Achta ne pouvait pas retrouver les demandes de ses clientes. Pour **garder** des informations, il faut une **base de données**. Dans ce chapitre, tu vas créer une table MySQL, y enregistrer les rendez-vous depuis PHP, puis les afficher dans une page de gestion.

> **Objectifs de ce chapitre**
> - Comprendre ce qu'est une base de données relationnelle
> - Créer une base et une table avec phpMyAdmin
> - Écrire les quatre requêtes SQL fondamentales
> - Connecter PHP à MySQL avec PDO
> - Utiliser des requêtes préparées pour se protéger des injections SQL

## Une base de données, c'est quoi ?

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

1. Clique sur **Nouvelle base de données**, nomme-la `chez_achta` et choisis l'interclassement `utf8mb4_unicode_ci` (pour gérer correctement les accents et les emojis).
2. Ouvre l'onglet **SQL** et exécute cette requête :

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
- `DEFAULT CURRENT_TIMESTAMP` : la date et l'heure sont remplies automatiquement.

## Les quatre requêtes SQL fondamentales

On les appelle souvent **CRUD** : *Create, Read, Update, Delete*.

```sql
-- Ajouter une ligne (Create)
INSERT INTO rendez_vous (nom, telephone, modele) VALUES ('Halimé Mahamat', '66123456', 'Robe en bazin');

-- Lire des lignes (Read)
SELECT nom, telephone FROM rendez_vous WHERE modele = 'Robe en bazin' ORDER BY cree_le DESC;

-- Modifier une ligne (Update)
UPDATE rendez_vous SET telephone = '66000000' WHERE id = 1;

-- Supprimer une ligne (Delete)
DELETE FROM rendez_vous WHERE id = 1;
```

> **Attention** : un `UPDATE` ou un `DELETE` sans `WHERE` s'applique à **toutes** les lignes de la table. Relis toujours ta clause `WHERE` avant d'exécuter ces requêtes. Et fais des sauvegardes régulières (onglet **Exporter** de phpMyAdmin).

Essaie ces requêtes dans l'onglet SQL de phpMyAdmin avant de passer à la suite.

## Connecter PHP à MySQL avec PDO

**PDO** (*PHP Data Objects*) est l'outil intégré à PHP pour dialoguer avec une base de données. Crée un fichier `db.php` qui ouvre la connexion :

```php
<?php
$pdo = new PDO(
    'mysql:host=localhost;dbname=chez_achta;charset=utf8mb4',
    'root',   // utilisateur (XAMPP : root)
    '',       // mot de passe (XAMPP : vide par défaut)
    [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]
);
```

- La première chaîne (le **DSN**) indique le type de base, le serveur, le nom de la base et l'encodage.
- `ERRMODE_EXCEPTION` fait apparaître clairement les erreurs SQL au lieu de les ignorer en silence.
- `FETCH_ASSOC` renvoie chaque ligne sous forme de tableau associatif : `$ligne['nom']`.

> **Info** : en ligne, ton hébergeur te donne un nom d'utilisateur et un mot de passe spécifiques. Ne mets jamais ce fichier dans un dépôt Git public.

## Enregistrer un rendez-vous : les requêtes préparées

Voici la règle d'or : **ne colle jamais une donnée envoyée par un visiteur directement dans une requête SQL.** Imagine ce code dangereux :

```php
// NE JAMAIS FAIRE ÇA
$pdo->query("SELECT * FROM rendez_vous WHERE nom = '" . $_POST['nom'] . "'");
```

Un visiteur malveillant pourrait taper dans le champ nom un morceau de SQL, comme `' OR '1'='1`, et modifier le sens de ta requête pour lire ou effacer toute la table. C'est l'**injection SQL**, l'une des attaques les plus courantes au monde.

La solution : les **requêtes préparées**. On écrit la requête avec des marqueurs `?`, puis on envoie les valeurs séparément. La base sait alors que ce sont des données, jamais du code :

```php
<?php
require 'db.php';

$nom = trim($_POST['nom'] ?? '');
$telephone = trim($_POST['telephone'] ?? '');
$modele = trim($_POST['modele'] ?? '');

if ($nom === '' || strlen($telephone) < 8) {
    exit('Merci de remplir correctement le formulaire.');
}

$requete = $pdo->prepare('INSERT INTO rendez_vous (nom, telephone, modele) VALUES (?, ?, ?)');
$requete->execute([$nom, $telephone, $modele]);
?>
<p>Merci <?= htmlspecialchars($nom) ?>, votre demande est enregistrée. Nous vous appelons très vite !</p>
```

`prepare()` envoie le modèle de requête, `execute()` y injecte les valeurs en toute sécurité, dans l'ordre des `?`.

## Afficher les rendez-vous

Crée une page `admin-rendez-vous.php` pour Achta :

```php
<?php
require 'db.php';

$rendezVous = $pdo->query('SELECT * FROM rendez_vous ORDER BY cree_le DESC')->fetchAll();
?>
<h1>Demandes de rendez-vous (<?= count($rendezVous) ?>)</h1>
<table>
  <tr><th>Date</th><th>Nom</th><th>Téléphone</th><th>Modèle</th></tr>
  <?php foreach ($rendezVous as $rdv): ?>
    <tr>
      <td><?= date('d/m/Y H:i', strtotime($rdv['cree_le'])) ?></td>
      <td><?= htmlspecialchars($rdv['nom']) ?></td>
      <td><?= htmlspecialchars($rdv['telephone']) ?></td>
      <td><?= htmlspecialchars($rdv['modele'] ?? '') ?></td>
    </tr>
  <?php endforeach; ?>
</table>
```

- `query()` suffit ici car la requête ne contient aucune donnée venant d'un visiteur.
- `fetchAll()` récupère toutes les lignes dans un tableau.
- On utilise encore `htmlspecialchars()` à l'affichage : ces données ont été saisies par des visiteurs.

Pour lire **une** ligne précise, par exemple depuis l'URL `rendez-vous-detail.php?id=3`, on reprend une requête préparée et `fetch()` :

```php
$requete = $pdo->prepare('SELECT * FROM rendez_vous WHERE id = ?');
$requete->execute([(int) ($_GET['id'] ?? 0)]);
$rdv = $requete->fetch(); // false si aucune ligne ne correspond
```

> **Attention** : en vrai, une page comme `admin-rendez-vous.php` doit être protégée par un mot de passe, sinon n'importe qui pourrait lire les numéros de téléphone des clientes. Tu apprendras à gérer les connexions avec les sessions PHP dans la suite du parcours.

## À toi de jouer

1. Crée la base `chez_achta` et la table `rendez_vous` dans phpMyAdmin.
2. Crée `db.php` avec ta connexion PDO.
3. Modifie `rendez-vous.php` du chapitre précédent pour enregistrer chaque demande avec une requête préparée. Ajoute au formulaire une liste déroulante `modele`.
4. Crée `admin-rendez-vous.php` qui affiche toutes les demandes, de la plus récente à la plus ancienne.
5. Bonus : ajoute sur chaque ligne un lien « Appeler » (`tel:`) et un lien « WhatsApp » (`https://wa.me/235…`) construits à partir du numéro.
6. Test de sécurité : envoie le formulaire avec le nom `Test' OR '1'='1`. La demande doit s'enregistrer telle quelle, sans erreur, et s'afficher comme un nom normal.

> **Pour t'auto-évaluer** : envoie trois demandes depuis le formulaire, puis vérifie qu'elles apparaissent à la fois dans phpMyAdmin (onglet **Afficher** de la table) et dans ta page d'administration.

## Vérifie tes acquis

1. Que se passe-t-il si tu exécutes `DELETE FROM rendez_vous;` sans `WHERE` ?
2. Pourquoi utilise-t-on `prepare()` et `execute()` plutôt que de construire la requête avec `.` ?
3. Quelle méthode PDO récupère toutes les lignes d'un résultat ?

> **Réponses** : 1. Toutes les lignes de la table sont supprimées. 2. Pour séparer le code SQL des données et empêcher les injections SQL. 3. `fetchAll()` (et `fetch()` pour une seule ligne).

## En résumé

- Une base de données relationnelle range les informations dans des **tables** (colonnes + lignes) ; la **clé primaire** identifie chaque ligne.
- Les quatre requêtes SQL de base : `INSERT`, `SELECT`, `UPDATE`, `DELETE`. Jamais d'`UPDATE` ou de `DELETE` sans `WHERE`.
- **PDO** connecte PHP à MySQL ; active `ERRMODE_EXCEPTION` et `FETCH_ASSOC`.
- Toute donnée venant d'un visiteur passe par une **requête préparée** (`prepare` + `execute`).
- À l'affichage, on protège toujours les données avec `htmlspecialchars()`.

## Pour aller plus loin

- [La documentation PDO du manuel PHP, en français](https://www.php.net/manual/fr/book.pdo.php)
- Demande au mentor IA : « Comment ajouter un statut "confirmé / annulé" à mes rendez-vous et le modifier depuis la page d'administration ? »
