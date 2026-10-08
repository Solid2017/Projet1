Excel est très pratique jusqu'à quelques milliers de lignes. Au-delà, ou quand il faut refaire la même analyse chaque mois, on passe à **Python** et à sa bibliothèque **pandas**. Dans ce chapitre, tu vas charger le fichier de ventes de Moussa, le nettoyer et en tirer tes premiers chiffres.

> **Objectifs de ce chapitre**
> - Utiliser Python dans Google Colab sans rien installer
> - Charger un fichier CSV dans un DataFrame pandas
> - Explorer, filtrer et trier des données
> - Nettoyer les valeurs manquantes et les incohérences
> - Calculer des totaux par catégorie

## Ton environnement : Google Colab

Pas besoin d'un ordinateur puissant : **Google Colab** (colab.research.google.com) permet d'écrire et d'exécuter du Python dans le navigateur, gratuitement, avec un compte Google. Le code s'écrit dans des **cellules** que l'on exécute avec **Maj+Entrée**.

> **Astuce** : Colab fonctionne aussi sur tablette. Pour économiser ta connexion, prépare ton code hors ligne et ouvre Colab seulement pour l'exécuter.

## Le fichier de départ

Crée un fichier `ventes.csv` (un fichier texte où les colonnes sont séparées par des virgules) :

```text
date,article,categorie,quantite,prix_unitaire
2026-03-01,Chargeur USB-C,accessoire,2,2500
2026-03-01,Credit Airtel,credit,5,1000
2026-03-02,Ecouteurs,accessoire,1,3500
2026-03-02,chargeur usb-c,accessoire,1,2500
2026-03-03,Credit Moov,credit,3,
2026-03-03,Coque Tecno,accessoire,1,2000
```

Dans Colab, clique sur l'icône de dossier à gauche, puis importe ce fichier.

## Charger et explorer les données

```python
import pandas as pd

ventes = pd.read_csv("ventes.csv")
print(ventes.head())      # les 5 premières lignes
print(ventes.shape)       # (nombre de lignes, nombre de colonnes)
ventes.info()             # types de colonnes et valeurs manquantes
```

Un **DataFrame** est un tableau : chaque colonne a un nom et un type. `info()` te montre par exemple que `prix_unitaire` contient 5 valeurs au lieu de 6 : il y a une case vide.

Les commandes d'exploration indispensables :

| Commande | Ce qu'elle fait |
| --- | --- |
| `ventes["article"]` | Sélectionne une colonne |
| `ventes.describe()` | Statistiques des colonnes numériques (moyenne, min, max…) |
| `ventes["categorie"].value_counts()` | Compte les lignes par catégorie |
| `ventes.isna().sum()` | Compte les valeurs manquantes par colonne |

## Filtrer et trier

```python
# Seulement les accessoires
accessoires = ventes[ventes["categorie"] == "accessoire"]

# Les ventes de 2 articles ou plus
grosses = ventes[ventes["quantite"] >= 2]

# Trier du plus cher au moins cher
ventes.sort_values("prix_unitaire", ascending=False)
```

La condition entre crochets renvoie une colonne de `True` / `False` ; pandas ne garde que les lignes où c'est vrai.

## Nettoyer les données

### Harmoniser le texte

« Chargeur USB-C » et « chargeur usb-c » sont le même article. On met tout en minuscules et on retire les espaces superflus :

```python
ventes["article"] = ventes["article"].str.lower().str.strip()
```

### Gérer les valeurs manquantes

Le prix du crédit Moov est manquant. Plusieurs options : supprimer la ligne, ou la remplir avec une valeur connue. Ici, on sait que le crédit est vendu à 1 000 FCFA l'unité :

```python
ventes["prix_unitaire"] = ventes["prix_unitaire"].fillna(1000)
```

Pour supprimer les lignes incomplètes à la place : `ventes = ventes.dropna()`.

> **Attention** : ne remplis jamais une valeur manquante « au hasard » ou avec la moyenne sans réfléchir. Note toujours tes choix de nettoyage : quelqu'un te demandera pourquoi les chiffres ont changé.

### Convertir les dates

```python
ventes["date"] = pd.to_datetime(ventes["date"])
ventes["jour"] = ventes["date"].dt.day_name()
```

## Calculer des indicateurs

On crée une colonne de chiffre d'affaires, puis on regroupe :

```python
ventes["montant"] = ventes["quantite"] * ventes["prix_unitaire"]

print(ventes["montant"].sum())                         # chiffre d'affaires total
print(ventes.groupby("categorie")["montant"].sum())    # par catégorie
print(ventes.groupby("article")["quantite"].sum().sort_values(ascending=False))
```

`groupby` est l'équivalent pandas du tableau croisé dynamique d'Excel : il regroupe les lignes qui ont la même valeur et applique un calcul (somme, moyenne, comptage).

## Un premier graphique

```python
ventes.groupby("categorie")["montant"].sum().plot(kind="bar", title="Chiffre d'affaires par catégorie")
```

Un graphique simple vaut souvent mieux qu'un long tableau pour convaincre Moussa.

## À toi de jouer

1. Charge `ventes.csv` dans Colab et affiche son nombre de lignes.
2. Harmonise la colonne `article` et remplis le prix manquant.
3. Crée la colonne `montant`, puis calcule le chiffre d'affaires total.
4. Affiche l'article le plus vendu en quantité.
5. Bonus : ajoute 10 lignes de ventes inventées sur une semaine complète et trouve le jour de la semaine le plus rentable.

> **Correction des étapes 3 et 4** : le total vaut 5 000 + 5 000 + 3 500 + 2 500 + 3 000 + 2 000 = 21 000 FCFA. L'article le plus vendu en quantité est le crédit Airtel (5 unités).

## Vérifie tes acquis

1. Quelle commande affiche le nombre de valeurs manquantes par colonne ?
2. À quoi sert `groupby` ?
3. Pourquoi mettre la colonne `article` en minuscules ?

> **Réponses** : 1. `ventes.isna().sum()`. 2. À regrouper les lignes partageant une même valeur pour calculer une somme, une moyenne ou un comptage par groupe. 3. Pour que les variantes d'écriture d'un même article soient comptées ensemble.

## En résumé

- **pandas** charge un fichier CSV dans un **DataFrame** avec `pd.read_csv()`.
- `head()`, `info()`, `describe()` et `value_counts()` servent à explorer.
- On filtre avec une condition entre crochets et on trie avec `sort_values()`.
- Nettoyer = harmoniser le texte, traiter les valeurs manquantes, convertir les dates.
- `groupby()` calcule des indicateurs par catégorie ; `.plot()` les visualise.

## Pour aller plus loin

- [Le tutoriel officiel de Python, en français](https://docs.python.org/fr/3/tutorial/)
- Demande au mentor IA : « Donne-moi un fichier CSV d'exemple sur les ventes d'une pharmacie et trois questions à résoudre avec pandas. »
