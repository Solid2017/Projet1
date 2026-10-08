-- IgoTech IA — contenus détaillés des 17 parcours (68 leçons réécrites).
-- Le parcours « Développement Web Full-Stack » est dans un fichier à part :
-- migration_contenus_dev_web.sql.
--
-- À importer via phpMyAdmin (onglet Importer). Les leçons sont retrouvées
-- par le slug du parcours et le titre exact de la leçon : aucun ID en dur.
-- Ré-importable sans risque (les leçons sont simplement mises à jour).
-- Si tu as renommé une leçon depuis l'administration, elle ne sera pas
-- trouvée : copie alors son contenu depuis docs/contenus/<parcours>/.

SET NAMES utf8mb4;


-- =====================================================================
-- Data & Intelligence Artificielle (data-ia)
-- =====================================================================
UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'De la donnée à la décision : le cycle d''un projet data, les types de données et les métiers.', l.duration_minutes = 25, l.content = 'Chaque fois que tu achètes du crédit, que tu payes par Mobile Money ou que tu likes une publication, tu produis des **données**. Les entreprises, les ONG et les administrations en accumulent des millions. La **data science** est le métier qui transforme ces données brutes en décisions : quel produit commander, quelle région aider en priorité, quel client risque de partir.

Dans ce parcours, tu suivras **Moussa**, qui tient une boutique de recharges et d''accessoires téléphoniques au marché de Dembé à N''Djamena. Il note ses ventes depuis un an et voudrait savoir quoi en faire.

> **Objectifs de ce chapitre**
> - Définir la data science et ses grandes étapes
> - Distinguer donnée, information et décision
> - Connaître les métiers de la donnée
> - Reconnaître les types de données et les problèmes de qualité

## De la donnée à la décision

Une **donnée** est un fait brut : « 12/03, chargeur USB-C, 2 500 FCFA ». Seule, elle ne dit pas grand-chose. En regroupant des milliers de données, on obtient une **information** : « les chargeurs se vendent surtout en début de mois ». Cette information mène à une **décision** : « je commande mon stock de chargeurs le 25 de chaque mois ».

La data science est l''ensemble des méthodes (statistiques, programmation, visualisation) qui permettent de passer de la donnée à la décision.

## Le cycle d''un projet data

Un projet data suit presque toujours les mêmes étapes :

1. **Poser la question** : que veut-on savoir ou prédire ? Par exemple : « Quels jours dois-je avoir plus de stock ? »
2. **Collecter les données** : cahier de ventes, fichier Excel, export d''une application, enquête terrain.
3. **Nettoyer les données** : corriger les fautes de saisie, retirer les doublons, gérer les cases vides. C''est souvent 60 à 80 % du travail.
4. **Explorer et visualiser** : calculer des moyennes, tracer des graphiques, repérer des tendances.
5. **Modéliser** : construire un modèle statistique ou de machine learning si la question l''exige.
6. **Communiquer** : présenter les résultats simplement à ceux qui décident.

> **Attention** : l''étape la plus souvent négligée est la première. Une analyse brillante qui répond à une mauvaise question ne sert à rien. Prends toujours le temps de reformuler la question avec la personne qui la pose.

## Les types de données

| Type | Exemple chez Moussa | Ce qu''on peut calculer |
| --- | --- | --- |
| Numérique continu | Montant d''une vente : 2 500 FCFA | Moyenne, somme, écart |
| Numérique discret | Nombre d''articles vendus : 3 | Somme, moyenne |
| Catégoriel | Catégorie : « chargeur », « écouteurs », « crédit » | Comptage, pourcentage |
| Date / heure | 12/03/2026 à 17 h 40 | Tendances par jour, mois, heure |
| Texte libre | « Client demande iPhone 15 » | Analyse de mots-clés |

On distingue aussi les données **structurées** (rangées en lignes et colonnes, comme un tableau Excel) et **non structurées** (photos, messages vocaux WhatsApp, textes). Ce parcours se concentre sur les données structurées, les plus courantes en entreprise.

## La qualité des données

Dans le cahier de Moussa, on trouve des lignes comme celles-ci :

| date | article | prix |
| --- | --- | --- |
| 12/03/2026 | Chargeur USB-C | 2500 |
| 12/03/2026 | chargeur usb c | 2 500 F |
| 13/03 | Ecouteurs | |
| 2026-03-14 | Credit Airtel | 1000 |

On y voit les problèmes classiques :

- **Incohérences** : le même article écrit de deux façons différentes.
- **Formats différents** : des dates et des prix écrits de plusieurs manières.
- **Valeurs manquantes** : un prix absent.
- **Doublons possibles** : deux ventes identiques le même jour, erreur ou vraie double vente ?

> **Info** : on dit en anglais *garbage in, garbage out* : des données de mauvaise qualité donnent des conclusions fausses, quel que soit le talent de l''analyste.

## Les métiers de la donnée

- **Data analyst** : nettoie, analyse et visualise les données pour répondre à des questions concrètes. C''est le métier le plus accessible pour commencer.
- **Data scientist** : construit des modèles prédictifs avec le machine learning.
- **Data engineer** : construit les « tuyaux » qui collectent et stockent les données de façon fiable.
- **Chargé de suivi-évaluation** : très recherché dans les ONG au Tchad, il analyse les données des projets pour mesurer leur impact.

Les outils de base sont les mêmes pour tous : un **tableur** (Excel, Google Sheets), le langage **Python** et ses bibliothèques, et le langage **SQL** pour interroger les bases de données.

## À toi de jouer

Moussa te confie ce besoin : « Je veux gagner plus d''argent avec ma boutique. »

1. Reformule ce besoin en **trois questions précises** auxquelles les données peuvent répondre.
2. Pour chaque question, liste les **colonnes** dont tu aurais besoin dans le fichier de ventes.
3. Repère au moins **trois problèmes de qualité** dans le tableau ci-dessus et propose une règle de saisie pour chacun.

> **Exemple de réponse** : « Quels sont les 5 articles qui rapportent le plus de bénéfice ? » (colonnes : article, prix de vente, prix d''achat, quantité). « Quels jours de la semaine vend-on le plus ? » (date, montant). « Quels articles sont demandés mais pas en stock ? » (texte des demandes clients). Règles de saisie : une liste fixe de noms d''articles, des dates au format JJ/MM/AAAA, des prix en chiffres sans « F ».

## Vérifie tes acquis

1. Quelle est généralement l''étape la plus longue d''un projet data ?
2. « Écouteurs », « chargeur », « crédit » : quel type de données ?
3. Quelle est la différence entre un data analyst et un data engineer ?

> **Réponses** : 1. Le nettoyage des données. 2. Des données catégorielles. 3. Le data analyst exploite les données pour répondre à des questions ; le data engineer construit les systèmes qui les collectent et les stockent.

## En résumé

- La data science transforme des **données** en **informations** puis en **décisions**.
- Un projet suit six étapes : question, collecte, nettoyage, exploration, modélisation, communication.
- Les données peuvent être numériques, catégorielles, temporelles ou textuelles.
- La **qualité** des données conditionne la qualité des conclusions.
- Data analyst, data scientist, data engineer et chargé de suivi-évaluation sont les principaux métiers.

## Pour aller plus loin

- Demande au mentor IA : « Propose-moi un mini-projet data à faire avec les données d''une petite entreprise tchadienne. »'
WHERE t.slug = 'data-ia' AND l.title = 'Qu''est-ce que la data science ?';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Charger, nettoyer et analyser un fichier de ventes avec pandas dans Google Colab.', l.duration_minutes = 30, l.content = 'Excel est très pratique jusqu''à quelques milliers de lignes. Au-delà, ou quand il faut refaire la même analyse chaque mois, on passe à **Python** et à sa bibliothèque **pandas**. Dans ce chapitre, tu vas charger le fichier de ventes de Moussa, le nettoyer et en tirer tes premiers chiffres.

> **Objectifs de ce chapitre**
> - Utiliser Python dans Google Colab sans rien installer
> - Charger un fichier CSV dans un DataFrame pandas
> - Explorer, filtrer et trier des données
> - Nettoyer les valeurs manquantes et les incohérences
> - Calculer des totaux par catégorie

## Ton environnement : Google Colab

Pas besoin d''un ordinateur puissant : **Google Colab** (colab.research.google.com) permet d''écrire et d''exécuter du Python dans le navigateur, gratuitement, avec un compte Google. Le code s''écrit dans des **cellules** que l''on exécute avec **Maj+Entrée**.

> **Astuce** : Colab fonctionne aussi sur tablette. Pour économiser ta connexion, prépare ton code hors ligne et ouvre Colab seulement pour l''exécuter.

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

Dans Colab, clique sur l''icône de dossier à gauche, puis importe ce fichier.

## Charger et explorer les données

```python
import pandas as pd

ventes = pd.read_csv("ventes.csv")
print(ventes.head())      # les 5 premières lignes
print(ventes.shape)       # (nombre de lignes, nombre de colonnes)
ventes.info()             # types de colonnes et valeurs manquantes
```

Un **DataFrame** est un tableau : chaque colonne a un nom et un type. `info()` te montre par exemple que `prix_unitaire` contient 5 valeurs au lieu de 6 : il y a une case vide.

Les commandes d''exploration indispensables :

| Commande | Ce qu''elle fait |
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

La condition entre crochets renvoie une colonne de `True` / `False` ; pandas ne garde que les lignes où c''est vrai.

## Nettoyer les données

### Harmoniser le texte

« Chargeur USB-C » et « chargeur usb-c » sont le même article. On met tout en minuscules et on retire les espaces superflus :

```python
ventes["article"] = ventes["article"].str.lower().str.strip()
```

### Gérer les valeurs manquantes

Le prix du crédit Moov est manquant. Plusieurs options : supprimer la ligne, ou la remplir avec une valeur connue. Ici, on sait que le crédit est vendu à 1 000 FCFA l''unité :

```python
ventes["prix_unitaire"] = ventes["prix_unitaire"].fillna(1000)
```

Pour supprimer les lignes incomplètes à la place : `ventes = ventes.dropna()`.

> **Attention** : ne remplis jamais une valeur manquante « au hasard » ou avec la moyenne sans réfléchir. Note toujours tes choix de nettoyage : quelqu''un te demandera pourquoi les chiffres ont changé.

### Convertir les dates

```python
ventes["date"] = pd.to_datetime(ventes["date"])
ventes["jour"] = ventes["date"].dt.day_name()
```

## Calculer des indicateurs

On crée une colonne de chiffre d''affaires, puis on regroupe :

```python
ventes["montant"] = ventes["quantite"] * ventes["prix_unitaire"]

print(ventes["montant"].sum())                         # chiffre d''affaires total
print(ventes.groupby("categorie")["montant"].sum())    # par catégorie
print(ventes.groupby("article")["quantite"].sum().sort_values(ascending=False))
```

`groupby` est l''équivalent pandas du tableau croisé dynamique d''Excel : il regroupe les lignes qui ont la même valeur et applique un calcul (somme, moyenne, comptage).

## Un premier graphique

```python
ventes.groupby("categorie")["montant"].sum().plot(kind="bar", title="Chiffre d''affaires par catégorie")
```

Un graphique simple vaut souvent mieux qu''un long tableau pour convaincre Moussa.

## À toi de jouer

1. Charge `ventes.csv` dans Colab et affiche son nombre de lignes.
2. Harmonise la colonne `article` et remplis le prix manquant.
3. Crée la colonne `montant`, puis calcule le chiffre d''affaires total.
4. Affiche l''article le plus vendu en quantité.
5. Bonus : ajoute 10 lignes de ventes inventées sur une semaine complète et trouve le jour de la semaine le plus rentable.

> **Correction des étapes 3 et 4** : le total vaut 5 000 + 5 000 + 3 500 + 2 500 + 3 000 + 2 000 = 21 000 FCFA. L''article le plus vendu en quantité est le crédit Airtel (5 unités).

## Vérifie tes acquis

1. Quelle commande affiche le nombre de valeurs manquantes par colonne ?
2. À quoi sert `groupby` ?
3. Pourquoi mettre la colonne `article` en minuscules ?

> **Réponses** : 1. `ventes.isna().sum()`. 2. À regrouper les lignes partageant une même valeur pour calculer une somme, une moyenne ou un comptage par groupe. 3. Pour que les variantes d''écriture d''un même article soient comptées ensemble.

## En résumé

- **pandas** charge un fichier CSV dans un **DataFrame** avec `pd.read_csv()`.
- `head()`, `info()`, `describe()` et `value_counts()` servent à explorer.
- On filtre avec une condition entre crochets et on trie avec `sort_values()`.
- Nettoyer = harmoniser le texte, traiter les valeurs manquantes, convertir les dates.
- `groupby()` calcule des indicateurs par catégorie ; `.plot()` les visualise.

## Pour aller plus loin

- [Le tutoriel officiel de Python, en français](https://docs.python.org/fr/3/tutorial/)
- Demande au mentor IA : « Donne-moi un fichier CSV d''exemple sur les ventes d''une pharmacie et trois questions à résoudre avec pandas. »'
WHERE t.slug = 'data-ia' AND l.title = 'Python pour la donnée : les bases';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Apprentissage supervisé ou non, régression et classification, entraînement, test et biais.', l.duration_minutes = 25, l.content = 'Le **machine learning** (apprentissage automatique) est la technique derrière la reconnaissance vocale, les filtres anti-spam ou la détection de fraude Mobile Money. Son principe est simple à énoncer : au lieu d''écrire des règles à la main, on montre à l''ordinateur des exemples, et il **apprend** les règles tout seul.

> **Objectifs de ce chapitre**
> - Comprendre la différence entre programmation classique et machine learning
> - Distinguer apprentissage supervisé et non supervisé
> - Différencier régression et classification
> - Comprendre pourquoi on sépare données d''entraînement et de test
> - Connaître les limites et les biais d''un modèle

## Programmer ou apprendre ?

En **programmation classique**, tu écris les règles : « si le montant dépasse 500 000 FCFA et que le numéro est nouveau, alors bloque la transaction ». Tu donnes des règles et des données, l''ordinateur produit des réponses.

En **machine learning**, tu donnes des données **et** les réponses attendues (des milliers de transactions déjà étiquetées « fraude » ou « normale »). L''algorithme en déduit les règles. Il produit un **modèle**, qu''on applique ensuite à de nouvelles données.

C''est utile quand les règles sont trop nombreuses ou trop subtiles pour être écrites à la main : reconnaître une écriture, estimer le prix d''une maison, détecter un comportement inhabituel.

## Le vocabulaire de base

Reprenons les données de Moussa. Il veut prédire ses ventes de la journée.

- Les **variables explicatives** (*features*) sont les informations connues à l''avance : jour de la semaine, jour du mois, présence d''une fête, pluie ou non.
- La **variable cible** (*target*) est ce qu''on veut prédire : le chiffre d''affaires du jour.
- Un **exemple** est une ligne de données : une journée passée, avec ses variables et sa cible.
- Le **modèle** est la formule apprise qui relie les variables à la cible.

## Les grandes familles

### L''apprentissage supervisé

On dispose d''exemples **avec la bonne réponse**. Deux cas :

| Tâche | La cible est… | Exemple au Tchad |
| --- | --- | --- |
| **Régression** | un nombre | Prédire le chiffre d''affaires de demain, le rendement d''un champ de sorgho |
| **Classification** | une catégorie | Classer une transaction en « fraude » ou « normale », un SMS en « spam » ou non |

### L''apprentissage non supervisé

On a des données **sans réponse** et on cherche une structure cachée. Exemple : regrouper automatiquement les clients d''une banque en profils similaires (petits épargnants, commerçants, salariés). On parle de **clustering**.

> **Info** : les grands modèles de langage comme le mentor IA de cette plateforme sont aussi issus du machine learning, entraînés sur d''immenses quantités de textes. Le principe de base reste le même : apprendre à partir d''exemples.

## Entraîner et tester

Un modèle doit être bon sur des données **qu''il n''a jamais vues**. On découpe donc les données en deux :

- l''**ensemble d''entraînement** (souvent 80 %) sert à apprendre ;
- l''**ensemble de test** (20 %) sert à mesurer la performance, comme un examen final.

Pense à un élève qui apprend par cœur les corrigés des exercices : il aura 20/20 sur ces exercices, mais échouera à l''examen s''il n''a pas compris. Un modèle qui « apprend par cœur » ses données d''entraînement fait du **surapprentissage** (*overfitting*) : excellent à l''entraînement, mauvais sur le test.

> **Attention** : ne mesure jamais la performance d''un modèle sur les données qui ont servi à l''entraîner. Le score serait trompeur et trop optimiste.

## Mesurer la performance

- En **régression**, on regarde l''erreur moyenne : « en moyenne, le modèle se trompe de 3 200 FCFA par jour ».
- En **classification**, on regarde l''**exactitude** (le pourcentage de bonnes réponses), mais pas seulement. Si 99 % des transactions sont normales, un modèle qui répond toujours « normale » a 99 % d''exactitude… et ne détecte aucune fraude. On regarde donc aussi combien de fraudes réelles il attrape.

## Les limites et les biais

Un modèle reproduit ce qu''il voit dans les données, y compris les injustices. Si une banque entraîne un modèle d''octroi de crédit sur un historique où les femmes commerçantes obtenaient rarement des prêts, le modèle risque de continuer à les refuser, même solvables.

Avant de déployer un modèle, pose-toi toujours ces questions :

- Les données représentent-elles bien toute la population concernée (villes et zones rurales, hommes et femmes, langues) ?
- Qui sera affecté si le modèle se trompe, et comment pourra-t-il contester ?
- Le modèle est-il encore valable si la situation change (crise, nouvelle réglementation) ?

## À toi de jouer

Pour chacune des situations suivantes, indique s''il s''agit de régression, de classification ou de clustering, puis cite deux variables explicatives possibles :

1. Prédire le nombre de patients qui viendront demain dans un centre de santé de Moundou.
2. Détecter si une photo de feuille de manioc montre une maladie.
3. Regrouper les abonnés d''un opérateur selon leurs habitudes de consommation.
4. Estimer le loyer d''un appartement à N''Djamena.

> **Réponses** : 1. Régression (jour de la semaine, saison des pluies, épidémie en cours). 2. Classification (couleur des taches, forme des feuilles, à partir des pixels de l''image). 3. Clustering (volume d''appels, data consommée, montant des recharges). 4. Régression (quartier, nombre de pièces, accès à l''eau et à l''électricité).

## Vérifie tes acquis

1. Quelle est la différence entre la variable cible et les variables explicatives ?
2. Pourquoi sépare-t-on les données en entraînement et test ?
3. Qu''est-ce que le surapprentissage ?

> **Réponses** : 1. La cible est ce qu''on veut prédire ; les variables explicatives sont les informations utilisées pour la prédire. 2. Pour mesurer la performance sur des données que le modèle n''a jamais vues. 3. Un modèle qui mémorise ses données d''entraînement au lieu de généraliser, et qui échoue sur de nouvelles données.

## En résumé

- Le machine learning apprend des règles à partir d''**exemples** au lieu de les programmer à la main.
- **Supervisé** : régression (prédire un nombre) ou classification (prédire une catégorie). **Non supervisé** : trouver des groupes.
- On entraîne sur une partie des données et on **teste** sur une autre.
- Le **surapprentissage** donne de bons scores à l''entraînement mais de mauvais résultats en réalité.
- Un modèle peut reproduire des **biais** : vérifie toujours qui risque d''être pénalisé.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi la différence entre régression et classification avec trois exemples tirés de l''agriculture tchadienne. »'
WHERE t.slug = 'data-ia' AND l.title = 'Qu''est-ce que le machine learning ?';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Une régression linéaire avec scikit-learn pour prédire le chiffre d''affaires d''une boutique.', l.duration_minutes = 35, l.content = 'Place à la pratique ! Dans ce chapitre, tu vas entraîner ton premier modèle avec **scikit-learn**, la bibliothèque Python de référence pour le machine learning classique. L''objectif : prédire le chiffre d''affaires journalier de la boutique de Moussa à partir de quelques informations sur la journée.

> **Objectifs de ce chapitre**
> - Préparer les variables explicatives et la cible
> - Séparer les données en entraînement et test
> - Entraîner une régression linéaire avec scikit-learn
> - Évaluer le modèle et interpréter ses erreurs
> - Utiliser le modèle pour une nouvelle prédiction

## Les données

Moussa a noté, pour 60 jours, le chiffre d''affaires et quelques informations. Voici un extrait de `journees.csv` :

```text
jour_du_mois,est_weekend,est_jour_de_paie,pluie,chiffre_affaires
1,0,1,0,48000
2,1,0,0,39500
3,1,0,1,21000
4,0,0,0,27500
5,0,0,1,18000
```

- `jour_du_mois` : de 1 à 31.
- `est_weekend`, `est_jour_de_paie` et `pluie` valent 1 (oui) ou 0 (non).
- `chiffre_affaires` est la cible, en FCFA.

> **Info** : les modèles ne comprennent que des nombres. Une information « oui/non » se code en 1/0 ; une catégorie comme le jour de la semaine se transforme en plusieurs colonnes 0/1. On appelle cela l''**encodage**.

## Préparer X et y

Par convention, on appelle `X` le tableau des variables explicatives et `y` la cible :

```python
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_absolute_error

donnees = pd.read_csv("journees.csv")

X = donnees[["jour_du_mois", "est_weekend", "est_jour_de_paie", "pluie"]]
y = donnees["chiffre_affaires"]
```

## Séparer entraînement et test

```python
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
print(len(X_train), len(X_test))   # 48 12
```

`test_size=0.2` garde 20 % des journées pour le test. `random_state=42` fixe le tirage au hasard pour obtenir les mêmes résultats à chaque exécution : pratique pour comparer.

## Entraîner le modèle

La **régression linéaire** cherche la meilleure formule de la forme : chiffre d''affaires = base + a × jour_du_mois + b × est_weekend + c × est_jour_de_paie + d × pluie.

```python
modele = LinearRegression()
modele.fit(X_train, y_train)
```

C''est tout : `fit()` est l''étape d''apprentissage. Le modèle a trouvé les coefficients a, b, c, d.

## Interpréter le modèle

```python
for nom, coef in zip(X.columns, modele.coef_):
    print(f"{nom} : {coef:+.0f} FCFA")
print(f"base : {modele.intercept_:.0f} FCFA")
```

Tu pourrais obtenir par exemple :

```text
jour_du_mois : -350 FCFA
est_weekend : +4200 FCFA
est_jour_de_paie : +18500 FCFA
pluie : -9800 FCFA
base : 31000 FCFA
```

On peut le lire ainsi : un jour de paie rapporte environ 18 500 FCFA de plus, la pluie fait perdre environ 9 800 FCFA, et les ventes baissent légèrement au fil du mois (l''argent des clients s''épuise). C''est l''un des grands atouts de la régression linéaire : elle est **explicable**.

> **Attention** : un coefficient montre une **association**, pas forcément une cause. Si les ventes baissent les jours de pluie, c''est peut-être parce que les clients sortent moins… ou parce que la boutique ferme plus tôt. Discute toujours des résultats avec la personne du terrain.

## Évaluer le modèle

```python
predictions = modele.predict(X_test)
erreur = mean_absolute_error(y_test, predictions)
print(f"Erreur moyenne : {erreur:.0f} FCFA")
```

L''**erreur absolue moyenne** dit de combien le modèle se trompe en moyenne. Pour savoir si c''est bien, compare-la à une méthode naïve : prédire chaque jour la moyenne des ventes.

```python
naif = [y_train.mean()] * len(y_test)
print(f"Erreur du modèle naïf : {mean_absolute_error(y_test, naif):.0f} FCFA")
```

Si ton modèle ne fait pas nettement mieux que la méthode naïve, il n''apporte rien.

## Prédire une nouvelle journée

Demain est le 28 du mois, un mardi, pas un jour de paie, et la météo annonce de la pluie :

```python
demain = pd.DataFrame([{"jour_du_mois": 28, "est_weekend": 0, "est_jour_de_paie": 0, "pluie": 1}])
print(f"Prévision : {modele.predict(demain)[0]:.0f} FCFA")
```

Moussa peut maintenant adapter son stock et ses horaires.

## À toi de jouer

1. Crée dans Colab un fichier `journees.csv` d''au moins 30 lignes (invente des données cohérentes : plus de ventes les jours de paie, moins quand il pleut).
2. Entraîne une régression linéaire et affiche ses coefficients.
3. Calcule l''erreur moyenne du modèle et celle du modèle naïf.
4. Ajoute une variable `est_jour_de_fete` (Tabaski, Noël, fête de l''Indépendance…) et observe si l''erreur diminue.
5. Rédige en trois phrases, pour Moussa, ce que le modèle lui apprend.

> **Pour t''auto-évaluer** : ton travail est réussi si ton modèle bat nettement le modèle naïf et si tes trois phrases pour Moussa ne contiennent aucun mot technique.

## Vérifie tes acquis

1. Que fait la méthode `fit()` ?
2. Pourquoi comparer le modèle à une prédiction naïve ?
3. Un coefficient de +18 500 pour `est_jour_de_paie` prouve-t-il que la paie cause les ventes ?

> **Réponses** : 1. Elle entraîne le modèle sur les données d''entraînement. 2. Pour vérifier que le modèle apporte réellement quelque chose par rapport à une méthode simple. 3. Non, il montre une association ; la causalité doit être confirmée par la connaissance du terrain.

## En résumé

- `X` contient les variables explicatives, `y` la cible ; tout doit être numérique.
- `train_test_split` sépare entraînement et test.
- `LinearRegression().fit()` entraîne le modèle, `predict()` fait des prédictions.
- L''**erreur absolue moyenne** mesure la qualité ; compare-la toujours à un modèle naïf.
- Les coefficients d''une régression linéaire s''interprètent, mais indiquent des associations, pas des causes.

## Pour aller plus loin

- [La documentation de scikit-learn](https://scikit-learn.org/stable/user_guide.html) (en anglais, avec de nombreux exemples)
- Demande au mentor IA : « Comment remplacer ma régression linéaire par un arbre de décision et comparer les deux ? »'
WHERE t.slug = 'data-ia' AND l.title = 'Entraîner un premier modèle simple';


-- =====================================================================
-- Cybersécurité (cybersecurite)
-- =====================================================================
UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Les trois propriétés à protéger, et les notions de menace, vulnérabilité et risque.', l.duration_minutes = 25, l.content = 'Une banque de N''Djamena dont le site est piraté, une ONG qui perd les fichiers de ses bénéficiaires, un compte Facebook d''entreprise volé : derrière chaque incident de sécurité, il y a une information qui a perdu l''une de ses trois protections fondamentales. Ces trois protections forment la **triade CIA**, le point de départ de toute réflexion en cybersécurité.

Dans ce parcours, tu accompagnes **Halimé**, qui vient d''être recrutée comme responsable informatique dans une microfinance de N''Djamena. Elle doit sécuriser les systèmes de l''agence.

> **Objectifs de ce chapitre**
> - Définir la confidentialité, l''intégrité et la disponibilité
> - Associer chaque menace à la propriété qu''elle attaque
> - Comprendre les notions de risque, menace et vulnérabilité
> - Proposer des mesures de protection adaptées

## C, I, A : trois propriétés à protéger

Le sigle vient de l''anglais *Confidentiality, Integrity, Availability*.

### La confidentialité

Seules les personnes autorisées peuvent **lire** l''information. Le solde d''un client de la microfinance ne doit être visible que par lui et par les agents habilités.

Elle est menacée par : le vol de mot de passe, un ordinateur perdu non chiffré, un employé curieux, une base de données exposée sur Internet.

### L''intégrité

L''information est **exacte et n''a pas été modifiée** sans autorisation. Si quelqu''un change le montant d''un prêt dans la base, de 150 000 à 1 500 000 FCFA, l''intégrité est violée, même si personne d''autre n''a lu la donnée.

Elle est menacée par : un pirate qui modifie des données, un virus, mais aussi une simple erreur de saisie ou un bug.

### La disponibilité

L''information et les systèmes sont **accessibles quand on en a besoin**. Si le serveur de l''agence tombe en panne un jour de remboursement, les clients ne peuvent plus payer : la disponibilité est perdue.

Elle est menacée par : une panne électrique (sujet très concret au Tchad), un rançongiciel qui chiffre tous les fichiers, une attaque par saturation, un disque dur qui lâche sans sauvegarde.

> **Info** : on ajoute souvent deux propriétés complémentaires : la **traçabilité** (savoir qui a fait quoi et quand) et l''**authenticité** (être sûr de l''identité de son interlocuteur).

## Associer une mesure à chaque propriété

| Propriété | Mesures de protection typiques |
| --- | --- |
| Confidentialité | Mots de passe solides, droits d''accès limités, chiffrement des disques et des connexions (HTTPS) |
| Intégrité | Droits en écriture limités, journalisation des modifications, contrôles de cohérence, signatures numériques |
| Disponibilité | Sauvegardes, onduleur et groupe électrogène, matériel redondant, plan de reprise après incident |

> **Attention** : renforcer une propriété peut en affaiblir une autre. Un système trop verrouillé (confidentialité maximale) peut devenir inutilisable pour les employés (disponibilité dégradée). La sécurité est toujours une question d''équilibre.

## Menace, vulnérabilité, risque

Trois mots que tu entendras partout :

- Une **vulnérabilité** est une faiblesse : un logiciel non mis à jour, un mot de passe « 123456 », une salle serveur sans serrure.
- Une **menace** est ce qui peut exploiter cette faiblesse : un pirate, un employé malveillant, une inondation, une coupure de courant.
- Le **risque** combine les deux avec l''impact : quelle est la probabilité que la menace exploite la vulnérabilité, et quelles seraient les conséquences ?

On peut retenir : **risque = probabilité × impact**. Une coupure de courant a une forte probabilité à N''Djamena ; si le serveur n''a pas d''onduleur et que chaque coupure corrompt la base, l''impact est fort : le risque est élevé et doit être traité en priorité.

## À toi de jouer

Voici cinq incidents survenus dans des organisations. Pour chacun, indique la ou les propriétés touchées (C, I, A) et propose une mesure de prévention.

1. Un agent envoie par erreur la liste des clients et de leurs soldes dans un groupe WhatsApp public.
2. Un rançongiciel chiffre tous les fichiers du serveur de comptabilité.
3. Un stagiaire modifie par erreur les taux d''intérêt dans le logiciel de gestion.
4. Le serveur s''éteint à chaque coupure d''électricité et met une heure à redémarrer.
5. Un ancien employé se connecte encore à la messagerie de l''entreprise trois mois après son départ.

> **Réponses** : 1. Confidentialité : sensibiliser le personnel et interdire le partage de données clients sur les messageries personnelles. 2. Disponibilité (et intégrité) : sauvegardes régulières hors ligne et mises à jour des logiciels. 3. Intégrité : limiter les droits de modification et journaliser les changements. 4. Disponibilité : onduleur et arrêt automatique propre du serveur. 5. Confidentialité : procédure de départ qui désactive tous les comptes le jour même.

## Vérifie tes acquis

1. Un pirate modifie le montant d''un virement sans le lire. Quelle propriété est touchée ?
2. Quelle mesure protège avant tout la disponibilité ?
3. Quelle est la différence entre une menace et une vulnérabilité ?

> **Réponses** : 1. L''intégrité. 2. Les sauvegardes (et l''alimentation de secours). 3. La vulnérabilité est une faiblesse du système ; la menace est ce qui peut l''exploiter.

## En résumé

- La **triade CIA** : confidentialité (qui peut lire), intégrité (l''exactitude), disponibilité (l''accès quand on en a besoin).
- Chaque incident touche au moins une de ces trois propriétés.
- Le **risque** dépend de la probabilité qu''une **menace** exploite une **vulnérabilité** et de l''impact.
- Les mesures de sécurité sont un équilibre entre protection et facilité d''usage.

## Pour aller plus loin

- [Le guide d''hygiène informatique de l''ANSSI](https://cyber.gouv.fr/publications/guide-dhygiene-informatique) : 42 mesures concrètes pour sécuriser une organisation.
- Demande au mentor IA : « Aide-moi à faire la liste des 5 plus grands risques informatiques d''une petite microfinance au Tchad. »'
WHERE t.slug = 'cybersecurite' AND l.title = 'La triade CIA : confidentialité, intégrité, disponibilité';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Phrases de passe, gestionnaire de mots de passe, double authentification et politique d''entreprise.', l.duration_minutes = 25, l.content = 'La grande majorité des piratages de comptes ne viennent pas d''attaques sophistiquées, mais de mots de passe faibles, réutilisés ou volés. Halimé découvre que la moitié des agents de la microfinance utilisent le même mot de passe pour leur session Windows, leur messagerie et le logiciel de gestion. Il est temps d''agir.

> **Objectifs de ce chapitre**
> - Comprendre comment les mots de passe sont attaqués
> - Créer des mots de passe robustes et faciles à retenir
> - Utiliser un gestionnaire de mots de passe
> - Mettre en place l''authentification à deux facteurs
> - Rédiger une politique de mots de passe pour une organisation

## Comment un mot de passe est-il volé ?

- **Le devinement** : l''attaquant essaie les mots de passe les plus courants (`123456`, `password`, `azerty`, le prénom de l''enfant, l''année de naissance).
- **La force brute** : un programme essaie toutes les combinaisons possibles. Un mot de passe de 6 caractères tombe en quelques secondes ; un de 16 caractères variés résiste des siècles.
- **Les fuites de données** : un site mal protégé se fait voler sa base. Si tu utilises le même mot de passe ailleurs, l''attaquant essaie la même combinaison e-mail + mot de passe sur tous tes comptes. C''est le **bourrage d''identifiants**.
- **L''hameçonnage** (*phishing*) : un faux site ou un faux message te pousse à saisir toi-même ton mot de passe. Tu l''étudieras en détail dans un prochain chapitre.
- **L''observation** : un post-it collé sous le clavier, un mot de passe tapé devant un collègue.

> **Info** : le site [Have I Been Pwned](https://haveibeenpwned.com) permet de vérifier si ton adresse e-mail apparaît dans une fuite de données connue. Fais le test : le résultat surprend souvent.

## Créer un mot de passe robuste

La **longueur** compte plus que la complexité. Un bon mot de passe en 2026 :

- fait au moins **12 caractères**, idéalement 16 ou plus ;
- est **unique** : un mot de passe différent pour chaque compte important ;
- n''est pas lié à toi (pas de nom, de date de naissance, de numéro de téléphone).

La méthode la plus simple est la **phrase de passe** : plusieurs mots sans rapport entre eux, faciles à retenir pour toi, impossibles à deviner pour les autres.

```text
Mauvais : Halime1995
Mauvais : P@ssw0rd!
Bon     : chameau-Bleu-radio-Sorgho-42
```

## Le gestionnaire de mots de passe

Retenir 30 mots de passe uniques est impossible. La solution : un **gestionnaire de mots de passe** (Bitwarden, KeePassXC, ou celui intégré à Google Chrome ou Firefox). Il génère et retient des mots de passe aléatoires pour chaque site. Tu n''as plus qu''**un seul** mot de passe maître à retenir : une longue phrase de passe.

> **Attention** : le mot de passe maître ne doit jamais être perdu ni réutilisé ailleurs. Note-le sur papier et range ce papier dans un endroit sûr, pas dans ton téléphone.

## L''authentification à deux facteurs

Même un excellent mot de passe peut être volé. L''**authentification à deux facteurs** (2FA) exige une deuxième preuve, d''une autre nature :

| Facteur | Exemples |
| --- | --- |
| Ce que je **sais** | Mot de passe, code PIN |
| Ce que je **possède** | Téléphone (code SMS, application d''authentification), clé de sécurité USB |
| Ce que je **suis** | Empreinte digitale, reconnaissance faciale |

Combiner deux facteurs différents rend le piratage beaucoup plus difficile : l''attaquant qui a volé ton mot de passe n''a pas ton téléphone.

Les applications d''authentification (Google Authenticator, Microsoft Authenticator, Aegis) sont plus sûres que les codes SMS, qui peuvent être interceptés lors d''une fraude au changement de carte SIM.

> **Astuce** : active la 2FA en priorité sur ta messagerie e-mail (elle permet de réinitialiser tous tes autres comptes), sur WhatsApp (la « vérification en deux étapes » dans les réglages) et sur les comptes d''administration.

## Côté développeur : stocker les mots de passe

Si tu développes une application, ne stocke **jamais** les mots de passe en clair dans la base de données. On stocke une **empreinte** (un *hash*) calculée avec un algorithme lent et salé, conçu pour cela : bcrypt ou Argon2. En PHP, c''est très simple :

```php
$empreinte = password_hash($motDePasse, PASSWORD_DEFAULT);   // à l''inscription
if (password_verify($saisie, $empreinte)) { /* connexion OK */ } // à la connexion
```

Même en cas de vol de la base, les mots de passe ne sont pas directement lisibles.

## À toi de jouer

Halimé te demande de rédiger la **politique de mots de passe** de la microfinance, en une page maximum. Elle doit couvrir :

1. La longueur minimale et les règles de création (avec un exemple de phrase de passe).
2. L''interdiction de réutiliser un mot de passe professionnel ailleurs.
3. L''outil de gestion de mots de passe recommandé.
4. Les comptes sur lesquels la 2FA est obligatoire.
5. La conduite à tenir si un employé pense que son mot de passe a été découvert.
6. La procédure lors du départ d''un employé.

> **Pour t''auto-évaluer** : ta politique est réussie si un agent sans formation technique peut la lire en trois minutes et l''appliquer seul. Évite le jargon ; explique le « pourquoi » de chaque règle en une phrase.

## Vérifie tes acquis

1. Pourquoi est-il dangereux de réutiliser le même mot de passe sur plusieurs sites ?
2. Qu''est-ce qui rend un mot de passe robuste avant tout : la longueur ou les caractères spéciaux ?
3. Pourquoi une application d''authentification est-elle plus sûre qu''un code SMS ?

> **Réponses** : 1. Si un site subit une fuite, l''attaquant peut utiliser la même combinaison sur tous tes autres comptes. 2. La longueur. 3. Parce que les SMS peuvent être détournés, notamment par une fraude au changement de carte SIM.

## En résumé

- Les mots de passe sont surtout volés par devinement, fuites de données et hameçonnage.
- Un bon mot de passe est **long**, **unique** et sans lien avec toi ; la phrase de passe est la méthode la plus simple.
- Un **gestionnaire de mots de passe** retient tout à ta place.
- La **2FA** ajoute une deuxième preuve d''une autre nature ; active-la sur les comptes critiques.
- Un développeur stocke des empreintes (`password_hash`), jamais des mots de passe en clair.

## Pour aller plus loin

- Demande au mentor IA : « Comment activer la vérification en deux étapes sur WhatsApp et Gmail ? Donne-moi les étapes. »'
WHERE t.slug = 'cybersecurite' AND l.title = 'Mots de passe et authentification forte';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Règles de pare-feu, ports, zones réseau, DMZ et moindre privilège.', l.duration_minutes = 30, l.content = 'Le réseau de l''agence de microfinance est « à plat » : les ordinateurs des guichets, le serveur de la base clients, l''imprimante et le Wi-Fi offert aux clients dans la salle d''attente sont tous connectés au même réseau. Si un seul appareil est infecté, tout le reste est à portée de l''attaquant. Halimé doit cloisonner. Ses deux outils : le **pare-feu** et la **segmentation**.

> **Objectifs de ce chapitre**
> - Comprendre le rôle d''un pare-feu et le fonctionnement de ses règles
> - Connaître les ports et protocoles les plus courants
> - Découper un réseau en zones (segmentation, VLAN, DMZ)
> - Appliquer le principe du moindre privilège au réseau

## Le pare-feu, un poste de contrôle

Un **pare-feu** (*firewall*) examine chaque connexion qui le traverse et décide de la laisser passer ou de la bloquer, selon des **règles**. Imagine le contrôle à l''entrée d''un bâtiment officiel : on vérifie qui entre, d''où il vient et où il va.

Il en existe deux grands types :

- le pare-feu **réseau** : un boîtier (ou un routeur) placé entre deux réseaux, par exemple entre le réseau de l''agence et Internet ;
- le pare-feu **local** : un logiciel sur chaque ordinateur, comme le pare-feu Windows ou `ufw` sous Linux.

Les deux sont complémentaires : on parle de **défense en profondeur**.

## Adresses, ports et protocoles

Une règle de pare-feu s''appuie sur quelques informations :

- l''adresse IP **source** (qui envoie) et **destination** (qui reçoit) ;
- le **protocole** : TCP ou UDP le plus souvent ;
- le **port** de destination, qui désigne le service visé sur la machine.

| Port | Service | Remarque |
| --- | --- | --- |
| 22 | SSH | Administration à distance des serveurs Linux |
| 53 | DNS | Résolution des noms de domaine |
| 80 / 443 | HTTP / HTTPS | Sites web |
| 3306 | MySQL | Ne doit **jamais** être ouvert sur Internet |
| 3389 | RDP | Bureau à distance Windows, très ciblé par les attaquants |

## Écrire des règles

Les règles sont lues **dans l''ordre**, et la première qui correspond s''applique. La bonne pratique est de tout interdire par défaut, puis d''autoriser uniquement ce qui est nécessaire :

| N° | Source | Destination | Port | Action |
| --- | --- | --- | --- | --- |
| 1 | Réseau guichets | Serveur applicatif | 443 | Autoriser |
| 2 | Poste d''administration | Serveurs | 22 | Autoriser |
| 3 | Réseau Wi-Fi clients | Internet | 80, 443 | Autoriser |
| 4 | Réseau Wi-Fi clients | Réseau interne | tous | Bloquer |
| 5 | Tout | Tout | tous | Bloquer (règle par défaut) |

Sous Linux, avec l''outil `ufw`, la même logique s''écrit en quelques commandes :

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow from 192.168.10.0/24 to any port 22
sudo ufw allow 443/tcp
sudo ufw enable
sudo ufw status numbered
```

> **Attention** : quand tu configures un pare-feu à distance par SSH, autorise **d''abord** ton accès SSH avant d''activer le blocage par défaut. Sinon, tu te retrouves enfermé dehors et il faudra se déplacer jusqu''au serveur.

## Segmenter le réseau

La **segmentation** consiste à découper le réseau en zones séparées, chacune avec son niveau de confiance. Le pare-feu contrôle les échanges entre zones. Sur un même équipement réseau, on crée ces zones avec des **VLAN** (réseaux locaux virtuels).

Pour l''agence, Halimé propose quatre zones :

- **Postes de travail** : les ordinateurs des agents.
- **Serveurs** : base clients, serveur de fichiers. Accès limité aux seuls services nécessaires.
- **Invités** : le Wi-Fi des clients, qui n''accède qu''à Internet.
- **DMZ** (zone démilitarisée) : les serveurs qui doivent être joignables depuis Internet, comme le site web. Si l''un d''eux est piraté, l''attaquant reste coincé dans cette zone.

> **Info** : les imprimantes, caméras de surveillance et autres objets connectés sont souvent mal sécurisés. Place-les dans leur propre zone, isolée des serveurs.

## Le principe du moindre privilège

Chaque utilisateur, programme ou machine ne doit avoir accès **qu''à ce dont il a strictement besoin**. Appliqué au réseau : un poste de guichet n''a aucune raison de se connecter à la base de données en direct sur le port 3306 ; il passe par l''application, sur le port 443.

## À toi de jouer

L''agence a la configuration suivante : 8 postes de guichet, 1 poste de comptabilité, 1 serveur de base de données, 1 serveur web public, 1 imprimante réseau et un Wi-Fi pour les clients.

1. Dessine (sur papier) un schéma avec les zones réseau que tu proposes.
2. Rédige le tableau des règles de pare-feu entre ces zones, en terminant par la règle « tout bloquer ».
3. Indique quels ports ne doivent en aucun cas être accessibles depuis Internet.

> **Éléments de correction** : au minimum quatre zones (postes, serveurs internes, DMZ pour le serveur web, invités), plus idéalement une zone pour l''imprimante. Le Wi-Fi clients n''accède qu''à Internet. Seuls les ports 80 et 443 du serveur web sont ouverts depuis Internet. Les ports 22, 3306 et 3389 ne doivent jamais l''être.

## Vérifie tes acquis

1. Dans quel ordre un pare-feu lit-il ses règles ?
2. À quoi sert une DMZ ?
3. Pourquoi le port 3306 ne doit-il jamais être ouvert sur Internet ?

> **Réponses** : 1. De haut en bas : la première règle qui correspond s''applique. 2. À isoler les serveurs accessibles depuis Internet pour qu''un piratage ne donne pas accès au réseau interne. 3. Parce qu''il expose directement la base de données MySQL aux attaques.

## En résumé

- Un **pare-feu** filtre les connexions selon des règles (source, destination, protocole, port).
- Bonne pratique : **tout bloquer par défaut**, puis autoriser le strict nécessaire.
- La **segmentation** découpe le réseau en zones (postes, serveurs, invités, DMZ) avec des VLAN.
- Le **moindre privilège** limite chaque accès au besoin réel.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi comment créer un réseau Wi-Fi invité isolé sur un routeur TP-Link ou MikroTik. »'
WHERE t.slug = 'cybersecurite' AND l.title = 'Pare-feu et segmentation réseau';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Repérer les messages frauduleux, lire une adresse web et réagir après une erreur.', l.duration_minutes = 25, l.content = '« Bonjour, ici le service client Airtel Money. Votre compte va être suspendu. Pour le réactiver, donnez-nous le code que vous venez de recevoir par SMS. » Ce type d''appel, tout le monde au Tchad en a déjà reçu. Les pirates ont compris qu''il est souvent plus facile de **tromper une personne** que de casser un système. C''est l''**ingénierie sociale**, et sa forme la plus répandue s''appelle l''**hameçonnage** (*phishing*).

> **Objectifs de ce chapitre**
> - Comprendre les ressorts psychologiques de l''ingénierie sociale
> - Reconnaître un e-mail, un SMS ou un appel frauduleux
> - Vérifier un lien avant de cliquer
> - Savoir réagir après un clic ou une erreur
> - Organiser une sensibilisation dans une équipe

## Les leviers de la manipulation

L''attaquant joue sur des émotions qui court-circuitent la réflexion :

- **L''urgence** : « Votre compte sera bloqué dans 2 heures. »
- **La peur** : « Une transaction suspecte de 450 000 FCFA a été détectée. »
- **L''autorité** : « Ici le directeur général, j''ai besoin d''un virement urgent et confidentiel. »
- **L''appât du gain** : « Félicitations, vous avez gagné 1 000 000 FCFA à la tombola. »
- **La serviabilité** : « Je suis le technicien, pouvez-vous me donner votre mot de passe pour la maintenance ? »

> **Info** : la règle d''or à transmettre à tout le monde : **aucun opérateur, aucune banque et aucun service informatique sérieux ne te demandera jamais ton code secret, ton code PIN ou un code reçu par SMS.**

## Les formes de l''hameçonnage

| Forme | Canal | Exemple |
| --- | --- | --- |
| Phishing | E-mail | Faux message de « Microsoft » demandant de reconfirmer son mot de passe |
| Smishing | SMS | Faux SMS de colis en attente avec un lien de paiement |
| Vishing | Appel vocal | Faux agent Mobile Money qui demande un code |
| Fraude au président | E-mail ou WhatsApp | Faux dirigeant qui exige un virement urgent |
| Spear phishing | Tous | Message très personnalisé, préparé à partir des réseaux sociaux de la victime |

## Repérer un e-mail frauduleux

Avant de cliquer, passe le message au crible :

1. **L''expéditeur** : regarde l''adresse complète, pas seulement le nom affiché. « Service Ecobank » peut cacher `support@ecobank-securite-verif.com`.
2. **Le ton** : urgence, menace ou promesse trop belle ?
3. **La demande** : on te demande un mot de passe, un code, un paiement ou d''ouvrir une pièce jointe inattendue ?
4. **Les liens** : survole le lien avec la souris (ou appui long sur mobile) pour voir la vraie adresse.
5. **La forme** : fautes, logo flou, formule générique comme « Cher client ».

## Lire une adresse web

La partie importante d''une adresse est le **nom de domaine**, juste avant le premier `/` :

```text
https://www.airtel.td/airtelmoney          → domaine : airtel.td      (légitime)
https://airtel.td.verification-compte.com  → domaine : verification-compte.com (piège !)
https://airteI-money.com                   → un « I » majuscule à la place du « l » (piège !)
```

Le domaine se lit **de droite à gauche** à partir du premier `/` : dans le deuxième exemple, le vrai propriétaire est `verification-compte.com` ; « airtel.td » n''est qu''un sous-domaine trompeur.

> **Attention** : le cadenas HTTPS prouve seulement que la connexion est chiffrée, **pas** que le site est honnête. Les sites de phishing ont presque tous un cadenas aujourd''hui.

## Réagir en cas d''erreur

Tout le monde peut se faire piéger un jour. Ce qui compte, c''est de réagir vite :

1. **Ne pas avoir honte et prévenir immédiatement** le responsable informatique : chaque minute compte.
2. **Changer le mot de passe** du compte concerné depuis un appareil sûr, puis ceux des comptes qui utilisaient le même.
3. **Déconnecter l''ordinateur du réseau** si une pièce jointe a été ouverte.
4. Pour un code Mobile Money ou bancaire communiqué, **appeler tout de suite** le service client officiel (numéro au dos de la carte ou sur le site officiel) pour bloquer le compte.
5. **Signaler** la tentative pour protéger les collègues.

## Sensibiliser une équipe

La technique ne suffit pas : la meilleure défense est une équipe vigilante. Quelques actions simples :

- une séance de 30 minutes avec des exemples réels de messages frauduleux ;
- une affiche près des postes : « Code demandé = arnaque » ;
- un canal clair pour signaler un message douteux, sans reproche ;
- des exercices de faux phishing, annoncés à la direction, pour mesurer les progrès.

## À toi de jouer

Analyse ce SMS reçu par un agent de la microfinance :

```text
MICROFINANCE-INFO : Votre accès au logiciel expire aujourd''hui.
Reconnectez-vous ici sous 1h pour éviter le blocage :
http://microfinance-td.acces-renouvellement.net/login
```

1. Relève au moins quatre indices de fraude.
2. Rédige la réponse que l''agent doit apporter (à qui le signaler, quoi faire).
3. Prépare trois diapositives (titre + 3 points chacune) pour une sensibilisation de 15 minutes destinée aux agents de guichet.

> **Correction** : indices : urgence (« sous 1h »), menace (« blocage »), lien en HTTP non sécurisé, domaine réel `acces-renouvellement.net` sans rapport avec la microfinance, un logiciel interne qui n''envoie pas de SMS de ce type. L''agent ne clique pas, transfère une capture au responsable informatique et supprime le message.

## Vérifie tes acquis

1. Dans `https://ecobank.com.securite-client.info/login`, quel est le vrai nom de domaine ?
2. Le cadenas HTTPS garantit-il qu''un site est fiable ?
3. Quelle est la première chose à faire après avoir saisi son mot de passe sur un faux site ?

> **Réponses** : 1. `securite-client.info`. 2. Non, il garantit seulement que la connexion est chiffrée. 3. Prévenir le responsable informatique et changer immédiatement le mot de passe depuis un appareil sûr.

## En résumé

- L''**ingénierie sociale** manipule les personnes par l''urgence, la peur, l''autorité ou l''appât du gain.
- Le phishing existe par e-mail, SMS, appel et messagerie.
- Vérifie l''expéditeur, la demande et surtout le **nom de domaine** des liens.
- Personne de sérieux ne demande un code secret.
- En cas d''erreur : prévenir, changer les mots de passe, isoler, signaler, sans honte.

## Pour aller plus loin

- Demande au mentor IA : « Crée-moi cinq exemples de SMS frauduleux réalistes au Tchad et cinq messages légitimes, pour un quiz de sensibilisation. »'
WHERE t.slug = 'cybersecurite' AND l.title = 'Reconnaître le phishing et l''ingénierie sociale';


-- =====================================================================
-- DevOps & Cloud (devops-cloud)
-- =====================================================================
UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Commits, branches, dépôt distant et résolution de conflits.', l.duration_minutes = 30, l.content = '« Le site marchait hier, quelqu''un a modifié un fichier et tout est cassé… mais personne ne sait quoi. » Ce scénario, toutes les équipes l''ont vécu avant d''adopter **Git**. Git est un **système de gestion de versions** : il enregistre l''historique complet de ton code, permet de revenir en arrière et de travailler à plusieurs sans s''écraser mutuellement. C''est la compétence numéro un demandée à tout développeur et à tout profil DevOps.

Dans ce parcours, tu suis **Ibrahim**, développeur dans une startup de N''Djamena qui édite une application de réservation de bus entre N''Djamena, Moundou et Abéché.

> **Objectifs de ce chapitre**
> - Comprendre le fonctionnement de Git : dépôt, commit, historique
> - Utiliser les commandes essentielles au quotidien
> - Travailler avec des branches
> - Collaborer via un dépôt distant (GitHub, GitLab)
> - Résoudre un conflit simple

## Les notions clés

- Un **dépôt** (*repository*) est un dossier suivi par Git, avec tout son historique.
- Un **commit** est une photo de l''état des fichiers à un instant donné, accompagnée d''un message qui explique le changement.
- L''**historique** est la suite de tous les commits.
- Une **branche** est une ligne de travail parallèle : on y développe une fonctionnalité sans toucher à la version stable.

## Les trois zones de Git

Avant d''être enregistré dans l''historique, un changement passe par trois étapes :

1. Le **répertoire de travail** : tes fichiers tels que tu les modifies.
2. La **zone de préparation** (*staging area*) : les changements que tu as choisis d''inclure dans le prochain commit, avec `git add`.
3. Le **dépôt** : l''historique, une fois le commit créé avec `git commit`.

Cette étape intermédiaire permet de faire des commits propres, qui ne regroupent que des changements liés entre eux.

## Démarrer

```bash
git config --global user.name "Ibrahim Abakar"
git config --global user.email "ibrahim@exemple.td"

mkdir reservation-bus && cd reservation-bus
git init
```

## Le cycle quotidien

```bash
git status                       # que s''est-il passé depuis le dernier commit ?
git add index.php                # préparer un fichier
git add .                        # ou tous les fichiers modifiés
git commit -m "Ajoute la page de recherche de trajets"
git log --oneline                # voir l''historique résumé
git diff                         # voir les modifications pas encore préparées
```

> **Astuce** : un bon message de commit décrit **ce que fait** le changement, à l''impératif : « Corrige le calcul du prix des billets » plutôt que « modif » ou « correction ». Dans six mois, tu remercieras ton toi d''aujourd''hui.

## Le fichier .gitignore

Certains fichiers ne doivent jamais entrer dans Git : mots de passe, fichiers de configuration locaux, dossiers de dépendances, fichiers temporaires. On les liste dans un fichier `.gitignore` :

```text
config/config.php
.env
vendor/
node_modules/
*.log
```

> **Attention** : un mot de passe commité reste dans l''historique même si tu supprimes le fichier ensuite. Si cela arrive sur un dépôt public, considère le mot de passe comme compromis et change-le immédiatement.

## Les branches

```bash
git switch -c paiement-mobile-money   # créer une branche et s''y placer
# ... modifications et commits ...
git switch main                       # revenir sur la branche principale
git merge paiement-mobile-money       # intégrer le travail de la branche
git branch -d paiement-mobile-money   # supprimer la branche fusionnée
```

La branche `main` contient la version stable, celle qui est en production. Chaque nouvelle fonctionnalité se développe sur sa propre branche, puis on la fusionne quand elle est prête et testée.

## Travailler avec un dépôt distant

Pour collaborer, l''équipe partage un dépôt en ligne sur **GitHub**, **GitLab** ou **Bitbucket** :

```bash
git clone https://github.com/startup-td/reservation-bus.git   # récupérer un projet existant
git pull                                                     # récupérer les nouveautés des collègues
git push                                                     # envoyer tes commits
```

Le flux classique en équipe : créer une branche, pousser la branche, ouvrir une **demande de fusion** (*pull request* sur GitHub, *merge request* sur GitLab), faire relire le code par un collègue, puis fusionner.

## Résoudre un conflit

Si deux personnes modifient la même ligne, Git ne peut pas choisir à leur place : c''est un **conflit**. Il l''indique dans le fichier :

```text
<<<<<<< HEAD
$prixBillet = 15000;
=======
$prixBillet = 17500;
>>>>>>> nouveaux-tarifs
```

Tu choisis la bonne version (ou tu combines les deux), tu supprimes les marqueurs `<<<<<<<`, `=======` et `>>>>>>>`, puis :

```bash
git add tarifs.php
git commit -m "Résout le conflit sur le prix des billets"
```

## À toi de jouer

1. Crée un dossier `reservation-bus`, initialise un dépôt Git et ajoute un fichier `README.md` décrivant le projet. Fais un premier commit.
2. Crée un fichier `.gitignore` qui exclut `config.php` et les fichiers `.log`.
3. Crée une branche `page-tarifs`, ajoute un fichier `tarifs.txt` avec trois trajets et leurs prix, et commite.
4. Reviens sur `main`, modifie le `README.md`, commite, puis fusionne `page-tarifs`.
5. Provoque volontairement un conflit : modifie la même ligne de `tarifs.txt` sur deux branches différentes, puis fusionne et résous le conflit.
6. Affiche l''historique avec `git log --oneline --graph`.

> **Pour t''auto-évaluer** : si tu peux expliquer à un camarade, en regardant le graphe de `git log --graph`, à quel moment chaque branche a été créée et fusionnée, tu as compris l''essentiel de Git.

## Vérifie tes acquis

1. Quelle commande prépare un fichier pour le prochain commit ?
2. À quoi sert le fichier `.gitignore` ?
3. Que dois-tu faire si Git signale un conflit ?

> **Réponses** : 1. `git add`. 2. À indiquer les fichiers que Git doit ignorer (secrets, dépendances, fichiers temporaires). 3. Ouvrir le fichier, choisir le bon contenu, supprimer les marqueurs de conflit, puis faire `git add` et `git commit`.

## En résumé

- Git enregistre l''**historique** du code sous forme de **commits**.
- Cycle quotidien : `git status`, `git add`, `git commit`, `git log`.
- Les **branches** isolent chaque fonctionnalité ; `git merge` les intègre.
- `git clone`, `git pull` et `git push` synchronisent avec un dépôt distant.
- Jamais de secrets dans Git : utilise `.gitignore`.

## Pour aller plus loin

- [Le livre Pro Git, gratuit et en français](https://git-scm.com/book/fr/v2)
- Demande au mentor IA : « Quelle est la différence entre git merge et git rebase ? Quand utiliser l''un ou l''autre ? »'
WHERE t.slug = 'devops-cloud' AND l.title = 'Git, les bases indispensables';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Intégration et déploiement continus, pipeline GitHub Actions et gestion des secrets.', l.duration_minutes = 25, l.content = 'Dans la startup d''Ibrahim, la mise en ligne d''une nouvelle version se fait à la main : un développeur copie les fichiers par FTP le vendredi soir… et passe parfois le week-end à réparer ce qui a cassé. La **CI/CD** automatise ce processus : chaque modification est testée automatiquement, puis déployée de façon fiable et répétable.

> **Objectifs de ce chapitre**
> - Comprendre l''intégration continue (CI) et le déploiement continu (CD)
> - Connaître les étapes d''un pipeline
> - Lire et écrire un workflow GitHub Actions simple
> - Savoir où ranger les secrets d''un pipeline

## Le problème à résoudre

Sans automatisation, chaque mise en production comporte des risques : un test oublié, un fichier mal copié, une étape sautée par fatigue. Plus les mises en ligne sont rares, plus elles regroupent de changements, et plus elles sont risquées. C''est un cercle vicieux.

L''idée de la CI/CD est inverse : livrer **souvent**, par **petits** changements, avec des étapes **automatisées** et donc identiques à chaque fois.

## Intégration continue (CI)

À chaque `git push`, un serveur récupère le code et exécute automatiquement une série de vérifications :

- installation des dépendances ;
- vérification du style de code (*lint*) ;
- exécution des tests automatisés ;
- construction de l''application (*build*).

Si une étape échoue, le développeur est prévenu en quelques minutes, pendant que le changement est encore frais dans sa tête. On ne fusionne dans `main` que du code qui passe la CI.

## Livraison et déploiement continus (CD)

- **Livraison continue** (*Continuous Delivery*) : après la CI, l''application est prête à être déployée ; une personne valide la mise en production d''un clic.
- **Déploiement continu** (*Continuous Deployment*) : la mise en production est entièrement automatique dès que la CI réussit.

La plupart des équipes commencent par la livraison continue, en gardant une validation humaine.

## Le pipeline

L''enchaînement des étapes s''appelle un **pipeline** :

```text
push → installation → lint → tests → build → déploiement en préproduction → validation → production
```

L''environnement de **préproduction** (*staging*) est une copie de la production où l''on vérifie la nouvelle version avant de l''exposer aux vrais utilisateurs.

## Un exemple avec GitHub Actions

**GitHub Actions** permet de définir un pipeline dans un fichier YAML placé dans le dépôt, sous `.github/workflows/ci.yml` :

```yaml
name: CI

on:
  push:
    branches: [main]
  pull_request:

jobs:
  tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: shivammathur/setup-php@v2
        with:
          php-version: ''8.2''
      - run: composer install --no-progress
      - run: php -l index.php
      - run: vendor/bin/phpunit
```

Ligne par ligne :

- `on` : le pipeline se déclenche à chaque push sur `main` et à chaque demande de fusion.
- `runs-on` : il s''exécute sur une machine Linux fournie par GitHub.
- `steps` : les étapes, dans l''ordre. `checkout` récupère le code, `setup-php` installe PHP, puis on installe les dépendances, on vérifie la syntaxe et on lance les tests.

> **Info** : GitLab propose l''équivalent avec GitLab CI (fichier `.gitlab-ci.yml`). Les concepts sont les mêmes ; seule la syntaxe change.

## Les secrets

Pour déployer, le pipeline a besoin d''informations sensibles : mot de passe FTP, clé SSH, clé d''API. Elles ne doivent **jamais** être écrites dans le fichier YAML. On les enregistre dans les **secrets** du dépôt (sur GitHub : *Settings → Secrets and variables → Actions*), puis on les utilise ainsi :

```yaml
      - run: ./deployer.sh
        env:
          CLE_SSH: ${{ secrets.CLE_SSH_SERVEUR }}
```

> **Attention** : un secret affiché par erreur dans les journaux d''exécution doit être considéré comme compromis. GitHub masque les secrets connus, mais pas leurs transformations : n''affiche jamais une variable sensible avec `echo`.

## Les bonnes pratiques

- Un pipeline **rapide** (moins de 10 minutes) : sinon les développeurs le contournent.
- Un pipeline **rouge** (en échec) se répare en priorité, avant toute nouvelle fonctionnalité.
- Les mêmes étapes pour tout le monde : personne ne déploie « à la main en vitesse ».
- Un moyen simple de **revenir en arrière** (*rollback*) si la nouvelle version pose problème.

## À toi de jouer

1. Sur GitHub, crée un dépôt public contenant un simple fichier `index.php`.
2. Ajoute le fichier `.github/workflows/ci.yml` qui vérifie la syntaxe PHP avec `php -l` à chaque push (sans Composer ni PHPUnit pour commencer).
3. Pousse un commit et observe l''exécution dans l''onglet **Actions**.
4. Introduis volontairement une erreur de syntaxe (un point-virgule manquant), pousse, et constate que le pipeline passe au rouge.
5. Corrige l''erreur et vérifie que le pipeline repasse au vert.

> **Pour t''auto-évaluer** : explique en trois phrases à un responsable non technique ce que le pipeline apporte à l''entreprise. Si ton explication parle de risques et de temps gagné plutôt que d''outils, c''est réussi.

## Vérifie tes acquis

1. Quelle est la différence entre livraison continue et déploiement continu ?
2. Où doit-on stocker le mot de passe du serveur utilisé par le pipeline ?
3. Que faire en priorité quand le pipeline de `main` est en échec ?

> **Réponses** : 1. En livraison continue, une personne valide la mise en production ; en déploiement continu, elle est automatique. 2. Dans les secrets du dépôt, jamais dans le fichier du pipeline. 3. Le réparer avant toute autre tâche.

## En résumé

- La **CI** vérifie automatiquement chaque modification (lint, tests, build).
- La **CD** prépare (livraison) ou réalise (déploiement) la mise en production automatiquement.
- Un **pipeline** enchaîne ces étapes ; GitHub Actions le décrit dans un fichier YAML.
- Les **secrets** se rangent dans le coffre-fort du dépôt, jamais dans le code.
- Livrer souvent par petits changements réduit les risques.

## Pour aller plus loin

- [La documentation de GitHub Actions](https://docs.github.com/fr/actions)
- Demande au mentor IA : « Comment ajouter à mon workflow GitHub Actions un déploiement automatique par SSH sur mon serveur ? »'
WHERE t.slug = 'devops-cloud' AND l.title = 'Qu''est-ce que la CI/CD ?';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Images, conteneurs, Dockerfile, volumes et Docker Compose.', l.duration_minutes = 30, l.content = '« Chez moi, ça marche ! » C''est la phrase la plus célèbre des développeurs. L''application tourne sur l''ordinateur d''Ibrahim avec PHP 8.2, mais le serveur a PHP 7.4 ; une bibliothèque manque ; une configuration diffère. **Docker** règle ce problème en emballant l''application avec **tout** ce dont elle a besoin dans un **conteneur**, qui fonctionne de la même façon partout.

> **Objectifs de ce chapitre**
> - Comprendre la différence entre conteneur et machine virtuelle
> - Distinguer image et conteneur
> - Lancer et gérer des conteneurs avec les commandes de base
> - Écrire un Dockerfile
> - Assembler plusieurs services avec Docker Compose

## Conteneur ou machine virtuelle ?

Une **machine virtuelle** simule un ordinateur complet, avec son propre système d''exploitation : elle est lourde (plusieurs Go) et lente à démarrer.

Un **conteneur** partage le noyau du système hôte et n''embarque que l''application et ses dépendances : il pèse souvent quelques dizaines de Mo et démarre en une seconde. Sur un même serveur, on peut faire tourner des dizaines de conteneurs.

Pense aux **conteneurs maritimes** qui arrivent au port de Douala puis par camion jusqu''à N''Djamena : quel que soit le contenu, ils ont une taille standard et se chargent de la même façon sur n''importe quel bateau ou camion. Docker applique ce principe au logiciel.

## Image et conteneur

- Une **image** est un modèle en lecture seule : le système de fichiers et la configuration de l''application. C''est la recette.
- Un **conteneur** est une instance en cours d''exécution d''une image. C''est le plat préparé à partir de la recette.

À partir d''une même image, on peut lancer plusieurs conteneurs. Les images publiques (PHP, MySQL, Nginx…) se trouvent sur **Docker Hub**.

## Les commandes essentielles

```bash
docker run -d --name web -p 8080:80 nginx   # lance un serveur web Nginx
docker ps                                   # liste les conteneurs en cours
docker logs web                             # affiche les journaux du conteneur
docker exec -it web sh                      # ouvre un terminal dans le conteneur
docker stop web && docker rm web            # arrête puis supprime le conteneur
docker images                               # liste les images téléchargées
```

L''option `-p 8080:80` relie le port 8080 de ta machine au port 80 du conteneur : ouvre `http://localhost:8080` pour voir la page d''accueil de Nginx. `-d` lance le conteneur en arrière-plan.

> **Info** : un conteneur est **éphémère** : si tu le supprimes, les fichiers créés dedans disparaissent. Pour garder des données (une base de données par exemple), on utilise un **volume**, un espace de stockage géré par Docker qui survit au conteneur.

## Écrire un Dockerfile

Pour emballer ta propre application, tu écris un **Dockerfile** à la racine du projet :

```dockerfile
FROM php:8.2-apache

RUN docker-php-ext-install pdo_mysql

COPY . /var/www/html/

EXPOSE 80
```

- `FROM` : l''image de départ (ici PHP 8.2 avec le serveur Apache).
- `RUN` : une commande exécutée pendant la construction (ici, installer l''extension PDO MySQL).
- `COPY` : copie le code du projet dans l''image.
- `EXPOSE` : documente le port utilisé.

On construit l''image puis on la lance :

```bash
docker build -t reservation-bus:1.0 .
docker run -d -p 8080:80 reservation-bus:1.0
```

## Plusieurs services avec Docker Compose

Une vraie application a besoin de plusieurs conteneurs : le site PHP et la base MySQL. **Docker Compose** les décrit dans un fichier `compose.yaml` :

```yaml
services:
  web:
    build: .
    ports:
      - "8080:80"
    depends_on:
      - db
  db:
    image: mysql:8.0
    environment:
      MYSQL_DATABASE: reservation
      MYSQL_ROOT_PASSWORD: change-moi
    volumes:
      - donnees-mysql:/var/lib/mysql

volumes:
  donnees-mysql:
```

Une seule commande lance tout : `docker compose up -d`. Et `docker compose down` arrête tout. Dans le code PHP, le serveur de base de données s''appelle simplement `db` : Compose crée un réseau où les services se trouvent par leur nom.

> **Attention** : le mot de passe écrit en clair dans `compose.yaml` convient pour apprendre en local. En production, on utilise un fichier `.env` exclu de Git, ou un gestionnaire de secrets.

## À toi de jouer

1. Installe Docker Desktop (Windows, Mac) ou Docker Engine (Linux).
2. Lance un conteneur Nginx sur le port 8080 et vérifie qu''il répond dans le navigateur.
3. Crée un dossier avec un fichier `index.php` qui affiche `phpversion()`, et un Dockerfile basé sur `php:8.2-apache`. Construis l''image et lance-la.
4. Ajoute un fichier `compose.yaml` avec un service `db` MySQL et un volume. Lance l''ensemble avec `docker compose up -d`.
5. Modifie `index.php` pour te connecter à la base avec PDO (hôte `db`) et afficher « Connexion réussie ».
6. Supprime les conteneurs avec `docker compose down`, relance-les, et vérifie que les données de la base sont toujours là grâce au volume.

> **Pour t''auto-évaluer** : un camarade doit pouvoir lancer ton projet complet sur sa machine avec seulement `git clone` puis `docker compose up -d`, sans rien installer d''autre que Docker.

## Vérifie tes acquis

1. Quelle est la différence entre une image et un conteneur ?
2. Que fait l''option `-p 8080:80` ?
3. Pourquoi utiliser un volume pour une base de données ?

> **Réponses** : 1. L''image est le modèle (la recette), le conteneur est une instance en cours d''exécution de cette image. 2. Elle relie le port 8080 de la machine hôte au port 80 du conteneur. 3. Pour que les données survivent à la suppression du conteneur.

## En résumé

- Un **conteneur** embarque une application et ses dépendances ; il est léger et identique partout.
- Une **image** est le modèle, un **conteneur** son exécution.
- `docker run`, `ps`, `logs`, `exec`, `stop` sont les commandes de base.
- Le **Dockerfile** décrit comment construire l''image de ton application.
- **Docker Compose** orchestre plusieurs services ; les **volumes** conservent les données.

## Pour aller plus loin

- [La documentation officielle de Docker](https://docs.docker.com/get-started/)
- Demande au mentor IA : « Comment réduire la taille de mon image Docker PHP ? »'
WHERE t.slug = 'devops-cloud' AND l.title = 'Introduction à Docker';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'IaaS, PaaS, SaaS, déploiement sur VPS, DNS, HTTPS, sauvegardes et supervision.', l.duration_minutes = 30, l.content = 'L''application de réservation de bus fonctionne en local dans Docker. Il est temps de la rendre accessible aux voyageurs de tout le Tchad. Où l''héberger ? Sur un serveur au bureau, chez un hébergeur mutualisé, ou dans le **cloud** ? Ce chapitre t''aide à choisir et te guide pour un premier déploiement sur un serveur virtuel.

> **Objectifs de ce chapitre**
> - Comprendre ce qu''est le cloud et ses modèles (IaaS, PaaS, SaaS)
> - Choisir un type d''hébergement selon le projet et le budget
> - Déployer une application Docker sur un VPS
> - Configurer un nom de domaine et HTTPS
> - Mettre en place sauvegardes et supervision de base

## Le cloud, c''est quoi ?

Le **cloud** consiste à louer des ressources informatiques (serveurs, stockage, bases de données) à un fournisseur, à la demande, au lieu de les acheter et de les gérer soi-même. Tu payes ce que tu utilises, tu peux augmenter la puissance en quelques minutes, et le fournisseur s''occupe du matériel, de l''électricité et de la climatisation.

## Les trois modèles

| Modèle | Tu gères | Le fournisseur gère | Exemples |
| --- | --- | --- | --- |
| **IaaS** (infrastructure) | Système, logiciels, application | Matériel, réseau | VPS chez OVHcloud, Hetzner, DigitalOcean ; machines virtuelles AWS, Azure |
| **PaaS** (plateforme) | Ton code et sa configuration | Serveur, système, mises à jour | Render, Heroku, Google App Engine |
| **SaaS** (logiciel) | Tes données et paramètres | Tout le reste | Gmail, Google Drive, Microsoft 365 |

Plus on monte vers le SaaS, moins il y a de travail technique, mais moins on a de contrôle.

> **Info** : pour un public au Tchad, la **latence** compte : un serveur en Europe répond généralement plus vite qu''un serveur aux États-Unis. Le choix de la région du centre de données a un vrai impact sur la rapidité perçue.

## Choisir son hébergement

- **Hébergement mutualisé** (comme LWS) : idéal pour un site PHP classique, peu cher, sans administration système. Mais pas de Docker et peu de liberté.
- **VPS** (serveur privé virtuel) : un serveur Linux à toi, à partir de quelques milliers de FCFA par mois. Tu installes ce que tu veux, Docker compris, mais tu es responsable de la sécurité et des mises à jour.
- **PaaS** : tu pousses ton code, la plateforme s''occupe du reste. Très confortable, plus cher à grande échelle.

Pour l''application d''Ibrahim, packagée en Docker et sans budget pour une équipe système, un petit VPS est un bon compromis.

## Déployer sur un VPS, étape par étape

### 1. Se connecter et sécuriser le serveur

```bash
ssh root@203.0.113.25
adduser ibrahim && usermod -aG sudo ibrahim
apt update && apt upgrade -y
ufw allow OpenSSH && ufw allow 80 && ufw allow 443 && ufw enable
```

On crée un utilisateur personnel, on met le système à jour et on active le pare-feu en n''ouvrant que SSH et le web. Ensuite, on configure la connexion par **clé SSH** et on désactive la connexion par mot de passe.

### 2. Installer Docker et récupérer le projet

```bash
curl -fsSL https://get.docker.com | sh
git clone https://github.com/startup-td/reservation-bus.git
cd reservation-bus
cp .env.exemple .env      # puis renseigner les vrais mots de passe
docker compose up -d
```

### 3. Nom de domaine et HTTPS

Chez ton registraire de domaine, crée un **enregistrement DNS de type A** qui pointe `bus.exemple.td` vers l''adresse IP du VPS. Ensuite, place devant l''application un **reverse proxy** qui gère le certificat HTTPS gratuit de Let''s Encrypt. **Caddy** le fait automatiquement avec une configuration de deux lignes :

```text
bus.exemple.td {
    reverse_proxy localhost:8080
}
```

> **Attention** : ne publie jamais une application qui gère des comptes ou des paiements sans HTTPS. Sans chiffrement, les mots de passe circulent en clair sur le réseau.

## Après le déploiement

Mettre en ligne n''est que le début. Trois réflexes indispensables :

- **Sauvegardes** automatiques et quotidiennes de la base de données, stockées **ailleurs** que sur le serveur (et testées : une sauvegarde jamais restaurée n''est pas une sauvegarde).
- **Supervision** : un service gratuit comme UptimeRobot vérifie toutes les 5 minutes que le site répond et t''alerte sinon.
- **Mises à jour** régulières du système et des images Docker, pour corriger les failles de sécurité.

Exemple de sauvegarde planifiée chaque nuit avec `cron` :

```bash
0 2 * * * docker compose -f /home/ibrahim/reservation-bus/compose.yaml exec -T db mysqldump -uroot -p"$MDP" reservation | gzip > /home/ibrahim/sauvegardes/reservation-$(date +\\%F).sql.gz
```

## À toi de jouer

Sans forcément louer de serveur, prépare le **dossier de déploiement** de l''application d''Ibrahim :

1. Choisis un type d''hébergement et justifie ce choix en cinq lignes (budget, compétences de l''équipe, besoins techniques).
2. Écris la liste ordonnée des commandes pour préparer et sécuriser le serveur.
3. Décris la configuration DNS et HTTPS.
4. Rédige la stratégie de sauvegarde : quoi, quand, où, combien de temps on garde les copies, et comment on teste la restauration.
5. Bonus : si tu as accès à un VPS (beaucoup de fournisseurs offrent un crédit d''essai), réalise le déploiement complet.

> **Pour t''auto-évaluer** : ton dossier est complet si un autre développeur peut redéployer l''application de zéro, seul, en suivant uniquement tes instructions.

## Vérifie tes acquis

1. Quelle est la différence entre IaaS et PaaS ?
2. Quel enregistrement DNS relie un nom de domaine à l''adresse IP d''un serveur ?
3. Pourquoi stocker les sauvegardes ailleurs que sur le serveur ?

> **Réponses** : 1. En IaaS, tu gères le système et les logiciels ; en PaaS, la plateforme s''en charge et tu ne gères que ton code. 2. Un enregistrement de type A. 3. Pour pouvoir restaurer les données même si le serveur est détruit, piraté ou inaccessible.

## En résumé

- Le **cloud** loue des ressources à la demande ; trois modèles : IaaS, PaaS, SaaS.
- Le choix dépend du budget, des compétences et des besoins (mutualisé, VPS, PaaS).
- Un déploiement sur VPS : sécuriser, installer Docker, lancer l''application, configurer DNS et HTTPS.
- Après la mise en ligne : **sauvegardes testées**, **supervision**, **mises à jour**.

## Pour aller plus loin

- [La documentation de Caddy](https://caddyserver.com/docs/) pour le HTTPS automatique
- Demande au mentor IA : « Comment déployer automatiquement sur mon VPS à chaque push grâce à GitHub Actions ? »'
WHERE t.slug = 'devops-cloud' AND l.title = 'Déployer une application dans le cloud';


-- =====================================================================
-- Développement Mobile (developpement-mobile)
-- =====================================================================
UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Natif, Flutter, React Native ou PWA : choisir selon le projet et les réalités du terrain.', l.duration_minutes = 25, l.content = 'Au Tchad, l''immense majorité des internautes se connectent depuis un **smartphone Android**, souvent d''entrée de gamme, avec une connexion 3G ou 4G variable. Créer une application mobile, c''est donc toucher directement ces utilisateurs. Mais avant d''écrire la moindre ligne de code, il faut faire un choix technique important : développer en **natif** ou en **multiplateforme** ?

Dans ce parcours, tu accompagnes **Achta**, qui veut créer **MarchéTchad**, une application pour consulter les prix des produits de base (mil, sorgho, sucre, huile) dans les principaux marchés du pays.

> **Objectifs de ce chapitre**
> - Connaître les trois grandes approches du développement mobile
> - Comparer leurs avantages et leurs inconvénients
> - Choisir une approche selon le projet, le budget et le public
> - Tenir compte des réalités du marché tchadien

## Approche 1 : le natif

On développe une application **différente pour chaque système**, avec les outils officiels :

- **Android** : langage **Kotlin** (ou Java), avec Android Studio.
- **iOS** (iPhone) : langage **Swift**, avec Xcode, qui ne fonctionne que sur un Mac.

Avantages : les meilleures performances, l''accès immédiat à toutes les fonctionnalités du téléphone, une interface parfaitement conforme à chaque système.

Inconvénients : deux applications à écrire et à maintenir, donc deux fois plus de temps et souvent deux équipes.

## Approche 2 : le multiplateforme

On écrit **un seul code** qui produit une application Android **et** une application iOS. Les deux outils les plus utilisés :

| Outil | Langage | Porté par | Points forts |
| --- | --- | --- | --- |
| **Flutter** | Dart | Google | Interface identique partout, très bonnes performances, rechargement à chaud |
| **React Native** | JavaScript / TypeScript | Meta | Idéal pour les développeurs web qui connaissent déjà JavaScript et React |

Avantages : un seul code, une seule équipe, un développement nettement plus rapide.

Inconvénients : une couche supplémentaire entre ton code et le téléphone, parfois besoin d''écrire un peu de code natif pour des fonctions très spécifiques, et une application un peu plus lourde.

## Approche 3 : l''application web progressive (PWA)

Une **PWA** est un site web qui se comporte comme une application : on peut l''installer sur l''écran d''accueil, elle fonctionne en partie hors ligne et peut envoyer des notifications.

Avantages : pas de passage par le Play Store, une seule base de code web, mises à jour instantanées.

Inconvénients : accès plus limité aux fonctions du téléphone, moins visible qu''une application du Play Store, et une prise en charge plus restreinte sur iPhone.

> **Info** : beaucoup de projets commencent par une PWA ou un site mobile bien conçu pour tester l''idée à moindre coût, puis passent à une application quand le besoin est confirmé.

## Les critères de choix

| Critère | Questions à se poser |
| --- | --- |
| Public | Android seulement, ou aussi iPhone ? |
| Budget et délai | Combien de développeurs, combien de mois ? |
| Fonctionnalités | Besoin du GPS, de la caméra, du Bluetooth, du mode hors ligne ? |
| Performances | Jeu, vidéo, cartes complexes, ou simples formulaires et listes ? |
| Compétences | L''équipe connaît-elle JavaScript, Dart, Kotlin ? |
| Maintenance | Qui fera évoluer l''application dans deux ans ? |

## Les réalités du terrain au Tchad

Quelle que soit l''approche, quelques contraintes locales doivent guider la conception :

- **Téléphones modestes** : peu de mémoire et de stockage. Une application de 150 Mo sera désinstallée au premier manque de place.
- **Connexion instable et data coûteuse** : prévois un **mode hors ligne** (afficher les dernières données enregistrées) et limite la taille des images.
- **Langues** : français et arabe, avec l''écriture de droite à gauche pour l''arabe ; pense aussi aux utilisateurs peu à l''aise avec l''écrit (icônes claires, messages vocaux).
- **Batterie** : coupures d''électricité fréquentes, donc pas de tâches inutiles en arrière-plan.

> **Attention** : teste toujours ton application sur un téléphone d''entrée de gamme réel, pas seulement sur l''émulateur de ton ordinateur ou sur le smartphone haut de gamme d''un collègue.

## À toi de jouer

Achta te donne le cahier des charges de MarchéTchad :

- consulter les prix du jour dans 10 marchés (N''Djamena, Moundou, Sarh, Abéché…) ;
- consulter les derniers prix même sans connexion ;
- recevoir une notification quand le prix d''un produit suivi change ;
- public : commerçants et ménages, surtout sur Android d''entrée de gamme ;
- équipe : un seul développeur, qui connaît un peu JavaScript ; budget limité ; lancement dans 4 mois.

1. Compare les trois approches dans un tableau de critères.
2. Recommande une approche et justifie ce choix en cinq lignes.
3. Liste trois décisions de conception liées aux réalités du terrain.

> **Exemple de réponse** : Flutter (ou React Native, plus proche des compétences JavaScript du développeur) est un bon choix : une seule base de code, un bon mode hors ligne grâce au stockage local, des notifications, et un éventuel passage sur iPhone plus tard sans réécriture. Une PWA serait aussi défendable pour un premier test à très faible coût. Décisions terrain : cache local des prix, images très légères, interface en français et en arabe.

## Vérifie tes acquis

1. Quel langage utilise-t-on pour une application Android native moderne ?
2. Quel est le principal avantage d''un outil multiplateforme comme Flutter ?
3. Cite deux contraintes du terrain tchadien à prendre en compte dans la conception.

> **Réponses** : 1. Kotlin. 2. Un seul code pour Android et iOS, donc moins de temps et de coûts. 3. Par exemple : téléphones peu puissants, connexion instable et data coûteuse, langues française et arabe.

## En résumé

- **Natif** : performances maximales, mais une application par système.
- **Multiplateforme** (Flutter, React Native) : un seul code pour Android et iOS.
- **PWA** : un site installable, sans Play Store, plus limité.
- Le choix dépend du public, du budget, des fonctionnalités et des compétences de l''équipe.
- Au Tchad : applications légères, mode hors ligne et tests sur de vrais téléphones d''entrée de gamme.

## Pour aller plus loin

- Demande au mentor IA : « Quels sont les avantages et inconvénients de Flutter par rapport à React Native pour un développeur qui connaît JavaScript ? »'
WHERE t.slug = 'developpement-mobile' AND l.title = 'Natif vs multiplateforme';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Écrans, navigation, cycle de vie, stockage local, API JSON et permissions.', l.duration_minutes = 25, l.content = 'Avant de coder MarchéTchad, Achta veut comprendre de quoi est faite une application mobile. Derrière l''icône sur l''écran d''accueil se cachent des écrans, une navigation, des données stockées dans le téléphone, des échanges avec un serveur et un cycle de vie particulier. Ce chapitre te donne cette vue d''ensemble indispensable.

> **Objectifs de ce chapitre**
> - Identifier les composants d''une application mobile
> - Comprendre la navigation entre écrans
> - Connaître le cycle de vie d''une application
> - Savoir où et comment stocker des données
> - Comprendre la communication avec un serveur par API
> - Connaître le rôle des permissions

## Les écrans et la navigation

Une application est une suite d''**écrans** (on dit aussi pages ou vues). Pour MarchéTchad :

1. un écran **d''accueil** avec la liste des marchés ;
2. un écran **marché** avec les produits et leurs prix ;
3. un écran **détail produit** avec l''historique des prix ;
4. un écran **paramètres** (langue, produits suivis).

La **navigation** fonctionne comme une pile d''assiettes : quand on ouvre un écran, il est posé sur le dessus ; le bouton retour retire l''assiette du dessus et revient à l''écran précédent. On trouve aussi souvent une **barre d''onglets** en bas de l''écran pour passer d''une section principale à l''autre.

> **Astuce** : dessine toujours le parcours de l''utilisateur sur papier avant de coder : quels écrans, quels boutons, où mène chaque bouton. Tu gagneras des heures.

## Le cycle de vie

Contrairement à un site web, une application mobile peut être interrompue à tout moment : un appel entrant, un passage à WhatsApp, l''écran qui se verrouille. Elle passe par plusieurs états :

| État | Situation | Ce que l''application doit faire |
| --- | --- | --- |
| Au premier plan | L''utilisateur s''en sert | Fonctionner normalement |
| En arrière-plan | L''utilisateur est passé à une autre application | Sauvegarder ce qui est en cours, arrêter les tâches inutiles |
| Arrêtée | Le système l''a fermée pour libérer de la mémoire | Pouvoir reprendre proprement au prochain lancement |

> **Attention** : sur les téléphones avec peu de mémoire, Android ferme souvent les applications en arrière-plan. Si l''utilisateur remplissait un formulaire, enregistre son brouillon, sinon il perdra tout.

## Stocker des données dans le téléphone

Selon le besoin, plusieurs solutions :

- **Préférences clé-valeur** (SharedPreferences sur Android, `shared_preferences` en Flutter) : pour de petites informations comme la langue choisie ou le dernier marché consulté.
- **Base de données locale** (SQLite, Hive, Isar) : pour des listes structurées, comme tous les prix téléchargés, consultables hors ligne.
- **Fichiers** : pour les images ou documents téléchargés.
- **Stockage sécurisé** (Keystore, `flutter_secure_storage`) : pour les informations sensibles comme un jeton de connexion. Jamais de mot de passe en clair !

## Communiquer avec un serveur : les API

Les prix du jour ne sont pas dans l''application : ils sont sur un **serveur**, mis à jour par les agents de collecte. L''application les récupère par une **API** (interface de programmation), le plus souvent une API **REST** qui répond en **JSON** :

```text
GET https://api.marchetchad.td/marches/ndjamena/prix
```

```json
{
  "marche": "N''Djamena - Marché central",
  "date": "2026-10-08",
  "prix": [
    { "produit": "Mil", "unite": "coro", "prix": 1000 },
    { "produit": "Sucre", "unite": "kg", "prix": 900 }
  ]
}
```

Le schéma typique : l''application affiche d''abord les **données en cache** (déjà enregistrées), puis tente de récupérer les nouvelles données ; si elle y parvient, elle met à jour l''écran et le cache. L''utilisateur voit toujours quelque chose, même sans réseau.

> **Info** : le format JSON est le même que celui que tu as peut-être déjà manipulé en JavaScript. C''est le langage commun entre presque toutes les applications et leurs serveurs.

## Les permissions

Pour accéder à certaines fonctions sensibles, l''application doit demander l''accord de l''utilisateur : localisation, caméra, micro, contacts, notifications. Bonnes pratiques :

- ne demander que les permissions **vraiment nécessaires** ;
- les demander **au moment où on en a besoin**, avec une explication (« Pour afficher les marchés proches de vous ») ;
- prévoir le cas où l''utilisateur refuse : l''application doit continuer à fonctionner autrement.

## Le paquet de l''application

Une application Android est distribuée sous forme de fichier **APK** ou, pour le Play Store, **AAB**. Elle contient le code compilé, les ressources (images, traductions, icônes) et un fichier **manifeste** qui déclare son nom, sa version et ses permissions.

## À toi de jouer

Prépare la fiche d''architecture de MarchéTchad :

1. Dessine les écrans et les flèches de navigation entre eux.
2. Pour chaque donnée (langue choisie, produits suivis, prix téléchargés, jeton de connexion d''un agent de collecte), indique où la stocker et pourquoi.
3. Écris l''exemple de réponse JSON de l''API pour l''historique des prix d''un produit sur 7 jours.
4. Liste les permissions nécessaires et le message d''explication montré à l''utilisateur pour chacune.

> **Éléments de correction** : langue et produits suivis dans les préférences ; prix dans une base locale pour le hors ligne ; jeton dans le stockage sécurisé. Permissions : notifications (« pour vous prévenir quand un prix change ») et éventuellement localisation (« pour afficher les marchés proches »), facultative.

## Vérifie tes acquis

1. Pourquoi une application doit-elle sauvegarder les données en cours quand elle passe en arrière-plan ?
2. Où stocker un jeton de connexion sur le téléphone ?
3. Quel format de données utilisent la plupart des API REST ?

> **Réponses** : 1. Parce que le système peut la fermer à tout moment pour libérer de la mémoire. 2. Dans le stockage sécurisé du système. 3. Le JSON.

## En résumé

- Une application est faite d''**écrans** reliés par une **navigation** en pile.
- Son **cycle de vie** impose de sauvegarder les données quand elle passe en arrière-plan.
- Préférences, base locale, fichiers et stockage sécurisé répondent à des besoins différents.
- Les données viennent d''un serveur par une **API REST** en **JSON** ; le cache permet le hors ligne.
- Les **permissions** se demandent au bon moment, avec une explication.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi la stratégie cache d''abord puis réseau pour une application mobile hors ligne. »'
WHERE t.slug = 'developpement-mobile' AND l.title = 'Anatomie d''une application mobile';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Créer un premier écran Flutter : mise en page, listes, état et navigation.', l.duration_minutes = 30, l.content = 'Achta a choisi **Flutter** pour MarchéTchad. En Flutter, tout ce que tu vois à l''écran est un **widget** : un texte, un bouton, une marge, une liste, et même l''écran entier. On construit une interface en emboîtant des widgets les uns dans les autres, comme des briques. Dans ce chapitre, tu vas créer ton premier écran : la liste des prix d''un marché.

> **Objectifs de ce chapitre**
> - Créer et lancer un projet Flutter
> - Comprendre l''arbre de widgets
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

Le code de l''application se trouve dans `lib/main.dart`. Pendant que l''application tourne, enregistre une modification : grâce au **hot reload** (rechargement à chaud), elle apparaît à l''écran en moins d''une seconde, sans perdre l''état de l''application.

> **Info** : si ton ordinateur est trop modeste pour l''émulateur Android, branche directement un téléphone Android en activant le **débogage USB** dans les options pour développeurs. C''est souvent plus rapide.

## Ton premier écran

Remplace le contenu de `lib/main.dart` par :

```dart
import ''package:flutter/material.dart'';

void main() {
  runApp(const MarcheTchadApp());
}

class MarcheTchadApp extends StatelessWidget {
  const MarcheTchadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ''MarchéTchad'',
      theme: ThemeData(colorSchemeSeed: Colors.orange),
      home: Scaffold(
        appBar: AppBar(title: const Text(''Marché central de N\\''Djamena'')),
        body: const Center(
          child: Text(''Bienvenue sur MarchéTchad''),
        ),
      ),
    );
  }
}
```

- `MaterialApp` : la racine de l''application, avec le thème et l''écran d''accueil.
- `Scaffold` : la structure d''un écran (barre du haut, corps, bouton flottant…).
- `AppBar`, `Center`, `Text` : des widgets imbriqués grâce aux propriétés `child`, `body`, `title`.
- La méthode `build()` décrit ce qu''il faut afficher ; Flutter l''appelle quand il faut redessiner.

## Les widgets de mise en page

| Widget | Rôle |
| --- | --- |
| `Column` | Empile ses enfants verticalement |
| `Row` | Aligne ses enfants horizontalement |
| `Padding` | Ajoute une marge intérieure autour de son enfant |
| `Container` | Boîte avec taille, couleur, bordure, marge |
| `Expanded` | Prend tout l''espace restant dans une `Row` ou une `Column` |
| `ListView` | Liste qui défile |
| `Card` | Carte avec ombre et coins arrondis |

Exemple d''une ligne de prix :

```dart
Padding(
  padding: const EdgeInsets.all(12),
  child: Row(
    children: const [
      Icon(Icons.grass),
      SizedBox(width: 12),
      Expanded(child: Text(''Mil (le coro)'')),
      Text(''1 000 FCFA'', style: TextStyle(fontWeight: FontWeight.bold)),
    ],
  ),
)
```

## Afficher une liste de prix

On décrit les données avec une classe, puis `ListView.builder` construit une ligne par élément. Il ne crée que les lignes visibles à l''écran, ce qui économise la mémoire sur les téléphones modestes :

```dart
class Prix {
  final String produit;
  final int montant;
  const Prix(this.produit, this.montant);
}

const prixDuJour = [
  Prix(''Mil (coro)'', 1000),
  Prix(''Sorgho (coro)'', 900),
  Prix(''Sucre (kg)'', 900),
  Prix(''Huile (litre)'', 1500),
];

ListView.builder(
  itemCount: prixDuJour.length,
  itemBuilder: (context, index) {
    final p = prixDuJour[index];
    return ListTile(
      title: Text(p.produit),
      trailing: Text(''${p.montant} FCFA''),
    );
  },
)
```

> **Attention** : les prix indiqués dans ces exemples sont fictifs. Dans la vraie application, ils viendront de l''API du serveur.

## Stateless ou Stateful ?

- Un **StatelessWidget** n''a pas d''état qui change : il affiche toujours la même chose pour les mêmes paramètres (un titre, une icône).
- Un **StatefulWidget** possède un **état** qui peut évoluer (un compteur, un produit mis en favori, des données chargées). Quand on modifie l''état avec `setState()`, Flutter redessine le widget.

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

À chaque appui, `setState` inverse la valeur de `suivi` et l''étoile se remplit ou se vide.

> **Astuce** : garde le plus de widgets possible en Stateless et isole l''état dans de petits widgets Stateful. Ton code sera plus simple à comprendre et plus rapide.

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
2. Affiche la liste d''au moins six produits avec leur prix, chacun dans une `Card`.
3. Ajoute une étoile « suivre » sur chaque ligne avec un StatefulWidget.
4. Crée un écran `DetailProduitPage` qui affiche le nom et le prix du produit en grand, et ouvre-le à l''appui sur une ligne.
5. Bonus : affiche en haut de l''écran la date du jour et un sélecteur de marché (`DropdownButton`).

> **Pour t''auto-évaluer** : fais pivoter le téléphone et réduis la taille de l''écran de l''émulateur : rien ne doit déborder (pas de bandes jaunes et noires, le signal d''erreur de dépassement de Flutter).

## Vérifie tes acquis

1. Quel widget sert à empiler des éléments verticalement ?
2. Que fait `setState()` ?
3. Pourquoi préférer `ListView.builder` pour une longue liste ?

> **Réponses** : 1. `Column`. 2. Il modifie l''état d''un StatefulWidget et demande à Flutter de le redessiner. 3. Parce qu''il ne construit que les éléments visibles, ce qui économise mémoire et batterie.

## En résumé

- En Flutter, **tout est widget** ; l''interface est un arbre de widgets imbriqués.
- `MaterialApp` et `Scaffold` posent la structure ; `Column`, `Row`, `Padding`, `Expanded` organisent la mise en page.
- **Stateless** pour l''affichage fixe, **Stateful** + `setState()` pour ce qui change.
- `ListView.builder` affiche efficacement des listes ; `Navigator.push` ouvre un nouvel écran.
- Le **hot reload** accélère énormément le développement.

## Pour aller plus loin

- [La documentation officielle de Flutter](https://docs.flutter.dev/)
- Demande au mentor IA : « Comment charger mes prix depuis une API JSON en Flutter avec le package http ? »'
WHERE t.slug = 'developpement-mobile' AND l.title = 'Les widgets de base (Flutter)';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Signer, construire et publier sur le Play Store, puis suivre et mettre à jour.', l.duration_minutes = 25, l.content = 'MarchéTchad fonctionne sur le téléphone d''Achta. Pour qu''il arrive dans les poches des commerçants de Moundou, Sarh ou Abéché, il faut le **publier**. Sur Android, la voie principale est le **Google Play Store**, mais ce n''est pas la seule. Ce chapitre te guide de la préparation de l''application jusqu''aux premières mises à jour.

> **Objectifs de ce chapitre**
> - Préparer une application pour la production
> - Signer et construire le paquet de publication
> - Créer une fiche Play Store convaincante
> - Connaître les autres canaux de distribution
> - Suivre et mettre à jour l''application après le lancement

## Préparer l''application

Avant de publier, vérifie ces points :

- **Identifiant unique** : chaque application a un identifiant, comme `td.marchetchad.app`. Il ne pourra plus jamais changer après la publication.
- **Nom et icône** : une icône lisible même en petit, sans texte.
- **Numéro de version** : dans `pubspec.yaml` en Flutter, par exemple `version: 1.0.0+1`. Le premier nombre (`1.0.0`) est la version affichée aux utilisateurs ; le second (`+1`) est un compteur qui doit **augmenter à chaque publication**.
- **Taille** : vise le plus léger possible ; compresse les images et retire les ressources inutilisées.
- **Politique de confidentialité** : obligatoire sur le Play Store dès que l''application collecte des données. Une simple page web qui explique quelles données sont collectées et pourquoi suffit pour commencer.

## Signer l''application

Android exige que chaque application soit **signée** avec une clé numérique : c''est ce qui prouve que les mises à jour viennent bien du même développeur.

```bash
keytool -genkey -v -keystore marchetchad-upload.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

On indique ensuite le chemin de cette clé dans la configuration du projet (fichier `android/key.properties` en Flutter), puis on construit le paquet de publication :

```bash
flutter build appbundle --release
```

Le fichier produit, au format **AAB** (*Android App Bundle*), est celui qu''on envoie sur le Play Store. Google génère ensuite des APK optimisés pour chaque type de téléphone, ce qui réduit la taille téléchargée par les utilisateurs.

> **Attention** : sauvegarde la clé de signature et son mot de passe à deux endroits sûrs, et **jamais** dans le dépôt Git. Avec la signature d''application par Google Play, une clé d''envoi perdue peut être réinitialisée, mais au prix de démarches pénibles.

## Publier sur le Google Play Store

1. Crée un compte **Google Play Console**. Des frais d''inscription uniques sont demandés (25 dollars au moment de la rédaction de ce cours ; vérifie le montant actuel).
2. Crée l''application et remplis la **fiche** : titre, description courte et longue, captures d''écran, icône, catégorie.
3. Remplis les questionnaires obligatoires : classification du contenu, public cible, sécurité des données.
4. Envoie l''AAB dans une piste de **test** d''abord. Pour les nouveaux comptes personnels, Google impose une période de test fermé avec un nombre minimal de testeurs avant de pouvoir publier pour tous : lis attentivement les conditions affichées dans la console.
5. Soumets pour examen. La validation prend de quelques heures à quelques jours.

## Une fiche qui donne envie

La fiche du Play Store est ta vitrine. Quelques conseils :

- un **titre** clair qui contient le mot que les gens tapent : « MarchéTchad : prix des marchés » ;
- une **description courte** qui dit le bénéfice en une phrase : « Les prix du mil, du sucre et de l''huile dans 10 marchés du Tchad, même sans connexion » ;
- des **captures d''écran** réelles, avec une courte légende sur chacune ;
- une mention de la **taille légère** et du **mode hors ligne**, de vrais arguments au Tchad.

## Les autres canaux de distribution

- **Fichier APK direct** : partagé par lien de téléchargement ou par WhatsApp. Pratique pour un test rapide avec quelques utilisateurs, mais l''utilisateur doit autoriser les « sources inconnues », ce qui est une mauvaise habitude de sécurité, et les mises à jour ne sont pas automatiques.
- **Autres boutiques** : certains fabricants de téléphones très présents en Afrique, comme Transsion (Tecno, Infinix, itel), Huawei ou Samsung, ont leurs propres boutiques d''applications.
- **Apple App Store** : pour iPhone, avec un compte développeur payant chaque année et un examen plus strict.

> **Info** : au lancement, le bouche-à-oreille et les groupes WhatsApp de commerçants seront probablement tes meilleurs canaux de promotion. Prépare un message court avec le lien direct vers la fiche Play Store.

## Après la publication

Publier n''est que le début :

- **Suis les plantages** (*crashes*) dans la Play Console ou avec un outil comme Firebase Crashlytics, et corrige-les en priorité.
- **Lis et réponds aux avis** : un utilisateur dont le problème est réglé change souvent sa note.
- **Mets à jour régulièrement** : augmente le numéro de version, construis un nouvel AAB, publie-le d''abord pour un petit pourcentage d''utilisateurs (déploiement progressif), puis pour tous si tout va bien.
- **Mesure l''usage** : combien d''installations, combien d''utilisateurs actifs, quels écrans sont les plus consultés.

## À toi de jouer

Prépare le **kit de lancement** de MarchéTchad :

1. Choisis l''identifiant de l''application et le numéro de la première version.
2. Rédige le titre (30 caractères maximum), la description courte (80 caractères maximum) et la description longue (10 lignes) de la fiche Play Store.
3. Liste les cinq captures d''écran à réaliser, avec leur légende.
4. Écris la politique de confidentialité en langage simple (données collectées, pourquoi, avec qui elles sont partagées, comment les supprimer).
5. Rédige le message WhatsApp d''annonce du lancement pour les groupes de commerçants.
6. Bonus : construis réellement l''AAB signé de ton projet Flutter.

> **Pour t''auto-évaluer** : demande à une personne non informaticienne de lire ta fiche Play Store. Si elle comprend en dix secondes à quoi sert l''application et pourquoi elle en aurait besoin, c''est réussi.

## Vérifie tes acquis

1. Quelle partie du numéro de version doit obligatoirement augmenter à chaque publication ?
2. Pourquoi faut-il sauvegarder soigneusement la clé de signature ?
3. Quel est l''inconvénient principal de la distribution d''un APK par WhatsApp ?

> **Réponses** : 1. Le numéro de build (le nombre après le `+` dans `pubspec.yaml`). 2. Parce qu''elle prouve que les mises à jour viennent du même développeur ; sa perte complique fortement la publication des mises à jour. 3. L''utilisateur doit autoriser les sources inconnues et les mises à jour ne sont pas automatiques.

## En résumé

- Avant publication : identifiant définitif, icône, version, taille réduite, politique de confidentialité.
- L''application est **signée** et construite au format **AAB** pour le Play Store.
- La Play Console demande une fiche complète, des questionnaires et souvent une phase de test.
- D''autres canaux existent : APK direct, boutiques des fabricants, App Store.
- Après le lancement : suivi des plantages, réponses aux avis, mises à jour progressives.

## Pour aller plus loin

- [Le guide de publication Android de Flutter](https://docs.flutter.dev/deployment/android)
- Demande au mentor IA : « Rédige-moi une description Play Store optimisée pour une application de prix des marchés au Tchad. »'
WHERE t.slug = 'developpement-mobile' AND l.title = 'Publier son application';


-- =====================================================================
-- Administration Systèmes & Réseaux (administration-systemes-reseaux)
-- =====================================================================
UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Arborescence Linux, fichiers, recherche, surveillance et installation de logiciels.', l.duration_minutes = 30, l.content = 'La grande majorité des serveurs qui font tourner Internet fonctionnent sous **Linux**, et on les administre presque toujours sans interface graphique, depuis un **terminal**. Savoir se déplacer, manipuler des fichiers et diagnostiquer un problème en ligne de commande est la compétence de base de tout administrateur système.

Dans ce parcours, tu suis **Abdelkerim**, technicien récemment embauché dans un fournisseur d''accès Internet de N''Djamena, qui découvre les serveurs Linux de l''entreprise.

> **Objectifs de ce chapitre**
> - Comprendre l''arborescence des fichiers Linux
> - Se déplacer et manipuler fichiers et dossiers
> - Lire et rechercher dans des fichiers texte
> - Surveiller les processus et l''espace disque
> - Installer des logiciels avec le gestionnaire de paquets

## Où pratiquer ?

Plusieurs options gratuites :

- une **machine virtuelle** Ubuntu avec VirtualBox sur ton ordinateur ;
- **WSL** (Windows Subsystem for Linux) sous Windows 10 ou 11 : `wsl --install` dans PowerShell ;
- sur Android, l''application **Termux**, qui offre un vrai terminal Linux sur ton téléphone.

## L''arborescence Linux

Sous Linux, tout part d''une seule racine, notée `/`. Pas de lecteur `C:` ou `D:` : les disques sont rattachés à des dossiers.

| Dossier | Contenu |
| --- | --- |
| `/home` | Les dossiers personnels des utilisateurs (`/home/abdelkerim`) |
| `/etc` | Les fichiers de configuration du système et des services |
| `/var/log` | Les journaux (logs) du système et des applications |
| `/var/www` | Souvent, les fichiers des sites web |
| `/tmp` | Les fichiers temporaires, effacés au redémarrage |
| `/root` | Le dossier personnel de l''administrateur (root) |

Le symbole `~` désigne ton dossier personnel. Un chemin **absolu** commence par `/` (`/etc/nginx`), un chemin **relatif** part du dossier où tu te trouves (`documents/rapport.txt`).

## Se déplacer

```bash
pwd                 # où suis-je ?
ls                  # que contient ce dossier ?
ls -la              # liste détaillée, fichiers cachés compris
cd /var/log         # aller dans un dossier
cd ..               # remonter d''un niveau
cd ~                # revenir dans mon dossier personnel
```

> **Astuce** : la touche **Tab** complète automatiquement les noms de fichiers et de commandes, et la flèche du haut rappelle les commandes précédentes. Ces deux réflexes te feront gagner un temps énorme.

## Manipuler fichiers et dossiers

```bash
mkdir sauvegardes                  # créer un dossier
touch notes.txt                    # créer un fichier vide
cp notes.txt notes-copie.txt       # copier
mv notes-copie.txt sauvegardes/    # déplacer (ou renommer)
rm sauvegardes/notes-copie.txt     # supprimer un fichier
rm -r sauvegardes                  # supprimer un dossier et son contenu
```

> **Attention** : sous Linux, il n''y a **pas de corbeille** en ligne de commande. Un fichier supprimé avec `rm` est perdu. Relis toujours une commande `rm -r` avant d''appuyer sur Entrée, surtout si tu es connecté en root.

## Lire et chercher dans des fichiers

```bash
cat /etc/hostname                 # afficher un petit fichier
less /var/log/syslog              # parcourir un gros fichier (q pour quitter)
head -n 20 fichier.log            # les 20 premières lignes
tail -n 50 /var/log/syslog        # les 50 dernières lignes
tail -f /var/log/nginx/error.log  # suivre un journal en direct (Ctrl+C pour arrêter)
grep "error" /var/log/syslog      # les lignes qui contiennent "error"
grep -ri "timeout" /etc/nginx     # recherche récursive, sans tenir compte des majuscules
```

Pour modifier un fichier de configuration, l''éditeur le plus simple est **nano** : `nano /etc/hosts`. On enregistre avec **Ctrl+O**, on quitte avec **Ctrl+X**.

## Enchaîner les commandes

Le caractère `|` (*pipe*) envoie le résultat d''une commande à la suivante. C''est l''une des grandes forces du terminal :

```bash
grep "Failed password" /var/log/auth.log | wc -l      # combien de tentatives de connexion échouées ?
ls -l /var/log | sort -k5 -n | tail -n 5               # les 5 plus gros fichiers de logs
```

Le symbole `>` enregistre le résultat dans un fichier (en l''écrasant), `>>` l''ajoute à la fin.

## Surveiller le système

```bash
df -h          # espace disque libre, en unités lisibles
du -sh /var/*  # taille de chaque dossier de /var
free -h        # mémoire vive utilisée et disponible
top            # processus en temps réel (q pour quitter) ; htop est plus lisible s''il est installé
ps aux | grep nginx   # le processus nginx tourne-t-il ?
uptime         # depuis quand le serveur tourne, et sa charge
```

## Installer des logiciels

Sur Debian et Ubuntu, le gestionnaire de paquets s''appelle **apt**. Les commandes d''administration nécessitent les droits d''administrateur, obtenus avec `sudo` :

```bash
sudo apt update            # mettre à jour la liste des paquets disponibles
sudo apt upgrade           # installer les mises à jour
sudo apt install htop      # installer un logiciel
sudo apt remove htop       # le désinstaller
```

> **Info** : `man` affiche le manuel de n''importe quelle commande (`man ls`). Et la plupart des commandes acceptent l''option `--help` pour un résumé rapide.

## À toi de jouer

Sur ta machine Linux :

1. Crée dans ton dossier personnel l''arborescence `formation/jour1/notes` en une seule commande (indice : cherche l''option `-p` de `mkdir`).
2. Crée un fichier `serveurs.txt` contenant cinq lignes de noms de serveurs, dont deux contenant le mot « web ».
3. Affiche uniquement les lignes contenant « web », puis compte-les avec un pipe.
4. Affiche l''espace disque disponible et la mémoire libre.
5. Installe `htop`, lance-le et repère le processus qui consomme le plus de mémoire.
6. Affiche les 10 dernières lignes du journal système (`/var/log/syslog` ou `journalctl -n 10`).

> **Correction de l''étape 3** : `grep "web" serveurs.txt` puis `grep "web" serveurs.txt | wc -l`, qui doit afficher 2.

## Vérifie tes acquis

1. Dans quel dossier trouve-t-on généralement les fichiers de configuration ?
2. Quelle commande permet de suivre un fichier de log en temps réel ?
3. Que fait le caractère `|` entre deux commandes ?

> **Réponses** : 1. `/etc`. 2. `tail -f`. 3. Il envoie le résultat de la première commande en entrée de la seconde.

## En résumé

- Linux organise tout à partir de la racine `/` : `/etc` pour la configuration, `/var/log` pour les journaux, `/home` pour les utilisateurs.
- `pwd`, `ls`, `cd` pour se déplacer ; `cp`, `mv`, `rm`, `mkdir` pour manipuler (sans corbeille !).
- `cat`, `less`, `tail -f` et `grep` pour lire et chercher ; `|` pour enchaîner.
- `df`, `free`, `top` et `ps` pour surveiller ; `apt` avec `sudo` pour installer.

## Pour aller plus loin

- Demande au mentor IA : « Donne-moi 10 défis en ligne de commande Linux de difficulté croissante, sans les solutions. »'
WHERE t.slug = 'administration-systemes-reseaux' AND l.title = 'Les commandes essentielles du terminal';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Utilisateurs, groupes, chmod, chown, sudo et moindre privilège.', l.duration_minutes = 30, l.content = 'Le serveur de fichiers de l''entreprise d''Abdelkerim est partagé par trois services : comptabilité, technique et commercial. Les techniciens ne doivent pas lire les fiches de paie, et un stagiaire ne doit pas pouvoir effacer la configuration du serveur. Sous Linux, ce contrôle repose sur les **utilisateurs**, les **groupes** et les **permissions**.

> **Objectifs de ce chapitre**
> - Créer et gérer des comptes utilisateurs et des groupes
> - Lire et modifier les permissions d''un fichier
> - Changer le propriétaire d''un fichier
> - Utiliser sudo de façon raisonnée
> - Appliquer le principe du moindre privilège

## Utilisateurs et groupes

Chaque personne (et chaque service, comme le serveur web) dispose d''un **compte utilisateur**. Les utilisateurs sont regroupés en **groupes**, ce qui permet de donner des droits à tout un service d''un coup.

```bash
sudo adduser fatime                    # créer un utilisateur (avec dossier personnel et mot de passe)
sudo groupadd compta                   # créer un groupe
sudo usermod -aG compta fatime         # ajouter fatime au groupe compta
groups fatime                          # voir les groupes de fatime
id fatime                              # identifiants numériques et groupes
sudo passwd -l stagiaire               # verrouiller un compte
sudo deluser --remove-home stagiaire   # supprimer un compte et son dossier
```

> **Attention** : dans `usermod -aG`, l''option `-a` (*append*, ajouter) est essentielle. Sans elle, l''utilisateur est retiré de tous ses autres groupes secondaires.

L''utilisateur **root** a tous les pouvoirs sur le système. On ne travaille jamais directement en root au quotidien.

## Lire les permissions

La commande `ls -l` affiche les permissions :

```text
-rw-r----- 1 fatime compta 2048 oct.  8 09:12 paie-octobre.xlsx
drwxr-x--- 2 root   compta 4096 oct.  8 09:00 comptabilite
```

Décomposons `-rw-r-----` :

| Position | Valeur | Signification |
| --- | --- | --- |
| 1 | `-` ou `d` | Fichier ordinaire ou dossier (*directory*) |
| 2 à 4 | `rw-` | Droits du **propriétaire** (fatime) |
| 5 à 7 | `r--` | Droits du **groupe** (compta) |
| 8 à 10 | `---` | Droits des **autres** utilisateurs |

Les trois droits :

- `r` (*read*) : lire le fichier, ou lister le contenu d''un dossier ;
- `w` (*write*) : modifier le fichier, ou créer et supprimer des fichiers dans un dossier ;
- `x` (*execute*) : exécuter le fichier (un script), ou **entrer** dans un dossier.

Ici, fatime peut lire et modifier la fiche de paie, les membres du groupe compta peuvent seulement la lire, et les autres n''y ont aucun accès.

## Modifier les permissions : chmod

### La notation symbolique

```bash
chmod u+x sauvegarde.sh      # ajouter l''exécution pour le propriétaire (u = user)
chmod g-w rapport.txt        # retirer l''écriture au groupe (g = group)
chmod o-rwx paie.xlsx        # retirer tous les droits aux autres (o = others)
```

### La notation octale

Chaque droit a une valeur : `r = 4`, `w = 2`, `x = 1`. On additionne pour chaque catégorie :

| Chiffre | Droits | Usage courant |
| --- | --- | --- |
| 7 | rwx | Propriétaire d''un script ou d''un dossier |
| 6 | rw- | Propriétaire d''un fichier |
| 5 | r-x | Lecture et accès à un dossier |
| 4 | r-- | Lecture seule |
| 0 | --- | Aucun accès |

```bash
chmod 640 paie-octobre.xlsx   # rw- r-- ---
chmod 750 comptabilite        # rwx r-x ---
chmod 600 ~/.ssh/id_ed25519   # clé privée SSH : lisible par son seul propriétaire
```

> **Attention** : `chmod 777` (tous les droits pour tout le monde) n''est jamais une solution, même quand « ça ne marche pas ». C''est une faille de sécurité ; cherche plutôt quel utilisateur a besoin de quel droit.

## Changer le propriétaire : chown

```bash
sudo chown fatime paie-octobre.xlsx            # nouveau propriétaire
sudo chown fatime:compta paie-octobre.xlsx     # propriétaire et groupe
sudo chown -R www-data:www-data /var/www/site  # récursif : tout le dossier du site web
```

Le serveur web (Apache ou Nginx) tourne souvent sous l''utilisateur `www-data`. Pour que le site puisse écrire dans un dossier d''envoi de fichiers, c''est cet utilisateur qui doit en avoir le droit, et lui seul.

## sudo : des droits d''administration contrôlés

`sudo` permet à un utilisateur autorisé d''exécuter une commande en tant que root, en saisissant **son propre** mot de passe. Chaque utilisation est enregistrée dans les journaux (`/var/log/auth.log`) : on sait qui a fait quoi.

```bash
sudo usermod -aG sudo abdelkerim   # donner les droits sudo (Debian, Ubuntu)
```

On ne donne les droits sudo qu''aux personnes qui administrent réellement le serveur.

## Le principe du moindre privilège

Chaque compte ne doit avoir **que les droits strictement nécessaires** à son travail. Appliqué au serveur de fichiers :

- un dossier par service, appartenant au groupe du service, en `770` ou `750` ;
- aucun accès pour les « autres » sur les dossiers sensibles ;
- les droits sudo réservés aux administrateurs ;
- les comptes des personnes parties désactivés le jour même.

## À toi de jouer

Mets en place le serveur de fichiers de l''entreprise :

1. Crée les groupes `compta`, `technique` et `commercial`.
2. Crée trois utilisateurs (un par service) et ajoute chacun à son groupe.
3. Crée les dossiers `/srv/partage/compta`, `/srv/partage/technique` et `/srv/partage/commercial`.
4. Donne à chaque dossier le bon groupe propriétaire et des permissions qui permettent aux membres du service de lire et écrire, sans aucun accès pour les autres.
5. Crée un dossier `/srv/partage/commun` lisible et modifiable par les trois services.
6. Vérifie en te connectant avec chaque utilisateur (`su - nom`) qu''il ne peut pas lire les dossiers des autres services.

> **Correction de l''étape 4** : par exemple `sudo chown root:compta /srv/partage/compta` puis `sudo chmod 770 /srv/partage/compta`, et de même pour les autres services. Pour `commun`, on peut créer un groupe `tous` contenant tout le monde, avec les mêmes réglages.

## Vérifie tes acquis

1. Que signifient les permissions `750` sur un dossier ?
2. Pourquoi l''option `-a` est-elle importante dans `usermod -aG` ?
3. Quel utilisateur doit souvent posséder les fichiers d''un site web ?

> **Réponses** : 1. Le propriétaire a tous les droits, le groupe peut lire et entrer dans le dossier, les autres n''ont aucun accès. 2. Sans elle, l''utilisateur perd ses autres groupes secondaires. 3. L''utilisateur du serveur web, souvent `www-data`.

## En résumé

- Linux gère les accès avec des **utilisateurs**, des **groupes** et des **permissions** `r`, `w`, `x`.
- Les permissions concernent trois catégories : propriétaire, groupe, autres.
- `chmod` modifie les droits (symbolique ou octal), `chown` change le propriétaire.
- `sudo` donne des droits d''administration temporaires et tracés.
- **Moindre privilège** : chacun n''a que les droits dont il a besoin. Jamais de `777`.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi le rôle du bit setgid sur un dossier partagé et quand l''utiliser. »'
WHERE t.slug = 'administration-systemes-reseaux' AND l.title = 'Gérer les utilisateurs et les permissions';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Couches, adresses IP, masques, DHCP, DNS, TCP/UDP et diagnostic réseau.', l.duration_minutes = 30, l.content = 'Un client de l''entreprise d''Abdelkerim appelle : « Internet ne marche plus ! » Est-ce le câble, le Wi-Fi, l''adresse IP, le DNS, ou le site lui-même qui est en panne ? Pour répondre vite, un technicien raisonne **par couches**, en s''appuyant sur le **modèle TCP/IP**. Ce chapitre te donne les notions réseau dont tu auras besoin tous les jours.

> **Objectifs de ce chapitre**
> - Comprendre les quatre couches du modèle TCP/IP
> - Lire une adresse IPv4 et un masque de sous-réseau
> - Connaître le rôle de la passerelle, du DHCP et du DNS
> - Distinguer TCP et UDP
> - Diagnostiquer une panne avec les bonnes commandes

## Le modèle en couches

Pour envoyer un message à travers le réseau, chaque couche ajoute ses informations, comme on glisse une lettre dans une enveloppe, puis dans un colis, puis dans un camion :

| Couche TCP/IP | Rôle | Exemples |
| --- | --- | --- |
| 4. Application | Les services utilisés par les programmes | HTTP, DNS, SMTP, SSH |
| 3. Transport | Le dialogue entre deux programmes, avec les **ports** | TCP, UDP |
| 2. Internet | L''acheminement entre réseaux, avec les **adresses IP** | IP, ICMP (ping) |
| 1. Accès réseau | La transmission physique sur le support | Ethernet, Wi-Fi, fibre, 4G |

> **Info** : tu entendras aussi parler du **modèle OSI** à 7 couches. Il découpe plus finement les mêmes idées ; le modèle TCP/IP est celui qui décrit réellement Internet.

## Les adresses IP

Une **adresse IPv4** identifie un appareil sur un réseau. Elle s''écrit en quatre nombres de 0 à 255 : `192.168.1.25`.

Le **masque de sous-réseau** indique quelle partie de l''adresse désigne le **réseau** et quelle partie désigne l''**appareil**. On l''écrit souvent en notation CIDR :

```text
192.168.1.25/24
masque : 255.255.255.0
réseau : 192.168.1.0   →   appareils possibles : 192.168.1.1 à 192.168.1.254
```

Le `/24` signifie que les 24 premiers bits (les trois premiers nombres) désignent le réseau. Deux appareils sur le même réseau communiquent directement ; sinon, ils passent par un routeur.

### Adresses privées et publiques

Certaines plages sont réservées aux réseaux **privés** (maison, entreprise) et ne circulent pas sur Internet : `10.0.0.0/8`, `172.16.0.0/12` et `192.168.0.0/16`. Le routeur de la box ou de l''entreprise traduit ces adresses privées en une adresse **publique** pour sortir sur Internet : c''est la **NAT**.

> **Info** : les adresses IPv4 sont épuisées dans le monde. Leur successeur, **IPv6**, utilise des adresses beaucoup plus longues comme `2001:db8::1`. Les deux coexistent aujourd''hui.

## Les services indispensables

- La **passerelle par défaut** : le routeur vers lequel l''appareil envoie tout ce qui ne concerne pas son réseau local. Sans elle, pas d''Internet.
- Le **DHCP** : le service qui attribue automatiquement une adresse IP, un masque, une passerelle et des serveurs DNS aux appareils qui se connectent.
- Le **DNS** : l''annuaire qui traduit les noms (`google.com`) en adresses IP.

## TCP ou UDP ?

| | TCP | UDP |
| --- | --- | --- |
| Fiabilité | Vérifie que chaque paquet arrive, renvoie les paquets perdus | Envoie sans vérifier |
| Ordre | Remet les données dans l''ordre | Pas de garantie d''ordre |
| Rapidité | Plus lent | Plus rapide |
| Usages | Web, e-mail, transfert de fichiers, SSH | Appels vocaux et vidéo, jeux en ligne, DNS |

Pour un appel WhatsApp, mieux vaut perdre un fragment de voix que d''attendre qu''il soit renvoyé : on utilise UDP. Pour télécharger un fichier, chaque octet compte : on utilise TCP.

## Diagnostiquer une panne, couche par couche

On part du bas et on remonte. Les commandes ci-dessous fonctionnent sous Linux ; sous Windows, `ipconfig` remplace `ip a` et `tracert` remplace `traceroute`.

```bash
ip a                        # 1. L''appareil a-t-il une adresse IP ? (une adresse en 169.254.x.x = DHCP en échec)
ip route                    # 2. Quelle est la passerelle par défaut ?
ping -c 4 192.168.1.1       # 3. La passerelle répond-elle ?
ping -c 4 8.8.8.8           # 4. Internet est-il joignable par adresse IP ?
nslookup google.com         # 5. Le DNS fonctionne-t-il ?
traceroute google.com       # 6. Par où passent les paquets, et où ça bloque ?
```

L''interprétation est logique :

- pas d''adresse IP → problème de câble, de Wi-Fi ou de DHCP ;
- la passerelle ne répond pas → problème sur le réseau local ;
- `8.8.8.8` ne répond pas mais la passerelle oui → problème côté routeur ou fournisseur d''accès ;
- `8.8.8.8` répond mais `google.com` non → problème de **DNS**.

> **Astuce** : beaucoup de « pannes d''Internet » sont en fait des pannes de DNS. Si `ping 8.8.8.8` fonctionne et pas les sites web, essaie de configurer un autre serveur DNS.

## À toi de jouer

1. Sur ta machine, relève ton adresse IP, ton masque, ta passerelle et tes serveurs DNS.
2. Calcule la plage d''adresses utilisables du réseau `192.168.10.0/24`, puis celle de `10.20.0.0/16`.
3. Un client a l''adresse `169.254.12.40`. Quel est le problème probable ?
4. Un autre client peut faire `ping 8.8.8.8` mais aucun site ne s''ouvre. Quelle couche ou quel service est en cause, et que lui proposes-tu ?
5. Rédige une fiche de diagnostic en 6 étapes que les techniciens du support pourront suivre au téléphone avec un client.

> **Réponses des étapes 2 à 4** : `192.168.10.1` à `192.168.10.254` ; `10.20.0.1` à `10.20.255.254`. Une adresse en 169.254 signifie que l''appareil n''a pas obtenu d''adresse du serveur DHCP. Le DNS est en cause : vérifier les serveurs DNS configurés ou en essayer d''autres.

## Vérifie tes acquis

1. À quelle couche se situent les ports ?
2. Quel service attribue automatiquement les adresses IP ?
3. Pourquoi un appel vidéo utilise-t-il plutôt UDP ?

> **Réponses** : 1. À la couche transport. 2. Le DHCP. 3. Parce qu''il vaut mieux perdre un petit fragment que d''attendre sa retransmission : la rapidité prime.

## En résumé

- Le modèle **TCP/IP** a quatre couches : accès réseau, Internet (IP), transport (TCP/UDP), application.
- Une adresse IP et son **masque** définissent le réseau et l''appareil ; les plages privées passent par la **NAT**.
- La **passerelle** mène vers les autres réseaux, le **DHCP** distribue les adresses, le **DNS** traduit les noms.
- **TCP** est fiable, **UDP** est rapide.
- On diagnostique de bas en haut : adresse, passerelle, Internet par IP, DNS.

## Pour aller plus loin

- Demande au mentor IA : « Fais-moi pratiquer le calcul de sous-réseaux avec 5 exercices corrigés. »'
WHERE t.slug = 'administration-systemes-reseaux' AND l.title = 'Les bases du modèle TCP/IP';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Indicateurs clés, systemd, journaux, script de contrôle avec cron et outils de supervision.', l.duration_minutes = 30, l.content = 'Un vendredi soir, le serveur de messagerie de l''entreprise s''est arrêté : son disque était plein. Personne ne s''en est rendu compte avant lundi matin, quand les clients ont commencé à se plaindre. Avec une **supervision**, Abdelkerim aurait reçu une alerte dès que le disque dépassait 85 %, des jours avant la panne. Superviser, c''est passer d''une administration qui **subit** les pannes à une administration qui les **anticipe**.

> **Objectifs de ce chapitre**
> - Identifier les indicateurs clés d''un serveur
> - Lire les journaux système
> - Vérifier l''état des services
> - Écrire un script de contrôle simple et le planifier avec cron
> - Connaître les outils de supervision professionnels

## Quoi surveiller ?

| Indicateur | Commande | Seuil d''alerte courant |
| --- | --- | --- |
| Espace disque | `df -h` | Plus de 85 % utilisé |
| Mémoire vive | `free -h` | Mémoire disponible très faible, swap très utilisé |
| Charge processeur | `uptime`, `top` | Charge durablement supérieure au nombre de cœurs |
| Services | `systemctl status nginx` | Service arrêté ou en échec |
| Disponibilité externe | Test HTTP depuis l''extérieur | Le site ne répond pas |
| Sécurité | `/var/log/auth.log` | Nombreuses connexions échouées |
| Sauvegardes | Date du dernier fichier de sauvegarde | Plus de 24 h |

> **Info** : la **charge** affichée par `uptime` donne trois nombres : la moyenne sur 1, 5 et 15 minutes. Sur un serveur à 4 cœurs, une charge de 4 signifie qu''il est occupé à 100 %.

## Les services avec systemd

Sur la plupart des distributions modernes, les services sont gérés par **systemd** :

```bash
systemctl status nginx          # état du service, avec les dernières lignes de log
sudo systemctl restart nginx    # redémarrer
sudo systemctl enable nginx     # démarrer automatiquement au démarrage du serveur
systemctl --failed              # lister les services en échec
```

## Les journaux

Les journaux racontent tout ce qui se passe sur le serveur. Deux sources principales :

```bash
journalctl -u nginx --since "1 hour ago"    # journal d''un service sur la dernière heure
journalctl -p err -b                        # toutes les erreurs depuis le dernier démarrage
tail -f /var/log/nginx/error.log            # erreurs du serveur web en direct
grep "Failed password" /var/log/auth.log | tail -n 20   # dernières tentatives de connexion échouées
```

> **Attention** : les journaux eux-mêmes peuvent remplir le disque. Vérifie que **logrotate** est actif : il compresse et supprime automatiquement les anciens journaux.

## Un script de contrôle maison

Même sans outil sophistiqué, un petit script peut vérifier l''essentiel et prévenir l''administrateur. Crée `/usr/local/bin/controle-serveur.sh` :

```bash
#!/bin/bash
SEUIL=85
ALERTES=""

# 1. Espace disque de la partition principale
UTILISE=$(df / --output=pcent | tail -n 1 | tr -dc ''0-9'')
if [ "$UTILISE" -ge "$SEUIL" ]; then
  ALERTES="$ALERTES Disque plein à ${UTILISE}%."
fi

# 2. Services indispensables
for SERVICE in nginx mysql; do
  if ! systemctl is-active --quiet "$SERVICE"; then
    ALERTES="$ALERTES Service $SERVICE arrêté."
  fi
done

# 3. Résultat
if [ -n "$ALERTES" ]; then
  echo "$(date ''+%F %T'') ALERTE :$ALERTES" >> /var/log/controle-serveur.log
fi
```

Rends-le exécutable avec `sudo chmod 750 /usr/local/bin/controle-serveur.sh`. Pour être prévenu sur ton téléphone, on peut remplacer l''écriture dans le fichier par l''envoi d''un e-mail ou d''un message via l''API d''un service de messagerie comme Telegram.

## Planifier avec cron

**cron** exécute des tâches à intervalles réguliers. On édite la liste des tâches avec `sudo crontab -e`, puis on ajoute une ligne :

```text
*/5 * * * * /usr/local/bin/controle-serveur.sh
```

Les cinq champs sont : minute, heure, jour du mois, mois, jour de la semaine. `*/5` signifie « toutes les 5 minutes ». Autres exemples :

| Ligne cron | Signification |
| --- | --- |
| `0 2 * * *` | Tous les jours à 2 h 00 |
| `30 7 * * 1-5` | Du lundi au vendredi à 7 h 30 |
| `0 */6 * * *` | Toutes les 6 heures |

## Les outils professionnels

Au-delà de quelques serveurs, on utilise des outils dédiés, souvent libres et gratuits :

- **Uptime Kuma** ou **UptimeRobot** : vérifient depuis l''extérieur que tes sites et services répondent, et alertent par e-mail, Telegram ou SMS.
- **Zabbix** : supervision complète d''un parc de serveurs et d''équipements réseau, très utilisée par les opérateurs et les grandes entreprises.
- **Prometheus** et **Grafana** : collecte de métriques et beaux tableaux de bord, populaires dans les environnements cloud et Docker.
- **Netdata** : tableau de bord en temps réel, installable en une commande sur un serveur.

> **Astuce** : une alerte doit être **utile**. Si tu reçois 50 alertes par jour pour rien, tu finiras par les ignorer toutes, y compris la vraie. Ajuste les seuils pour n''être prévenu que de ce qui demande une action.

## À toi de jouer

1. Sur ta machine Linux, relève l''espace disque, la mémoire, la charge et la liste des services en échec.
2. Crée le script `controle-serveur.sh` ci-dessus et teste-le en mettant volontairement le seuil à 1 % : une alerte doit apparaître dans le journal.
3. Planifie-le toutes les 5 minutes avec cron, et vérifie après 10 minutes que le journal se remplit.
4. Ajoute une vérification : alerte si le dernier fichier du dossier `/srv/sauvegardes` date de plus de 24 heures (indice : `find /srv/sauvegardes -mtime -1`).
5. Rédige la **fiche de supervision** du serveur : indicateurs, seuils, fréquence de contrôle, qui est prévenu et comment.

> **Pour t''auto-évaluer** : arrête volontairement le service nginx (`sudo systemctl stop nginx`). Dans les 5 minutes, ton script doit avoir enregistré l''alerte. Pense à redémarrer le service ensuite !

## Vérifie tes acquis

1. Quelle commande liste les services en échec ?
2. Que signifie la ligne cron `0 2 * * *` ?
3. Pourquoi faut-il éviter les alertes trop nombreuses ?

> **Réponses** : 1. `systemctl --failed`. 2. Tous les jours à 2 h du matin. 3. Parce que l''équipe finit par les ignorer et risque de manquer une alerte importante.

## En résumé

- On surveille au minimum le disque, la mémoire, la charge, les services, la disponibilité externe et les sauvegardes.
- `systemctl` gère les services, `journalctl` et `/var/log` contiennent les journaux.
- Un script simple planifié avec **cron** suffit pour commencer.
- Uptime Kuma, Zabbix, Prometheus et Grafana prennent le relais pour un parc plus important.
- Des alertes peu nombreuses mais pertinentes.

## Pour aller plus loin

- Demande au mentor IA : « Comment installer Uptime Kuma avec Docker et recevoir les alertes sur Telegram ? »'
WHERE t.slug = 'administration-systemes-reseaux' AND l.title = 'Superviser un serveur';


-- =====================================================================
-- UX/UI Design (ux-ui-design)
-- =====================================================================
UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Entretiens, observation, personas, parcours utilisateur et énoncé du problème.', l.duration_minutes = 25, l.content = 'Une application peut être techniquement parfaite et pourtant abandonnée au bout de deux jours, parce qu''elle ne répond pas au vrai besoin de ses utilisateurs ou qu''elle est trop compliquée à utiliser. Le **design UX** (*User Experience*, expérience utilisateur) consiste à partir des personnes, de leurs besoins et de leurs contraintes, **avant** de dessiner le moindre écran.

Dans ce parcours, tu accompagnes **Mariam**, designer dans une agence de N''Djamena, chargée de concevoir **SantéRDV**, une application de prise de rendez-vous dans les centres de santé de la ville.

> **Objectifs de ce chapitre**
> - Distinguer UX et UI
> - Mener un entretien utilisateur sans biaiser les réponses
> - Observer les utilisateurs sur le terrain
> - Synthétiser la recherche en personas et parcours utilisateur
> - Formuler le problème à résoudre

## UX et UI, quelle différence ?

- L''**UX** concerne l''expérience globale : l''utilisateur atteint-il son but facilement, rapidement, sans frustration ? Elle commence bien avant les écrans, par la compréhension des besoins.
- L''**UI** (*User Interface*, interface utilisateur) concerne l''apparence et les éléments de l''interface : couleurs, typographie, boutons, icônes.

Une belle UI ne sauve pas une mauvaise UX. Une porte magnifique sur laquelle on ne sait pas s''il faut pousser ou tirer reste une mauvaise porte.

## La recherche utilisateur

Le piège classique est de concevoir pour **soi-même** : « Moi, je trouve ça simple. » Mais toi, tu connais déjà le produit, tu as un smartphone récent, tu lis facilement le français. Ce n''est peut-être pas le cas des patients d''un centre de santé de Farcha ou de Chagoua. La recherche utilisateur sert à sortir de ses suppositions.

### L''entretien individuel

On rencontre 5 à 8 personnes du public visé, pendant 30 à 45 minutes, pour comprendre leurs habitudes, leurs difficultés et leurs motivations.

Les règles d''or :

- **Parler du passé réel, pas d''hypothèses** : « Racontez-moi la dernière fois que vous êtes allé dans un centre de santé » plutôt que « Utiliseriez-vous une application de rendez-vous ? ». À la seconde question, tout le monde répond oui par politesse.
- **Poser des questions ouvertes** : « Comment ça s''est passé ? », « Qu''est-ce qui a été difficile ? ».
- **Ne pas présenter ta solution** pendant l''entretien : tu cherches à comprendre le problème.
- **Creuser** : « Pourquoi ? », « Pouvez-vous m''en dire plus ? ».
- **Écouter plus que parler**, et noter les mots exacts utilisés.

> **Attention** : évite les questions qui suggèrent la réponse, comme « Ce n''est pas trop pénible d''attendre des heures ? ». Préfère « Comment se passe l''attente ? ».

### L''observation

Ce que les gens **disent** et ce qu''ils **font** est souvent différent. Passer une matinée dans la salle d''attente d''un centre de santé (avec l''accord des responsables) t''apprendra beaucoup : comment les patients sont appelés, combien de temps ils attendent, qui les accompagne, s''ils utilisent leur téléphone.

## Synthétiser : la persona

Une **persona** est un personnage fictif mais réaliste qui représente un groupe d''utilisateurs, construit à partir de ta recherche (pas inventé).

Exemple pour SantéRDV :

> **Amina, 34 ans, commerçante au marché de Dembé**
> - Mère de trois enfants, elle emmène régulièrement le plus jeune en consultation.
> - Smartphone Android d''entrée de gamme, forfait internet limité, utilise surtout WhatsApp et les messages vocaux.
> - Lit le français avec un peu de difficulté, parle l''arabe tchadien au quotidien.
> - **Son problème** : elle perd souvent une matinée entière de vente pour attendre une consultation.
> - **Son objectif** : savoir à quelle heure venir pour être reçue rapidement.

On crée généralement deux ou trois personas principales, par exemple aussi un agent d''accueil du centre de santé, qui utilisera l''autre côté de l''application.

## Le parcours utilisateur

La **carte du parcours utilisateur** (*user journey map*) décrit les étapes vécues par la persona, avec ses actions, ses émotions et ses difficultés à chaque moment :

| Étape | Action d''Amina | Ressenti | Problème | Opportunité |
| --- | --- | --- | --- | --- |
| Besoin | Son fils a de la fièvre | Inquiète | Ne sait pas quel centre est ouvert | Afficher les centres ouverts à proximité |
| Déplacement | Prend une moto-taxi | Pressée | Coût et temps de trajet | Donner une heure de passage estimée |
| Attente | Attend 3 heures | Agacée | Perte de revenus | Prévenir par SMS quand c''est bientôt son tour |
| Consultation | Voit le médecin | Rassurée | — | — |

Les colonnes « problème » et « opportunité » sont une mine d''idées pour la conception.

## Formuler le problème

On termine la recherche par un **énoncé du problème** clair, qui guidera toute la conception :

> « Comment pourrions-nous aider les parents qui travaillent, comme Amina, à faire soigner leur enfant sans perdre une demi-journée de travail, alors qu''ils ont un téléphone modeste et peu de data ? »

## À toi de jouer

Choisis un service que tu connais bien (inscription à l''université, paiement de facture d''électricité, achat de billet de bus…).

1. Rédige un **guide d''entretien** de 8 questions ouvertes, sans questions suggestives.
2. Mène au moins **trois entretiens** de 20 minutes avec des personnes de ton entourage qui utilisent ce service.
3. Construis une **persona** à partir de ce que tu as appris.
4. Dessine sa **carte de parcours** en 4 à 6 étapes, avec les émotions et les problèmes.
5. Écris ton **énoncé du problème** sous la forme « Comment pourrions-nous… ».

> **Pour t''auto-évaluer** : relis tes questions d''entretien. Si l''une d''elles peut recevoir une simple réponse « oui » ou « non », ou si elle mentionne une solution, reformule-la.

## Vérifie tes acquis

1. Quelle est la différence entre UX et UI ?
2. Pourquoi faut-il éviter la question « Utiliseriez-vous cette application ? » ?
3. Sur quoi une persona doit-elle s''appuyer ?

> **Réponses** : 1. L''UX concerne l''expérience globale et la facilité à atteindre son but ; l''UI concerne l''apparence de l''interface. 2. Parce qu''elle porte sur un futur hypothétique et pousse à répondre oui par politesse ; mieux vaut interroger sur des expériences passées réelles. 3. Sur des données réelles issues de la recherche utilisateur, pas sur l''imagination.

## En résumé

- L''**UX** part des besoins réels des utilisateurs, l''**UI** donne forme à l''interface.
- Les **entretiens** portent sur le vécu réel, avec des questions ouvertes et sans présenter de solution.
- L''**observation** révèle ce que les gens font vraiment.
- **Personas** et **parcours utilisateur** synthétisent la recherche.
- Un **énoncé du problème** clair guide toute la conception.

## Pour aller plus loin

- Demande au mentor IA : « Relis mon guide d''entretien et signale-moi les questions suggestives ou fermées. »'
WHERE t.slug = 'ux-ui-design' AND l.title = 'Comprendre les besoins utilisateurs';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Flux, wireframes papier et Figma, prototype cliquable et tests utilisateurs.', l.duration_minutes = 30, l.content = 'Mariam a compris le problème d''Amina : savoir à quelle heure se présenter au centre de santé pour ne pas perdre sa journée. Avant de concevoir des écrans colorés, elle va dessiner des **wireframes**, de simples schémas en noir et blanc, puis un **prototype** cliquable qu''elle pourra tester avec de vrais utilisateurs. Changer un croquis prend une minute ; changer une application développée prend des semaines.

> **Objectifs de ce chapitre**
> - Organiser les contenus et le parcours dans l''application
> - Dessiner des wireframes basse et moyenne fidélité
> - Créer un prototype cliquable avec Figma
> - Organiser un test utilisateur et en tirer des améliorations

## Organiser avant de dessiner

### Les tâches principales

On liste d''abord ce que l''utilisateur doit pouvoir faire, par ordre d''importance. Pour SantéRDV :

1. Trouver un centre de santé ouvert près de chez soi.
2. Prendre un rendez-vous ou un ticket de passage.
3. Être prévenu quand son tour approche.
4. Annuler ou déplacer un rendez-vous.

### Le flux utilisateur

Le **flux** (*user flow*) montre l''enchaînement des écrans pour accomplir une tâche :

```text
Accueil → Liste des centres → Fiche du centre → Choix du créneau → Confirmation (numéro de ticket + SMS)
```

Chaque étape en moins est une chance de plus que l''utilisateur aille au bout. Demande-toi pour chaque écran : est-il vraiment nécessaire ?

> **Astuce** : pour SantéRDV, Mariam décide qu''il n''est pas nécessaire de créer un compte pour prendre un ticket : un numéro de téléphone suffit. Chaque champ de formulaire supprimé fait gagner des utilisateurs.

## Le wireframe

Un **wireframe** est le plan d''un écran : il montre **où** se trouvent les éléments et leur importance, sans couleurs ni images définitives.

### Basse fidélité : sur papier

Commence au crayon, sur papier. Dessine chaque écran dans un rectangle au format téléphone. Utilise des conventions simples :

- un rectangle avec une croix pour une image ;
- des lignes ondulées pour du texte ;
- un rectangle avec un mot pour un bouton.

Dessine **plusieurs versions** de l''écran le plus important : la première idée est rarement la meilleure. Le papier est rapide, et personne n''hésite à critiquer un croquis.

### Moyenne fidélité : sur ordinateur

Une fois la direction choisie, on redessine proprement les écrans dans un outil comme **Figma** (gratuit dans sa version de base, utilisable dans le navigateur) avec des niveaux de gris, de vrais textes et des tailles réalistes.

> **Info** : utilise de **vrais contenus** dès le wireframe : un vrai nom de centre de santé, de vraies adresses, de vrais horaires. Les textes de remplissage comme « Lorem ipsum » cachent les problèmes, par exemple un nom de quartier trop long pour tenir sur une ligne.

## Les composants à connaître

| Élément | Usage |
| --- | --- |
| Barre de navigation | Accéder aux sections principales (en bas de l''écran sur mobile) |
| Liste | Afficher plusieurs éléments similaires (centres, créneaux) |
| Carte | Regrouper les informations d''un élément (nom, distance, horaires) |
| Bouton principal | L''action la plus importante de l''écran : **un seul** par écran |
| Bouton secondaire | Les actions moins importantes (Annuler, Retour) |
| Champ de saisie | Saisir une information, avec une étiquette toujours visible |
| Message de confirmation | Rassurer après une action importante |

## Le prototype

Un **prototype** relie les écrans entre eux pour simuler l''application : on clique sur un bouton, on arrive sur l''écran suivant. Dans Figma :

1. Passe en mode **Prototype**.
2. Sélectionne un bouton et tire une flèche vers l''écran de destination.
3. Choisis le déclencheur (« Au clic ») et l''animation.
4. Lance l''aperçu et partage le lien ; il s''ouvre aussi sur un téléphone avec l''application Figma.

Le prototype n''a pas besoin d''être complet : il suffit qu''il permette de réaliser les tâches que tu veux tester.

## Tester avec de vrais utilisateurs

Le **test utilisateur** est le moment de vérité. Il suffit de **cinq personnes** du public visé pour découvrir la majorité des problèmes importants.

1. Prépare 3 ou 4 **scénarios** réalistes : « Votre fille a mal à l''oreille. Trouvez un centre ouvert près de Chagoua et prenez un ticket pour cet après-midi. »
2. Demande à la personne de **penser à voix haute** pendant qu''elle utilise le prototype.
3. **Observe sans aider**, même si c''est difficile ! Si elle bloque, demande « Qu''est-ce que vous cherchez ? » plutôt que de montrer le bouton.
4. Note les hésitations, les erreurs, les phrases prononcées.
5. Classe ensuite les problèmes par gravité et corrige les plus graves en priorité.

> **Attention** : quand un utilisateur échoue, ce n''est jamais lui qui se trompe, c''est la conception qui doit s''améliorer. Ne dis jamais « Ah non, il fallait cliquer ici ».

## À toi de jouer

En reprenant le problème défini au chapitre précédent :

1. Liste les quatre tâches principales de ton application.
2. Dessine sur papier le flux de la tâche la plus importante.
3. Dessine trois versions différentes de l''écran principal, puis choisis-en une en justifiant ton choix.
4. Reproduis les écrans du flux dans Figma en niveaux de gris, avec de vrais contenus.
5. Relie-les en prototype cliquable.
6. Teste le prototype avec trois personnes à l''aide d''un scénario, et note les trois problèmes les plus importants observés, avec ta proposition de correction.

> **Pour t''auto-évaluer** : un bon prototype de test permet à un utilisateur d''accomplir la tâche principale sans aucune explication de ta part.

## Vérifie tes acquis

1. Pourquoi commencer par des wireframes sur papier ?
2. Combien de boutons principaux devrait-il y avoir sur un écran ?
3. Que faire si un utilisateur bloque pendant un test ?

> **Réponses** : 1. Parce que c''est rapide, peu coûteux et facile à modifier ou à critiquer. 2. Un seul. 3. Ne pas lui montrer la solution ; lui demander ce qu''il cherche, puis noter le problème pour améliorer la conception.

## En résumé

- On définit les **tâches** et les **flux** avant de dessiner.
- Le **wireframe** fixe la structure de l''écran, d''abord sur papier puis dans Figma.
- Utilise de **vrais contenus** dès les premières maquettes.
- Le **prototype** relie les écrans pour simuler l''application.
- Le **test utilisateur** avec cinq personnes révèle l''essentiel des problèmes.

## Pour aller plus loin

- [Le centre d''aide de Figma](https://help.figma.com/) pour apprendre l''outil pas à pas
- Demande au mentor IA : « Propose-moi un scénario de test utilisateur pour une application de prise de rendez-vous médical. »'
WHERE t.slug = 'ux-ui-design' AND l.title = 'Du wireframe au prototype';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Guider l''œil avec la taille, le contraste, la couleur, l''espace et une échelle typographique.', l.duration_minutes = 25, l.content = 'Les tests du prototype SantéRDV ont confirmé le parcours. Mariam passe maintenant au **design visuel** (l''UI). Son objectif n''est pas de « faire joli », mais de guider l''œil : en une seconde, l''utilisateur doit voir ce qui est le plus important sur l''écran et ce qu''il doit faire ensuite. C''est le rôle de la **hiérarchie visuelle**, et la **typographie** en est l''outil principal.

> **Objectifs de ce chapitre**
> - Comprendre comment l''œil parcourt un écran
> - Créer une hiérarchie avec la taille, le contraste, la couleur et l''espace
> - Choisir et combiner des polices lisibles
> - Construire une échelle typographique et une palette de couleurs
> - Utiliser l''espacement et l''alignement

## Ce qui attire l''œil

Sur un écran, le regard est attiré d''abord par :

- ce qui est **plus grand** ;
- ce qui est **plus contrasté** (foncé sur clair, couleur vive au milieu de gris) ;
- ce qui est **isolé**, entouré d''espace vide ;
- ce qui est **en haut** de l''écran ;
- les **visages** et les images.

La hiérarchie visuelle consiste à utiliser ces leviers volontairement pour que l''ordre de lecture corresponde à l''ordre d''importance.

> **Astuce** : le **test du plissement d''yeux** : plisse les yeux devant ton écran jusqu''à ce que le texte devienne flou. Les éléments qui restent visibles sont ceux qui dominent. Si ce n''est pas le bouton principal ou l''information clé, ta hiérarchie est à revoir.

## Les leviers de la hiérarchie

| Levier | Exemple sur la fiche d''un centre de santé |
| --- | --- |
| Taille | Le nom du centre en grand, l''adresse en plus petit |
| Graisse | L''heure de passage estimée en gras |
| Couleur | Le bouton « Prendre un ticket » dans la couleur principale, seul élément coloré |
| Contraste | Les informations secondaires en gris moyen |
| Espace | Un grand espace autour du bouton principal |
| Position | L''information la plus utile tout en haut |

Ne les utilise pas tous à la fois : si tout est gros, gras et coloré, plus rien ne ressort.

## La typographie

### Choisir une police

Pour une interface, privilégie une police **sans empattements** (*sans-serif*), très lisible sur écran et en petite taille : **Inter**, **Roboto**, **Open Sans**, **Noto Sans** sont gratuites (Google Fonts). Vérifie qu''elle gère les accents français et, si besoin, l''alphabet arabe : la famille **Noto Sans Arabic** est conçue pour s''harmoniser avec Noto Sans.

Règle simple : **une ou deux polices maximum** dans toute l''application. Une seule police bien utilisée, avec plusieurs graisses, suffit largement.

### L''échelle typographique

On définit à l''avance un petit nombre de tailles, utilisées partout de façon cohérente :

| Style | Taille | Graisse | Usage |
| --- | --- | --- | --- |
| Titre 1 | 24 px | Gras | Titre de l''écran |
| Titre 2 | 18 px | Semi-gras | Titres de sections, noms des centres |
| Corps | 16 px | Normal | Texte courant |
| Légende | 13 px | Normal | Informations secondaires (distance, horaires) |

> **Attention** : sur mobile, ne descends pas sous **16 px** pour le texte principal. Les utilisateurs plus âgés ou ceux qui ont une vue fatiguée doivent pouvoir lire sans zoomer.

### La lisibilité

- **Interligne** : environ 1,4 à 1,6 fois la taille du texte.
- **Longueur de ligne** : 45 à 75 caractères pour un texte confortable.
- **Alignement à gauche** pour le français (à droite pour l''arabe) ; évite le texte justifié sur mobile, qui crée des trous.
- **Pas de texte entièrement en majuscules** pour les paragraphes : c''est plus difficile à lire.

## La couleur

Une palette d''interface se construit simplement :

- une **couleur principale** pour les actions (boutons, liens) ;
- des **neutres** (blanc, gris clairs et foncés) pour le fond et le texte : ils représentent la grande majorité de l''écran ;
- des **couleurs de statut** : vert (succès), orange (attention), rouge (erreur).

> **Info** : les couleurs ont des significations culturelles. Pour une application de santé au Tchad, Mariam évite d''utiliser du rouge vif pour des éléments neutres, car il évoque l''urgence ou le danger.

## L''espacement et l''alignement

L''espace vide n''est pas de l''espace perdu : il **regroupe** et **sépare**. Des éléments proches sont perçus comme liés (le nom d''un centre et son adresse) ; un espace plus grand sépare des groupes différents (deux centres dans une liste).

Utilise une **grille d''espacement** basée sur un multiple de 8 : 8, 16, 24, 32, 48 px. Cela donne une régularité que l''œil perçoit, même sans la remarquer. Et aligne les éléments sur les mêmes bords : un écran bien aligné paraît immédiatement plus professionnel.

## À toi de jouer

Reprends l''écran principal de ton prototype du chapitre précédent :

1. Classe tous les éléments de l''écran par ordre d''importance (de 1 à N).
2. Définis ton échelle typographique (4 styles maximum) avec une seule police.
3. Choisis une palette : une couleur principale, trois neutres et trois couleurs de statut.
4. Redessine l''écran dans Figma en appliquant ces choix et une grille d''espacement de 8 px.
5. Fais le test du plissement d''yeux : l''élément le plus visible correspond-il à ton numéro 1 ?
6. Montre l''écran pendant 5 secondes à une personne, cache-le, et demande-lui ce dont elle se souvient.

> **Pour t''auto-évaluer** : si la personne se souvient de l''information principale et du bouton à utiliser, ta hiérarchie fonctionne.

## Vérifie tes acquis

1. Cite trois leviers de hiérarchie visuelle.
2. Quelle taille minimale recommander pour le texte principal sur mobile ?
3. Pourquoi limiter le nombre de polices ?

> **Réponses** : 1. Par exemple la taille, la graisse, la couleur, le contraste, l''espace ou la position. 2. 16 px. 3. Pour garder une interface cohérente et lisible ; trop de polices donnent une impression de désordre.

## En résumé

- La **hiérarchie visuelle** fait correspondre l''ordre de lecture à l''ordre d''importance.
- Leviers : taille, graisse, couleur, contraste, espace, position. Ne pas tout mettre en avant.
- Une ou deux polices lisibles, une **échelle typographique** de quelques tailles, 16 px minimum sur mobile.
- Une palette simple : couleur principale, neutres, couleurs de statut.
- L''**espace** et l''**alignement** structurent l''écran ; une grille de 8 px aide à rester régulier.

## Pour aller plus loin

- [Google Fonts](https://fonts.google.com/) pour trouver des polices gratuites, dont les familles Noto
- Demande au mentor IA : « Analyse la hiérarchie visuelle de cet écran : [décris ton écran]. Qu''est-ce qui attire l''œil en premier ? »'
WHERE t.slug = 'ux-ui-design' AND l.title = 'Hiérarchie visuelle et typographie';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'WCAG, contrastes, zones tactiles, formulaires, lecteurs d''écran et langage clair.', l.duration_minutes = 25, l.content = 'Une personne malvoyante qui utilise un lecteur d''écran, un agriculteur qui consulte son téléphone en plein soleil, une grand-mère dont les mains tremblent, un utilisateur daltonien, quelqu''un qui lit difficilement le français : tous doivent pouvoir utiliser SantéRDV. **L''accessibilité** consiste à concevoir des interfaces utilisables par **tous**, quelles que soient leurs capacités ou leur situation. Et ce qui aide les personnes en situation de handicap améliore presque toujours l''expérience de tout le monde.

> **Objectifs de ce chapitre**
> - Comprendre les différents types de handicap et de situations limitantes
> - Connaître les principes des règles WCAG
> - Vérifier les contrastes de couleur
> - Concevoir des zones tactiles, des formulaires et des messages accessibles
> - Penser aux utilisateurs peu à l''aise avec la lecture

## Pour qui concevoir ?

| Situation | Exemples | Ce qui aide |
| --- | --- | --- |
| Vision | Malvoyance, daltonisme, cécité | Contrastes forts, texte agrandissable, lecteur d''écran |
| Motricité | Tremblements, doigts abîmés par le travail manuel | Grandes zones tactiles, pas de gestes complexes |
| Audition | Surdité | Sous-titres, alternatives aux sons et messages vocaux |
| Cognition | Difficultés de concentration, de mémoire | Écrans simples, une tâche à la fois, langage clair |
| Situations temporaires | Bras cassé, plein soleil, environnement bruyant | Les mêmes solutions ! |
| Littératie | Lecture difficile | Icônes accompagnées de texte, phrases courtes, audio |

## Les règles WCAG

Les **WCAG** (*Web Content Accessibility Guidelines*) sont la référence internationale de l''accessibilité numérique. Elles reposent sur quatre principes : le contenu doit être

- **Perceptible** : on peut le voir, l''entendre ou le lire avec un lecteur d''écran ;
- **Utilisable** : on peut s''en servir au toucher, au clavier, sans limite de temps excessive ;
- **Compréhensible** : le texte et le fonctionnement sont clairs et prévisibles ;
- **Robuste** : il fonctionne avec les technologies d''assistance.

Le niveau **AA** est l''objectif visé par la plupart des organisations.

## Les contrastes

Le texte doit se détacher suffisamment du fond. Le niveau AA demande un **rapport de contraste** d''au moins :

- **4,5 pour 1** pour le texte normal ;
- **3 pour 1** pour le texte de grande taille et pour les icônes et bordures de champs.

Le gris clair sur fond blanc, très à la mode, échoue souvent à ce test. Vérifie tes couleurs avec un outil gratuit comme le vérificateur de contraste de WebAIM ou un plugin Figma comme **Stark** ou **Contrast**.

> **Info** : un bon contraste n''aide pas seulement les personnes malvoyantes : il rend l''application lisible en plein soleil, une situation très courante au Tchad.

## Ne pas compter que sur la couleur

Environ 8 % des hommes ont une forme de daltonisme. Si un créneau disponible est vert et un créneau complet est rouge, sans autre indication, certains utilisateurs ne voient pas la différence. Ajoute toujours un second indice : une **icône**, un **texte** (« Complet »), un **motif**.

## Des zones tactiles confortables

Chaque élément touchable (bouton, lien, case à cocher) doit mesurer au moins **44 × 44 points** sur iOS et **48 × 48 dp** sur Android, avec de l''espace entre deux éléments voisins. Un bouton trop petit est un calvaire pour des doigts épais, des mains qui tremblent ou un utilisateur dans un bus qui roule sur une route cahoteuse.

## Des formulaires accessibles

- Une **étiquette visible** au-dessus de chaque champ, jamais seulement un texte gris dans le champ qui disparaît dès qu''on commence à taper.
- Le **bon clavier** : clavier numérique pour un numéro de téléphone.
- Des **messages d''erreur clairs**, placés près du champ concerné, qui expliquent comment corriger : « Le numéro doit contenir 8 chiffres, par exemple 66 12 34 56 » plutôt que « Format invalide ».
- Ne pas effacer ce que l''utilisateur a déjà saisi en cas d''erreur.

> **Attention** : ne limite jamais le temps pour remplir un formulaire sans prévenir et sans permettre de prolonger. Une personne qui écrit lentement ou qui doit chercher un document perdrait tout.

## Les lecteurs d''écran

Les personnes aveugles utilisent un **lecteur d''écran** (TalkBack sur Android, VoiceOver sur iPhone) qui lit à voix haute les éléments de l''écran. Pour qu''il fonctionne bien :

- chaque image utile a une **description** (texte alternatif) ; les images décoratives sont ignorées ;
- chaque bouton-icône a un **nom** : un bouton loupe doit être annoncé « Rechercher », pas « Bouton » ;
- l''**ordre de lecture** suit l''ordre logique de l''écran.

> **Astuce** : active TalkBack sur ton téléphone Android (Paramètres, Accessibilité) et essaie d''utiliser ton application les yeux fermés pendant cinq minutes. L''expérience est très instructive. Note bien comment le désactiver avant de commencer !

## Un langage clair pour tous

- Des **phrases courtes**, un mot simple plutôt qu''un mot technique : « Votre ticket » plutôt que « Votre réservation de créneau ».
- Des **icônes accompagnées d''un mot** : une icône seule est souvent ambiguë.
- Des messages **traduits** (français et arabe), avec une mise en page qui s''inverse correctement pour l''arabe.
- Pour les utilisateurs qui lisent difficilement : des **messages vocaux** ou des confirmations par SMS très simples.

## À toi de jouer

Fais l''**audit d''accessibilité** de ton écran principal :

1. Vérifie le contraste de chaque couleur de texte avec un outil en ligne et corrige ceux qui sont sous 4,5:1.
2. Repère toute information transmise uniquement par la couleur et ajoute un second indice.
3. Mesure les zones tactiles et agrandis celles qui font moins de 48 px.
4. Réécris tous les messages d''erreur pour qu''ils expliquent comment corriger.
5. Écris le texte qu''un lecteur d''écran devrait annoncer pour chaque bouton-icône.
6. Simplifie trois textes de ton interface en remplaçant les mots techniques.

> **Pour t''auto-évaluer** : demande à une personne âgée de ton entourage d''utiliser ton prototype. Si elle accomplit la tâche principale sans lunettes spéciales ni aide, tu as fait un grand pas.

## Vérifie tes acquis

1. Quel rapport de contraste minimal le niveau AA demande-t-il pour un texte normal ?
2. Pourquoi ne faut-il pas indiquer un état uniquement par la couleur ?
3. Quelle taille minimale recommander pour une zone tactile sur Android ?

> **Réponses** : 1. 4,5 pour 1. 2. Parce que les personnes daltoniennes ou malvoyantes risquent de ne pas percevoir la différence. 3. 48 × 48 dp.

## En résumé

- L''accessibilité permet à **tous** d''utiliser l''application, y compris dans des situations temporaires.
- Les **WCAG** reposent sur quatre principes : perceptible, utilisable, compréhensible, robuste.
- Contraste d''au moins **4,5:1**, jamais d''information par la couleur seule.
- Zones tactiles d''au moins **48 px**, formulaires avec étiquettes visibles et erreurs explicites.
- Penser aux **lecteurs d''écran** et utiliser un **langage clair**.

## Pour aller plus loin

- [Les règles WCAG présentées par le W3C, en français](https://www.w3.org/WAI/standards-guidelines/wcag/fr)
- Demande au mentor IA : « Fais-moi une checklist d''accessibilité en 15 points pour une application mobile. »'
WHERE t.slug = 'ux-ui-design' AND l.title = 'Concevoir pour l''accessibilité';


-- =====================================================================
-- Gestion de Projets IT (gestion-de-projets-it)
-- =====================================================================
UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Agile ou prédictif, les trois rôles, les événements du sprint et les artefacts.', l.duration_minutes = 25, l.content = 'Le ministère a commandé à une entreprise de N''Djamena une plateforme d''inscription en ligne aux concours de la fonction publique. Le cahier des charges fait 80 pages, le délai est de 6 mois. Avec une méthode classique, l''équipe développerait tout pendant 6 mois avant de montrer le résultat… au risque de découvrir trop tard que ce n''est pas ce qu''on attendait. Avec **Scrum**, elle livrera une version utilisable toutes les deux semaines et ajustera le tir en continu.

Dans ce parcours, tu suis **Zara**, cheffe de projet qui découvre les méthodes agiles sur ce projet.

> **Objectifs de ce chapitre**
> - Comprendre la différence entre cycle en V et approche agile
> - Connaître les trois rôles de Scrum
> - Connaître les événements (cérémonies) d''un sprint
> - Connaître les artefacts : backlog produit, backlog de sprint, incrément
> - Savoir quand Scrum est adapté, et quand il ne l''est pas

## Prédictif ou agile ?

L''approche **prédictive** (le cycle en V ou « en cascade ») enchaîne des phases : spécifications complètes, conception, développement, tests, livraison. Elle convient quand le besoin est parfaitement connu et stable, comme la construction d''un bâtiment.

L''approche **agile** découpe le projet en courtes itérations. À chaque itération, on livre une partie fonctionnelle du produit, on recueille les retours et on adapte la suite. Elle convient quand le besoin évolue ou n''est pas entièrement connu au départ, ce qui est le cas de la plupart des projets logiciels.

> **Info** : le **Manifeste agile** (2001) résume l''état d''esprit en quatre valeurs : les individus et leurs interactions plutôt que les processus et les outils ; un logiciel qui fonctionne plutôt qu''une documentation exhaustive ; la collaboration avec le client plutôt que la négociation contractuelle ; l''adaptation au changement plutôt que le suivi d''un plan.

## Scrum en une phrase

**Scrum** est le cadre agile le plus utilisé : une petite équipe livre un produit par **sprints**, des itérations de durée fixe (généralement 2 semaines, au maximum un mois), en s''inspectant et en s''adaptant régulièrement.

## Les trois rôles

### Le Product Owner

Il représente les utilisateurs et le client. Il décide **quoi** construire et dans quel ordre. Il gère le **backlog produit** (la liste ordonnée de tout ce qu''il faut faire) et maximise la valeur du produit. Sur le projet de Zara, c''est un agent du ministère, disponible chaque semaine.

### Le Scrum Master

Il aide l''équipe à appliquer Scrum et à s''améliorer. Il anime les événements, protège l''équipe des interruptions et lève les obstacles (un accès au serveur qui tarde, un service qui ne répond pas). Ce n''est **pas** un chef qui distribue les tâches.

### Les Developers

L''équipe qui réalise le travail : développeurs, testeurs, designers. Elle décide elle-même **comment** faire le travail et s''organise librement. Taille idéale : une dizaine de personnes au maximum.

> **Attention** : le Product Owner décide du **quoi**, l''équipe du **comment**. Un Product Owner qui impose la technique, ou une équipe qui change les priorités sans lui, sont deux signes de dysfonctionnement.

## Les événements du sprint

| Événement | Quand | Durée (sprint de 2 semaines) | Objectif |
| --- | --- | --- | --- |
| Sprint Planning | Début du sprint | 4 h max | Choisir l''objectif du sprint et les éléments à réaliser |
| Daily Scrum | Chaque jour, même heure | 15 min | Faire le point sur l''avancement vers l''objectif et les obstacles |
| Sprint Review | Fin du sprint | 2 h max | Montrer l''incrément aux parties prenantes et recueillir leurs retours |
| Sprint Retrospective | Après la review | 1 h 30 max | Améliorer la façon de travailler de l''équipe |

Le **Daily Scrum** n''est pas une réunion de compte rendu au chef : c''est un moment où l''équipe se synchronise. Beaucoup d''équipes s''appuient sur trois questions : qu''ai-je fait hier pour l''objectif ? que vais-je faire aujourd''hui ? qu''est-ce qui me bloque ?

La **rétrospective** est souvent la plus négligée, et pourtant la plus précieuse : on y décide d''une ou deux améliorations concrètes à essayer au sprint suivant.

## Les artefacts

- Le **Product Backlog** : la liste ordonnée de toutes les fonctionnalités, corrections et améliorations souhaitées. Elle évolue en permanence.
- Le **Sprint Backlog** : les éléments choisis pour le sprint en cours, et le plan pour les réaliser.
- L''**Incrément** : le résultat du sprint, un produit **utilisable** et testé, qui respecte la **définition de terminé** (*Definition of Done*) de l''équipe.

Exemple de définition de terminé : « Le code est relu par un collègue, les tests passent, la fonctionnalité est déployée en préproduction et validée par le Product Owner. »

## Quand Scrum n''est pas adapté

- Un besoin parfaitement connu et stable, avec une contrainte réglementaire forte : une approche prédictive peut suffire.
- Un client qui ne peut pas se rendre disponible pour donner son avis régulièrement : sans Product Owner engagé, Scrum perd son intérêt.
- Une équipe de support qui traite des demandes au fil de l''eau : la méthode **Kanban**, vue dans un prochain chapitre, est souvent plus adaptée.

## À toi de jouer

Le projet de Zara démarre. Prépare le **cadre Scrum** du projet :

1. Qui pourrait jouer le rôle de Product Owner côté ministère ? Quelles qualités et quelle disponibilité doit-il avoir ?
2. Propose la durée des sprints et justifie-la.
3. Construis le calendrier type d''un sprint de 2 semaines, avec le jour et l''heure de chaque événement.
4. Rédige la définition de terminé de l''équipe en 5 points.
5. Cite deux risques de ce projet que la démarche agile aide à réduire.

> **Exemple de réponse pour l''étape 5** : le risque de livrer une plateforme qui ne correspond pas aux attentes du ministère (réduit par la review toutes les deux semaines) et le risque de découvrir tardivement que le serveur ne supporte pas la charge le jour d''ouverture des inscriptions (réduit en livrant et testant tôt).

## Vérifie tes acquis

1. Qui décide de l''ordre des éléments du backlog produit ?
2. Quelle est la durée maximale du Daily Scrum ?
3. Quel est le but de la rétrospective ?

> **Réponses** : 1. Le Product Owner. 2. 15 minutes. 3. Améliorer la façon de travailler de l''équipe au sprint suivant.

## En résumé

- L''approche **agile** livre par petites itérations et s''adapte aux retours.
- **Scrum** : trois rôles (Product Owner, Scrum Master, Developers).
- Quatre événements : planning, daily, review, rétrospective, dans un **sprint** de durée fixe.
- Trois artefacts : product backlog, sprint backlog, incrément conforme à la définition de terminé.
- Scrum demande un Product Owner disponible et un besoin qui peut évoluer.

## Pour aller plus loin

- [Le Guide Scrum officiel, disponible en français](https://scrumguides.org/)
- Demande au mentor IA : « Joue le rôle d''un Product Owner exigeant et fais-moi animer un Sprint Planning. »'
WHERE t.slug = 'gestion-de-projets-it' AND l.title = 'Scrum : rôles et cérémonies';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'User stories, critères d''acceptation, INVEST, estimation en points et MoSCoW.', l.duration_minutes = 25, l.content = 'Le cahier des charges du ministère est un long document en prose. L''équipe de Zara ne peut pas travailler à partir de 80 pages : elle a besoin d''une liste d''éléments courts, compréhensibles, estimables et classés par priorité. C''est le **backlog produit**, et sa qualité conditionne celle de tout le projet.

> **Objectifs de ce chapitre**
> - Écrire des user stories centrées sur l''utilisateur
> - Rédiger des critères d''acceptation vérifiables
> - Découper un besoin trop gros
> - Estimer les efforts en points
> - Prioriser le backlog

## La user story

Une **user story** décrit un besoin du point de vue de l''utilisateur, en une phrase :

```text
En tant que [type d''utilisateur],
je veux [action],
afin de [bénéfice].
```

Exemples pour la plateforme des concours :

- « En tant que candidat, je veux créer mon compte avec mon numéro de téléphone, afin de m''inscrire sans adresse e-mail. »
- « En tant que candidat, je veux téléverser une photo de mon diplôme, afin de compléter mon dossier sans me déplacer. »
- « En tant qu''agent du ministère, je veux filtrer les dossiers incomplets, afin de relancer les candidats concernés. »

La partie **« afin de »** est essentielle : elle explique le pourquoi et permet à l''équipe de proposer parfois une meilleure solution.

> **Astuce** : une user story n''est pas une spécification complète. C''est un rappel de conversation : les détails se discutent entre le Product Owner et l''équipe au moment de la réaliser.

## Les critères d''acceptation

Chaque story est complétée par des **critères d''acceptation** : les conditions précises et vérifiables qui permettent de dire qu''elle est terminée. Le format **Étant donné / Quand / Alors** est très utilisé :

```text
Étant donné un candidat sur la page d''inscription,
quand il saisit un numéro de téléphone tchadien valide et un mot de passe de 8 caractères minimum,
alors son compte est créé et il reçoit un code de confirmation par SMS.

Étant donné un numéro déjà utilisé par un autre compte,
quand le candidat tente de s''inscrire,
alors un message lui indique que ce numéro est déjà enregistré et lui propose de se connecter.
```

> **Attention** : un critère comme « l''inscription doit être rapide et simple » n''est pas vérifiable. Remplace-le par un fait mesurable : « l''inscription se fait en 3 écrans maximum ».

## La règle INVEST

Une bonne user story respecte les critères **INVEST** :

| Lettre | Critère | Signification |
| --- | --- | --- |
| I | Indépendante | Peut être réalisée sans attendre une autre story, autant que possible |
| N | Négociable | Les détails se discutent, ce n''est pas un contrat figé |
| V | Valeur | Apporte quelque chose à un utilisateur ou au client |
| E | Estimable | L''équipe comprend assez bien pour estimer l''effort |
| S | *Small* (petite) | Réalisable en quelques jours, bien à l''intérieur d''un sprint |
| T | Testable | On peut vérifier qu''elle est terminée |

## Découper les stories trop grosses

« En tant que candidat, je veux m''inscrire à un concours » est trop gros : c''est une **épopée** (*epic*). On la découpe, de préférence par tranches qui apportent chacune de la valeur :

1. Créer un compte avec son numéro de téléphone.
2. Remplir ses informations personnelles.
3. Choisir le concours et la ville d''examen.
4. Téléverser les pièces justificatives.
5. Recevoir un récapitulatif de candidature par SMS.
6. Payer les frais d''inscription par Mobile Money.

> **Info** : découpe par **parcours utilisateur** (verticalement), pas par couches techniques (« faire la base de données », puis « faire l''interface »). Une story technique isolée n''apporte aucune valeur visible à la fin du sprint.

## Estimer l''effort

Les équipes Scrum estiment souvent en **points d''effort**, une mesure **relative** de la difficulté (complexité, quantité de travail, incertitude), plutôt qu''en heures. On utilise une suite proche de Fibonacci : 1, 2, 3, 5, 8, 13. Plus le nombre est grand, plus l''incertitude est grande ; au-delà de 13, on découpe.

Le **planning poker** est une technique simple : chaque membre de l''équipe choisit secrètement une carte, puis tout le monde la montre en même temps. Si les estimations sont très différentes, ceux qui ont donné la plus haute et la plus basse expliquent leur raisonnement, puis on revote. Ces discussions révèlent souvent un malentendu ou un risque oublié.

Après quelques sprints, l''équipe connaît sa **vélocité** : le nombre moyen de points qu''elle termine par sprint. Cela permet de prévoir.

## Prioriser

Le Product Owner classe le backlog par ordre de priorité. Une méthode simple, **MoSCoW** :

- **Must have** : indispensable, sans quoi le produit n''a pas de sens (créer un compte, s''inscrire à un concours).
- **Should have** : important mais contournable pour la première version (modifier son dossier après validation).
- **Could have** : appréciable si le temps le permet (choix de la langue arabe).
- **Won''t have (this time)** : explicitement exclu de cette version (application mobile native).

## À toi de jouer

Le ministère ajoute un besoin : « Les candidats doivent pouvoir connaître leurs résultats en ligne. »

1. Rédige au moins **4 user stories** (candidat et agent du ministère) pour ce besoin.
2. Écris 2 critères d''acceptation au format Étant donné / Quand / Alors pour la story la plus importante, dont un cas d''erreur.
3. Vérifie chaque story avec la grille INVEST et corrige-les si nécessaire.
4. Estime-les en points, seul ou avec des camarades par planning poker.
5. Classe-les avec MoSCoW.

> **Exemple de story** : « En tant que candidat, je veux recevoir un SMS dès que les résultats sont publiés, afin de ne pas consulter le site tous les jours. »

## Vérifie tes acquis

1. Quelles sont les trois parties d''une user story ?
2. Pourquoi estimer en points plutôt qu''en heures ?
3. Que signifie le « M » de MoSCoW ?

> **Réponses** : 1. Le type d''utilisateur, l''action souhaitée, le bénéfice attendu. 2. Parce que les points mesurent une difficulté relative, plus facile à estimer collectivement que des durées précises, et qu''ils intègrent l''incertitude. 3. *Must have* : indispensable.

## En résumé

- Une **user story** : « En tant que…, je veux…, afin de… ».
- Des **critères d''acceptation** vérifiables, au format Étant donné / Quand / Alors.
- La grille **INVEST** vérifie la qualité des stories ; les épopées se **découpent** par parcours utilisateur.
- On estime en **points** relatifs (planning poker) et on suit la **vélocité**.
- On priorise avec **MoSCoW** ; le backlog évolue en permanence.

## Pour aller plus loin

- Demande au mentor IA : « Relis mes user stories et signale celles qui ne respectent pas INVEST. »'
WHERE t.slug = 'gestion-de-projets-it' AND l.title = 'Rédiger un backlog efficace';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Tableau Kanban, limite du travail en cours, burndown chart et vélocité.', l.duration_minutes = 25, l.content = '« Où en est-on ? » C''est la question que le directeur général pose à Zara chaque lundi. Répondre « ça avance bien » ne suffit pas. Il faut des outils qui montrent, d''un coup d''œil, l''état réel du travail, les blocages et la tendance. Les plus utilisés en gestion de projet agile sont le **tableau Kanban** et le **graphique d''avancement** (*burndown chart*).

> **Objectifs de ce chapitre**
> - Organiser le travail avec un tableau Kanban
> - Limiter le travail en cours
> - Lire et construire un burndown chart
> - Suivre quelques indicateurs simples
> - Choisir un outil adapté à l''équipe

## Le tableau Kanban

**Kanban** (« étiquette » en japonais) est né dans les usines Toyota. Le principe : rendre le travail **visible** sur un tableau divisé en colonnes qui représentent les étapes. Chaque tâche est une carte qui se déplace de gauche à droite.

Un tableau simple pour l''équipe de Zara :

| À faire | En cours | En revue / test | Terminé |
| --- | --- | --- | --- |
| Paiement Mobile Money | Téléversement des pièces | Création de compte | Page d''accueil |
| Résultats en ligne | Filtre des dossiers | | Choix du concours |

Chaque carte indique la story, la personne qui s''en occupe et éventuellement une étiquette de couleur (bug, urgent, bloqué).

> **Astuce** : un tableau physique avec des post-it sur un mur, bien visible par toute l''équipe, fonctionne très bien et ne dépend ni de l''électricité ni de la connexion. Pour une équipe à distance, un outil en ligne prend le relais.

## Limiter le travail en cours

La règle la plus importante de Kanban, et la plus souvent oubliée : **limiter le nombre de tâches en cours** (*WIP limit*, *Work In Progress*). Par exemple : pas plus de 3 cartes dans la colonne « En cours ».

Pourquoi ? Parce qu''une équipe qui commence tout et ne finit rien n''avance pas. Passer d''une tâche à l''autre fait perdre du temps, et une tâche à 90 % n''apporte aucune valeur. Quand la colonne est pleine, on aide un collègue à terminer plutôt que de commencer autre chose.

> **Info** : « Arrêtez de commencer, commencez à finir » est la devise des équipes Kanban.

## Le burndown chart

Le **burndown chart** montre le travail **restant** au fil du temps. En Scrum, on le trace souvent pour un sprint :

- en abscisse, les jours du sprint ;
- en ordonnée, les points d''effort restants ;
- une **ligne idéale** descend régulièrement du total au départ jusqu''à zéro le dernier jour ;
- la **ligne réelle** est mise à jour chaque jour.

Exemple : un sprint de 10 jours avec 40 points.

| Jour | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Idéal | 40 | 36 | 32 | 28 | 24 | 20 | 16 | 12 | 8 | 4 |
| Réel | 40 | 40 | 37 | 37 | 37 | 29 | 24 | 21 | 13 | 5 |

### Lire le graphique

- La ligne réelle est **au-dessus** de l''idéale : l''équipe est en retard. Ici, du jour 2 au jour 5, rien n''a été terminé : il faut comprendre pourquoi (blocage, tâche sous-estimée, absence).
- La ligne réelle est **plate** pendant plusieurs jours : des tâches sont commencées mais pas terminées, ou l''équipe est bloquée.
- La ligne réelle **remonte** : du travail a été ajouté en cours de sprint, ce qui doit rester exceptionnel.
- La ligne réelle n''atteint pas zéro : certaines stories ne sont pas terminées. Elles retournent dans le backlog.

> **Attention** : le burndown est un outil pour l''équipe, pas un instrument de contrôle. S''il sert à juger les personnes, elles finiront par l''arranger pour qu''il soit joli, et il ne servira plus à rien.

## Quelques indicateurs utiles

- **Vélocité** : points terminés par sprint, en moyenne sur les 3 derniers sprints. Sert à prévoir combien de sprints restent.
- **Temps de cycle** : temps moyen entre le moment où une tâche est commencée et celui où elle est terminée. Plus il est court, plus l''équipe est fluide.
- **Nombre de bugs ouverts** : s''il augmente sprint après sprint, la qualité se dégrade.

Avec une vélocité de 30 points par sprint et 150 points restants dans le backlog, Zara peut annoncer environ 5 sprints, soit 10 semaines, tout en précisant que c''est une estimation qui sera affinée.

## Les outils

| Outil | Points forts |
| --- | --- |
| Tableau mural + post-it | Gratuit, très visible, sans connexion |
| Trello | Simple, gratuit pour les petites équipes, application mobile |
| Jira | Très complet, standard dans les entreprises tech, burndown intégré |
| GitHub Projects / GitLab | Lié directement au code et aux tickets |
| Tableur partagé | Suffisant pour démarrer, burndown en quelques formules |

Le meilleur outil est celui que **toute l''équipe utilise vraiment**, chaque jour.

## À toi de jouer

1. Crée un tableau Kanban (Trello, ou papier) pour un projet personnel ou de groupe, avec au moins 12 cartes et les colonnes À faire, En cours, En revue, Terminé.
2. Fixe une limite de travail en cours et respecte-la pendant une semaine.
3. Dans un tableur, construis le burndown du sprint ci-dessus (lignes idéale et réelle) sous forme de graphique.
4. Rédige en 5 lignes ton analyse de ce sprint pour la rétrospective : que s''est-il probablement passé et que proposer ?
5. Avec une vélocité de 25 points et un backlog restant de 120 points, combien de sprints de 2 semaines faut-il prévoir ?

> **Réponse de l''étape 5** : 120 ÷ 25 = 4,8, donc 5 sprints, soit environ 10 semaines, à présenter comme une estimation.

## Vérifie tes acquis

1. Pourquoi limiter le nombre de tâches en cours ?
2. Que signifie une ligne réelle qui reste plate plusieurs jours sur un burndown ?
3. Comment calcule-t-on la vélocité ?

> **Réponses** : 1. Pour finir les tâches avant d''en commencer d''autres et éviter les pertes de temps liées aux changements de tâche. 2. Que des tâches ne sont pas terminées : blocage, tâche trop grosse ou sous-estimée. 3. En faisant la moyenne des points terminés sur les derniers sprints.

## En résumé

- Le **tableau Kanban** rend le travail visible, colonne par colonne.
- **Limiter le travail en cours** fait avancer plus vite : commencer à finir.
- Le **burndown chart** compare le travail restant à une ligne idéale ; il révèle retards et blocages.
- **Vélocité**, **temps de cycle** et **bugs ouverts** sont des indicateurs simples et utiles.
- Le meilleur outil est celui que l''équipe utilise vraiment.

## Pour aller plus loin

- Demande au mentor IA : « Comment construire un burndown chart automatique dans Google Sheets ? Donne-moi les formules. »'
WHERE t.slug = 'gestion-de-projets-it' AND l.title = 'Suivre l''avancement (Kanban, burndown)';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Cartographie pouvoir/intérêt, plan de communication, rapport d''avancement et mauvaises nouvelles.', l.duration_minutes = 25, l.content = 'Le projet de Zara avance bien techniquement. Pourtant, un matin, le secrétaire général du ministère l''appelle, mécontent : il a appris par la presse que les inscriptions ouvriraient plus tard que prévu. Personne ne l''avait informé. Dans un projet, une mauvaise communication fait échouer autant de projets que les problèmes techniques. Ce chapitre t''apprend à identifier les bonnes personnes, à leur dire les bonnes choses, au bon moment et de la bonne façon.

> **Objectifs de ce chapitre**
> - Identifier et cartographier les parties prenantes
> - Construire un plan de communication
> - Rédiger un rapport d''avancement clair
> - Annoncer une mauvaise nouvelle
> - Animer une réunion efficace

## Qui sont les parties prenantes ?

Une **partie prenante** est toute personne ou organisation qui influence le projet ou qui est affectée par lui. Pour la plateforme des concours :

- le **sponsor** : le secrétaire général du ministère, qui finance et porte le projet ;
- le **Product Owner** et les agents du service des concours ;
- les **candidats**, futurs utilisateurs ;
- la **direction informatique** de l''État, qui héberge la plateforme ;
- l''**opérateur Mobile Money** pour le paiement des frais ;
- l''**équipe de développement** ;
- la **presse**, qui relaiera l''ouverture des inscriptions.

## La matrice pouvoir / intérêt

On classe les parties prenantes selon leur **pouvoir** sur le projet et leur **intérêt** pour lui :

| | Intérêt faible | Intérêt fort |
| --- | --- | --- |
| **Pouvoir fort** | **Satisfaire** : informer régulièrement, sans détails (direction informatique) | **Gérer de près** : impliquer, consulter souvent (secrétaire général, Product Owner) |
| **Pouvoir faible** | **Surveiller** : informer ponctuellement (presse) | **Tenir informé** : communiquer régulièrement (candidats, agents) |

> **Info** : l''erreur de Zara est classique : le secrétaire général se trouve dans la case « gérer de près », mais elle le traitait comme une partie prenante à simplement informer de temps en temps.

## Le plan de communication

Pour chaque partie prenante importante, on définit **quoi** communiquer, **quand**, **comment** et **qui** s''en charge :

| Partie prenante | Information | Fréquence | Canal | Responsable |
| --- | --- | --- | --- | --- |
| Secrétaire général | Avancement, risques, décisions à prendre | Toutes les 2 semaines | Réunion de 30 min + note d''une page | Zara |
| Product Owner | Contenu des sprints, arbitrages | Chaque sprint | Sprint review, échanges quotidiens | Équipe |
| Direction informatique | Besoins d''hébergement, dates de mise en production | Mensuelle | E-mail + réunion technique | Responsable technique |
| Candidats | Date d''ouverture, mode d''emploi | Avant et pendant l''ouverture | Site, radio, réseaux sociaux | Service communication |

## Le rapport d''avancement

Un décideur a peu de temps. Un bon rapport tient sur **une page** et se lit en deux minutes. Une structure efficace :

1. **Statut global** avec un code couleur : vert (dans les temps), orange (risque identifié, sous contrôle), rouge (décision nécessaire).
2. **Ce qui a été réalisé** depuis le dernier rapport (3 points maximum).
3. **Ce qui est prévu** pour la prochaine période.
4. **Risques et problèmes**, chacun avec son plan d''action.
5. **Décisions attendues** du destinataire, avec une date limite.

> **Astuce** : commence toujours par la conclusion. « Le projet est orange : l''ouverture des inscriptions est maintenue au 1er décembre, mais le paiement Mobile Money risque de n''être prêt que le 10. Nous avons besoin de votre accord sur la solution de repli proposée. » Le détail vient ensuite, pour ceux qui le souhaitent.

## Annoncer une mauvaise nouvelle

Les retards et les problèmes font partie de tout projet. Ce qui détruit la confiance, ce n''est pas le problème : c''est de l''apprendre trop tard ou par quelqu''un d''autre.

1. **Annonce tôt**, dès que le risque est sérieux, sans attendre d''être certain.
2. **Annonce toi-même**, directement à la personne concernée, avant qu''elle ne l''apprenne ailleurs.
3. **Sois factuel** : ce qui se passe, pourquoi, quel impact.
4. **Viens avec des options** : « Nous pouvons ouvrir le 1er décembre sans paiement en ligne (paiement au guichet pendant 10 jours), ou repousser l''ouverture au 10. Je recommande la première option, pour les raisons suivantes… »
5. **Ne cherche pas de coupable** en public.

> **Attention** : « La pastèque », c''est un projet vert à l''extérieur et rouge à l''intérieur. Un statut toujours vert jusqu''à la veille de l''échéance est le signe d''une communication défaillante, pas d''un projet réussi.

## Animer une réunion efficace

- Un **objectif** clair annoncé dans l''invitation (« décider de la date d''ouverture »).
- Un **ordre du jour** avec une durée pour chaque point.
- Seulement les **personnes nécessaires**.
- Un **compte rendu** envoyé le jour même : décisions prises, actions, responsables, échéances.

Un compte rendu très court suffit, par exemple : « Décision : ouverture le 1er décembre, paiement au guichet jusqu''au 10. Actions : Zara informe l''opérateur avant jeudi ; le service communication adapte le message radio avant le 20 novembre. »

## À toi de jouer

Le paiement Mobile Money aura 10 jours de retard à cause d''un délai de signature du contrat avec l''opérateur.

1. Dresse la liste des parties prenantes du projet et place-les dans la matrice pouvoir / intérêt.
2. Construis le plan de communication pour les quatre parties prenantes les plus importantes.
3. Rédige le rapport d''avancement d''une page destiné au secrétaire général, en annonçant ce retard avec deux options et ta recommandation.
4. Rédige le message court (5 lignes maximum) à publier pour informer les candidats du mode de paiement temporaire.

> **Pour t''auto-évaluer** : fais lire ton rapport à quelqu''un pendant 2 minutes, puis cache-le. S''il peut te dire le statut du projet, le problème et la décision attendue, ton rapport est efficace.

## Vérifie tes acquis

1. Comment traiter une partie prenante qui a un fort pouvoir et un fort intérêt ?
2. Quelles sont les cinq rubriques d''un rapport d''avancement efficace ?
3. Quelle est la règle principale pour annoncer une mauvaise nouvelle ?

> **Réponses** : 1. La gérer de près : l''impliquer et la consulter régulièrement. 2. Statut global, réalisations, prévisions, risques et problèmes, décisions attendues. 3. L''annoncer tôt, soi-même, avec des faits et des options.

## En résumé

- Les **parties prenantes** se cartographient selon leur pouvoir et leur intérêt.
- Le **plan de communication** précise quoi, quand, comment et par qui.
- Un **rapport d''avancement** tient sur une page et commence par la conclusion.
- Une mauvaise nouvelle s''annonce **tôt**, **soi-même**, avec des **options**.
- Une réunion efficace a un objectif, un ordre du jour et un compte rendu le jour même.

## Pour aller plus loin

- Demande au mentor IA : « Relis mon rapport d''avancement et propose une version plus courte et plus claire pour un directeur. »'
WHERE t.slug = 'gestion-de-projets-it' AND l.title = 'Communiquer avec les parties prenantes';


-- =====================================================================
-- Qualité & Tests Logiciels (qualite-tests-logiciels)
-- =====================================================================
UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Niveaux de test, fonctionnel et non fonctionnel, pyramide des tests et régression.', l.duration_minutes = 25, l.content = 'Le jour du lancement de son application de transfert d''argent, une fintech découvre qu''un envoi de 100 000 FCFA est débité deux fois quand la connexion coupe au mauvais moment. Les clients sont furieux, la réputation est abîmée. Un bug trouvé en production coûte beaucoup plus cher qu''un bug trouvé pendant le développement. Le métier de **testeur** (ou ingénieur qualité, *QA*) consiste justement à trouver ces problèmes **avant** les utilisateurs.

Dans ce parcours, tu accompagnes **Rokia**, testeuse dans une fintech de N''Djamena qui développe **TchadPay**, une application de paiement de factures (eau, électricité, abonnements TV).

> **Objectifs de ce chapitre**
> - Comprendre à quoi servent les tests et leurs limites
> - Connaître les niveaux de test : unitaire, intégration, système, acceptation
> - Distinguer tests fonctionnels et non fonctionnels
> - Comprendre la pyramide des tests
> - Connaître le rôle des tests de régression

## Pourquoi tester ?

Tester, c''est **comparer** le comportement réel d''un logiciel à son comportement attendu, pour trouver des écarts. Les tests permettent :

- de **trouver des défauts** avant qu''ils n''atteignent les utilisateurs ;
- de **donner confiance** avant une mise en production ;
- de **réduire les risques** financiers, juridiques et d''image ;
- de vérifier qu''une correction n''a rien **cassé ailleurs**.

> **Info** : un principe fondamental : **les tests montrent la présence de défauts, jamais leur absence**. On ne peut pas tout tester ; on teste en priorité ce qui présente le plus de risques.

## Les niveaux de test

| Niveau | Ce qu''on teste | Qui | Exemple TchadPay |
| --- | --- | --- | --- |
| **Unitaire** | Une petite unité de code isolée (une fonction) | Développeur | La fonction qui calcule les frais : 1 % avec un minimum de 100 FCFA |
| **Intégration** | La communication entre plusieurs composants | Développeur, testeur | L''application et l''API de la société d''électricité échangent correctement les références de facture |
| **Système** | L''application complète, de bout en bout | Testeur | Un utilisateur se connecte, choisit sa facture, paie et reçoit son reçu |
| **Acceptation** | La conformité aux besoins réels | Client, utilisateurs | Les agents d''une agence vérifient que le parcours correspond à leurs attentes |

## Tests fonctionnels et non fonctionnels

- Les tests **fonctionnels** vérifient **ce que fait** le logiciel : le paiement est-il enregistré ? le reçu contient-il les bonnes informations ?
- Les tests **non fonctionnels** vérifient **comment** il le fait :

| Type | Question posée |
| --- | --- |
| Performance | L''application répond-elle en moins de 3 secondes, même à 2 000 paiements par heure en fin de mois ? |
| Sécurité | Peut-on voir les factures d''un autre client en modifiant un numéro dans l''adresse ? |
| Utilisabilité | Un nouvel utilisateur paie-t-il sa facture sans aide ? |
| Compatibilité | Fonctionne-t-elle sur Android 9 avec 2 Go de mémoire ? |
| Fiabilité | Que se passe-t-il si la connexion coupe pendant le paiement ? |

> **Attention** : au Tchad, les tests de **fiabilité en conditions réelles** sont essentiels : connexion lente, coupures, téléphones modestes. Une application parfaite en Wi-Fi au bureau peut être inutilisable sur le terrain.

## Tests en boîte noire et en boîte blanche

- En **boîte noire**, on teste sans regarder le code, à partir des spécifications : on donne des entrées et on vérifie les sorties. C''est l''approche la plus courante pour un testeur.
- En **boîte blanche**, on s''appuie sur la structure du code, par exemple pour vérifier que chaque condition `if` a été testée dans ses deux cas.

## La pyramide des tests

Les tests n''ont pas tous le même coût. La **pyramide des tests** recommande :

- une **large base de tests unitaires** : très rapides (des milliers en quelques secondes), peu coûteux, faciles à maintenir ;
- un **étage intermédiaire de tests d''intégration** ;
- une **petite pointe de tests de bout en bout** (interface complète) : lents, fragiles, mais indispensables pour les parcours critiques.

Une équipe qui ne fait que des tests manuels de bout en bout se retrouve avec une pyramide inversée : chaque vérification est longue et coûteuse, donc on teste moins, et les bugs passent.

## Les tests de régression

Une **régression** est un défaut qui apparaît dans une fonctionnalité qui marchait auparavant, à cause d''une modification ailleurs. Exemple : en ajoutant le paiement des abonnements TV, un développeur casse le calcul des frais des factures d''eau.

Les **tests de régression** consistent à rejouer régulièrement les tests des fonctionnalités existantes après chaque modification. C''est là que l''**automatisation** devient indispensable : on ne peut pas tout retester à la main à chaque livraison.

## À toi de jouer

Voici des vérifications prévues sur TchadPay. Pour chacune, indique le niveau de test (unitaire, intégration, système, acceptation) et s''il s''agit d''un test fonctionnel ou non fonctionnel :

1. La fonction `calculerFrais(5000)` renvoie 100.
2. L''application affiche les factures retournées par l''API de la société d''eau.
3. Un utilisateur paie sa facture d''électricité de bout en bout et reçoit un SMS de confirmation.
4. Le paiement de 500 utilisateurs simultanés reste sous 3 secondes.
5. Des commerçants de Moundou valident que le parcours est compréhensible.
6. Un utilisateur connecté ne peut pas afficher le reçu d''un autre client.

> **Réponses** : 1. Unitaire, fonctionnel (1 % de 5 000 donne 50, donc le minimum de 100 s''applique). 2. Intégration, fonctionnel. 3. Système, fonctionnel. 4. Système, non fonctionnel (performance). 5. Acceptation, non fonctionnel (utilisabilité). 6. Système, non fonctionnel (sécurité).

## Vérifie tes acquis

1. Les tests peuvent-ils prouver qu''un logiciel n''a aucun défaut ?
2. Quel niveau de test vérifie une seule fonction isolée ?
3. Qu''est-ce qu''une régression ?

> **Réponses** : 1. Non, ils montrent la présence de défauts, jamais leur absence. 2. Le test unitaire. 3. Un défaut qui apparaît dans une fonctionnalité qui fonctionnait auparavant, à la suite d''une modification.

## En résumé

- Tester, c''est comparer le comportement réel au comportement attendu pour **réduire les risques**.
- Quatre niveaux : **unitaire**, **intégration**, **système**, **acceptation**.
- Tests **fonctionnels** (ce que fait le logiciel) et **non fonctionnels** (performance, sécurité, utilisabilité…).
- La **pyramide** : beaucoup de tests unitaires, moins de tests de bout en bout.
- Les tests de **régression** vérifient que rien ne s''est cassé ; ils gagnent à être automatisés.

## Pour aller plus loin

- Demande au mentor IA : « Liste-moi 10 risques à tester en priorité sur une application de paiement mobile. »'
WHERE t.slug = 'qualite-tests-logiciels' AND l.title = 'Les types de tests';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Structure d''un cas de test, partitions d''équivalence et valeurs limites.', l.duration_minutes = 25, l.content = 'Rokia doit tester la fonctionnalité « Payer une facture d''électricité » de TchadPay. Si elle se contente de « cliquer un peu partout », elle oubliera des cas importants et ne pourra pas refaire exactement les mêmes vérifications à la prochaine version. Elle va donc écrire des **cas de test** : des scénarios précis, reproductibles, que n''importe quel testeur pourra exécuter.

> **Objectifs de ce chapitre**
> - Connaître la structure d''un cas de test
> - Tester les cas nominaux, alternatifs et d''erreur
> - Appliquer les partitions d''équivalence et l''analyse des valeurs limites
> - Organiser les cas de test en campagne

## La structure d''un cas de test

| Champ | Exemple |
| --- | --- |
| Identifiant | CT-PAIE-001 |
| Titre | Paiement d''une facture d''électricité avec un solde suffisant |
| Préconditions | Utilisateur connecté, compte Mobile Money test avec 50 000 FCFA, facture n°F-2026-1042 de 12 500 FCFA impayée |
| Étapes | 1. Ouvrir « Factures ». 2. Choisir « Électricité ». 3. Saisir la référence F-2026-1042. 4. Valider. 5. Confirmer le paiement avec le code PIN de test. |
| Données | Référence F-2026-1042, PIN de test 0000 |
| Résultat attendu | Message « Paiement réussi », facture marquée payée, frais de 125 FCFA affichés, solde réduit de 12 625 FCFA, SMS de reçu envoyé |
| Priorité | Haute |

> **Attention** : le **résultat attendu** doit être précis et vérifiable. « Le paiement fonctionne » n''est pas un résultat attendu ; « le solde passe de 50 000 à 37 375 FCFA » en est un.

Une bonne règle : un autre testeur, qui ne connaît pas l''application, doit pouvoir exécuter ton cas de test et arriver à la même conclusion que toi.

## Couvrir les différents scénarios

Pour chaque fonctionnalité, on écrit des cas de test pour trois familles de scénarios :

- **Cas nominal** : tout se passe comme prévu (solde suffisant, référence valide, connexion stable).
- **Cas alternatifs** : chemins différents mais valides (paiement partiel autorisé, paiement de la facture d''un proche).
- **Cas d''erreur** : ce qui doit être refusé ou bien géré (solde insuffisant, référence inexistante, facture déjà payée, mauvais code PIN, perte de connexion pendant le paiement).

Les cas d''erreur sont souvent les plus révélateurs : c''est là que se cachent les bugs les plus graves, comme le double débit en cas de coupure réseau.

## Les partitions d''équivalence

On ne peut pas tester toutes les valeurs possibles. On regroupe les valeurs qui doivent se comporter de la même façon en **classes d''équivalence**, et on teste **une valeur par classe**.

Exemple : le montant d''un paiement doit être compris entre 500 et 500 000 FCFA.

| Classe | Exemple de valeur | Résultat attendu |
| --- | --- | --- |
| Trop petit | 200 | Refusé avec message d''erreur |
| Valide | 25 000 | Accepté |
| Trop grand | 800 000 | Refusé avec message d''erreur |
| Non numérique | « abc » | Refusé, saisie impossible ou message d''erreur |
| Vide | (rien) | Refusé |

## L''analyse des valeurs limites

Les erreurs se cachent très souvent **aux frontières**, à cause d''un `<` écrit à la place d''un `<=`. On teste donc précisément les limites et leurs voisines immédiates :

| Valeur | Résultat attendu |
| --- | --- |
| 499 | Refusé |
| 500 | Accepté |
| 501 | Accepté |
| 499 999 | Accepté |
| 500 000 | Accepté |
| 500 001 | Refusé |

> **Info** : ces deux techniques se combinent : les partitions d''équivalence choisissent une valeur représentative dans chaque classe, l''analyse des valeurs limites vérifie les frontières entre les classes.

## Organiser une campagne de test

Avant une mise en production, Rokia prépare une **campagne de test** :

1. Elle sélectionne les cas de test concernés par la nouvelle version, plus les tests de régression des fonctions critiques.
2. Elle les exécute et note le résultat de chacun : **réussi**, **échoué** ou **bloqué** (impossible à exécuter, par exemple parce que l''environnement de test est indisponible).
3. Pour chaque échec, elle crée une **fiche d''anomalie** (sujet du prochain chapitre).
4. Elle produit une **synthèse** : nombre de tests exécutés, réussis, échoués, anomalies bloquantes restantes, et sa recommandation pour la mise en production.

On utilise un tableur pour démarrer, puis un outil dédié (TestRail, Xray dans Jira, ou Qase) quand le nombre de cas de test augmente.

## À toi de jouer

La fonctionnalité « Transfert d''argent entre utilisateurs TchadPay » a les règles suivantes :

- montant entre 100 et 200 000 FCFA par transfert ;
- le numéro du destinataire doit être un numéro tchadien à 8 chiffres inscrit sur TchadPay ;
- frais de 1 % avec un minimum de 50 FCFA ;
- confirmation par code PIN, bloqué après 3 erreurs.

1. Identifie les classes d''équivalence pour le montant et pour le numéro du destinataire.
2. Liste les valeurs limites à tester pour le montant.
3. Rédige **6 cas de test complets** (avec la structure vue dans ce chapitre) : 2 nominaux et 4 d''erreur.
4. Calcule le résultat attendu des frais pour un transfert de 3 000 FCFA et pour un transfert de 50 000 FCFA.

> **Réponses de l''étape 4** : 1 % de 3 000 donne 30 FCFA, inférieur au minimum, donc 50 FCFA de frais. 1 % de 50 000 donne 500 FCFA de frais.

## Vérifie tes acquis

1. Quelles informations doit absolument contenir un cas de test ?
2. Pour un champ acceptant 1 à 10 articles, quelles valeurs limites tester ?
3. Que signifie un test au statut « bloqué » ?

> **Réponses** : 1. Au minimum un identifiant, des préconditions, des étapes, des données et un résultat attendu précis. 2. 0, 1, 2, 9, 10 et 11. 3. Qu''il n''a pas pu être exécuté, par exemple à cause d''un environnement indisponible ou d''une anomalie qui empêche d''atteindre l''étape.

## En résumé

- Un **cas de test** contient préconditions, étapes, données et un **résultat attendu précis**.
- On couvre les cas **nominaux**, **alternatifs** et **d''erreur**.
- Les **partitions d''équivalence** réduisent le nombre de tests : une valeur par classe.
- L''**analyse des valeurs limites** cible les frontières, où se cachent beaucoup de bugs.
- Une **campagne** regroupe l''exécution des tests et se termine par une synthèse.

## Pour aller plus loin

- Demande au mentor IA : « Voici une règle métier : [ta règle]. Aide-moi à trouver les classes d''équivalence et les valeurs limites. »'
WHERE t.slug = 'qualite-tests-logiciels' AND l.title = 'Écrire un cas de test efficace';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Quoi automatiser, tests unitaires PHPUnit, tests d''interface et intégration continue.', l.duration_minutes = 30, l.content = 'À chaque nouvelle version de TchadPay, Rokia rejoue à la main 120 cas de test de régression. Cela lui prend trois jours. L''équipe voudrait livrer toutes les deux semaines : ce n''est plus tenable. La solution est d''**automatiser** une partie des tests : un programme exécute les vérifications à la place d''une personne, en quelques minutes, autant de fois qu''on le souhaite.

> **Objectifs de ce chapitre**
> - Savoir quels tests automatiser en priorité
> - Écrire un test unitaire avec PHPUnit
> - Comprendre la structure Préparer / Agir / Vérifier
> - Découvrir l''automatisation des tests d''interface
> - Intégrer les tests automatisés dans un pipeline

## Que faut-il automatiser ?

Tout automatiser n''est ni possible ni souhaitable. On automatise en priorité :

- les tests **répétés souvent** (régression) ;
- les **calculs et règles métier** critiques (frais, limites, soldes) ;
- les **parcours essentiels** (connexion, paiement) ;
- les tests avec **beaucoup de combinaisons de données**.

On garde en manuel :

- les tests **exploratoires**, où le testeur cherche librement des problèmes avec son expérience et sa créativité ;
- les tests d''**utilisabilité** et de ressenti ;
- les fonctionnalités qui changent encore beaucoup.

> **Info** : un test automatisé a un coût : il faut l''écrire, puis le maintenir quand l''application évolue. Il devient rentable quand il est exécuté de nombreuses fois.

## Un premier test unitaire

Prenons la règle de calcul des frais de TchadPay : 1 % du montant, avec un minimum de 100 FCFA. Le code PHP :

```php
<?php
// src/Frais.php
class Frais
{
    public static function calculer(int $montant): int
    {
        if ($montant <= 0) {
            throw new InvalidArgumentException(''Montant invalide'');
        }
        return max(100, (int) round($montant * 0.01));
    }
}
```

Le test avec **PHPUnit**, l''outil de référence en PHP :

```php
<?php
// tests/FraisTest.php
use PHPUnit\\Framework\\TestCase;

class FraisTest extends TestCase
{
    public function testUnPourcentPourUnMontantNormal(): void
    {
        // Préparer
        $montant = 50000;
        // Agir
        $frais = Frais::calculer($montant);
        // Vérifier
        $this->assertSame(500, $frais);
    }

    public function testMinimumDeCentFrancs(): void
    {
        $this->assertSame(100, Frais::calculer(3000));
    }

    public function testMontantNegatifRefuse(): void
    {
        $this->expectException(InvalidArgumentException::class);
        Frais::calculer(-500);
    }
}
```

On lance les tests avec `vendor/bin/phpunit tests` : PHPUnit affiche un point par test réussi et le détail de chaque échec.

## La structure Préparer / Agir / Vérifier

Un bon test automatisé suit trois étapes, en anglais *Arrange / Act / Assert* :

1. **Préparer** les données et l''état de départ.
2. **Agir** : appeler la fonction ou l''action à tester.
3. **Vérifier** que le résultat est celui attendu, avec une **assertion**.

Règles d''or :

- **un comportement par test**, avec un nom qui le décrit (`testMinimumDeCentFrancs`) ;
- des tests **indépendants** les uns des autres, qui peuvent s''exécuter dans n''importe quel ordre ;
- des tests **rapides** et **déterministes** : le même résultat à chaque exécution.

> **Astuce** : quand un bug est trouvé, commence par écrire un test automatisé qui le reproduit (il échoue), puis corrige le code (le test passe). Ce bug ne pourra plus jamais revenir sans que l''équipe le sache.

## Les tests d''interface

Pour automatiser un parcours complet dans le navigateur (se connecter, choisir une facture, payer), on utilise un outil qui pilote un vrai navigateur, comme **Playwright** ou **Cypress**. Exemple avec Playwright en JavaScript :

```js
import { test, expect } from ''@playwright/test'';

test(''un client paie sa facture d\\''électricité'', async ({ page }) => {
  await page.goto(''https://test.tchadpay.td/connexion'');
  await page.fill(''#telephone'', ''66000001'');
  await page.fill(''#code'', ''0000'');
  await page.click(''text=Se connecter'');
  await page.click(''text=Électricité'');
  await page.fill(''#reference'', ''F-2026-1042'');
  await page.click(''text=Payer'');
  await expect(page.locator(''.message-succes'')).toContainText(''Paiement réussi'');
});
```

Pour les applications mobiles, **Appium** joue le même rôle sur Android et iOS.

> **Attention** : les tests d''interface sont lents et peuvent devenir **instables** (*flaky*) : ils échouent parfois sans vraie raison, à cause d''un chargement un peu plus lent. Un test instable perd vite la confiance de l''équipe. Garde-les peu nombreux, réservés aux parcours critiques, et corrige vite ceux qui deviennent instables.

## Les tests dans le pipeline

Les tests automatisés prennent toute leur valeur quand ils s''exécutent **automatiquement à chaque modification du code**, dans le pipeline d''intégration continue (CI). Si un test échoue, la modification n''est pas fusionnée : la régression est détectée en quelques minutes, au lieu de l''être par un client des semaines plus tard.

## À toi de jouer

1. Installe PHP et Composer, crée un dossier de projet et installe PHPUnit avec `composer require --dev phpunit/phpunit`.
2. Crée la classe `Frais` ci-dessus et ses trois tests ; exécute-les.
3. Ajoute un test pour la règle « frais plafonnés à 2 000 FCFA » ; il doit échouer.
4. Modifie la classe `Frais` pour que ce nouveau test passe, sans casser les autres.
5. Écris les tests des valeurs limites : 1, 9 999, 10 000, 10 001 et 1 000 000 FCFA.

> **Indice pour l''étape 4** : `min(2000, max(100, (int) round($montant * 0.01)))`. Vérifie que le test des 50 000 FCFA (500 de frais) passe toujours.

## Vérifie tes acquis

1. Pourquoi ne pas automatiser les tests exploratoires ?
2. Quelles sont les trois étapes d''un test automatisé ?
3. Qu''est-ce qu''un test instable et pourquoi est-il dangereux ?

> **Réponses** : 1. Parce qu''ils reposent sur l''intuition et la créativité du testeur, qu''un script ne peut pas reproduire. 2. Préparer, agir, vérifier. 3. Un test qui échoue parfois sans vraie raison ; l''équipe finit par ignorer ses échecs, y compris les vrais.

## En résumé

- On automatise les tests **répétitifs**, les **règles métier** et les **parcours critiques** ; l''exploratoire reste manuel.
- **PHPUnit** (PHP), et des équivalents dans chaque langage, permettent d''écrire des tests unitaires.
- Un test suit **Préparer / Agir / Vérifier**, teste un seul comportement et reste indépendant.
- **Playwright**, **Cypress** et **Appium** automatisent les tests d''interface, à utiliser avec modération.
- Les tests prennent toute leur valeur exécutés à chaque modification, dans la **CI**.

## Pour aller plus loin

- [La documentation de PHPUnit](https://docs.phpunit.de/)
- Demande au mentor IA : « Écris avec moi les tests PHPUnit d''une fonction qui vérifie un numéro de téléphone tchadien. »'
WHERE t.slug = 'qualite-tests-logiciels' AND l.title = 'Introduction aux tests automatisés';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Reproduire, rédiger une fiche d''anomalie, gravité, priorité et cycle de vie.', l.duration_minutes = 25, l.content = 'Rokia a trouvé un problème : en payant une facture d''eau, le reçu affiche parfois un montant de frais erroné. Si elle écrit simplement « Les frais sont faux » dans le groupe WhatsApp de l''équipe, le développeur va perdre une heure à chercher dans quel cas cela arrive, ou pire, conclure « chez moi ça marche » et passer à autre chose. Une anomalie mal décrite est une anomalie qui ne sera pas corrigée. Ce chapitre t''apprend à **reproduire**, **décrire** et **suivre** un défaut comme un professionnel.

> **Objectifs de ce chapitre**
> - Reproduire une anomalie de façon fiable
> - Rédiger une fiche d''anomalie complète et claire
> - Distinguer gravité et priorité
> - Connaître le cycle de vie d''une anomalie
> - Rassembler les bonnes preuves (captures, journaux)

## Reproduire avant de signaler

Avant d''écrire quoi que ce soit, Rokia cherche les conditions **exactes** dans lesquelles le problème apparaît. Elle fait varier un paramètre à la fois :

- Est-ce sur toutes les factures d''eau, ou seulement certaines ? → Seulement celles dont le montant se termine par 50.
- Sur tous les téléphones ? → Oui, Android comme navigateur web.
- Depuis quand ? → Depuis la version 2.4 livrée mardi.

Elle arrive à une description précise : « Les frais sont mal arrondis quand le montant de la facture se termine par 50 FCFA. » Le développeur saura immédiatement où chercher : dans la fonction d''arrondi.

> **Astuce** : si une anomalie n''apparaît qu''une fois sur dix, note-le explicitement (« fréquence : environ 1 fois sur 10 ») et décris tout ce qui était particulier à ce moment-là : connexion lente, application restée longtemps en arrière-plan, plusieurs onglets ouverts.

## La fiche d''anomalie

| Champ | Exemple |
| --- | --- |
| Titre | Frais mal arrondis pour les factures d''eau dont le montant se termine par 50 FCFA |
| Environnement | Préproduction, version 2.4.0, Android 11 (Tecno Spark) et Chrome 129 sur Windows |
| Préconditions | Compte de test 66000001 avec 50 000 FCFA, facture d''eau E-7731 de 12 550 FCFA |
| Étapes pour reproduire | 1. Se connecter. 2. Factures, puis Eau. 3. Saisir E-7731. 4. Payer avec le PIN 0000. |
| Résultat obtenu | Frais affichés : 125 FCFA ; total débité : 12 675 FCFA |
| Résultat attendu | Frais de 1 % de 12 550 = 125,5, arrondi à 126 FCFA selon la règle métier ; total : 12 676 FCFA |
| Fréquence | Systématique pour les montants se terminant par 50 |
| Gravité | Majeure |
| Priorité | Haute |
| Pièces jointes | Capture du reçu, extrait du journal de l''API |

Les qualités d''une bonne fiche :

- un **titre** qui permet de comprendre le problème sans ouvrir la fiche ;
- **une seule anomalie** par fiche ;
- des **étapes** que n''importe qui peut rejouer ;
- les résultats **obtenu** et **attendu**, factuels et chiffrés ;
- un ton **neutre** : on décrit le logiciel, jamais la personne qui l''a développé.

> **Attention** : n''écris jamais « le module de paiement ne marche pas » ou « encore un bug de Mahamat ». Un titre vague fait perdre du temps et un ton accusateur abîme la collaboration dans l''équipe.

## Gravité et priorité

Ces deux notions sont souvent confondues :

- La **gravité** mesure l''**impact** technique ou métier du défaut. Elle est évaluée par le testeur.
- La **priorité** indique l''**ordre** dans lequel le corriger. Elle est décidée avec le Product Owner, selon le contexte.

| Gravité | Exemple |
| --- | --- |
| Bloquante | Impossible de payer une facture : la fonctionnalité principale est inutilisable |
| Majeure | Montant de frais erroné, double débit dans certains cas |
| Mineure | Message d''erreur peu clair, mais l''utilisateur peut continuer |
| Cosmétique | Faute d''orthographe, icône mal alignée |

Les deux ne vont pas toujours ensemble : une faute d''orthographe dans le nom de l''entreprise sur la page d''accueil est **cosmétique** mais peut être **hautement prioritaire** juste avant un lancement très médiatisé.

## Le cycle de vie d''une anomalie

Dans l''outil de suivi (Jira, GitLab, GitHub Issues, Mantis…), une anomalie passe par plusieurs états :

1. **Nouvelle** : créée par le testeur.
2. **Analysée** ou **confirmée** : l''équipe la reproduit et la priorise.
3. **En cours** : un développeur la corrige.
4. **Corrigée** : la correction est livrée dans un environnement de test.
5. **Vérifiée** puis **Fermée** : le testeur rejoue le scénario et confirme la correction.
6. **Rouverte** : si le problème est toujours là.

D''autres issues sont possibles : **en double** (déjà signalée), **non reproductible**, ou **ne sera pas corrigée** (décision assumée et justifiée).

> **Info** : après une correction, rejoue toujours le scénario de l''anomalie, **et** quelques tests autour : une correction peut provoquer une régression ailleurs.

## Les preuves utiles

- une **capture d''écran** annotée (entoure la zone qui pose problème) ;
- une **vidéo courte** de l''écran pour les problèmes de parcours ou d''animation ;
- les **journaux** : console du navigateur (F12), journaux de l''application, réponse de l''API ;
- l''**heure exacte** du test, pour retrouver les traces côté serveur ;
- les **données** utilisées (numéro de compte de test, référence de facture).

Ne joins jamais de vraies données personnelles de clients : utilise des comptes de test.

## À toi de jouer

Lors de tes tests du transfert d''argent, tu constates ceci : si tu appuies deux fois rapidement sur « Confirmer », deux transferts de 10 000 FCFA sont effectués et le solde est débité deux fois. Cela arrive environ 3 fois sur 5 sur un téléphone Android avec une connexion 3G, jamais en Wi-Fi.

1. Rédige la fiche d''anomalie complète.
2. Évalue sa gravité et propose une priorité, en justifiant.
3. Propose deux pistes de correction possibles, l''une dans l''interface et l''autre côté serveur.
4. Décris comment tu vérifieras la correction, y compris les tests autour.

> **Éléments de correction** : gravité majeure, voire bloquante (perte d''argent pour le client), priorité très haute. Pistes : désactiver le bouton dès le premier appui ; côté serveur, refuser une seconde opération identique grâce à un identifiant unique de transaction (idempotence), la vraie protection. Vérification : rejouer le double appui en 3G, puis tester les transferts normaux et les erreurs.

## Vérifie tes acquis

1. Pourquoi faut-il une seule anomalie par fiche ?
2. Quelle est la différence entre gravité et priorité ?
3. Que fait le testeur quand une anomalie passe à l''état « Corrigée » ?

> **Réponses** : 1. Pour pouvoir suivre, corriger et vérifier chaque problème indépendamment. 2. La gravité mesure l''impact du défaut ; la priorité fixe l''ordre de correction selon le contexte. 3. Il rejoue le scénario pour vérifier la correction, teste autour, puis ferme ou rouvre l''anomalie.

## En résumé

- On **reproduit** et isole les conditions exactes avant de signaler.
- Une **fiche d''anomalie** : titre précis, environnement, étapes, résultats obtenu et attendu, fréquence, preuves.
- **Gravité** (impact) et **priorité** (ordre de correction) sont deux notions distinctes.
- Une anomalie suit un **cycle de vie** jusqu''à sa vérification et sa fermeture.
- Un ton neutre et des données de test, jamais de vraies données clients.

## Pour aller plus loin

- Demande au mentor IA : « Relis ma fiche d''anomalie et dis-moi ce qui manque pour qu''un développeur la reproduise du premier coup. »'
WHERE t.slug = 'qualite-tests-logiciels' AND l.title = 'Suivre et reproduire une anomalie';


-- =====================================================================
-- Développement de Jeux Vidéo (developpement-jeux-video)
-- =====================================================================
UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Défi, action, récompense, courbe de difficulté et document de conception.', l.duration_minutes = 25, l.content = 'Pourquoi joue-t-on « encore une partie » à certains jeux pendant des heures, alors qu''on abandonne d''autres au bout de cinq minutes ? Le secret tient souvent dans la **boucle de gameplay** : l''enchaînement d''actions que le joueur répète et qui lui procure du plaisir. Avant de programmer quoi que ce soit, un concepteur de jeu (*game designer*) définit cette boucle avec soin.

Dans ce parcours, tu suis **Hassan**, étudiant à N''Djamena, qui veut créer **Sahel Runner**, un jeu mobile où une jeune livreuse traverse la ville à moto pour livrer des colis en évitant les obstacles.

> **Objectifs de ce chapitre**
> - Comprendre la boucle de gameplay et ses trois temps
> - Distinguer boucle courte, moyenne et longue
> - Connaître les composantes d''un jeu : mécaniques, objectifs, retours
> - Concevoir une courbe de difficulté
> - Rédiger un document de conception d''une page

## La boucle de gameplay

Une boucle de gameplay se résume souvent à trois temps qui se répètent :

1. **Le défi** : le jeu propose une situation (un obstacle arrive, un ennemi apparaît).
2. **L''action** : le joueur réagit (sauter, esquiver, tirer, choisir).
3. **La récompense** : le jeu répond (points, pièces, son satisfaisant, progression), ce qui motive à recommencer.

Pour Sahel Runner : un obstacle apparaît (charrette, nid-de-poule, troupeau de chèvres), le joueur change de voie d''un glissement de doigt, il gagne des points et ramasse des pièces.

## Trois boucles imbriquées

| Boucle | Durée | Sahel Runner |
| --- | --- | --- |
| **Courte** | Quelques secondes | Esquiver un obstacle, ramasser une pièce |
| **Moyenne** | Quelques minutes | Terminer une livraison, battre son record |
| **Longue** | Des jours ou des semaines | Débloquer de nouvelles motos et de nouveaux quartiers de N''Djamena |

La boucle courte doit être **amusante en elle-même**. Les boucles moyenne et longue donnent envie de revenir. Si la boucle courte n''est pas plaisante, aucun système de récompense ne sauvera le jeu.

> **Info** : un exercice classique des concepteurs : « Si mon jeu ne contenait que la boucle courte, sans score ni niveaux, serait-il amusant 30 secondes ? » Si la réponse est non, il faut retravailler les sensations de base avant tout le reste.

## Les ingrédients d''un jeu

- Les **mécaniques** : les règles et les actions possibles (changer de voie, sauter, accélérer).
- Les **objectifs** : ce que le joueur cherche à accomplir (livrer le colis, atteindre 1 000 mètres).
- Les **contraintes** : ce qui rend l''objectif difficile (obstacles, temps limité, carburant).
- Les **retours** (*feedback*) : comment le jeu communique avec le joueur.

Les retours sont essentiels et souvent sous-estimés. Quand le joueur ramasse une pièce, il doit le **sentir** : un son clair, une petite animation, le compteur qui grossit un instant, une légère vibration du téléphone. Les développeurs appellent cela le *game feel* ou le « jus » (*juice*).

## La courbe de difficulté

Un jeu trop facile ennuie ; trop difficile, il décourage. Entre les deux se trouve l''état de **flow** : le joueur est totalement absorbé parce que le défi correspond à son niveau.

Pour y arriver :

- **Apprendre en jouant** : les premières secondes introduisent une seule mécanique à la fois, sans long tutoriel écrit.
- **Augmenter progressivement** : la vitesse augmente doucement, de nouveaux obstacles apparaissent au fil de la partie.
- **Alterner tension et repos** : après une séquence intense, un court moment plus calme.
- **Rendre l''échec acceptable** : une partie qui recommence en une seconde donne envie de réessayer.

> **Attention** : le concepteur connaît son jeu par cœur et le trouve toujours trop facile. Fais tester ton jeu par des personnes qui ne l''ont jamais vu, et observe-les sans les aider.

## Le contexte compte

Sahel Runner vise des joueurs au Tchad et en Afrique centrale. Cela guide la conception :

- des **parties courtes** (1 à 3 minutes), adaptées aux pauses et aux trajets ;
- un jeu **léger** et jouable **hors ligne**, pour les téléphones modestes et la data coûteuse ;
- un **univers familier** : rues de N''Djamena, motos-taxis, marchés, qui donne une identité forte face aux jeux étrangers.

## Le document de conception

Avant de coder, Hassan rédige un **document de conception** (*Game Design Document*) d''une page :

- **Concept** en une phrase : « Une livreuse traverse N''Djamena à moto en esquivant les obstacles pour livrer ses colis à temps. »
- **Public visé** et **plateforme** : joueurs occasionnels de 12 à 35 ans, Android.
- **Boucles** courte, moyenne et longue.
- **Contrôles** : glisser à gauche ou à droite pour changer de voie, glisser vers le haut pour sauter.
- **Conditions de victoire et de défaite**.
- **Progression** : ce qui se débloque.
- **Style visuel et sonore** : couleurs chaudes, musique inspirée des rythmes sahéliens.

## À toi de jouer

1. Choisis un jeu mobile que tu aimes et décris ses boucles courte, moyenne et longue.
2. Imagine ton propre concept de jeu inspiré du Tchad (marché, saison des pluies, lac Tchad, transport…).
3. Décris sa boucle courte en trois temps : défi, action, récompense.
4. Liste cinq retours (sons, animations, effets) qui rendront l''action satisfaisante.
5. Rédige le document de conception d''une page.
6. Prototype papier : dessine 5 situations de jeu sur des cartes et fais « jouer » un ami en lui demandant ce qu''il ferait à chaque fois.

> **Pour t''auto-évaluer** : si une personne comprend ton jeu et a envie d''y jouer après avoir lu seulement la phrase de concept, tu tiens une bonne idée.

## Vérifie tes acquis

1. Quels sont les trois temps d''une boucle de gameplay ?
2. Pourquoi la boucle courte est-elle la plus importante ?
3. Qu''est-ce que l''état de flow ?

> **Réponses** : 1. Le défi, l''action et la récompense. 2. Parce que c''est elle que le joueur vit en permanence : si elle n''est pas amusante, rien ne compense. 3. Un état d''absorption totale, quand la difficulté correspond au niveau du joueur.

## En résumé

- La **boucle de gameplay** répète défi, action, récompense.
- Boucles **courte** (secondes), **moyenne** (minutes) et **longue** (semaines) s''emboîtent.
- Mécaniques, objectifs, contraintes et **retours** sont les ingrédients d''un jeu.
- Une bonne **courbe de difficulté** mène au flow ; teste avec de vrais joueurs.
- Un **document de conception** d''une page fixe la vision avant de coder.

## Pour aller plus loin

- Demande au mentor IA : « Aide-moi à améliorer la boucle de gameplay de mon concept de jeu : [décris ton concept]. »'
WHERE t.slug = 'developpement-jeux-video' AND l.title = 'La boucle de gameplay';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Godot, Unity, Unreal ou Phaser, et les bases de Godot : nœuds et scènes.', l.duration_minutes = 25, l.content = 'Hassan a son concept. Il pourrait tout programmer à partir de zéro : l''affichage, les collisions, les sons, l''adaptation à chaque téléphone… Des mois de travail avant de voir sa livreuse bouger. Les développeurs utilisent plutôt un **moteur de jeu**, un logiciel qui fournit tous ces outils de base. Encore faut-il choisir le bon.

> **Objectifs de ce chapitre**
> - Comprendre ce qu''apporte un moteur de jeu
> - Comparer Godot, Unity, Unreal Engine et les solutions web
> - Choisir un moteur selon le projet, les compétences et le matériel
> - Découvrir les notions de base de Godot : scènes et nœuds

## Ce que fait un moteur de jeu

Un moteur de jeu fournit :

- le **rendu** graphique en 2D et en 3D ;
- la **physique** et les **collisions** ;
- la gestion des **entrées** (toucher, clavier, manette) ;
- le **son** et la musique ;
- un **éditeur** visuel pour placer les éléments des niveaux ;
- l''**export** vers différentes plateformes (Android, iOS, Windows, navigateur web).

Le développeur se concentre sur ce qui rend son jeu unique : les règles, les niveaux, l''univers.

## Les principaux moteurs

| Moteur | Langage | Licence et coût | Points forts | Points d''attention |
| --- | --- | --- | --- | --- |
| **Godot** | GDScript (proche de Python), C# | Libre et gratuit (MIT), sans redevance | Très léger, excellent en 2D, fonctionne sur un ordinateur modeste | Communauté plus petite, moins d''outils commerciaux |
| **Unity** | C# | Gratuit sous conditions de revenus, puis payant | Énorme communauté, beaucoup de tutoriels, très utilisé en mobile | Éditeur plus lourd ; conditions de licence à vérifier |
| **Unreal Engine** | C++, Blueprints (visuel) | Gratuit, redevance au-delà d''un certain chiffre d''affaires | Graphismes 3D de très haut niveau | Très gourmand, peu adapté à un premier jeu mobile 2D |
| **Phaser** et autres moteurs web | JavaScript | Libre et gratuit | Jeux jouables directement dans le navigateur, sans installation | Performances limitées pour les jeux complexes |

> **Attention** : les conditions de licence et les seuils de revenus des moteurs commerciaux évoluent. Vérifie toujours les conditions actuelles sur le site officiel avant de te lancer dans un projet commercial.

## Comment choisir ?

Pose-toi ces questions :

- **2D ou 3D ?** Pour un jeu mobile 2D comme Sahel Runner, Godot, Unity et Phaser conviennent tous.
- **Quel matériel ?** Sur un ordinateur portable avec 4 Go de mémoire, Godot (moins de 200 Mo) sera bien plus confortable qu''Unreal.
- **Quelles compétences ?** Si tu connais Python, GDScript te semblera familier ; si tu connais JavaScript, Phaser ; C# mène naturellement à Unity.
- **Quel objectif professionnel ?** Les studios mobiles recrutent beaucoup sur Unity ; Godot gagne rapidement en popularité chez les indépendants.
- **Quel budget ?** Godot n''a aucun coût, aucune condition et aucune redevance.

> **Info** : les concepts appris dans un moteur (scènes, objets, collisions, boucle de jeu) se transfèrent très bien vers un autre. Le plus important est de commencer et de **terminer** un premier petit jeu.

Hassan choisit **Godot 4** : léger pour son ordinateur, gratuit, excellent en 2D, avec un langage proche de Python qu''il a déjà pratiqué.

## Les bases de Godot : nœuds et scènes

Godot organise tout en **nœuds** (*nodes*). Chaque nœud a une fonction précise :

| Nœud | Rôle |
| --- | --- |
| `Node2D` | Un élément positionné en 2D |
| `Sprite2D` | Affiche une image |
| `CharacterBody2D` | Un personnage contrôlé qui se déplace et entre en collision |
| `CollisionShape2D` | La forme utilisée pour détecter les collisions |
| `Area2D` | Une zone qui détecte ce qui y entre (une pièce à ramasser) |
| `Camera2D` | La caméra qui suit le joueur |
| `Label` | Affiche un texte (le score) |
| `AudioStreamPlayer` | Joue un son |

On assemble des nœuds en arbre pour former une **scène**. Par exemple, la scène `Joueur` :

```text
Joueur (CharacterBody2D)
├── Sprite2D           ← l''image de la livreuse à moto
├── CollisionShape2D   ← sa forme de collision
└── Camera2D           ← la caméra qui la suit
```

Une scène peut ensuite être **instanciée** (réutilisée) dans une autre : la scène `Niveau` contient le joueur, des obstacles et des pièces, chacun étant lui-même une scène. C''est très pratique : modifier la scène `Piece` met à jour toutes les pièces du jeu.

On ajoute du comportement en attachant un **script** GDScript à un nœud. Deux fonctions sont essentielles :

```gdscript
extends Node2D

func _ready():
	print("La scène est prête")   # exécuté une fois, au chargement

func _process(delta):
	pass                           # exécuté à chaque image (60 fois par seconde environ)
```

`delta` est le temps écoulé depuis l''image précédente, en secondes. On s''en sert pour que le jeu tourne à la même vitesse sur un téléphone rapide et sur un téléphone lent.

## À toi de jouer

1. Pour ton propre concept de jeu, remplis le tableau de choix : 2D ou 3D, matériel disponible, compétences, objectif, budget. Choisis un moteur et justifie ton choix en cinq lignes.
2. Télécharge Godot 4 sur le site officiel (aucune installation n''est nécessaire, c''est un seul fichier).
3. Crée un nouveau projet, puis une scène avec un `Node2D` racine, un `Sprite2D` affichant l''icône de Godot et un `Label` affichant le nom de ton jeu.
4. Attache un script qui écrit « Bienvenue ! » dans la console au démarrage.
5. Lance la scène avec **F6**.

> **Pour t''auto-évaluer** : sauras-tu expliquer à un camarade la différence entre un nœud et une scène ? Un nœud est une brique avec une fonction précise ; une scène est un assemblage de nœuds réutilisable.

## Vérifie tes acquis

1. Cite trois services fournis par un moteur de jeu.
2. Pourquoi Godot est-il adapté à un ordinateur modeste ?
3. Que représente le paramètre `delta` dans `_process(delta)` ?

> **Réponses** : 1. Par exemple le rendu graphique, la physique, les collisions, le son, la gestion des entrées, l''export multiplateforme. 2. Parce qu''il est très léger (moins de 200 Mo) et peu gourmand en ressources. 3. Le temps écoulé depuis l''image précédente, qui permet d''avoir la même vitesse quel que soit l''appareil.

## En résumé

- Un **moteur de jeu** fournit rendu, physique, entrées, son, éditeur et export.
- **Godot** (libre, léger, idéal en 2D), **Unity** (très répandu en mobile), **Unreal** (3D haut de gamme), **Phaser** (web).
- On choisit selon la 2D/3D, le matériel, les compétences, l''objectif et le budget.
- Dans Godot, les **nœuds** s''assemblent en **scènes** réutilisables, animées par des scripts GDScript.

## Pour aller plus loin

- [La documentation officielle de Godot](https://docs.godotengine.org/fr/stable/)
- Demande au mentor IA : « Explique-moi la différence entre _process et _physics_process dans Godot. »'
WHERE t.slug = 'developpement-jeux-video' AND l.title = 'Choisir son moteur de jeu';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'CharacterBody2D, vecteurs, actions d''entrée, déplacement par voies et contrôle tactile dans Godot 4.', l.duration_minutes = 30, l.content = 'Place à la programmation ! Dans ce chapitre, tu vas faire bouger la livreuse de Sahel Runner avec Godot 4 : d''abord au clavier pour tester sur ordinateur, puis au toucher pour le téléphone. Tu découvriras les vecteurs, la vitesse et la façon dont Godot gère le déplacement d''un personnage.

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

- Dans le `Sprite2D`, glisse l''image de ta livreuse (ou l''icône de Godot pour commencer).
- Dans le `CollisionShape2D`, choisis une forme `RectangleShape2D` qui couvre à peu près l''image.
- Enregistre la scène sous `joueur.tscn`.

## Les vecteurs

En 2D, une position est un **vecteur** à deux composantes : `x` (horizontal, vers la droite) et `y` (vertical, **vers le bas** dans Godot). Le coin en haut à gauche de l''écran est `(0, 0)`.

```gdscript
position = Vector2(200, 400)   # 200 pixels à droite, 400 pixels vers le bas
```

Une **vitesse** est aussi un vecteur : elle indique de combien de pixels le personnage se déplace **par seconde** dans chaque direction. `Vector2(300, 0)` signifie 300 pixels par seconde vers la droite.

> **Info** : attention au sens de l''axe vertical : dans Godot, comme dans la plupart des moteurs 2D, `y` augmente vers le **bas**. Pour monter, la vitesse verticale doit être négative.

## Les actions d''entrée

Plutôt que de tester directement une touche précise, Godot utilise des **actions** nommées, définies dans *Projet → Paramètres du projet → Contrôles* (*Input Map*). Les actions `ui_left`, `ui_right`, `ui_up` et `ui_down` existent déjà et sont associées aux flèches du clavier. Tu pourras ensuite associer d''autres touches ou boutons à la même action sans changer ton code.

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

- `_physics_process` est appelée à intervalle régulier (60 fois par seconde par défaut) : c''est là qu''on gère les mouvements et la physique.
- `Input.get_vector` renvoie un vecteur de direction à partir des quatre actions, déjà normalisé : en diagonale, le personnage ne va pas plus vite.
- `velocity` est une propriété du `CharacterBody2D` : la vitesse souhaitée, en pixels par seconde.
- `move_and_slide()` déplace le personnage selon `velocity`, en tenant compte du temps écoulé et des collisions : il glisse le long des murs au lieu de s''y bloquer.

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

- `is_action_just_pressed` ne réagit qu''au **moment** de l''appui, pas tant que la touche reste enfoncée : un appui égale un changement de voie.
- `move_toward` rapproche la position de la cible d''au plus `VITESSE_LATERALE * delta` pixels par image : le changement de voie est fluide plutôt qu''instantané.

Ici, c''est la **route** qui défilera vers le bas pour donner l''impression d''avancer : le joueur reste à la même hauteur. Tu le feras au chapitre suivant avec les obstacles.

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

On mémorise la position du doigt quand il touche l''écran ; quand il se relève, on calcule l''écart horizontal. Au-delà de 50 pixels, on considère que c''est un glissement.

> **Astuce** : pour tester le tactile sur ordinateur, active *Projet → Paramètres du projet → Entrée → Pointage → Émuler le toucher depuis la souris* (en affichant les paramètres avancés). Le clic de la souris se comportera comme un doigt.

## À toi de jouer

1. Crée la scène `Joueur` avec le déplacement libre et teste-la.
2. Remplace-le par le déplacement en trois voies, d''abord au clavier.
3. Ajoute le contrôle tactile par glissement et teste-le avec l''émulation.
4. Ajoute un saut : quand on glisse vers le haut, la moto s''agrandit légèrement pendant 0,5 seconde (indice : modifie `scale` et utilise un `Timer` ou un `Tween`).
5. Ajuste `VITESSE_LATERALE` pour que le changement de voie soit à la fois rapide et agréable à l''œil.

> **Pour t''auto-évaluer** : fais tester ton prototype à quelqu''un sans rien lui expliquer. S''il comprend en moins de 10 secondes comment changer de voie, tes contrôles sont intuitifs.

## Vérifie tes acquis

1. Dans Godot, dans quel sens augmente la coordonnée `y` ?
2. Quelle est la différence entre `is_action_pressed` et `is_action_just_pressed` ?
3. Que fait `move_and_slide()` ?

> **Réponses** : 1. Vers le bas. 2. La première est vraie tant que la touche est enfoncée, la seconde seulement au moment de l''appui. 3. Elle déplace le CharacterBody2D selon sa vitesse en gérant les collisions et le temps écoulé.

## En résumé

- Un personnage contrôlé est un **CharacterBody2D** avec un sprite et une forme de collision.
- Positions et vitesses sont des **vecteurs** ; dans Godot, `y` augmente vers le bas.
- Les **actions** d''entrée découplent le code des touches physiques.
- `velocity` + `move_and_slide()` dans `_physics_process` gèrent le déplacement.
- Le tactile se gère dans `_input` avec `InputEventScreenTouch`.

## Pour aller plus loin

- Demande au mentor IA : « Comment ajouter une animation de virage à ma moto quand elle change de voie dans Godot 4 ? »'
WHERE t.slug = 'developpement-jeux-video' AND l.title = 'Déplacer un personnage';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Area2D, signaux, apparition d''objets, score, fin de partie et meilleur score.', l.duration_minutes = 30, l.content = 'La livreuse change de voie, mais il ne se passe encore rien : aucun obstacle, aucun danger, aucune récompense. Dans ce chapitre, tu vas compléter la boucle de gameplay de Sahel Runner : faire apparaître des obstacles et des pièces, détecter les collisions, compter le score et gérer la fin de partie.

> **Objectifs de ce chapitre**
> - Utiliser une Area2D pour détecter un contact
> - Connecter un signal à une fonction
> - Faire apparaître des objets avec un Timer
> - Afficher et mettre à jour un score
> - Gérer la fin de partie et le redémarrage
> - Sauvegarder le meilleur score

## Les zones de détection : Area2D

Pour savoir si la moto touche une pièce ou un obstacle, on utilise une **Area2D** : une zone qui détecte les corps qui y entrent, sans les bloquer physiquement.

Crée la scène `Piece` :

```text
Piece (Area2D)
├── Sprite2D
└── CollisionShape2D   (CircleShape2D)
```

Et la scène `Obstacle` sur le même modèle, avec l''image d''une charrette ou d''un nid-de-poule et une forme rectangulaire.

## Les signaux

Quand quelque chose se produit, un nœud émet un **signal**. L''Area2D émet le signal `body_entered` quand un corps entre dans sa zone. On le connecte à une fonction, soit dans l''onglet **Nœud → Signaux** de l''éditeur, soit par le code.

Script de la pièce :

```gdscript
extends Area2D

signal ramassee

const VITESSE_DEFILEMENT = 400.0

func _ready():
	body_entered.connect(_on_body_entered)

func _process(delta):
	position.y += VITESSE_DEFILEMENT * delta   # la pièce descend vers le joueur
	if position.y > 1400:
		queue_free()                           # sortie de l''écran : on la supprime

func _on_body_entered(body):
	if body.name == "Joueur":
		ramassee.emit()
		queue_free()
```

- Le signal personnalisé `ramassee` prévient le niveau qu''il faut ajouter des points.
- `queue_free()` supprime proprement le nœud. Supprimer les objets sortis de l''écran est indispensable : sinon, des milliers de pièces invisibles s''accumulent et le jeu ralentit.

Le script de l''obstacle est presque identique, mais il émet un signal `touche` au lieu de `ramassee`.

> **Info** : les signaux permettent aux scènes de rester **indépendantes** : la pièce ne connaît pas le système de score, elle annonce simplement qu''elle a été ramassée. Le niveau décide quoi en faire.

## Faire apparaître les objets

Dans la scène `Niveau`, ajoute un nœud **Timer** nommé `MinuteurApparition`, avec un temps d''attente de 0,8 seconde et l''option *Autostart* cochée. À chaque fin de minuterie, on crée un objet sur une voie au hasard :

```gdscript
extends Node2D

const SCENE_PIECE = preload("res://piece.tscn")
const SCENE_OBSTACLE = preload("res://obstacle.tscn")
const VOIES = [180.0, 360.0, 540.0]

var score = 0
var partie_en_cours = true

func _ready():
	$MinuteurApparition.timeout.connect(_faire_apparaitre)

func _faire_apparaitre():
	if not partie_en_cours:
		return
	var objet
	if randf() < 0.7:
		objet = SCENE_PIECE.instantiate()
		objet.ramassee.connect(_on_piece_ramassee)
	else:
		objet = SCENE_OBSTACLE.instantiate()
		objet.touche.connect(_on_obstacle_touche)
	objet.position = Vector2(VOIES.pick_random(), -100)
	add_child(objet)
```

- `preload` charge la scène une seule fois au démarrage.
- `instantiate()` crée une nouvelle copie de la scène ; `add_child()` l''ajoute au niveau.
- `randf()` renvoie un nombre aléatoire entre 0 et 1 : ici, 70 % de pièces et 30 % d''obstacles.

## Le score

Ajoute un nœud `CanvasLayer` contenant un `Label` nommé `LabelScore`, placé en haut de l''écran. Le `CanvasLayer` garde l''interface fixe à l''écran, même si la caméra bouge.

```gdscript
func _on_piece_ramassee():
	score += 10
	$CanvasLayer/LabelScore.text = "Score : %d" % score
	$SonPiece.play()
```

Un son court et clair (`AudioStreamPlayer` nommé `SonPiece`) rend la récompense bien plus satisfaisante : c''est le retour (*feedback*) vu au premier chapitre.

## La fin de partie

```gdscript
func _on_obstacle_touche():
	partie_en_cours = false
	$MinuteurApparition.stop()
	$CanvasLayer/LabelScore.text = "Livraison ratée ! Score : %d\\nTouchez pour rejouer" % score
	get_tree().paused = true

func _unhandled_input(event):
	if not partie_en_cours and event is InputEventScreenTouch and event.pressed:
		get_tree().paused = false
		get_tree().reload_current_scene()
```

`get_tree().paused = true` met le jeu en pause. Pour que le niveau puisse encore recevoir le toucher de redémarrage, règle son mode de traitement (*Process → Mode*) sur **Always** dans l''inspecteur. `reload_current_scene()` relance une partie propre.

> **Attention** : teste la fin de partie dès que possible. Les bugs de redémarrage (score qui ne se remet pas à zéro, objets qui continuent d''apparaître) sont parmi les plus fréquents dans les premiers jeux.

## Augmenter la difficulté

Pour que la partie devienne progressivement plus intense, on accélère l''apparition des objets au fil du score :

```gdscript
	$MinuteurApparition.wait_time = max(0.35, 0.8 - score / 2000.0)
```

## Sauvegarder le meilleur score

Godot permet d''écrire dans un fichier propre au jeu, avec le chemin spécial `user://` :

```gdscript
const FICHIER_RECORD = "user://record.save"

func sauvegarder_record(valeur):
	var fichier = FileAccess.open(FICHIER_RECORD, FileAccess.WRITE)
	fichier.store_32(valeur)

func charger_record():
	if not FileAccess.file_exists(FICHIER_RECORD):
		return 0
	var fichier = FileAccess.open(FICHIER_RECORD, FileAccess.READ)
	return fichier.get_32()
```

Afficher « Nouveau record ! » quand le joueur bat son meilleur score est l''un des moteurs les plus puissants de la boucle moyenne.

## À toi de jouer

1. Crée les scènes `Piece` et `Obstacle` avec leurs scripts et leurs signaux.
2. Ajoute le minuteur d''apparition dans le niveau et vérifie que les objets apparaissent sur les trois voies.
3. Affiche le score et ajoute un son à chaque pièce ramassée.
4. Gère la fin de partie et le redémarrage par un toucher.
5. Ajoute l''augmentation progressive de la difficulté.
6. Sauvegarde et affiche le meilleur score.
7. Bonus : exporte ton jeu en APK Android (*Projet → Exporter*) et fais-le tester par trois personnes.

> **Pour t''auto-évaluer** : ton prototype est réussi si un testeur dit spontanément « encore une ! » après sa première partie. C''est le signe que ta boucle de gameplay fonctionne.

## Vérifie tes acquis

1. Quelle est la différence entre une Area2D et un CharacterBody2D ?
2. À quoi sert un signal ?
3. Pourquoi supprimer les objets qui sortent de l''écran ?

> **Réponses** : 1. L''Area2D détecte ce qui entre dans sa zone sans bloquer ; le CharacterBody2D est un corps contrôlé qui se déplace et entre en collision physiquement. 2. À prévenir d''autres nœuds qu''un événement s''est produit, sans que les scènes dépendent les unes des autres. 3. Pour éviter qu''ils s''accumulent inutilement en mémoire et ralentissent le jeu.

## En résumé

- Une **Area2D** détecte les contacts ; son signal `body_entered` déclenche une fonction.
- Les **signaux** gardent les scènes indépendantes les unes des autres.
- Un **Timer** et `instantiate()` font apparaître des objets ; `queue_free()` les supprime.
- Le **score**, les **sons** et la **fin de partie** complètent la boucle de gameplay.
- `user://` permet de **sauvegarder** le meilleur score.

## Pour aller plus loin

- Demande au mentor IA : « Comment ajouter un écran de menu principal et un bouton pause à mon jeu Godot 4 ? »'
WHERE t.slug = 'developpement-jeux-video' AND l.title = 'Gérer les collisions et le score';


-- =====================================================================
-- Maintenance Informatique & Support Technique (maintenance-informatique)
-- =====================================================================
UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Composants, sécurité, assemblage, démarrage et méthode de diagnostic.', l.duration_minutes = 30, l.content = 'Au Tchad, un ordinateur est un investissement important. On le répare plutôt que de le remplacer, et un bon technicien de maintenance est toujours recherché, dans une boutique, une administration, une ONG ou à son compte. Pour réparer, il faut d''abord savoir comment l''ordinateur est construit et comment trouver méthodiquement d''où vient une panne.

Dans ce parcours, tu suis **Djibrine**, qui vient d''ouvrir un petit atelier de réparation informatique près du grand marché de N''Djamena.

> **Objectifs de ce chapitre**
> - Identifier les composants d''un ordinateur et leur rôle
> - Respecter les règles de sécurité avant d''ouvrir une machine
> - Assembler les éléments d''un ordinateur de bureau
> - Comprendre la séquence de démarrage
> - Appliquer une méthode de diagnostic

## Les composants essentiels

| Composant | Rôle | Analogie |
| --- | --- | --- |
| **Carte mère** | Relie tous les composants entre eux | Le squelette et le système nerveux |
| **Processeur** (CPU) | Exécute les calculs et les instructions | Le cerveau |
| **Mémoire vive** (RAM) | Stocke temporairement les programmes ouverts ; s''efface à l''extinction | Le plan de travail |
| **Stockage** (disque dur HDD ou SSD) | Conserve le système, les programmes et les fichiers | L''armoire |
| **Alimentation** | Transforme le courant du secteur pour les composants | Le cœur |
| **Carte graphique** (GPU) | Calcule l''affichage ; souvent intégrée au processeur | Les yeux |
| **Ventilateurs et radiateurs** | Évacuent la chaleur | Le système de refroidissement |

> **Info** : remplacer un vieux disque dur (HDD) par un **SSD** est souvent la réparation la plus rentable : l''ordinateur démarre en quelques secondes au lieu de plusieurs minutes. C''est un service très apprécié des clients.

## La sécurité avant tout

Avant d''ouvrir un ordinateur :

1. **Éteins** l''ordinateur et **débranche** le câble d''alimentation. Pour un portable, retire aussi la batterie si elle est amovible.
2. Appuie quelques secondes sur le bouton marche pour décharger le courant résiduel.
3. Décharge l''**électricité statique** de ton corps en touchant une partie métallique non peinte du boîtier, ou porte un **bracelet antistatique**. Une décharge invisible suffit à détruire une barrette de mémoire.
4. Travaille sur une surface propre, non métallique, bien éclairée, et range les vis dans des petites boîtes séparées.

> **Attention** : n''ouvre **jamais** un bloc d''alimentation ni un écran ancien à tube : ils contiennent des condensateurs qui peuvent rester chargés à des tensions dangereuses longtemps après le débranchement. Un bloc d''alimentation défectueux se remplace, il ne se répare pas.

## Assembler un ordinateur de bureau

L''ordre de montage habituel :

1. Installer le **processeur** sur la carte mère en respectant le repère (un petit triangle doré), sans jamais forcer.
2. Appliquer une fine couche de **pâte thermique** et fixer le **radiateur** avec son ventilateur.
3. Insérer les barrettes de **RAM** dans les bons emplacements, jusqu''au clic des loquets.
4. Fixer la **carte mère** dans le boîtier sur ses entretoises.
5. Installer l''**alimentation**, puis le **disque** ou le SSD.
6. Brancher les câbles : alimentation 24 broches de la carte mère, 4 ou 8 broches du processeur, câbles des disques, boutons de la façade.
7. Ajouter la carte graphique si besoin.
8. **Avant de refermer**, faire un premier démarrage de test.

## La séquence de démarrage

Quand on appuie sur le bouton :

1. L''alimentation fournit le courant aux composants.
2. Le micrologiciel de la carte mère (**BIOS** ou **UEFI**) lance l''autotest de démarrage, le **POST** : il vérifie le processeur, la mémoire, la carte graphique.
3. Si tout va bien, il cherche un support de démarrage (SSD, disque, clé USB) dans l''ordre configuré.
4. Il lance le **système d''exploitation** (Windows, Linux).

En cas de problème pendant le POST, beaucoup de cartes mères émettent des **bips** ou allument des **voyants** selon un code qui indique le composant en cause. Le code exact dépend du fabricant : consulte le manuel de la carte mère ou le site du constructeur.

## La méthode de diagnostic

Un bon technicien ne change pas des pièces au hasard. Il suit une méthode :

1. **Écouter le client** : que se passe-t-il exactement ? Depuis quand ? Qu''est-ce qui a changé (chute, orage, coupure de courant, nouvelle installation) ?
2. **Reproduire** la panne soi-même.
3. **Commencer par le plus simple** : le câble est-il branché ? la prise fonctionne-t-elle ? l''écran est-il allumé sur la bonne entrée ?
4. **Isoler** : ne garder que le minimum (carte mère, processeur, une barrette de RAM, alimentation) et ajouter les éléments un par un.
5. **Tester par substitution** : remplacer un composant suspect par un composant qu''on sait fonctionnel.
6. **Noter** chaque test et son résultat.

| Symptôme | Pistes à vérifier en premier |
| --- | --- |
| Rien ne se passe, aucun voyant | Prise, câble, interrupteur de l''alimentation, alimentation défectueuse |
| Les ventilateurs tournent, écran noir | Câble vidéo, RAM mal enfoncée (la retirer et la réinsérer), carte graphique |
| Bips au démarrage | Code de bips du fabricant : souvent la RAM ou la carte graphique |
| L''ordinateur s''éteint tout seul | Surchauffe : poussière, ventilateur bloqué, pâte thermique sèche |
| « Aucun périphérique de démarrage » | Disque débranché ou en panne, ordre de démarrage dans le BIOS |

> **Astuce** : au Tchad, la **poussière** et la **chaleur** sont responsables d''une grande partie des pannes. Un nettoyage à la bombe d''air sec (ou à la soufflette), ventilateurs bloqués pour ne pas qu''ils s''emballent, règle de nombreux arrêts inexpliqués. Propose-le systématiquement à tes clients.

## À toi de jouer

1. Si tu as accès à un vieil ordinateur de bureau, ouvre-le en respectant les règles de sécurité et identifie chaque composant. Prends des photos et légende-les.
2. Dresse la fiche technique de ton ordinateur avec l''outil gratuit **CPU-Z** (Windows) ou la commande `lshw -short` (Linux) : processeur, quantité de RAM, type de stockage.
3. Pour chacun des cas suivants, écris les trois premières vérifications que tu ferais :
   - un client dit que son ordinateur « ne s''allume plus depuis l''orage d''hier » ;
   - un ordinateur portable s''éteint après 20 minutes d''utilisation ;
   - au démarrage, l''écran affiche « No bootable device ».
4. Rédige un modèle de **fiche d''intervention** pour l''atelier de Djibrine : client, appareil, symptômes, tests réalisés, diagnostic, réparation, prix, garantie.

> **Éléments de correction pour l''étape 3** : après l''orage, vérifier la prise et la multiprise, tester avec un autre câble ou une autre alimentation, puis la carte mère. Pour le portable, nettoyer les aérations et le ventilateur, vérifier les températures, puis la pâte thermique. Pour « No bootable device », vérifier l''ordre de démarrage dans le BIOS, la détection du disque, puis l''état du disque.

## Vérifie tes acquis

1. Quelle est la différence entre la RAM et le stockage ?
2. Que vérifie le POST ?
3. Pourquoi faut-il toucher une partie métallique avant de manipuler des composants ?

> **Réponses** : 1. La RAM conserve temporairement les programmes en cours et s''efface à l''extinction ; le stockage conserve durablement les fichiers. 2. Le bon fonctionnement des composants essentiels au démarrage (processeur, mémoire, carte graphique). 3. Pour décharger l''électricité statique, qui peut détruire les composants.

## En résumé

- Carte mère, processeur, RAM, stockage, alimentation, carte graphique et refroidissement forment un ordinateur.
- **Débrancher**, décharger l''électricité statique, ne jamais ouvrir une alimentation.
- Le démarrage passe par le **BIOS/UEFI**, le **POST**, puis le système d''exploitation.
- Le diagnostic suit une méthode : écouter, reproduire, commencer simple, isoler, substituer, noter.
- Poussière et chaleur causent de nombreuses pannes : le nettoyage est un service essentiel.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi comment choisir un SSD compatible avec un ordinateur portable donné. »'
WHERE t.slug = 'maintenance-informatique' AND l.title = 'Assembler et diagnostiquer un ordinateur';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Ordinateur lent, virus, Windows qui démarre mal et problèmes d''impression.', l.duration_minutes = 30, l.content = 'Dans l''atelier de Djibrine, la plupart des clients n''arrivent pas avec un composant grillé, mais avec un ordinateur « devenu très lent », « plein de publicités », « qui ne s''allume plus correctement » ou une imprimante qui refuse d''imprimer. Ces pannes logicielles et courantes représentent l''essentiel du travail quotidien d''un technicien. Savoir les résoudre vite et proprement fait la réputation d''un atelier.

> **Objectifs de ce chapitre**
> - Diagnostiquer et accélérer un ordinateur lent
> - Supprimer virus et logiciels indésirables
> - Réparer un Windows qui démarre mal
> - Récupérer les données d''un client avant toute intervention
> - Résoudre les problèmes d''impression les plus fréquents

## La règle d''or : protéger les données du client

Avant toute intervention importante (réinstallation, réparation du disque), pose la question : « Y a-t-il des documents importants sur cet ordinateur ? » Puis **sauvegarde** les dossiers essentiels (Documents, Bureau, Images, Téléchargements, fichiers de comptabilité) sur un disque externe.

> **Attention** : une réinstallation qui efface les photos de famille ou la comptabilité d''une boutique, et ta réputation en souffre durablement. Fais signer au client une fiche indiquant si une sauvegarde a été faite et qui en porte la responsabilité.

## L''ordinateur lent

C''est la plainte numéro un. Les causes les plus fréquentes et leurs solutions :

| Cause | Vérification | Solution |
| --- | --- | --- |
| Trop de programmes au démarrage | Gestionnaire des tâches (**Ctrl+Maj+Échap**), onglet Démarrage | Désactiver les programmes inutiles au démarrage |
| Disque presque plein | Explorateur, propriétés du disque C: | Nettoyage de disque, suppression des fichiers inutiles |
| Disque dur mécanique fatigué | Gestionnaire des tâches : disque à 100 % en permanence | Remplacer par un SSD |
| Mémoire insuffisante | Gestionnaire des tâches, onglet Performance | Fermer des programmes, ajouter de la RAM |
| Logiciels malveillants | Analyse antivirus | Voir la section suivante |
| Surchauffe | Ventilateur bruyant, ordinateur brûlant | Nettoyage de la poussière |

Le **Gestionnaire des tâches** est ton premier outil : il montre en direct ce qui consomme le processeur, la mémoire et le disque.

> **Info** : l''outil intégré **Nettoyage de disque** (tape `cleanmgr` dans la recherche Windows), avec l''option « Nettoyer les fichiers système », libère souvent plusieurs gigaoctets d''anciennes mises à jour.

## Virus et logiciels indésirables

Symptômes typiques : publicités qui s''ouvrent seules, page d''accueil du navigateur modifiée, nouveaux programmes inconnus, fichiers dont l''extension a changé, clés USB dont les dossiers sont devenus des raccourcis.

La démarche :

1. **Déconnecter** l''ordinateur d''Internet pour limiter les dégâts.
2. Lancer une **analyse complète** avec **Microsoft Defender**, intégré à Windows 10 et 11 et efficace s''il est à jour.
3. Compléter avec un outil de seconde opinion gratuit comme **Malwarebytes** (version gratuite) pour les logiciels publicitaires.
4. Désinstaller les programmes inconnus (**Paramètres → Applications**) et réinitialiser les navigateurs.
5. Si l''infection est profonde ou s''il s''agit d''un **rançongiciel** (fichiers chiffrés, demande de rançon) : sauvegarder ce qui peut l''être, puis réinstaller complètement le système.

> **Astuce** : beaucoup d''infections au Tchad passent par les **clés USB** échangées entre cybercafés, bureaux et écoles. Conseille à tes clients d''analyser toute clé avant de l''ouvrir et de ne jamais exécuter un fichier inconnu qui s''y trouve.

## Windows démarre mal

### L''écran bleu

Note le **code d''arrêt** affiché (par exemple `MEMORY_MANAGEMENT` ou `CRITICAL_PROCESS_DIED`) et recherche-le : il oriente le diagnostic. La mémoire défectueuse se teste avec l''outil intégré **Diagnostic de mémoire Windows** (`mdsched`).

### Les outils de réparation

Si Windows échoue au démarrage plusieurs fois de suite, il propose l''**environnement de récupération**, avec :

- **Outil de redémarrage système** : répare automatiquement les problèmes de démarrage ;
- **Restauration du système** : revient à un point de restauration antérieur, sans toucher aux documents ;
- **Désinstaller les mises à jour** : utile si le problème est apparu juste après une mise à jour ;
- **Invite de commandes** : pour les réparations avancées.

Depuis une invite de commandes en administrateur, deux commandes réparent les fichiers système endommagés :

```text
sfc /scannow
DISM /Online /Cleanup-Image /RestoreHealth
```

Et pour vérifier les erreurs du disque : `chkdsk C: /f` (l''analyse se fera au prochain redémarrage).

## Les pannes d''impression

| Problème | Vérifications |
| --- | --- |
| L''imprimante n''imprime rien | Allumée, papier, câble ou Wi-Fi, bonne imprimante par défaut |
| Documents bloqués dans la file d''attente | Annuler tous les documents ; si besoin, redémarrer le service « Spouleur d''impression » |
| Impression pâle ou avec des traits | Niveau d''encre ou de toner, nettoyage des têtes (menu de l''imprimante) |
| Bourrage papier | Retirer le papier délicatement dans le sens de passage, vérifier qu''aucun morceau ne reste |
| Imprimante « hors ligne » | Réinstaller le pilote depuis le site du fabricant, vérifier l''adresse IP pour une imprimante réseau |

## À toi de jouer

1. Sur ton ordinateur, ouvre le Gestionnaire des tâches et relève les trois programmes qui consomment le plus de mémoire, puis la liste des programmes au démarrage. Lesquels pourraient être désactivés ?
2. Lance le Nettoyage de disque avec les fichiers système et note l''espace libéré.
3. Rédige une **procédure en 10 étapes** pour la prise en charge d''un « ordinateur lent » à l''atelier, de l''accueil du client à la remise de l''appareil.
4. Un client arrive : sa clé USB montre des raccourcis à la place de ses dossiers. Explique-lui en termes simples ce qui s''est passé et comment tu vas récupérer ses fichiers.
5. Crée une **grille de tarifs** indicative pour les interventions courantes de l''atelier (nettoyage, désinfection, réinstallation avec sauvegarde, remplacement par un SSD).

> **Pour l''étape 4** : un virus a caché les vrais dossiers et créé des raccourcis qui lancent le virus. Il ne faut surtout pas cliquer dessus. Les vrais fichiers sont généralement toujours sur la clé, simplement masqués : on analyse la clé, on supprime les raccourcis malveillants, puis on rend les dossiers à nouveau visibles.

## Vérifie tes acquis

1. Que faut-il toujours faire avant une réinstallation de Windows ?
2. Quel outil intégré permet de voir ce qui ralentit un ordinateur ?
3. Que fait la commande `sfc /scannow` ?

> **Réponses** : 1. Sauvegarder les données du client. 2. Le Gestionnaire des tâches. 3. Elle vérifie et répare les fichiers système de Windows endommagés.

## En résumé

- **Sauvegarder les données du client** avant toute intervention importante.
- Un ordinateur lent : programmes au démarrage, disque plein, disque mécanique, manque de RAM, virus, poussière.
- Contre les virus : déconnecter, analyser avec Defender et un outil complémentaire, réinstaller si nécessaire.
- L''**environnement de récupération**, `sfc` et `DISM` réparent un Windows qui démarre mal.
- Les pannes d''impression se résolvent souvent avec la file d''attente, l''encre ou le pilote.

## Pour aller plus loin

- Demande au mentor IA : « Comment récupérer les fichiers d''une clé USB infectée par un virus qui transforme les dossiers en raccourcis ? »'
WHERE t.slug = 'maintenance-informatique' AND l.title = 'Résoudre les pannes courantes';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Préparer, créer la clé, installer Windows ou Linux et finaliser le système.', l.duration_minutes = 30, l.content = 'Un client apporte un ordinateur portable infesté de virus, d''une lenteur insupportable, avec un Windows qui affiche des erreurs à chaque démarrage. Après avoir sauvegardé ses données, Djibrine décide de faire une **installation propre** du système d''exploitation. C''est une compétence de base que tout technicien doit maîtriser, et qui s''applique aussi bien à Windows qu''à Linux.

> **Objectifs de ce chapitre**
> - Préparer une installation (sauvegarde, pilotes, licence)
> - Créer une clé USB d''installation
> - Configurer le démarrage dans le BIOS/UEFI
> - Installer Windows et comprendre le partitionnement
> - Découvrir l''installation de Linux, alternative pour les machines anciennes
> - Finaliser et sécuriser le système après l''installation

## Préparer l''installation

Avant de commencer :

1. **Sauvegarder** les données du client, et vérifier que la sauvegarde est lisible.
2. **Noter les informations utiles** : modèle exact de l''ordinateur, version de Windows installée, mots de passe Wi-Fi.
3. **Vérifier la licence** : sur la plupart des ordinateurs vendus avec Windows, la clé de licence est enregistrée dans la carte mère et Windows se réactive automatiquement après une réinstallation de la même édition.
4. **Préparer les pilotes** (*drivers*) : en particulier le pilote réseau (Wi-Fi ou Ethernet), téléchargé depuis le site du fabricant sur une clé à part, pour éviter de se retrouver sans Internet après l''installation.

> **Attention** : n''installe jamais une version piratée ou « activée » de Windows trouvée sur Internet : elles contiennent très souvent des logiciels malveillants. Pour un client sans licence et avec un budget limité, propose plutôt une distribution Linux gratuite et légale.

## Créer une clé USB d''installation

Il faut une clé d''au moins 8 Go (son contenu sera effacé).

- **Windows** : télécharge l''**outil de création de support** sur le site officiel de Microsoft ; il télécharge Windows et prépare la clé automatiquement.
- **Linux** : télécharge l''image ISO de la distribution (par exemple **Linux Mint** ou **Ubuntu**) et écris-la sur la clé avec **Rufus** (Windows) ou **balenaEtcher**.

> **Astuce** : l''outil **Ventoy** permet de copier plusieurs fichiers ISO sur une même clé et de choisir au démarrage lequel lancer. Très pratique pour un technicien qui installe Windows, Linux et des outils de dépannage depuis une seule clé.

Le téléchargement d''un système fait plusieurs gigaoctets : prévois-le là où la connexion est bonne, et garde les fichiers ISO sur un disque de l''atelier pour ne pas les retélécharger à chaque fois.

## Démarrer sur la clé USB

1. Branche la clé et allume l''ordinateur.
2. Appuie aussitôt sur la touche du **menu de démarrage** (souvent **F12**, **F11**, **F9** ou **Échap** selon le fabricant) et choisis la clé USB.
3. Si la clé n''apparaît pas, entre dans le **BIOS/UEFI** (souvent **F2** ou **Suppr**) et vérifie l''ordre de démarrage.

Les ordinateurs récents utilisent le mode **UEFI** avec des disques partitionnés en **GPT** ; les anciens utilisent le mode **BIOS hérité** (*Legacy*) avec des disques **MBR**. Les outils de création de clé gèrent généralement ce choix, mais il faut que la clé et le mode de démarrage correspondent.

## Installer Windows

L''assistant guide les étapes : langue, clavier, édition. L''étape délicate est le choix du disque :

- Choisis l''installation **personnalisée** pour une installation propre.
- Supprime les anciennes partitions **du disque système** pour repartir de zéro : Windows crée automatiquement ses partitions (système EFI, réservée, récupération, et la partition principale).
- Si l''ordinateur a **deux disques**, vérifie trois fois lequel tu supprimes : le second contient peut-être les données du client.

Après la copie des fichiers et plusieurs redémarrages, Windows demande la région, le clavier, le réseau et le compte utilisateur.

## Linux, une seconde vie pour les vieux ordinateurs

Un ordinateur trop lent pour Windows 11 peut redevenir très agréable avec une distribution Linux légère comme **Linux Mint Xfce** ou **Lubuntu**. Elles sont gratuites, légales, peu exposées aux virus Windows, et incluent une suite bureautique (LibreOffice), un navigateur et un lecteur multimédia.

L''installation suit le même principe : démarrer sur la clé, tester le système en mode « live » sans rien installer, puis lancer l''installateur et choisir « Effacer le disque et installer ».

> **Info** : c''est un excellent argument commercial pour l''atelier : « Plutôt que d''acheter un nouvel ordinateur à 250 000 FCFA, je peux rendre le vôtre rapide pour le travail de bureau et Internet. »

## Après l''installation

Une installation n''est pas terminée tant que le système n''est pas prêt à l''emploi :

1. **Pilotes** : vérifie le **Gestionnaire de périphériques** (`devmgmt.msc`) ; aucun élément ne doit afficher de point d''exclamation jaune.
2. **Mises à jour** : lance Windows Update jusqu''à ce qu''il n''y en ait plus.
3. **Activation** : vérifie que Windows est activé (Paramètres → Système → Activation).
4. **Logiciels essentiels** : navigateur, lecteur PDF, suite bureautique, outil de compression, selon les besoins du client. Télécharge-les toujours depuis les sites officiels.
5. **Sécurité** : Microsoft Defender actif, compte utilisateur protégé par un mot de passe.
6. **Restauration des données** sauvegardées, et vérification avec le client.
7. **Point de restauration** ou image du système propre, pour faciliter une future intervention.

## À toi de jouer

1. Crée une clé USB d''installation de Linux Mint avec Rufus ou balenaEtcher.
2. Démarre un ordinateur (ou une machine virtuelle VirtualBox) sur cette clé et teste le mode live.
3. Installe le système dans une machine virtuelle et note chaque étape avec des captures d''écran.
4. Rédige la **checklist d''installation** de l''atelier, avant et après, en 15 points.
5. Rédige un argumentaire de 5 lignes pour proposer Linux à un client dont l''ordinateur de 2014 est trop lent sous Windows.

> **Pour t''auto-évaluer** : ta checklist est bonne si un autre technicien peut réaliser une installation complète, sans oublier la sauvegarde, les pilotes ni la vérification finale avec le client.

## Vérifie tes acquis

1. Quel pilote faut-il préparer en priorité avant une installation ?
2. Quelle touche donne généralement accès au menu de démarrage ?
3. Pourquoi refuser d''installer une version piratée de Windows ?

> **Réponses** : 1. Le pilote réseau (Wi-Fi ou Ethernet). 2. Souvent F12, F11, F9 ou Échap selon le fabricant. 3. Parce que c''est illégal et que ces versions contiennent souvent des logiciels malveillants.

## En résumé

- Préparer : **sauvegarde**, modèle de l''ordinateur, licence, **pilote réseau**.
- Créer la clé avec l''outil Microsoft, Rufus, balenaEtcher ou Ventoy.
- Démarrer sur la clé via le **menu de démarrage** ou le **BIOS/UEFI** ; attention au mode UEFI/GPT ou BIOS/MBR.
- Installation propre de Windows en supprimant les partitions **du bon disque** ; Linux pour redonner vie aux vieux ordinateurs.
- Finaliser : pilotes, mises à jour, activation, logiciels officiels, sécurité, restauration des données.

## Pour aller plus loin

- Demande au mentor IA : « Quelle distribution Linux légère recommander pour un ordinateur avec 2 Go de RAM et un usage bureautique ? »'
WHERE t.slug = 'maintenance-informatique' AND l.title = 'Installer un système d''exploitation';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'ipconfig, ping, nslookup, diagnostic par maillons et problèmes Wi-Fi.', l.duration_minutes = 25, l.content = '« Internet ne marche pas ! » C''est l''appel que Djibrine reçoit le plus souvent de ses clients professionnels. Derrière cette phrase se cachent des causes très différentes : un câble débranché, un Wi-Fi saturé, une adresse IP mal configurée, un forfait épuisé, une panne de l''opérateur. Avec une méthode simple et quelques commandes, on trouve la cause en quelques minutes.

> **Objectifs de ce chapitre**
> - Comprendre le chemin d''une connexion, de l''ordinateur à Internet
> - Lire la configuration réseau d''un ordinateur
> - Diagnostiquer pas à pas avec ping, ipconfig et nslookup
> - Résoudre les problèmes Wi-Fi les plus courants
> - Expliquer le problème simplement au client

## Le chemin d''une connexion

Pour accéder à un site, la connexion traverse plusieurs maillons :

```text
Ordinateur → câble ou Wi-Fi → box ou routeur → opérateur (fibre, 4G, satellite) → Internet → site web
```

Si un maillon est cassé, tout ce qui est après lui est inaccessible. Le diagnostic consiste à tester les maillons **un par un, du plus proche au plus lointain**.

## Lire la configuration réseau

Sous Windows, ouvre l''invite de commandes et tape :

```text
ipconfig /all
```

Les lignes importantes :

| Information | Exemple | Signification |
| --- | --- | --- |
| Adresse IPv4 | 192.168.1.34 | L''adresse de l''ordinateur sur le réseau local |
| Masque de sous-réseau | 255.255.255.0 | La taille du réseau local |
| Passerelle par défaut | 192.168.1.1 | L''adresse de la box ou du routeur |
| Serveurs DNS | 192.168.1.1 | Le service qui traduit les noms de sites en adresses |
| DHCP activé | Oui | L''adresse est attribuée automatiquement par la box |

> **Info** : une adresse qui commence par **169.254** signifie que l''ordinateur n''a reçu aucune adresse de la box : le problème est entre l''ordinateur et la box (câble, Wi-Fi, ou box qui ne distribue plus d''adresses).

## Le diagnostic pas à pas

### Étape 1 : le physique

- Le câble réseau est-il bien branché ? Les voyants de la prise réseau clignotent-ils ?
- Le Wi-Fi est-il activé sur l''ordinateur (pas de mode avion) ?
- La box est-elle allumée ? Ses voyants indiquent-ils une connexion à Internet ?

### Étape 2 : la box répond-elle ?

```text
ping 192.168.1.1
```

Remplace l''adresse par la passerelle relevée avec `ipconfig`. Si tu obtiens des réponses (« Réponse de 192.168.1.1 : octets=32 temps=2 ms »), la liaison avec la box fonctionne. Sinon, le problème est local : câble, Wi-Fi, carte réseau, pilote.

### Étape 3 : Internet répond-il ?

```text
ping 8.8.8.8
```

`8.8.8.8` est un serveur public de Google qui répond presque toujours. S''il ne répond pas alors que la box répond, le problème est **entre la box et Internet** : forfait épuisé, panne de l''opérateur, câble de la fibre, problème de la box.

### Étape 4 : le DNS fonctionne-t-il ?

```text
nslookup google.com
```

Si `ping 8.8.8.8` répond mais que les sites ne s''ouvrent pas et que `nslookup` échoue, c''est un problème de **DNS**. Solution rapide : configurer des serveurs DNS publics (par exemple `1.1.1.1` et `8.8.8.8`) dans les paramètres de la carte réseau.

### Étape 5 : le problème vient-il d''un seul site ou d''un seul appareil ?

- Un seul site ne fonctionne pas : le problème vient sûrement du site lui-même.
- Un seul ordinateur ne se connecte pas, alors que les téléphones marchent : le problème est sur cet ordinateur (pilote, configuration, antivirus, proxy).

> **Astuce** : sous Windows, la commande `ipconfig /release` puis `ipconfig /renew` redemande une adresse à la box, et `ipconfig /flushdns` vide le cache DNS. Avec un redémarrage de la box, ces trois gestes règlent une bonne partie des problèmes courants.

## Les problèmes Wi-Fi courants

| Symptôme | Causes possibles | Solutions |
| --- | --- | --- |
| Signal faible | Distance, murs épais en béton ou en banco, box posée au sol | Placer la box en hauteur et au centre, ajouter un répéteur |
| Connexion lente aux heures de pointe | Trop d''appareils, voisins sur le même canal | Changer de canal dans l''interface de la box, préférer la bande 5 GHz près de la box |
| « Connecté, pas d''Internet » | Problème entre la box et l''opérateur, forfait épuisé | Vérifier les voyants et le solde du forfait, redémarrer la box |
| Mot de passe refusé | Erreur de saisie, mot de passe changé | Vérifier sur l''étiquette de la box ou dans son interface |
| Coupures fréquentes | Surchauffe de la box, coupures électriques | Ventiler la box, l''alimenter avec un petit onduleur |

## Expliquer au client

Un bon technicien sait expliquer sans jargon. Plutôt que « votre serveur DNS ne résout plus les requêtes », dis : « Votre connexion fonctionne, mais l''annuaire qui permet de trouver les sites ne répondait plus. J''en ai configuré un autre, plus fiable. » Le client comprend, te fait confiance, et revient.

## À toi de jouer

1. Sur ton ordinateur, relève avec `ipconfig /all` ton adresse IP, ta passerelle et tes serveurs DNS.
2. Teste successivement `ping` vers ta passerelle, vers `8.8.8.8`, puis `nslookup google.com`, et note les résultats.
3. Pour chaque situation, indique le maillon en cause et ta solution :
   - l''ordinateur a l''adresse 169.254.20.5 ;
   - la passerelle répond, mais pas 8.8.8.8 ;
   - 8.8.8.8 répond, mais aucun site ne s''ouvre ;
   - seul l''ordinateur de la comptable n''a pas Internet, tous les autres oui.
4. Rédige une **fiche de dépannage** d''une page, illustrée par un schéma des maillons, à afficher dans les bureaux d''un client pour que les employés fassent les premières vérifications eux-mêmes.

> **Réponses de l''étape 3** : pas d''adresse reçue de la box (câble, Wi-Fi ou DHCP de la box) ; problème entre la box et l''opérateur (forfait, panne, box) ; problème de DNS (changer de serveurs DNS) ; problème propre à cet ordinateur (configuration, pilote, câble, antivirus).

## Vérifie tes acquis

1. Que signifie une adresse IP commençant par 169.254 ?
2. Pourquoi tester `ping 8.8.8.8` avant d''ouvrir un site web ?
3. Quelle commande vide le cache DNS sous Windows ?

> **Réponses** : 1. Que l''ordinateur n''a pas reçu d''adresse de la box ou du serveur DHCP. 2. Pour savoir si l''accès à Internet fonctionne indépendamment du DNS. 3. `ipconfig /flushdns`.

## En résumé

- La connexion traverse plusieurs maillons : ordinateur, câble ou Wi-Fi, box, opérateur, Internet.
- `ipconfig /all` montre l''adresse IP, la passerelle et les DNS.
- On teste dans l''ordre : physique, passerelle (`ping`), Internet (`ping 8.8.8.8`), DNS (`nslookup`).
- Les problèmes Wi-Fi se règlent souvent par le placement de la box, le canal ou un répéteur.
- On explique le problème au client avec des mots simples.

## Pour aller plus loin

- Demande au mentor IA : « Comment changer le canal Wi-Fi et le mot de passe dans l''interface d''une box 4G ? »'
WHERE t.slug = 'maintenance-informatique' AND l.title = 'Dépanner une connexion réseau';


-- =====================================================================
-- Mobile Money & Paiement Numérique (mobile-money-paiement-numerique)
-- =====================================================================
UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Monnaie électronique, acteurs, trajet d''un transfert, plafonds, KYC et interopérabilité.', l.duration_minutes = 25, l.content = 'Au Tchad, des millions de personnes n''ont jamais ouvert de compte en banque, mais envoient et reçoivent de l''argent chaque semaine avec leur téléphone. Le **mobile money** (Airtel Money, Moov Money) a transformé la façon dont on paie, épargne et aide sa famille, de N''Djamena jusqu''aux villages les plus éloignés. Comprendre comment il fonctionne ouvre la porte à de nombreux métiers : agent, superviseur de réseau, conseiller client, analyste fraude, développeur d''intégrations.

Dans ce parcours, tu suis **Fatimé**, qui ouvre un point de service mobile money au marché de Moundou et veut comprendre le système de bout en bout.

> **Objectifs de ce chapitre**
> - Comprendre ce qu''est la monnaie électronique
> - Identifier les acteurs d''un système de mobile money
> - Suivre le trajet d''un transfert d''argent étape par étape
> - Connaître les principales opérations et leurs frais
> - Comprendre le rôle de la réglementation et de l''interopérabilité

## La monnaie électronique

Quand Fatimé dépose 10 000 FCFA en espèces chez un agent, son solde mobile money augmente de 10 000 FCFA. Ce solde est de la **monnaie électronique** : une valeur stockée sur un compte lié à son numéro de téléphone, qu''elle peut dépenser, envoyer ou retirer.

Point essentiel : chaque franc de monnaie électronique en circulation doit correspondre à un franc réel déposé sur un **compte de cantonnement** (ou compte de garantie) dans une banque. C''est ce qui garantit que les clients peuvent toujours récupérer leur argent en espèces.

> **Info** : le mobile money n''est pas une banque : il ne prête pas l''argent des clients. Les fonds sont conservés en garantie, ce qui le rend sûr, mais explique aussi pourquoi il ne verse généralement pas d''intérêts.

## Les acteurs

| Acteur | Rôle |
| --- | --- |
| **L''émetteur** | L''entité qui émet la monnaie électronique et gère la plateforme, souvent une filiale de l''opérateur télécom agréée pour cela |
| **La banque partenaire** | Conserve les fonds en garantie sur le compte de cantonnement |
| **Les agents** | Boutiques et points de service qui font l''échange espèces ↔ monnaie électronique |
| **Les distributeurs** (ou super-agents) | Gèrent un réseau d''agents et leur fournissent de la liquidité |
| **Les marchands** | Commerces, entreprises et administrations qui acceptent les paiements |
| **Les clients** | Particuliers qui détiennent un compte lié à leur numéro |
| **Le régulateur** | Au Tchad, dans la zone CEMAC, la **BEAC** et la **COBAC** encadrent les services de paiement |

## Le trajet d''un transfert

Mahamat, à N''Djamena, envoie 25 000 FCFA à sa mère à Abéché :

1. Mahamat compose le code USSD de son opérateur (ou ouvre l''application) et choisit « Transfert d''argent ».
2. Il saisit le numéro de sa mère, le montant, puis son **code PIN** secret.
3. La plateforme vérifie le PIN, le solde de Mahamat et les plafonds autorisés.
4. Elle **débite** le compte de Mahamat (montant + frais éventuels) et **crédite** celui de sa mère, dans la même opération : soit les deux se font, soit aucun.
5. Les deux reçoivent un **SMS de confirmation** avec un identifiant de transaction.
6. La mère peut garder l''argent sur son compte, payer un achat, ou se rendre chez un agent d''Abéché pour le retirer en espèces.

Aucun billet n''a voyagé entre N''Djamena et Abéché : seules des écritures ont changé dans la plateforme.

> **Attention** : l''identifiant de transaction reçu par SMS est la preuve d''une opération. Conseille toujours de le conserver, surtout pour les montants importants : c''est lui qu''on demandera en cas de réclamation.

## Les principales opérations

| Opération | Description | Qui paie des frais, en général |
| --- | --- | --- |
| **Dépôt** (*cash-in*) | Le client donne des espèces à un agent, son solde augmente | Souvent gratuit pour le client |
| **Retrait** (*cash-out*) | Le client retire des espèces chez un agent | Le client |
| **Transfert** (P2P) | D''un client à un autre | L''expéditeur, selon le montant |
| **Paiement marchand** | Achat chez un commerçant | Souvent le marchand (commission) |
| **Paiement de factures** | Électricité, eau, TV, frais de scolarité | Variable |
| **Achat de crédit** | Recharge téléphonique | Généralement gratuit |
| **Transfert international** | Réception depuis l''étranger ou envoi | Variable selon les corridors |

Les **grilles tarifaires** sont publiées par chaque opérateur et varient selon les tranches de montant. Elles changent régulièrement : consulte toujours la grille officielle en vigueur.

## Plafonds et identification

Pour limiter la fraude et le blanchiment d''argent, les comptes ont des **plafonds** (montant maximal par opération, par jour, par mois, et solde maximal). Ces plafonds dépendent du niveau d''**identification** du client : un compte ouvert avec une pièce d''identité vérifiée bénéficie de plafonds plus élevés. On parle de procédure **KYC** (*Know Your Customer*, connaître son client).

## L''interopérabilité

Pendant longtemps, un client Airtel Money ne pouvait pas envoyer directement de l''argent à un client Moov Money. L''**interopérabilité** permet ces échanges entre opérateurs, et entre mobile money et banques. Dans la zone CEMAC, le **GIMAC** (Groupement Interbancaire Monétique de l''Afrique Centrale) joue un rôle central dans ces échanges entre acteurs. Les services disponibles évoluent : renseigne-toi auprès des opérateurs sur ce qui est proposé aujourd''hui.

## À toi de jouer

1. Dessine le schéma des acteurs du mobile money et les flux entre eux (argent réel et monnaie électronique).
2. Décris, étape par étape, le trajet d''un paiement de facture d''électricité de 18 000 FCFA, du client jusqu''à la société d''électricité.
3. Relève la grille tarifaire officielle actuelle d''un opérateur (agence, site web ou application) et calcule les frais pour un transfert de 5 000, 50 000 et 200 000 FCFA.
4. Explique en cinq lignes, à une personne âgée qui n''a jamais utilisé le mobile money, pourquoi son argent est en sécurité et quelles précautions prendre.

> **Pour t''auto-évaluer** : ton explication de l''étape 4 est réussie si elle mentionne le code PIN à ne jamais partager, le SMS de confirmation à conserver, et l''agent officiel pour les retraits.

## Vérifie tes acquis

1. Qu''est-ce qui garantit que la monnaie électronique peut toujours être retirée en espèces ?
2. Quel est le rôle d''un agent ?
3. À quoi sert la procédure KYC ?

> **Réponses** : 1. Le fait que chaque franc électronique correspond à un franc réel conservé sur un compte de cantonnement en banque. 2. Échanger des espèces contre de la monnaie électronique et inversement (dépôts et retraits). 3. À vérifier l''identité des clients pour lutter contre la fraude et le blanchiment, ce qui permet des plafonds plus élevés.

## En résumé

- La **monnaie électronique** est garantie par des fonds réels conservés en banque.
- Acteurs : émetteur, banque partenaire, agents, distributeurs, marchands, clients, régulateur (BEAC, COBAC).
- Un transfert débite et crédite deux comptes dans une même opération, confirmée par SMS.
- Opérations : dépôt, retrait, transfert, paiement marchand, factures, crédit, international.
- **Plafonds**, **KYC** et **interopérabilité** encadrent et élargissent le service.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi la différence entre une banque et un émetteur de monnaie électronique, avec des exemples simples. »'
WHERE t.slug = 'mobile-money-paiement-numerique' AND l.title = 'Comment fonctionne un paiement mobile money ?';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Double caisse, liquidité, registre, réconciliation, commissions et règles de service.', l.duration_minutes = 30, l.content = 'Fatimé ouvre son point de service mobile money à Moundou. Elle découvre vite que le métier d''agent ne se résume pas à « faire des dépôts et des retraits » : il faut gérer deux caisses à la fois, anticiper les besoins de liquidité, tenir une comptabilité rigoureuse, accueillir les clients et se protéger des fraudes. Un agent bien organisé gagne correctement sa vie ; un agent désorganisé perd de l''argent sans comprendre pourquoi.

> **Objectifs de ce chapitre**
> - Comprendre la double caisse : espèces et float électronique
> - Gérer sa liquidité et anticiper les pics d''activité
> - Tenir un registre et faire la réconciliation quotidienne
> - Calculer ses commissions et sa rentabilité
> - Appliquer les règles de service et de conformité

## Devenir agent

Pour devenir agent, on signe un contrat avec l''opérateur ou avec un distributeur. On fournit généralement : une pièce d''identité, un local identifiable, parfois un registre de commerce, et un fonds de départ. L''agent reçoit un **numéro agent** distinct de son numéro personnel, avec ses propres codes.

> **Attention** : n''utilise jamais ton numéro agent pour tes opérations personnelles, et ton numéro personnel pour celles de tes clients. Mélanger les deux rend la comptabilité impossible et peut entraîner des sanctions.

## La double caisse

Un agent gère en permanence deux réserves :

- les **espèces** dans son tiroir-caisse ;
- le **float** : le solde de monnaie électronique de son compte agent.

Chaque opération déplace l''argent de l''une à l''autre :

| Opération du client | Espèces de l''agent | Float de l''agent |
| --- | --- | --- |
| **Dépôt** de 20 000 FCFA | +20 000 | −20 000 |
| **Retrait** de 15 000 FCFA | −15 000 | +15 000 |

La **somme** espèces + float reste stable (aux commissions près). Ce qui change, c''est la **répartition**. Si tous les clients de la journée font des dépôts, l''agent se retrouve avec beaucoup d''espèces et plus de float : il ne peut plus servir de nouveaux dépôts. C''est le problème de **liquidité**.

## Gérer la liquidité

Pour ne jamais refuser un client :

- **Connaître ses pics** : en début de mois, beaucoup de salariés et de familles qui reçoivent de l''argent viennent **retirer** (besoin d''espèces) ; les jours de marché, les commerçants viennent **déposer** leur recette (besoin de float).
- **Rééquilibrer** régulièrement auprès de son distributeur ou d''une agence bancaire : vendre du float contre des espèces, ou l''inverse.
- **Fixer des seuils** : par exemple, rééquilibrer dès que le float descend sous 100 000 FCFA ou que les espèces dépassent 500 000 FCFA.

> **Info** : trop d''espèces dans la boutique est aussi un **risque de vol**. Ne garde pas plus que ce dont tu as besoin et dépose l''excédent régulièrement, en variant tes horaires et tes trajets.

## Le registre et la réconciliation

Chaque opération est notée dans un **registre** (cahier ou tableur) :

| Heure | Type | Numéro client (partiel) | Montant | Identifiant de transaction | Pièce vérifiée |
| --- | --- | --- | --- | --- | --- |
| 08:42 | Retrait | 66 XX XX 12 | 30 000 | CI241008.0842.B5521 | Oui |
| 09:15 | Dépôt | 99 XX XX 87 | 10 000 | CI241008.0915.A1180 | — |

En fin de journée, l''agent fait la **réconciliation** :

1. Compter les espèces en caisse.
2. Relever le solde du float (par USSD ou application).
3. Comparer avec la situation attendue : espèces et float du matin + effet de chaque opération + commissions.
4. Rechercher immédiatement tout écart.

Un écart de quelques milliers de francs qu''on ne cherche pas le jour même devient une perte qu''on n''expliquera jamais.

## Les commissions et la rentabilité

L''agent est rémunéré par des **commissions** versées par l''opérateur sur chaque opération (souvent une partie des frais payés par le client). Les grilles exactes dépendent de l''opérateur et du contrat.

Pour savoir si son activité est rentable, Fatimé calcule chaque mois :

```text
Bénéfice = commissions du mois − (loyer + électricité + crédit téléphonique + salaire éventuel + autres frais)
```

> **Astuce** : beaucoup d''agents complètent leurs revenus avec des activités liées : vente de crédit, de cartes SIM, d''accessoires téléphoniques, photocopies. Le point mobile money attire du passage, autant en profiter.

## Bien servir et respecter les règles

- **Vérifier l''identité** du client pour les retraits et les montants importants, selon les règles de l''opérateur, et la consigner.
- **Ne jamais demander ni connaître le code PIN** d''un client : c''est lui qui le tape, discrètement.
- **Afficher** la grille tarifaire officielle de manière visible, et ne jamais facturer plus.
- **Donner le reçu** ou attendre que le client ait reçu son SMS de confirmation avant qu''il ne parte.
- **Signaler** les opérations suspectes (montants inhabituels, client qui semble agir sous la contrainte, multiples petits dépôts pour contourner les plafonds).

## À toi de jouer

Fatimé commence la journée avec 300 000 FCFA d''espèces et 400 000 FCFA de float. Voici ses opérations :

- 08:30 retrait de 50 000 ;
- 09:10 dépôt de 120 000 ;
- 10:45 retrait de 35 000 ;
- 14:20 dépôt de 200 000 ;
- 16:00 retrait de 80 000.

1. Calcule les espèces et le float après chaque opération (sans tenir compte des commissions).
2. À quel moment de la journée son float est-il le plus bas ? Pouvait-elle accepter un dépôt supplémentaire de 300 000 FCFA à 15 h ?
3. Conçois le modèle de registre de son point de service dans un tableur, avec une formule qui calcule automatiquement les soldes.
4. Rédige ses règles de rééquilibrage (seuils et actions).

> **Réponses des étapes 1 et 2** : après chaque opération, espèces / float : 250 000 / 450 000 ; 370 000 / 330 000 ; 335 000 / 365 000 ; 535 000 / 165 000 ; 455 000 / 245 000. Le float est au plus bas après le dépôt de 14 h 20 (165 000 FCFA) : à 15 h, elle ne pouvait pas accepter un dépôt de 300 000 FCFA sans rééquilibrer.

## Vérifie tes acquis

1. Que devient le float de l''agent lors d''un dépôt d''un client ?
2. Pourquoi faire la réconciliation chaque jour ?
3. Un client demande à l''agent de taper son code PIN à sa place. Que faire ?

> **Réponses** : 1. Il diminue du montant déposé. 2. Pour détecter et expliquer immédiatement tout écart avant qu''il ne devienne une perte inexpliquée. 3. Refuser poliment et l''inviter à le saisir lui-même, discrètement : un agent ne doit jamais connaître le PIN d''un client.

## En résumé

- L''agent gère une **double caisse** : espèces et **float** électronique.
- Dépôts et retraits déplacent la valeur d''une caisse à l''autre ; la **liquidité** doit être rééquilibrée.
- Un **registre** et une **réconciliation** quotidienne évitent les pertes inexpliquées.
- La rentabilité se calcule : commissions moins charges.
- Service de qualité et conformité : identité vérifiée, PIN jamais partagé, tarifs affichés, opérations suspectes signalées.

## Pour aller plus loin

- Demande au mentor IA : « Aide-moi à construire dans Google Sheets un registre d''agent mobile money avec calcul automatique des soldes. »'
WHERE t.slug = 'mobile-money-paiement-numerique' AND l.title = 'Gérer un point agent';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Arnaques courantes, fraude au changement de SIM, fraudes visant les agents et réflexes.', l.duration_minutes = 30, l.content = '« Bonsoir, je me suis trompé de numéro en vous envoyant 50 000 FCFA, pouvez-vous me les renvoyer s''il vous plaît ? » Le SMS de confirmation semble réel… mais c''est un faux, envoyé depuis un numéro ordinaire. Le mobile money brasse chaque jour des montants considérables : il attire les fraudeurs, qui exploitent surtout la confiance et la précipitation. Connaître leurs techniques est la meilleure protection, pour les clients comme pour les agents.

> **Objectifs de ce chapitre**
> - Reconnaître les principales arnaques visant les clients
> - Identifier les fraudes visant les agents
> - Comprendre la fraude au changement de carte SIM
> - Appliquer les bons réflexes de prévention
> - Savoir réagir et signaler une fraude

## Les arnaques visant les clients

| Arnaque | Comment elle fonctionne | Le réflexe |
| --- | --- | --- |
| **Faux transfert « par erreur »** | Un faux SMS imite une confirmation de réception, puis l''escroc demande le « remboursement » | Vérifier son **solde réel** par le menu officiel, jamais sur la foi d''un SMS |
| **Faux service client** | Un appel ou un SMS se présente comme l''opérateur et demande le code PIN ou un code reçu | Raccrocher : **aucun opérateur ne demande jamais le PIN** |
| **Faux gain** | « Vous avez gagné 1 000 000 FCFA, envoyez 10 000 FCFA de frais de dossier » | Un vrai gain ne demande jamais de payer pour le recevoir |
| **Faux proche en détresse** | Message d''un numéro inconnu : « C''est moi, j''ai changé de numéro, envoie-moi vite de l''argent » | Appeler le proche sur son numéro habituel avant tout envoi |
| **Faux investissement** | Promesse de doubler son argent en quelques jours | Un rendement garanti et rapide est toujours une arnaque |

> **Info** : un vrai SMS de transaction vient de l''**expéditeur officiel** de l''opérateur (un nom ou un numéro court), jamais d''un numéro de téléphone ordinaire à 8 chiffres. Mais le seul contrôle fiable reste la consultation du solde dans le menu officiel.

## La fraude au changement de carte SIM

C''est l''une des fraudes les plus graves. Le fraudeur obtient une **nouvelle carte SIM avec le numéro de la victime**, souvent en usurpant son identité auprès d''un point de vente, ou avec la complicité d''un employé. Dès que la nouvelle SIM est activée, celle de la victime cesse de fonctionner, et le fraudeur reçoit les codes de confirmation et peut vider le compte.

Les signes d''alerte : le téléphone affiche soudainement « Pas de service » ou « SIM non valide » alors que le réseau fonctionne pour les autres.

Les protections :

- côté client : réagir **immédiatement** en cas de perte inexpliquée du réseau, en appelant l''opérateur depuis un autre téléphone ;
- côté opérateur : vérification stricte de l''identité avant tout remplacement de SIM, et souvent un **blocage temporaire** des opérations mobile money après un changement de SIM.

## Les fraudes visant les agents

- **Faux SMS de dépôt** : un « client » montre un faux SMS prouvant qu''il a envoyé du float à l''agent et demande des espèces. Réflexe : vérifier le **solde réel** du compte agent avant de remettre de l''argent.
- **Faux billets** lors des dépôts : utiliser un détecteur de faux billets et vérifier les billets de grosse valeur.
- **Usurpation d''identité** lors des retraits : comparer soigneusement la pièce d''identité et la personne.
- **Faux agents de l''opérateur** qui se présentent pour un « contrôle » et demandent les codes du compte agent ou de l''argent liquide : exiger une carte professionnelle et vérifier par téléphone auprès du service officiel.
- **Fractionnement** : un client qui fait plusieurs petites opérations pour rester sous les plafonds ou les seuils de vérification. À signaler.

> **Attention** : le code secret du compte agent ne se partage avec **personne**, ni employé ni « contrôleur ». Si un employé utilise le compte, l''opérateur doit lui attribuer ses propres accès quand c''est possible.

## Les bons réflexes au quotidien

Pour les clients :

- un **code PIN** que personne ne peut deviner (pas la date de naissance, pas 0000 ni 1234), tapé à l''abri des regards ;
- le PIN **jamais noté** sur le téléphone ni sur un papier rangé avec lui ;
- un **verrouillage du téléphone** (code ou empreinte) ;
- la vérification du **nom du bénéficiaire** affiché avant de confirmer un transfert ;
- la consultation régulière de son **historique** de transactions.

Pour les agents :

- vérifier le solde avant de remettre des espèces ;
- noter chaque opération et faire la réconciliation tous les jours ;
- ne garder qu''un montant limité d''espèces ;
- former les employés à reconnaître les arnaques.

## Réagir en cas de fraude

1. **Agir vite** : appeler immédiatement le service client officiel de l''opérateur pour bloquer le compte ou la transaction, si possible.
2. Rassembler les **preuves** : identifiants de transaction, numéros utilisés, captures d''écran des messages, heure.
3. **Changer le code PIN** si on soupçonne qu''il a été découvert.
4. **Porter plainte** auprès de la police ou de la gendarmerie avec ces éléments.
5. **Prévenir son entourage** : les mêmes escrocs ciblent souvent les contacts de la victime.

## Côté technique : la détection

Les opérateurs utilisent aussi des systèmes automatiques qui analysent les transactions pour repérer les comportements anormaux : un compte qui reçoit soudainement de nombreux petits montants de numéros différents, des retraits immédiats après un changement de SIM, des transferts à 3 h du matin vers un numéro inconnu. Ces règles, et de plus en plus des modèles de machine learning, permettent de bloquer ou de vérifier les opérations suspectes avant que l''argent ne disparaisse.

## À toi de jouer

1. Rédige une **affiche de prévention** pour le point de service de Fatimé : 5 règles courtes, compréhensibles par tous, avec des pictogrammes que tu décris.
2. Écris le **script** que l''agent récite quand un client semble sur le point de se faire arnaquer (par exemple un client qui veut envoyer de l''argent pour « débloquer un gain »).
3. Analyse cette situation : un client arrive à 18 h, montre un SMS « Vous avez reçu 150 000 FCFA de AGENT-66XXXX » et demande à retirer 150 000 FCFA en espèces sur le compte de Fatimé, car il serait pressé. Quels sont les signaux d''alerte ? Que doit-elle faire ?
4. Propose trois règles automatiques qu''un opérateur pourrait mettre en place pour détecter la fraude au changement de carte SIM.

> **Éléments de correction pour l''étape 3** : le SMS vient d''un expéditeur douteux, la demande est inhabituelle (il veut récupérer en espèces de l''argent prétendument envoyé sur le compte de l''agent), le client met la pression. Fatimé vérifie son solde réel par le menu officiel avant toute remise d''espèces ; si rien n''a été crédité, elle refuse calmement et signale la tentative.

## Vérifie tes acquis

1. Quel est le seul moyen fiable de vérifier qu''un transfert a bien été reçu ?
2. Quel signe peut révéler une fraude au changement de carte SIM ?
3. Un opérateur peut-il demander le code PIN d''un client par téléphone ?

> **Réponses** : 1. Consulter son solde dans le menu officiel de l''opérateur. 2. Une perte soudaine et inexpliquée du réseau sur son téléphone (« SIM non valide »). 3. Non, jamais.

## En résumé

- Les arnaques jouent sur la confiance et la précipitation : faux transferts, faux service client, faux gains, faux proches.
- La **fraude au changement de SIM** se repère par une perte soudaine du réseau : réagir immédiatement.
- Les agents vérifient toujours leur **solde réel** avant de remettre des espèces.
- PIN secret et robuste, téléphone verrouillé, vérification du bénéficiaire.
- En cas de fraude : bloquer vite, rassembler les preuves, porter plainte, prévenir l''entourage.

## Pour aller plus loin

- Demande au mentor IA : « Crée un quiz de 10 questions pour sensibiliser les clients d''un point mobile money aux arnaques. »'
WHERE t.slug = 'mobile-money-paiement-numerique' AND l.title = 'Prévenir la fraude';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Sessions USSD, API de paiement, callbacks, sécurité et réconciliation.', l.duration_minutes = 30, l.content = 'Une école privée de N''Djamena veut permettre aux parents de payer les frais de scolarité par mobile money. Aujourd''hui, les parents envoient l''argent sur un numéro, puis le comptable vérifie chaque paiement à la main en comparant les SMS : des heures de travail et beaucoup d''erreurs. La solution passe par deux technologies : l''**USSD**, que les parents utilisent sur n''importe quel téléphone, et les **API**, qui permettent au logiciel de l''école de dialoguer automatiquement avec la plateforme de paiement.

> **Objectifs de ce chapitre**
> - Comprendre le fonctionnement de l''USSD et de ses menus
> - Comprendre ce qu''est une API de paiement
> - Connaître les grandes étapes d''une intégration : collecte, confirmation, réconciliation
> - Comprendre le rôle des notifications (callbacks)
> - Connaître les règles de sécurité d''une intégration de paiement

## L''USSD

L''**USSD** (*Unstructured Supplementary Service Data*) est le service qui s''ouvre quand on compose un code commençant par `*` et finissant par `#`. Il présente des menus textuels interactifs :

```text
1. Transfert d''argent
2. Retrait
3. Paiement marchand
4. Factures
5. Mon compte
```

Ses avantages, décisifs au Tchad :

- il fonctionne sur **tous les téléphones**, même les plus simples, sans smartphone ;
- il ne consomme **pas de data** internet ;
- il fonctionne avec une couverture réseau minimale (2G).

Ses limites : une **session courte** (si l''utilisateur tarde à répondre, la session se ferme), des écrans de quelques lignes seulement, et une expérience peu adaptée aux opérations complexes.

### Comment fonctionne une session USSD

1. L''utilisateur compose le code ; le réseau ouvre une **session** et la transmet au serveur du service.
2. Le serveur renvoie un **menu** ; l''utilisateur répond par un chiffre.
3. Les échanges continuent jusqu''à ce que le serveur termine la session (« Opération réussie ») ou que le délai expire.

Une entreprise peut obtenir son propre **code USSD** auprès d''un opérateur ou d''un agrégateur, pour proposer ses services (consultation de solde scolaire, paiement de facture) directement depuis le menu du téléphone.

> **Astuce** : en concevant un menu USSD, garde au maximum 5 ou 6 choix par écran, des libellés très courts, et le moins d''étapes possible : chaque étape supplémentaire augmente le risque d''expiration de la session.

## Les API de paiement

Une **API** (*Application Programming Interface*) est une porte d''entrée qu''un système ouvre pour que d''autres programmes puissent communiquer avec lui, selon des règles précises. Une API de paiement permet par exemple au logiciel de l''école de :

- **demander un paiement** à un parent (on parle de **collecte**) ;
- **vérifier le statut** d''un paiement ;
- **envoyer de l''argent** (rembourser, payer un fournisseur : on parle de **décaissement**) ;
- **recevoir des notifications** quand un paiement est confirmé.

Les API modernes fonctionnent sur HTTPS et échangent des données au format **JSON**. L''accès se fait avec des **identifiants** fournis par l''opérateur ou l''agrégateur après signature d''un contrat marchand, et un environnement de **test** (*sandbox*) permet d''essayer sans argent réel.

## Le parcours d''un paiement par API

1. Le parent choisit sur le site ou l''application de l''école « Payer les frais du 1er trimestre : 45 000 FCFA » et saisit son numéro.
2. Le serveur de l''école envoie une **demande de collecte** à l''API, avec le montant, le numéro et une **référence unique** de commande.
3. La plateforme envoie au parent une demande de confirmation sur son téléphone (souvent une fenêtre USSD) ; il valide avec son **code PIN**. L''école ne voit jamais ce code.
4. La plateforme traite le paiement, puis envoie une **notification** au serveur de l''école (**callback** ou *webhook*) : « Paiement de la référence ECOLE-2026-0412 réussi ».
5. Le serveur de l''école **vérifie** le statut auprès de l''API, puis marque les frais comme payés et envoie un reçu au parent.

Exemple simplifié de demande, au format JSON (chaque fournisseur a son propre format, décrit dans sa documentation) :

```json
{
  "reference": "ECOLE-2026-0412",
  "montant": 45000,
  "devise": "XAF",
  "telephone": "23566123456",
  "description": "Frais de scolarité T1 - Achta Mahamat",
  "url_notification": "https://ecole-exemple.td/paiements/notification"
}
```

> **Info** : comme vu avec les intégrations de paiement de la plateforme IgoTech IA, certaines entreprises passent par un **agrégateur** qui donne accès à plusieurs opérateurs avec une seule API, d''autres signent directement avec chaque opérateur. Vérifie toujours que le service couvre bien le Tchad et les opérateurs souhaités avant de signer.

## Les règles de sécurité

- **Ne jamais faire confiance au navigateur** : un parent pourrait modifier le montant dans la page. Le montant se calcule et se vérifie toujours côté serveur.
- **Toujours vérifier la notification** : une notification reçue peut être falsifiée. On vérifie sa signature si le fournisseur en propose une, et on interroge l''API pour confirmer le statut réel avant de valider.
- **Une référence unique par paiement** et un traitement **idempotent** : si la même notification arrive deux fois, le paiement ne doit être enregistré qu''une seule fois.
- **Protéger les identifiants d''API** : jamais dans le code publié ni dans un dépôt Git, mais dans un fichier de configuration protégé.
- **Journaliser** chaque échange pour pouvoir analyser une réclamation.

## La réconciliation

Même avec une API, il faut **réconcilier** : comparer régulièrement les paiements enregistrés dans le logiciel de l''école avec le relevé de la plateforme de paiement. Les écarts révèlent les notifications perdues, les paiements en attente ou les erreurs. Une réconciliation automatique quotidienne, avec un rapport des écarts, est une bonne pratique.

## À toi de jouer

1. Conçois le **menu USSD** de l''école pour les parents : consultation du montant restant à payer, paiement d''un trimestre, réception du dernier reçu. Écris chaque écran (5 lignes maximum).
2. Dessine le **schéma** du parcours d''un paiement par API, avec les acteurs (parent, téléphone, serveur de l''école, plateforme de paiement) et les messages échangés.
3. Écris, en français structuré (pseudo-code), ce que doit faire le serveur de l''école quand il reçoit une notification de paiement, en intégrant les règles de sécurité.
4. Liste les colonnes d''un rapport de réconciliation quotidien et les types d''écarts à rechercher.

> **Correction possible pour l''étape 3** : recevoir la notification ; vérifier sa signature ; retrouver le paiement par sa référence (s''il n''existe pas, journaliser et ignorer) ; s''il est déjà marqué payé, ne rien faire (idempotence) ; interroger l''API pour confirmer le statut ; si le statut est « réussi » et le montant correct, marquer comme payé et envoyer le reçu ; dans tous les cas, journaliser et répondre au fournisseur que la notification est reçue.

## Vérifie tes acquis

1. Pourquoi l''USSD est-il si utilisé au Tchad ?
2. Qu''est-ce qu''un callback dans une intégration de paiement ?
3. Pourquoi faut-il vérifier le statut auprès de l''API même après avoir reçu une notification ?

> **Réponses** : 1. Parce qu''il fonctionne sur tous les téléphones, sans data internet et avec une couverture minimale. 2. Une notification envoyée par la plateforme de paiement au serveur du marchand pour l''informer du résultat d''un paiement. 3. Parce qu''une notification peut être falsifiée ou erronée : seule la confirmation par l''API fait foi.

## En résumé

- L''**USSD** offre des menus interactifs sur tous les téléphones, sans internet, avec des sessions courtes.
- Une **API de paiement** permet de collecter, vérifier, décaisser et recevoir des notifications, en JSON sur HTTPS.
- Le parcours : demande de collecte, validation par PIN sur le téléphone, notification, vérification, reçu.
- Sécurité : montant calculé côté serveur, notifications vérifiées, traitement idempotent, identifiants protégés.
- La **réconciliation** quotidienne détecte les écarts.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi l''idempotence avec un exemple de double notification de paiement. »'
WHERE t.slug = 'mobile-money-paiement-numerique' AND l.title = 'Notions d''API et d''USSD';


-- =====================================================================
-- Bureautique & Gestion de Données (bureautique-gestion-donnees)
-- =====================================================================
UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'SOMME, SI, NB.SI, SOMME.SI, références absolues et RECHERCHEV.', l.duration_minutes = 30, l.content = 'Dans presque tous les bureaux du Tchad, administration, ONG, commerce ou banque, une compétence revient dans les offres d''emploi : « maîtrise d''Excel ». Un tableur bien utilisé fait gagner des heures de calcul et évite les erreurs. Dans ce chapitre, tu apprends les formules que tout le monde utilise au quotidien, dans **Excel** comme dans **Google Sheets**.

Dans ce parcours, tu accompagnes **Kaltouma**, assistante administrative dans une coopérative agricole de Sarh qui collecte et vend le sésame et l''arachide de ses membres.

> **Objectifs de ce chapitre**
> - Comprendre la structure d''une formule
> - Utiliser les fonctions SOMME, MOYENNE, MIN, MAX, NB
> - Maîtriser les références relatives et absolues
> - Prendre des décisions avec SI
> - Compter et additionner sous condition avec NB.SI et SOMME.SI
> - Rechercher une valeur avec RECHERCHEV

## La structure d''une formule

Une formule commence **toujours** par le signe `=`. Elle peut contenir des nombres, des références de cellules, des opérateurs et des fonctions :

```text
=B2*C2
=SOMME(D2:D50)
=SI(D2>100000;"Gros livreur";"Petit livreur")
```

- `B2` désigne la cellule à la colonne B, ligne 2.
- `D2:D50` désigne la **plage** de D2 à D50.
- Les arguments d''une fonction sont séparés par un **point-virgule** dans les versions françaises d''Excel et de Google Sheets.

> **Info** : les fonctions portent des noms français dans un Excel en français (`SOMME`, `SI`) et anglais dans un Excel en anglais (`SUM`, `IF`). Les formules s''adaptent automatiquement quand on ouvre le fichier dans l''autre langue.

## Le tableau de départ

Kaltouma enregistre les livraisons des membres :

| | A | B | C | D | E |
| --- | --- | --- | --- | --- | --- |
| 1 | Membre | Produit | Quantité (kg) | Prix au kg | Montant |
| 2 | Néloumta | Sésame | 450 | 650 | |
| 3 | Achta | Arachide | 1 200 | 300 | |
| 4 | Ngarlem | Sésame | 300 | 650 | |
| 5 | Halimé | Arachide | 800 | 300 | |

> **Attention** : les prix de cet exemple sont fictifs, choisis pour faciliter les calculs.

En E2, on calcule le montant : `=C2*D2`. Puis on **recopie** la formule vers le bas en tirant la petite poignée en bas à droite de la cellule (ou en double-cliquant dessus) : Excel adapte automatiquement la formule à chaque ligne (`=C3*D3`, `=C4*D4`…).

## Les fonctions de base

| Fonction | Exemple | Résultat |
| --- | --- | --- |
| `SOMME` | `=SOMME(E2:E5)` | Le total des montants |
| `MOYENNE` | `=MOYENNE(C2:C5)` | La quantité moyenne livrée |
| `MIN` / `MAX` | `=MAX(C2:C5)` | La plus grosse livraison |
| `NB` | `=NB(C2:C5)` | Le nombre de cellules contenant un nombre |
| `NBVAL` | `=NBVAL(A2:A5)` | Le nombre de cellules non vides |
| `ARRONDI` | `=ARRONDI(E2/1000;0)` | Le montant en milliers, arrondi à l''unité |

## Références relatives et absolues

Kaltouma veut appliquer une retenue de 5 % sur chaque montant pour les frais de la coopérative. Elle écrit le taux une seule fois, dans la cellule H1. En F2 : `=E2*H1`. Mais en recopiant vers le bas, la formule devient `=E3*H2`, `=E4*H3`… : la référence au taux s''est décalée, et le résultat est faux.

Il faut **bloquer** la référence au taux avec le symbole `$` : `=E2*$H$1`. En recopiant, `E2` devient `E3`, `E4` (référence **relative**), mais `$H$1` reste fixe (référence **absolue**).

> **Astuce** : en cours de saisie d''une formule, place le curseur sur une référence et appuie sur **F4** : Excel ajoute ou retire les `$` automatiquement.

## Décider avec SI

La fonction `SI` renvoie une valeur si une condition est vraie, une autre sinon :

```text
=SI(condition;valeur_si_vrai;valeur_si_faux)
```

Exemple : une prime de 10 000 FCFA pour les membres qui ont livré plus de 1 000 kg.

```text
=SI(C2>1000;10000;0)
```

On peut combiner plusieurs conditions avec `ET` et `OU` :

```text
=SI(ET(B2="Sésame";C2>=400);"Prime qualité";"")
```

## Compter et additionner sous condition

Ces fonctions sont parmi les plus utiles au quotidien :

| Fonction | Exemple | Ce qu''elle calcule |
| --- | --- | --- |
| `NB.SI` | `=NB.SI(B2:B5;"Sésame")` | Le nombre de livraisons de sésame |
| `SOMME.SI` | `=SOMME.SI(B2:B5;"Sésame";C2:C5)` | La quantité totale de sésame livrée |
| `MOYENNE.SI` | `=MOYENNE.SI(B2:B5;"Arachide";C2:C5)` | La quantité moyenne par livraison d''arachide |
| `SOMME.SI.ENS` | `=SOMME.SI.ENS(C2:C5;B2:B5;"Sésame";A2:A5;"Néloumta")` | La quantité de sésame livrée par Néloumta (plusieurs conditions) |

## Rechercher une valeur avec RECHERCHEV

Kaltouma a une seconde feuille « Membres » avec le village et le téléphone de chaque membre. Pour afficher automatiquement le village d''un membre dans le tableau des livraisons :

```text
=RECHERCHEV(A2;Membres!A:C;2;FAUX)
```

- `A2` : la valeur cherchée (le nom du membre) ;
- `Membres!A:C` : le tableau où chercher, la valeur cherchée devant être dans sa **première colonne** ;
- `2` : le numéro de la colonne à renvoyer dans ce tableau (ici, le village) ;
- `FAUX` : une correspondance **exacte**. Ne l''oublie jamais, sinon Excel peut renvoyer une valeur approchante et fausse.

> **Info** : les versions récentes d''Excel proposent `RECHERCHEX`, plus souple : elle cherche dans n''importe quelle colonne et gère directement le cas « introuvable ». `RECHERCHEV` reste très répandue et fonctionne partout.

## Les erreurs courantes

| Erreur | Signification |
| --- | --- |
| `#DIV/0!` | Division par zéro (ou par une cellule vide) |
| `#N/A` | Valeur introuvable, souvent avec `RECHERCHEV` |
| `#NOM?` | Nom de fonction mal écrit |
| `#VALEUR!` | Calcul avec du texte, par exemple « 450 kg » au lieu de 450 |
| `#REF!` | Référence à une cellule supprimée |
| `#####` | Colonne trop étroite pour afficher le nombre |

La fonction `SIERREUR` permet d''afficher un message propre : `=SIERREUR(RECHERCHEV(A2;Membres!A:C;2;FAUX);"Membre inconnu")`.

## À toi de jouer

1. Recrée le tableau des livraisons avec au moins 10 lignes (sésame et arachide, plusieurs membres).
2. Calcule la colonne Montant, puis la retenue de 5 % avec une référence absolue, puis le net à payer.
3. Calcule le total, la moyenne, la plus grosse et la plus petite livraison.
4. Ajoute une colonne Prime : 10 000 FCFA au-delà de 1 000 kg, sinon 0.
5. Dans un petit tableau de synthèse, calcule avec `NB.SI` et `SOMME.SI` le nombre de livraisons et la quantité totale pour chaque produit.
6. Crée la feuille Membres et affiche automatiquement le village de chaque membre avec `RECHERCHEV`.

> **Contrôle avec les 4 lignes de l''exemple** : montants 292 500, 360 000, 195 000 et 240 000 FCFA, soit un total de 1 087 500 FCFA. Sésame : 2 livraisons pour 750 kg. Seule Achta touche la prime.

## Vérifie tes acquis

1. Par quel signe commence toute formule ?
2. Pourquoi écrire `$H$1` plutôt que `H1` dans une formule recopiée ?
3. Que signifie le dernier argument `FAUX` de `RECHERCHEV` ?

> **Réponses** : 1. Le signe égal `=`. 2. Pour que la référence reste fixe lors de la recopie de la formule. 3. Qu''on veut une correspondance exacte.

## En résumé

- Une formule commence par `=` ; les arguments se séparent par `;` en français.
- `SOMME`, `MOYENNE`, `MIN`, `MAX`, `NB` couvrent les calculs de base.
- `$` rend une référence **absolue** (touche F4) ; sans `$`, elle est **relative**.
- `SI`, `ET`, `OU` prennent des décisions ; `NB.SI` et `SOMME.SI` calculent sous condition.
- `RECHERCHEV(...;FAUX)` va chercher une information dans un autre tableau ; `SIERREUR` masque proprement les erreurs.

## Pour aller plus loin

- Demande au mentor IA : « Donne-moi 5 exercices Excel progressifs sur SI, NB.SI et RECHERCHEV avec un fichier de ventes. »'
WHERE t.slug = 'bureautique-gestion-donnees' AND l.title = 'Formules essentielles d''Excel/Google Sheets';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Préparer les données, placer les champs, grouper, filtrer et créer un graphique.', l.duration_minutes = 25, l.content = 'La coopérative de Kaltouma a enregistré 2 400 livraisons sur la saison. Le président lui demande : « Combien de sésame a-t-on reçu par village et par mois ? Quels sont nos dix plus gros livreurs ? » Avec des formules, cela prendrait une demi-journée. Avec un **tableau croisé dynamique** (TCD), il faut deux minutes. C''est l''outil le plus puissant du tableur pour résumer de grandes quantités de données.

> **Objectifs de ce chapitre**
> - Préparer des données pour un tableau croisé dynamique
> - Créer un TCD et placer les champs
> - Changer le type de calcul (somme, nombre, moyenne)
> - Grouper par date, filtrer et trier
> - Créer un graphique croisé dynamique

## Préparer les données

Un TCD fonctionne à partir d''une **liste de données propre** :

- **une ligne par enregistrement** (une livraison) ;
- **une ligne d''en-têtes** unique, avec un titre dans chaque colonne ;
- **pas de ligne ni de colonne vide** au milieu ;
- **pas de cellules fusionnées** ;
- des données **cohérentes** : toujours « Sésame », pas « sesame » ou « Sésame blanc » au hasard ;
- des dates au format date et des nombres au format nombre.

| Date | Membre | Village | Produit | Quantité (kg) | Montant |
| --- | --- | --- | --- | --- | --- |
| 03/10/2026 | Néloumta | Balimba | Sésame | 450 | 292 500 |
| 03/10/2026 | Achta | Kemkian | Arachide | 1 200 | 360 000 |
| 05/10/2026 | Ngarlem | Balimba | Sésame | 300 | 195 000 |

> **Astuce** : transforme d''abord ta liste en **tableau** (dans Excel : **Insertion → Tableau**, ou **Ctrl+T**). Les nouvelles lignes ajoutées seront automatiquement prises en compte par le TCD après une simple actualisation.

## Créer un tableau croisé dynamique

Dans **Excel** :

1. Clique dans les données.
2. **Insertion → Tableau croisé dynamique**, puis choisis « Nouvelle feuille de calcul ».
3. Le volet **Champs** apparaît à droite : il liste les colonnes de tes données.

Dans **Google Sheets** : **Insertion → Tableau croisé dynamique**, puis l''éditeur s''ouvre sur la droite.

## Placer les champs

Le volet contient quatre zones :

| Zone | Rôle | Exemple |
| --- | --- | --- |
| **Lignes** | Les catégories affichées en lignes | Village |
| **Colonnes** | Les catégories affichées en colonnes | Produit |
| **Valeurs** | Ce qu''on calcule | Somme de Quantité (kg) |
| **Filtres** | Restreindre l''ensemble du tableau | Mois = octobre |

En glissant **Village** en Lignes, **Produit** en Colonnes et **Quantité** en Valeurs, on obtient immédiatement :

| Village | Arachide | Sésame | Total |
| --- | --- | --- | --- |
| Balimba | 2 300 | 4 150 | 6 450 |
| Kemkian | 5 800 | 1 200 | 7 000 |
| Total | 8 100 | 5 350 | 13 450 |

On peut changer la question en quelques secondes, simplement en déplaçant les champs : c''est pour cela qu''on l''appelle **dynamique**.

## Changer le calcul

Par défaut, un champ numérique est **additionné**. Pour un autre calcul, clique sur le champ dans la zone Valeurs, puis **Paramètres des champs de valeurs** (Excel) ou **Résumer par** (Sheets) :

- **Nombre** : combien de livraisons par village ;
- **Moyenne** : la quantité moyenne par livraison ;
- **Max** : la plus grosse livraison ;
- **% du total** : la part de chaque village dans la production.

> **Info** : on peut placer le même champ deux fois dans la zone Valeurs, par exemple « Somme de Quantité » et « Nombre de Quantité », pour voir à la fois le volume et le nombre de livraisons.

## Grouper, filtrer, trier

- **Grouper par date** : place le champ Date en Lignes, puis clic droit → **Grouper** → Mois. Les livraisons quotidiennes sont résumées par mois.
- **Filtrer** : utilise la petite flèche des en-têtes de lignes ou la zone Filtres pour n''afficher qu''un produit ou qu''une période.
- **Trier** : clic droit sur une valeur → Trier du plus grand au plus petit.
- **Top 10** : dans le filtre des lignes, **Filtres s''appliquant aux valeurs → 10 premiers**, pour obtenir les dix plus gros livreurs.

## Actualiser

Un TCD ne se met **pas** à jour automatiquement quand les données changent. Après avoir ajouté ou corrigé des livraisons : clic droit dans le TCD → **Actualiser** (Excel). Google Sheets actualise en général automatiquement.

> **Attention** : avant de présenter un résultat au président, actualise toujours le TCD. Un chiffre périmé dans une réunion abîme vite la confiance.

## Le graphique croisé dynamique

Un graphique parle souvent plus qu''un tableau. Dans Excel, clique dans le TCD puis **Analyse du tableau croisé dynamique → Graphique croisé dynamique**. Le graphique suit les filtres et les champs du TCD. Choisis :

- un **histogramme** pour comparer des villages ou des produits ;
- une **courbe** pour suivre l''évolution mois par mois ;
- un **secteur** seulement pour montrer quelques parts d''un total (3 à 5 catégories maximum).

## À toi de jouer

1. Crée une liste d''au moins 40 livraisons sur trois mois, avec cinq membres, trois villages et deux produits. Vérifie qu''elle respecte toutes les règles d''une liste propre.
2. Crée un TCD : quantité livrée par village et par produit.
3. Ajoute le nombre de livraisons à côté de la somme des quantités.
4. Groupe les dates par mois pour suivre l''évolution de la production.
5. Affiche le top 3 des membres par montant total.
6. Crée un graphique croisé dynamique de l''évolution mensuelle de la quantité de sésame.
7. Rédige en 4 phrases ce que le président de la coopérative doit retenir de ces chiffres.

> **Pour t''auto-évaluer** : ajoute 5 nouvelles livraisons à ta liste, actualise le TCD et vérifie que les totaux ont changé correctement. Si ce n''est pas le cas, ta source n''est sans doute pas définie comme un tableau.

## Vérifie tes acquis

1. Pourquoi faut-il éviter les cellules fusionnées dans les données source ?
2. Dans quelle zone place-t-on le champ à additionner ?
3. Un TCD se met-il à jour tout seul dans Excel quand les données changent ?

> **Réponses** : 1. Parce qu''elles empêchent le tableau croisé de lire correctement chaque ligne. 2. Dans la zone Valeurs. 3. Non, il faut l''actualiser.

## En résumé

- Un **TCD** résume en quelques clics des milliers de lignes.
- Les données source doivent être une **liste propre** : une ligne par enregistrement, des en-têtes, rien de vide ni de fusionné.
- Quatre zones : **Lignes**, **Colonnes**, **Valeurs**, **Filtres**.
- On change le calcul (somme, nombre, moyenne, %), on groupe par mois, on filtre et on trie.
- On **actualise** après chaque modification ; le graphique croisé dynamique illustre les résultats.

## Pour aller plus loin

- Demande au mentor IA : « Quelles questions utiles un responsable d''ONG peut-il poser à un tableau croisé dynamique de distributions alimentaires ? »'
WHERE t.slug = 'bureautique-gestion-donnees' AND l.title = 'Tableaux croisés dynamiques';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Tables, identifiants uniques, relations et types de données.', l.duration_minutes = 30, l.content = 'Le fichier Excel de la coopérative a grandi : une seule feuille contient maintenant les livraisons, avec à chaque ligne le nom, le village et le téléphone du membre. Quand Néloumta change de numéro, Kaltouma doit corriger 85 lignes, et elle en oublie toujours quelques-unes. Le problème ne vient pas d''Excel, mais de la **structure** des données. Dans ce chapitre, tu apprends à organiser des données comme une vraie **base de données**.

> **Objectifs de ce chapitre**
> - Comprendre les notions de table, d''enregistrement et de champ
> - Éviter les répétitions grâce à des tables séparées
> - Utiliser des identifiants uniques et des relations
> - Choisir le bon type de donnée pour chaque champ
> - Découvrir les outils adaptés : tableur, Access, LibreOffice Base, applications de base de données

## Le vocabulaire

| Terme | Signification | Exemple |
| --- | --- | --- |
| **Table** | Un ensemble de données d''un même type | La table des membres |
| **Enregistrement** (ligne) | Un élément de la table | Le membre Néloumta |
| **Champ** (colonne) | Une information sur chaque élément | Le téléphone |
| **Identifiant** (clé) | Un code unique pour chaque enregistrement | M007 |

## Le problème des répétitions

Dans un tableau unique, les informations des membres sont répétées à chaque livraison :

| Date | Membre | Village | Téléphone | Produit | Quantité |
| --- | --- | --- | --- | --- | --- |
| 03/10 | Néloumta Ngarmadji | Balimba | 66 11 22 33 | Sésame | 450 |
| 12/10 | Néloumta Ngarmadji | Balimba | 66 11 22 33 | Sésame | 380 |
| 20/10 | Néloumta Ngarmadji | Balimba | 66 11 22 33 | Arachide | 600 |

Conséquences :

- **Mises à jour pénibles et risquées** : un changement de téléphone doit être fait sur chaque ligne.
- **Incohérences** : une ligne finit avec l''ancien numéro, une autre avec le nouveau. Lequel est le bon ?
- **Fichier plus lourd** et plus lent.

## La solution : séparer en tables reliées

On découpe les données en tables, chacune consacrée à **un seul sujet** :

**Table Membres**

| id_membre | Nom | Village | Téléphone |
| --- | --- | --- | --- |
| M007 | Néloumta Ngarmadji | Balimba | 66 11 22 33 |
| M012 | Achta Abakar | Kemkian | 99 44 55 66 |

**Table Livraisons**

| id_livraison | Date | id_membre | Produit | Quantité |
| --- | --- | --- | --- | --- |
| L0001 | 03/10/2026 | M007 | Sésame | 450 |
| L0002 | 12/10/2026 | M007 | Sésame | 380 |
| L0003 | 12/10/2026 | M012 | Arachide | 1 200 |

Chaque information n''est écrite **qu''une seule fois**. Le téléphone de Néloumta est dans une seule cellule : on le corrige une fois, et c''est fini. La table Livraisons ne contient que l''**identifiant** du membre, qui fait le lien avec la table Membres : c''est une **relation**.

> **Info** : on parle de relation **un à plusieurs** : un membre peut avoir plusieurs livraisons, mais chaque livraison concerne un seul membre. C''est la relation la plus courante dans les bases de données.

## L''identifiant unique

Pourquoi ne pas utiliser simplement le nom comme lien ? Parce que deux membres peuvent porter le même nom, qu''un nom peut être écrit de plusieurs façons et qu''il peut changer. L''identifiant (`M007`) :

- est **unique** : deux membres n''ont jamais le même ;
- ne **change jamais** ;
- ne porte **aucune signification** qui pourrait évoluer (pas le village dans le code, par exemple).

> **Attention** : n''utilise pas le numéro de téléphone comme identifiant : les gens changent de numéro, et certains partagent un téléphone avec leur famille.

## Choisir le bon type de donnée

| Type | Champs concernés | Pourquoi c''est important |
| --- | --- | --- |
| Texte | Nom, village, produit | — |
| Nombre | Quantité, prix | Permet les calculs ; pas d''unité dans la cellule (« 450 », pas « 450 kg ») |
| Date | Date de livraison | Permet de trier, de grouper par mois, de calculer des durées |
| Liste de choix | Produit, village | Évite les fautes de frappe et les variantes |
| Oui/Non | Payé, membre actif | Permet de filtrer facilement |

> **Astuce** : le numéro de téléphone se stocke en **texte**, pas en nombre : on ne fait pas de calcul dessus, et le format nombre supprimerait un éventuel zéro ou l''indicatif `+235`.

## Relier les tables dans un tableur

Dans Excel ou Google Sheets, on crée une feuille par table, puis on retrouve les informations liées avec `RECHERCHEV` (ou `RECHERCHEX`) :

```text
=RECHERCHEV(C2;Membres!A:D;2;FAUX)
```

Cette formule, placée dans la feuille Livraisons, affiche le nom du membre à partir de son identifiant en C2.

## Les outils de base de données

Quand les données deviennent nombreuses ou que plusieurs personnes doivent les saisir en même temps, on passe à un outil dédié :

- **Microsoft Access** ou **LibreOffice Base** (gratuit) : de vraies bases de données relationnelles sur un ordinateur, avec formulaires de saisie et requêtes.
- Les applications en ligne comme **AppSheet**, **Airtable** ou **NocoDB** : des bases de données faciles, avec formulaires sur téléphone.
- **MySQL**, **PostgreSQL** : les bases de données des applications web, interrogées en langage SQL (vues dans le parcours Développement Web).

La logique est toujours la même : des **tables**, des **identifiants** et des **relations**. Ce que tu apprends ici te servira partout.

## À toi de jouer

Kaltouma veut aussi suivre les **paiements** versés aux membres (date, montant, mode : espèces ou mobile money) et les **villages** (nom, chef de village, distance jusqu''au magasin de Sarh).

1. Identifie les tables nécessaires et liste les champs de chacune, avec leur type.
2. Choisis le format des identifiants de chaque table.
3. Indique les relations entre les tables (qui est lié à qui, un à plusieurs).
4. Crée ces tables dans un classeur (une feuille par table) avec quelques lignes d''exemple.
5. Dans la feuille Paiements, affiche automatiquement le nom et le village du membre à partir de son identifiant.
6. Calcule pour chaque membre : total livré, total payé, reste à payer.

> **Éléments de correction** : quatre tables : Villages (id_village…), Membres (id_membre, nom, id_village, téléphone…), Livraisons (id_livraison, date, id_membre, produit, quantité, prix), Paiements (id_paiement, date, id_membre, montant, mode). Un village a plusieurs membres ; un membre a plusieurs livraisons et plusieurs paiements.

## Vérifie tes acquis

1. Pourquoi ne faut-il pas répéter les informations d''un membre à chaque livraison ?
2. Quelles sont les qualités d''un bon identifiant ?
3. Pourquoi stocker un numéro de téléphone en texte ?

> **Réponses** : 1. Parce que les mises à jour deviennent pénibles et provoquent des incohérences. 2. Il est unique, ne change jamais et ne porte pas de signification susceptible d''évoluer. 3. Parce qu''on ne calcule pas dessus et que le format nombre peut supprimer des caractères comme le `+` ou un zéro initial.

## En résumé

- Une base de données s''organise en **tables**, **enregistrements** et **champs**.
- **Une table par sujet** : chaque information n''est écrite qu''une fois.
- Les tables sont reliées par des **identifiants uniques** (relation un à plusieurs).
- Chaque champ a le bon **type** : texte, nombre, date, liste, oui/non.
- Tableur pour commencer, puis Access, LibreOffice Base, AppSheet ou MySQL quand les besoins grandissent.

## Pour aller plus loin

- Demande au mentor IA : « Aide-moi à concevoir les tables d''une base de données pour gérer les élèves, les classes et les paiements d''une école. »'
WHERE t.slug = 'bureautique-gestion-donnees' AND l.title = 'Structurer une base de données simple';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Règles de saisie, validation des données, nettoyage et protection des fichiers.', l.duration_minutes = 25, l.content = 'Le jour où le président de la coopérative demande le total de sésame livré par Balimba, le tableau croisé dynamique de Kaltouma affiche trois lignes : « Balimba », « balimba » et « Balimba » (avec un espace en trop). Le total est faux. Les meilleurs outils ne servent à rien si les données sont mal saisies. Dans ce chapitre, tu apprends à **prévenir** les erreurs de saisie et à **nettoyer** celles qui sont déjà là.

> **Objectifs de ce chapitre**
> - Connaître les erreurs de saisie les plus fréquentes
> - Rédiger des règles de saisie claires
> - Utiliser la validation des données et les listes déroulantes
> - Nettoyer des données avec les fonctions et outils du tableur
> - Protéger et sauvegarder les fichiers

## Les erreurs les plus fréquentes

| Erreur | Exemple | Conséquence |
| --- | --- | --- |
| Variantes d''écriture | « Sésame », « sesame », « SESAME » | Comptées comme trois produits différents |
| Espaces en trop | « Balimba » avec un espace final | Invisible à l''œil, mais une catégorie de plus |
| Unités dans les nombres | « 450 kg » | Considéré comme du texte : impossible à additionner |
| Dates en texte | « 3 octobre », « 03-10-26 » | Impossible à trier ou grouper par mois |
| Doublons | La même livraison saisie deux fois | Totaux gonflés |
| Cellules vides | Quantité oubliée | Totaux sous-estimés, erreurs de calcul |
| Plusieurs infos dans une cellule | « Néloumta - Balimba » | Impossible de filtrer par village |

## Fixer des règles de saisie

Avant toute chose, on écrit les **règles** et on les partage avec toutes les personnes qui saisissent. Exemple pour la coopérative :

- Dates au format **JJ/MM/AAAA**.
- Quantités en **kilogrammes**, en chiffres uniquement, sans unité ni espace.
- Produits choisis **uniquement** dans la liste : Sésame, Arachide, Mil, Sorgho.
- Un membre est toujours désigné par son **identifiant** (M007), jamais par son seul nom.
- **Une information par cellule.**
- Toute correction est signalée à la responsable, jamais effacée en silence.

> **Astuce** : place une feuille « Lisez-moi » au début du classeur avec ces règles, la signification de chaque colonne et la date de dernière mise à jour. Toute personne qui reprend le fichier gagnera un temps précieux.

## La validation des données

Mieux vaut **empêcher** une erreur que la corriger. Le tableur peut refuser automatiquement les saisies invalides.

Dans **Excel** : sélectionne la colonne, puis **Données → Validation des données**. Dans **Google Sheets** : **Données → Validation des données**.

### La liste déroulante

Pour la colonne Produit, choisis **Liste** et indique les valeurs autorisées (`Sésame;Arachide;Mil;Sorgho`) ou, mieux, une plage d''une feuille « Listes ». Ceux qui saisissent n''ont plus qu''à choisir : fini les variantes d''écriture.

### Les nombres et les dates

- Quantité : **Nombre entier** compris entre 1 et 10 000.
- Date : **Date** comprise entre le début et la fin de la campagne.

Ajoute un **message d''erreur** explicite : « La quantité doit être un nombre de kg entre 1 et 10 000, sans unité. »

> **Info** : la validation n''agit que sur les nouvelles saisies. Elle ne corrige pas les erreurs déjà présentes, et un copier-coller peut parfois la contourner. Le nettoyage reste nécessaire.

## Nettoyer les données existantes

### Les fonctions de nettoyage

| Fonction | Rôle | Exemple |
| --- | --- | --- |
| `SUPPRESPACE` | Supprime les espaces en trop | `=SUPPRESPACE(C2)` |
| `NOMPROPRE` | Majuscule au début de chaque mot | `=NOMPROPRE("néloumta ngarmadji")` → Néloumta Ngarmadji |
| `MAJUSCULE` / `MINUSCULE` | Tout en majuscules ou en minuscules | `=MAJUSCULE(D2)` |
| `SUBSTITUE` | Remplace un texte par un autre | `=SUBSTITUE(E2;" kg";"")` |
| `CNUM` | Convertit un texte en nombre | `=CNUM(SUBSTITUE(E2;" kg";""))` |

On applique la formule dans une colonne temporaire, puis on **copie** le résultat et on le **colle en valeurs** (Collage spécial → Valeurs) à la place des données d''origine, avant de supprimer la colonne temporaire.

### Les autres outils

- **Rechercher et remplacer** (**Ctrl+H**) : remplacer « sesame » par « Sésame » dans toute une colonne.
- **Supprimer les doublons** (Excel : **Données → Supprimer les doublons** ; Sheets : **Données → Nettoyage des données**) : à utiliser avec prudence, après avoir vérifié qu''il s''agit bien de vrais doublons.
- **Filtres** : afficher les valeurs d''une colonne permet de repérer immédiatement les variantes (« Balimba », « balimba »…).
- **Mise en forme conditionnelle** : colorer les cellules vides ou les doublons pour les repérer.

> **Attention** : avant tout nettoyage important, **fais une copie** du fichier d''origine. Une suppression de doublons trop large ou un remplacement mal ciblé peut détruire des données qu''on ne retrouvera pas.

## Protéger et sauvegarder

- **Protéger les feuilles** et les cellules de formules (**Révision → Protéger la feuille**) pour éviter qu''une formule soit effacée par erreur.
- **Limiter les accès** dans Google Sheets : en lecture seule pour ceux qui consultent, en modification pour ceux qui saisissent.
- **Sauvegarder** régulièrement : une copie datée chaque semaine (`livraisons_2026-10-12.xlsx`), sur un autre support ou dans le cloud. L''historique des versions de Google Sheets permet aussi de revenir en arrière.

## À toi de jouer

Voici un extrait de saisie à nettoyer :

| Date | Membre | Village | Produit | Quantité |
| --- | --- | --- | --- | --- |
| 03/10/2026 | néloumta ngarmadji | Balimba | sesame | 450 kg |
| 3 octobre | Achta Abakar | kemkian | Arachide | 1200 |
| 05/10/2026 | NGARLEM DJIMET | Balimba | Sésame | 300 |
| 05/10/2026 | NGARLEM DJIMET | Balimba | Sésame | 300 |

1. Liste toutes les erreurs que tu repères.
2. Rédige les règles de saisie de ce fichier.
3. Recrée l''extrait dans un tableur et nettoie-le avec les fonctions vues (`NOMPROPRE`, `SUPPRESPACE`, `SUBSTITUE`, `CNUM`) et Rechercher-remplacer.
4. Mets en place les validations : liste déroulante pour les produits et les villages, nombre entier pour la quantité, date pour la date.
5. Ajoute une mise en forme conditionnelle qui colore en rouge les quantités vides.
6. Crée la feuille « Lisez-moi » du classeur.

> **Erreurs à repérer** : nom en minuscules ou en majuscules, espace final après « Balimba », village sans majuscule, produit sans accent et en minuscules, unité « kg » dans la quantité, date en texte, doublon probable sur les deux dernières lignes (à vérifier avant de supprimer).

## Vérifie tes acquis

1. Pourquoi « 450 kg » pose-t-il problème dans une colonne de quantités ?
2. Quel outil empêche de saisir un produit qui n''est pas dans la liste ?
3. Que faut-il faire avant un nettoyage important ?

> **Réponses** : 1. Parce que la cellule devient du texte et ne peut plus être additionnée. 2. La validation des données avec une liste déroulante. 3. Une copie de sauvegarde du fichier.

## En résumé

- Variantes d''écriture, espaces, unités, dates en texte et doublons faussent les résultats.
- Des **règles de saisie** écrites et partagées sont la première protection.
- La **validation des données** et les **listes déroulantes** empêchent les erreurs.
- `SUPPRESPACE`, `NOMPROPRE`, `SUBSTITUE`, `CNUM`, Rechercher-remplacer et la suppression des doublons nettoient l''existant.
- Protéger les formules, limiter les accès et **sauvegarder** régulièrement.

## Pour aller plus loin

- Demande au mentor IA : « Comment créer une liste déroulante dépendante (le village dépend du canton) dans Excel ? »'
WHERE t.slug = 'bureautique-gestion-donnees' AND l.title = 'Bonnes pratiques de saisie';


-- =====================================================================
-- Support IT pour Organisations Humanitaires & ONG (it-organisations-humanitaires)
-- =====================================================================
UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'VSAT, orbite basse, terminaux portables, radios HF et VHF, redondance et coordination.', l.duration_minutes = 30, l.content = 'Une ONG ouvre une base dans l''Est du Tchad pour accompagner des réfugiés et les communautés qui les accueillent. Pas de fibre, une couverture mobile faible ou inexistante, et pourtant l''équipe doit envoyer ses rapports, échanger avec la coordination à N''Djamena, et surtout pouvoir communiquer en cas d''urgence sécuritaire. Le technicien IT humanitaire doit choisir et combiner plusieurs moyens de communication : **satellite** pour les données, **radio** pour la sécurité, **mobile** quand il existe.

Dans ce parcours, tu suis **Adoum**, technicien IT d''une ONG internationale, chargé d''équiper une nouvelle base à l''Est du pays.

> **Objectifs de ce chapitre**
> - Connaître les solutions de connectivité terrain et leurs usages
> - Comparer les technologies satellite (VSAT, LEO, terminaux portables)
> - Comprendre le rôle des radios HF et VHF dans la sécurité
> - Concevoir une solution de connectivité redondante
> - Connaître le rôle de la coordination des télécommunications d''urgence

## Les options de connectivité

| Solution | Débit | Latence | Coût | Usage typique |
| --- | --- | --- | --- | --- |
| **Réseau mobile 3G/4G** | Moyen à bon | Faible | Faible | Là où la couverture existe ; souvent une box 4G avec antenne extérieure |
| **VSAT géostationnaire** | Moyen | Élevée (environ 600 ms) | Élevé | Connexion fixe d''un bureau, historiquement très utilisée par les ONG |
| **Satellite en orbite basse** (LEO, par exemple Starlink, là où il est autorisé) | Élevé | Faible | Moyen | Bureau ou base, installation rapide |
| **Terminaux satellites portables** (BGAN, Iridium, Thuraya) | Faible | Élevée | Très élevé à l''usage | Missions mobiles, urgences, voix et messages courts |
| **Radio HF** | Voix, données très faibles | — | Équipement seulement | Communications de sécurité à longue distance |
| **Radio VHF** | Voix | — | Équipement seulement | Communications locales : véhicules, base, ville |

> **Attention** : l''utilisation des équipements satellites et radio est **réglementée**. Fréquences radio, autorisations d''importation et licences d''exploitation doivent être obtenues auprès des autorités tchadiennes compétentes. Renseigne-toi sur les règles en vigueur avant tout déploiement.

## Le satellite en pratique

### La latence

Un satellite **géostationnaire** est à environ 36 000 km d''altitude : un aller-retour du signal prend plus d''une demi-seconde. Cela suffit pour les e-mails et la navigation, mais gêne les appels vidéo et certaines applications. Les satellites en **orbite basse** (quelques centaines de kilomètres) offrent une latence proche de celle de la fibre.

### L''installation

- **Dégager la vue du ciel** : pas d''arbre ni de bâtiment dans la direction du satellite (ou au-dessus de l''antenne pour l''orbite basse).
- **Fixer solidement** l''antenne : les vents de sable et les orages de la saison des pluies sont violents.
- **Protéger l''électronique** de la chaleur et de la poussière.
- **Alimenter** de manière stable : onduleur, et souvent panneaux solaires avec batteries.

### Le budget data

Les forfaits satellites peuvent coûter cher. Un technicien maîtrise la consommation :

- bloquer les mises à jour automatiques en journée, les planifier la nuit ;
- limiter les vidéos haute définition et le stockage en ligne automatique des photos ;
- utiliser un **pare-feu** ou un **contrôleur** qui attribue un quota par utilisateur ou par usage.

> **Astuce** : la première cause de facture satellite explosée est souvent la synchronisation automatique de photos et de vidéos des téléphones personnels du personnel connectés au Wi-Fi du bureau. Sépare le réseau du personnel et celui du travail.

## La radio : l''outil de sécurité

Dans les zones à risque, la radio est le **moyen de communication de sécurité principal** : elle ne dépend ni d''un opérateur, ni d''Internet, ni d''un forfait.

- La **VHF** couvre quelques kilomètres à quelques dizaines de kilomètres : radios portatives, radios dans les véhicules, et une station de base au bureau. Un **relais** installé en hauteur étend la portée.
- La **HF** porte à des centaines de kilomètres, voire plus, en utilisant la réflexion sur l''ionosphère : elle relie une base isolée au bureau de coordination.

L''organisation repose sur des **procédures** : indicatifs d''appel pour chaque véhicule et personne, vacations (appels réguliers) à heures fixes, suivi des mouvements de véhicules, alphabet phonétique pour épeler, et messages courts et clairs.

> **Info** : l''alphabet phonétique international (Alpha, Bravo, Charlie, Delta…) évite les confusions de lettres à la radio, surtout avec un signal brouillé. C''est l''une des premières choses que l''on apprend au personnel.

## Concevoir une solution redondante

Sur le terrain, tout tombe en panne un jour : antenne arrachée par le vent, générateur en panne, forfait épuisé, antenne relais de l''opérateur coupée. On conçoit donc des **moyens de secours** :

| Besoin | Moyen principal | Secours |
| --- | --- | --- |
| Internet du bureau | Satellite en orbite basse | Box 4G si couverture, sinon VSAT ou terminal portable |
| Communication de sécurité | Radio VHF et HF | Téléphone satellite |
| Électricité | Réseau ou générateur | Panneaux solaires et batteries |

## La coordination des télécommunications d''urgence

Lors d''une crise humanitaire, les organisations ne travaillent pas seules. Le **Cluster Télécommunications d''Urgence** (*Emergency Telecommunications Cluster*, ETC), coordonné par le Programme alimentaire mondial (PAM), peut fournir des services de connectivité et de radio partagés aux acteurs humanitaires dans les zones d''intervention. Le technicien IT d''une ONG travaille en lien avec ces mécanismes de coordination.

## À toi de jouer

L''ONG d''Adoum ouvre une base de 15 personnes dans une zone sans couverture 4G fiable, avec 4 véhicules qui se déplacent dans un rayon de 80 km.

1. Propose une solution de connectivité Internet principale et une solution de secours, en justifiant.
2. Propose une solution de communication de sécurité pour la base et les véhicules.
3. Liste les éléments à vérifier avant l''installation (autorisations, emplacement, électricité, sécurité).
4. Rédige trois règles d''utilisation d''Internet pour limiter la consommation de data.
5. Rédige la procédure de vacation radio quotidienne (heures, ordre des appels, informations à transmettre).

> **Éléments de correction** : Internet principal par satellite en orbite basse si autorisé, sinon VSAT ; secours par terminal portable satellite. Sécurité : VHF avec relais pour les véhicules dans un rayon de 80 km, HF avec le bureau de coordination, téléphone satellite dans chaque véhicule pour les urgences. Ne pas oublier l''énergie solaire et les autorisations.

## Vérifie tes acquis

1. Pourquoi la latence d''un satellite géostationnaire est-elle élevée ?
2. Pourquoi la radio reste-t-elle indispensable même avec une bonne connexion Internet ?
3. Quelle organisation coordonne le Cluster Télécommunications d''Urgence ?

> **Réponses** : 1. Parce que le satellite est à environ 36 000 km : le signal parcourt une très longue distance. 2. Parce qu''elle ne dépend ni d''un opérateur ni d''Internet, ce qui la rend fiable en cas de crise ou de panne. 3. Le Programme alimentaire mondial (PAM).

## En résumé

- Le terrain combine **mobile**, **satellite** (VSAT, orbite basse, terminaux portables) et **radio** (VHF, HF).
- Le satellite exige une bonne installation, une alimentation stable et une **maîtrise de la consommation**.
- La **radio** est l''outil de sécurité : procédures, indicatifs, vacations, alphabet phonétique.
- On conçoit toujours des **moyens de secours** pour la connectivité, la sécurité et l''électricité.
- Autorisations nationales et coordination humanitaire (ETC) encadrent les déploiements.

## Pour aller plus loin

- Demande au mentor IA : « Comment calculer la taille d''une installation solaire pour alimenter un terminal satellite, un routeur et deux ordinateurs ? »'
WHERE t.slug = 'it-organisations-humanitaires' AND l.title = 'Connectivité satellite et radio';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Équipements, plan d''adressage, réseaux séparés, énergie et documentation.', l.duration_minutes = 30, l.content = 'La connexion satellite de la base est installée. Adoum doit maintenant monter le **réseau local** du bureau : une quinzaine d''ordinateurs portables, une imprimante, des téléphones, une salle de réunion, et peut-être plus tard un local pour les partenaires. Le tout avec des contraintes fortes : électricité instable, chaleur, poussière, budget limité, et personne pour l''aider s''il tombe en panne la nuit.

> **Objectifs de ce chapitre**
> - Choisir les équipements d''un petit réseau de bureau
> - Planifier l''adressage IP et le Wi-Fi
> - Séparer les réseaux du personnel, des invités et de l''administration
> - Protéger les équipements contre les problèmes électriques et l''environnement
> - Documenter le réseau pour faciliter la maintenance

## Les équipements

| Équipement | Rôle | Conseil terrain |
| --- | --- | --- |
| **Routeur / pare-feu** | Relie le réseau local à Internet, distribue les adresses (DHCP), filtre le trafic | Choisir un modèle qui gère les VLAN et les quotas (MikroTik, Ubiquiti, pfSense sur un petit PC) |
| **Commutateur** (switch) | Relie les appareils câblés entre eux | Un modèle « manageable » permet de créer des VLAN |
| **Points d''accès Wi-Fi** | Fournissent le Wi-Fi | Plusieurs points d''accès gérés de façon centralisée valent mieux qu''un seul très puissant |
| **Onduleur** (UPS) | Fournit de l''électricité pendant les coupures et protège des surtensions | Indispensable pour le routeur, le switch et le terminal satellite |
| **Coffret ou baie** | Protège les équipements | Fermé, ventilé, à l''abri de la poussière |

> **Astuce** : standardise le matériel dans toutes les bases de l''organisation (même marque, mêmes modèles). Les pièces de rechange sont interchangeables, la configuration est identique, et un technicien d''une autre base peut aider à distance.

## Planifier l''adressage

Avant de brancher quoi que ce soit, on écrit le **plan d''adressage** :

| Réseau | VLAN | Plage d''adresses | Usage |
| --- | --- | --- | --- |
| Administration | 10 | 192.168.10.0/24 | Routeur, switch, points d''accès, imprimante |
| Personnel | 20 | 192.168.20.0/24 | Ordinateurs et téléphones professionnels |
| Invités | 30 | 192.168.30.0/24 | Partenaires et visiteurs, accès Internet seulement |

- Les équipements fixes (routeur, imprimante, points d''accès) reçoivent des **adresses fixes**, notées dans la documentation.
- Les autres appareils reçoivent leur adresse automatiquement par **DHCP**.
- Le réseau **invités** n''a accès qu''à Internet, avec un quota de bande passante, et jamais au réseau du personnel.

## Le Wi-Fi

- **Sécurité** : WPA2 ou WPA3 avec un mot de passe long, différent pour le personnel et les invités. Change le mot de passe invités régulièrement.
- **Nom de réseau** (SSID) : clair mais discret, sans le nom de l''organisation dans les zones où la discrétion est importante pour la sécurité.
- **Placement** : points d''accès en hauteur, au centre des zones à couvrir. Les murs en briques épaisses ou en banco atténuent fortement le signal.
- **Bandes** : 5 GHz pour les bureaux (plus rapide, moins encombrée), 2,4 GHz pour une portée plus grande.

> **Attention** : ne laisse jamais le mot de passe d''administration par défaut sur un routeur ou un point d''accès (souvent « admin »). C''est la première chose que testent les personnes malveillantes.

## L''électricité et l''environnement

Sur le terrain, la plupart des pannes réseau sont en réalité des problèmes électriques ou environnementaux :

- **Onduleur** pour tous les équipements réseau, avec une autonomie suffisante pour couvrir le démarrage du générateur ou les coupures courtes.
- **Protection contre la foudre et les surtensions** : parafoudres, mise à la terre correcte de l''antenne satellite et du bâtiment.
- **Chaleur** : les équipements souffrent au-delà de 40 °C. Les placer à l''ombre, dans un local ventilé, jamais en plein soleil ni sous une tôle surchauffée.
- **Poussière** : coffrets fermés, nettoyage régulier des ventilateurs.
- **Énergie solaire** : pour une base isolée, un système de panneaux et de batteries dimensionné pour le réseau et la communication assure le service même quand le générateur est arrêté.

## Les services utiles

- **Partage d''imprimante** sur le réseau du personnel.
- **Stockage partagé** : un petit serveur NAS ou un dossier synchronisé, avec une **sauvegarde** hors du bureau.
- **Mise en cache** des mises à jour pour ne pas télécharger 15 fois la même mise à jour de Windows par le satellite.
- **Supervision** simple : une alerte quand le lien Internet tombe ou que l''onduleur passe sur batterie.

## Documenter

Un réseau non documenté devient incompréhensible après le départ du technicien. Le **dossier réseau** de la base contient :

- un **schéma** du réseau (même dessiné à la main puis photographié) ;
- le **plan d''adressage** et la liste des équipements avec leur adresse, numéro de série et emplacement ;
- les **identifiants d''administration**, rangés dans un gestionnaire de mots de passe partagé de l''organisation, jamais sur un post-it ;
- les **contacts** des fournisseurs (satellite, électricité) ;
- une **procédure de redémarrage** pas à pas, que n''importe quel membre du personnel peut suivre en l''absence du technicien.

> **Info** : la procédure de redémarrage doit être affichée près de la baie, rédigée simplement : « 1. Vérifier que l''onduleur est allumé. 2. Débrancher le terminal satellite 30 secondes. 3. Le rebrancher et attendre 5 minutes… »

## À toi de jouer

Conçois le réseau de la base d''Adoum : 15 membres du personnel, une salle de réunion utilisée par des partenaires, une imprimante, un terminal satellite, et un bâtiment de deux pièces séparées par un mur épais.

1. Dresse la liste du matériel avec quantités et rôle de chaque élément.
2. Rédige le plan d''adressage avec au moins trois réseaux séparés.
3. Décris le placement des points d''accès Wi-Fi sur un plan schématique des deux pièces.
4. Décris la protection électrique (onduleur, parafoudre, solaire).
5. Rédige la procédure de redémarrage affichable, en 6 étapes maximum.

> **Pour t''auto-évaluer** : ton dossier est réussi si un autre technicien, arrivant dans la base sans t''avoir jamais rencontré, peut comprendre le réseau et le dépanner en lisant uniquement ta documentation.

## Vérifie tes acquis

1. Pourquoi séparer le réseau des invités de celui du personnel ?
2. Quels équipements doivent impérativement être branchés sur un onduleur ?
3. Que doit contenir la documentation d''un réseau de base terrain ?

> **Réponses** : 1. Pour que les visiteurs n''aient pas accès aux ordinateurs et données de l''organisation, et pour limiter leur consommation. 2. Le routeur, le switch, les points d''accès et le terminal satellite. 3. Un schéma, le plan d''adressage, la liste des équipements, les identifiants dans un coffre-fort numérique, les contacts fournisseurs et une procédure de redémarrage.

## En résumé

- Un petit réseau : **routeur/pare-feu**, **switch**, **points d''accès**, **onduleur**, matériel standardisé.
- Un **plan d''adressage** avec des réseaux séparés : administration, personnel, invités.
- Un Wi-Fi sécurisé, bien placé, sans mots de passe par défaut.
- **Électricité, chaleur et poussière** sont les premiers ennemis : onduleur, parafoudre, ventilation, solaire.
- Tout est **documenté**, y compris une procédure de redémarrage simple.

## Pour aller plus loin

- Demande au mentor IA : « Comment créer des VLAN pour le personnel et les invités sur un routeur MikroTik ? Donne-moi les étapes. »'
WHERE t.slug = 'it-organisations-humanitaires' AND l.title = 'Monter un petit réseau de bureau terrain';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'KoboToolbox, ODK, formulaires XLSForm, contraintes et collecte hors ligne.', l.duration_minutes = 30, l.content = 'Pendant des années, les enquêtes humanitaires se faisaient sur papier : des milliers de questionnaires remplis à la main, transportés jusqu''au bureau, puis ressaisis dans Excel pendant des semaines, avec des erreurs à chaque étape. Aujourd''hui, les enquêteurs utilisent des **formulaires numériques** sur téléphone ou tablette, qui fonctionnent même sans connexion et envoient les données dès qu''un réseau est disponible. Le technicien IT d''une ONG conçoit, déploie et maintient ces outils.

> **Objectifs de ce chapitre**
> - Connaître les outils de collecte mobile : KoboToolbox, ODK, CommCare
> - Concevoir un formulaire avec le format XLSForm
> - Utiliser les contrôles, les conditions et les types de questions
> - Organiser une collecte hors ligne et la synchronisation
> - Préparer les équipes et le matériel pour le terrain

## Les principaux outils

| Outil | Caractéristiques | Usage typique |
| --- | --- | --- |
| **KoboToolbox** | Gratuit pour les organisations humanitaires, basé sur ODK, interface web simple | Évaluations des besoins, enquêtes, suivi de projets |
| **ODK** (Open Data Kit) | Libre, très robuste, auto-hébergeable ou en version hébergée | Enquêtes à grande échelle, organisations ayant leur propre serveur |
| **CommCare** | Suivi de personnes dans le temps (dossiers, visites) | Santé communautaire, suivi nutritionnel |

KoboToolbox et ODK partagent le même format de formulaire, **XLSForm**, et la même application de collecte sur Android (**KoboCollect** ou **ODK Collect**).

> **Info** : ces outils fonctionnent **hors ligne** : l''enquêteur télécharge le formulaire au bureau, remplit des dizaines de questionnaires dans les villages sans réseau, puis envoie tout au serveur dès qu''il retrouve une connexion.

## Concevoir un formulaire avec XLSForm

Un formulaire XLSForm est un simple **fichier Excel** avec deux feuilles principales.

### La feuille survey

| type | name | label | required | constraint | relevant |
| --- | --- | --- | --- | --- | --- |
| text | nom_village | Nom du village | yes | | |
| integer | taille_menage | Nombre de personnes dans le ménage | yes | . > 0 and . < 40 | |
| select_one oui_non | enfants_moins5 | Y a-t-il des enfants de moins de 5 ans ? | yes | | |
| integer | nb_enfants_moins5 | Combien d''enfants de moins de 5 ans ? | yes | . <= ${taille_menage} | ${enfants_moins5} = ''oui'' |
| select_multiple sources_eau | source_eau | Quelles sources d''eau utilisez-vous ? | | | |
| geopoint | gps | Position GPS du ménage | | | |
| date | date_enquete | Date de l''enquête | yes | | |

### La feuille choices

| list_name | name | label |
| --- | --- | --- |
| oui_non | oui | Oui |
| oui_non | non | Non |
| sources_eau | forage | Forage |
| sources_eau | puits | Puits |
| sources_eau | riviere | Rivière ou mare |

Les colonnes clés :

- **type** : le type de question (`text`, `integer`, `decimal`, `date`, `select_one`, `select_multiple`, `geopoint`, `image`…) ;
- **name** : le nom technique de la variable, sans espace ni accent ;
- **label** : la question affichée à l''enquêteur ;
- **required** : réponse obligatoire ;
- **constraint** : une règle de validité (le point `.` désigne la réponse) ;
- **relevant** : la condition d''affichage de la question.

## Des données fiables dès la saisie

Les contraintes et conditions évitent la plupart des erreurs :

- `. > 0 and . < 40` refuse une taille de ménage aberrante ;
- `. <= ${taille_menage}` empêche d''avoir plus d''enfants que de personnes dans le ménage ;
- la condition `relevant` n''affiche la question sur le nombre d''enfants que si la réponse précédente est « oui » ;
- les **listes de choix** remplacent les réponses libres, ce qui évite les variantes d''écriture.

> **Astuce** : ajoute un **message de contrainte** (colonne `constraint_message`) clair pour l''enquêteur : « La taille du ménage doit être comprise entre 1 et 39 personnes. » Sans message, l''enquêteur bloque sans comprendre.

## Les langues

Les enquêtes se font souvent en arabe tchadien, en sara ou dans d''autres langues locales, même si le formulaire est rédigé en français. XLSForm permet plusieurs colonnes de libellés (`label::Français`, `label::Arabe`) : l''enquêteur choisit la langue dans l''application. Il faut aussi **former** les enquêteurs à traduire oralement les questions de façon cohérente.

## Tester avant de déployer

1. **Prévisualiser** le formulaire dans le navigateur (KoboToolbox le propose).
2. Le **tester sur un téléphone** comme le feront les enquêteurs.
3. Faire un **pilote** avec quelques vrais ménages, puis corriger les questions mal comprises.
4. **Télécharger les données du test** et vérifier qu''elles sont exploitables dans Excel.

> **Attention** : modifier un formulaire **en cours de collecte** peut créer des incohérences dans les données. Fais tous les tests avant le déploiement et, si une modification est vraiment nécessaire, crée une nouvelle version clairement identifiée.

## Préparer le terrain

- **Téléphones** : chargés, avec batteries externes ; écran lisible au soleil ; application installée et formulaire téléchargé au bureau.
- **Formation** des enquêteurs : utilisation de l''application, signification de chaque question, consentement des personnes interrogées.
- **Synchronisation** : définir quand et où les enquêteurs envoient leurs données (chaque soir, au retour à la base).
- **Supervision** : vérifier chaque jour les données reçues pour détecter rapidement les problèmes (enquêteur qui va trop vite, GPS absent, valeurs étranges).

## À toi de jouer

Ton ONG prépare une évaluation rapide de l''accès à l''eau dans 20 villages.

1. Crée un compte gratuit sur KoboToolbox.
2. Construis un formulaire XLSForm d''au moins 12 questions : identification du village et du ménage, sources d''eau, distance et temps de trajet, coût de l''eau, problèmes de santé liés à l''eau, position GPS.
3. Ajoute au moins 3 contraintes avec message, et 2 questions conditionnelles.
4. Ajoute une version en arabe des libellés d''au moins 5 questions.
5. Importe le formulaire dans KoboToolbox, déploie-le, remplis-le trois fois depuis l''application KoboCollect, puis télécharge les données en Excel.
6. Rédige une fiche de formation d''une page pour les enquêteurs.

> **Pour t''auto-évaluer** : essaie volontairement de saisir des réponses absurdes (ménage de 0 personne, 10 enfants dans un ménage de 5). Si ton formulaire les refuse avec un message clair, tes contraintes sont bien conçues.

## Vérifie tes acquis

1. Pourquoi les outils comme KoboToolbox sont-ils adaptés aux zones sans réseau ?
2. À quoi sert la colonne `relevant` dans un XLSForm ?
3. Pourquoi éviter de modifier un formulaire en cours de collecte ?

> **Réponses** : 1. Parce que le formulaire se remplit hors ligne et que les données sont envoyées plus tard, dès qu''une connexion est disponible. 2. À n''afficher une question que si une condition est remplie. 3. Parce que cela peut créer des données incohérentes entre les questionnaires remplis avant et après la modification.

## En résumé

- **KoboToolbox**, **ODK** et **CommCare** remplacent les questionnaires papier, avec un fonctionnement **hors ligne**.
- Un formulaire **XLSForm** est un fichier Excel : feuilles `survey` et `choices`.
- Les **contraintes**, les **conditions** et les **listes de choix** garantissent des données fiables dès la saisie.
- On **teste** et on fait un **pilote** avant de déployer.
- Matériel prêt, enquêteurs formés, synchronisation organisée et supervision quotidienne.

## Pour aller plus loin

- [La documentation de KoboToolbox](https://support.kobotoolbox.org/)
- Demande au mentor IA : « Aide-moi à écrire la contrainte XLSForm qui vérifie qu''un numéro de téléphone tchadien a bien 8 chiffres. »'
WHERE t.slug = 'it-organisations-humanitaires' AND l.title = 'Outils de collecte de données terrain';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Données sensibles, minimisation, consentement, chiffrement et gestion des fuites.', l.duration_minutes = 30, l.content = 'Les données collectées par une ONG décrivent souvent des personnes très vulnérables : réfugiés, victimes de violences, personnes malades, enfants séparés de leur famille. Une liste de bénéficiaires perdue, envoyée au mauvais destinataire ou piratée peut les exposer à des représailles, à la stigmatisation ou à l''exclusion. Pour une organisation humanitaire, protéger ces données fait partie du principe fondamental : **ne pas nuire**.

> **Objectifs de ce chapitre**
> - Identifier les données personnelles et les données sensibles
> - Appliquer les principes de la protection des données
> - Recueillir un consentement éclairé
> - Mettre en place les mesures techniques et organisationnelles
> - Réagir à une fuite de données

## Données personnelles et données sensibles

Une **donnée personnelle** est toute information qui permet d''identifier une personne, directement (nom, photo, numéro de téléphone, empreinte digitale) ou indirectement (combinaison de village, âge, nombre d''enfants et métier).

Certaines données sont **sensibles** : leur divulgation peut causer un tort grave. Dans le contexte humanitaire : santé, statut de réfugié ou de déplacé, appartenance ethnique ou religieuse, violences subies, opinions politiques, données biométriques.

> **Attention** : même des données qui semblent anodines peuvent devenir dangereuses une fois combinées. Une carte des ménages avec leurs coordonnées GPS, leur ethnie et leur statut peut devenir une liste de cibles dans un contexte de conflit.

## Les principes fondamentaux

| Principe | Signification | Exemple |
| --- | --- | --- |
| **Licéité et transparence** | On collecte sur une base légitime, en expliquant clairement pourquoi | Informer les personnes de l''usage de leurs données |
| **Limitation de la finalité** | Les données ne servent qu''à l''objectif annoncé | Les données d''une distribution alimentaire ne sont pas transmises à d''autres fins |
| **Minimisation** | On ne collecte que ce qui est strictement nécessaire | Pas d''ethnie si elle n''est pas indispensable au projet |
| **Exactitude** | Des données correctes et à jour | Corriger un numéro de téléphone erroné |
| **Durée limitée** | On ne garde les données que le temps nécessaire | Supprimer les listes après la fin du projet et des audits |
| **Sécurité** | On protège contre la perte, le vol et l''accès non autorisé | Chiffrement, accès limités |
| **Responsabilité** | L''organisation doit pouvoir démontrer ses bonnes pratiques | Registre des traitements, procédures écrites |

> **Info** : le Tchad dispose d''un cadre légal sur la protection des données à caractère personnel, et les organisations internationales appliquent en plus leurs propres politiques et celles de leurs bailleurs. Le **Manuel sur la protection des données dans l''action humanitaire** publié par le CICR est une référence du secteur. Vérifie toujours les textes et la politique de ton organisation.

## Le consentement éclairé

Avant de collecter des données auprès d''une personne, on lui explique, dans une langue qu''elle comprend :

- **qui** collecte les données ;
- **pourquoi** et **à quoi** elles serviront ;
- **avec qui** elles pourront être partagées ;
- **combien de temps** elles seront conservées ;
- qu''elle peut **refuser** sans que cela la prive de l''aide ;
- comment **accéder** à ses données ou demander leur suppression.

Dans l''urgence et face à une forte dépendance à l''aide, le consentement n''est pas toujours vraiment libre. C''est une raison supplémentaire pour **minimiser** les données collectées.

## Les mesures techniques

- **Chiffrement** des ordinateurs portables (BitLocker sous Windows, chiffrement intégré sous macOS et Linux) et des téléphones : un appareil volé ne doit pas livrer ses données.
- **Comptes individuels** avec mots de passe robustes et authentification à deux facteurs sur les plateformes (KoboToolbox, messagerie, stockage).
- **Accès limité** : chaque personne n''accède qu''aux données nécessaires à son travail.
- **Pseudonymisation** : remplacer les noms par des codes dans les fichiers d''analyse ; la table de correspondance est conservée à part, avec un accès très restreint.
- **Transferts sécurisés** : pas de listes de bénéficiaires par WhatsApp ni sur des clés USB non chiffrées ; utiliser les espaces de partage de l''organisation avec des droits d''accès.
- **Suppression des données** des téléphones de collecte une fois envoyées au serveur.
- **Sauvegardes chiffrées**.

> **Astuce** : avant de partager un fichier, pose-toi trois questions : le destinataire a-t-il vraiment besoin de ces données ? A-t-il besoin des noms, ou des chiffres agrégés suffisent-ils ? Le canal de partage est-il sûr ?

## Les mesures organisationnelles

- Une **politique de protection des données** connue de tout le personnel.
- Une **formation** régulière, y compris des enquêteurs, chauffeurs et volontaires.
- Des **accords de partage de données** écrits avec les partenaires et les autorités, qui précisent ce qui est partagé, pourquoi et comment.
- Une **évaluation d''impact** avant tout nouveau traitement à risque, par exemple l''utilisation de la biométrie.
- Un **registre** des traitements de données de l''organisation.

## Réagir à une fuite de données

Un ordinateur portable contenant des listes de bénéficiaires est volé dans un véhicule. Que faire ?

1. **Signaler immédiatement** l''incident à la hiérarchie et au référent protection des données ou IT.
2. **Limiter les dégâts** : changer les mots de passe des comptes accessibles depuis l''appareil, révoquer ses accès, l''effacer à distance si c''est possible.
3. **Évaluer** : quelles données, combien de personnes, quel risque concret pour elles ? L''appareil était-il chiffré ?
4. **Informer** les personnes concernées et les autorités quand la loi ou la politique de l''organisation l''exige, et quand cela permet aux personnes de se protéger.
5. **Documenter** l''incident et **tirer les leçons** pour qu''il ne se reproduise pas.

Si l''ordinateur était **chiffré** et protégé par un bon mot de passe, le risque est très réduit : c''est pourquoi le chiffrement est obligatoire dans de nombreuses organisations.

## À toi de jouer

Ton ONG prépare une distribution de kits d''hygiène à 800 ménages déplacés. Le formulaire d''enregistrement prévu contient : nom complet, photo, ethnie, religion, numéro de téléphone, coordonnées GPS de l''abri, composition du ménage, handicap éventuel, statut sérologique.

1. Applique le principe de **minimisation** : quelles données garder, lesquelles supprimer, en justifiant pour chacune.
2. Rédige le **texte de consentement** (8 lignes maximum) que l''enquêteur lira aux personnes.
3. Liste les **mesures techniques** à mettre en place, de la collecte à l''archivage.
4. Rédige la **procédure** à suivre en cas de perte d''un téléphone de collecte.

> **Éléments de correction** : l''ethnie, la religion et le statut sérologique n''ont aucun rapport avec un kit d''hygiène : à supprimer. La photo et le GPS précis sont à éviter sauf justification forte. La composition du ménage (pour adapter le kit), un contact et l''information sur un handicap (pour adapter la distribution) peuvent être justifiés.

## Vérifie tes acquis

1. Qu''est-ce que le principe de minimisation ?
2. Pourquoi le chiffrement des ordinateurs portables est-il si important ?
3. Une personne qui refuse de donner ses informations doit-elle être exclue de l''aide ?

> **Réponses** : 1. Ne collecter que les données strictement nécessaires à l''objectif. 2. Parce qu''en cas de perte ou de vol, les données restent illisibles pour celui qui trouve l''appareil. 3. Non, le refus ne doit pas la priver de l''aide ; il faut prévoir une solution alternative.

## En résumé

- Les données des bénéficiaires peuvent les mettre en danger : leur protection relève du principe **ne pas nuire**.
- Principes : licéité, finalité, **minimisation**, exactitude, durée limitée, sécurité, responsabilité.
- Un **consentement éclairé**, dans une langue comprise, sans condition sur l''aide.
- Mesures techniques : **chiffrement**, accès limités, pseudonymisation, transferts sécurisés.
- En cas de fuite : signaler, limiter, évaluer, informer, documenter.

## Pour aller plus loin

- Le *Manuel sur la protection des données dans l''action humanitaire* du CICR, téléchargeable gratuitement sur le [site du CICR](https://www.icrc.org/fr)
- Demande au mentor IA : « Aide-moi à rédiger un accord de partage de données simple entre deux ONG partenaires. »'
WHERE t.slug = 'it-organisations-humanitaires' AND l.title = 'Protection des données des bénéficiaires';


-- =====================================================================
-- Marketing Digital & Réseaux Sociaux (marketing-digital-reseaux-sociaux)
-- =====================================================================
UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Choisir ses réseaux, créer une page Facebook complète et une identité visuelle.', l.duration_minutes = 25, l.content = 'Au Tchad, Facebook et WhatsApp sont devenus la vitrine de milliers de commerces, de restaurants, d''écoles et de prestataires de services. Beaucoup de clients cherchent un commerce sur Facebook avant de se déplacer. Une page professionnelle bien construite inspire confiance et attire des clients ; une page vide ou abandonnée fait l''effet inverse.

Dans ce parcours, tu accompagnes **Zénaba**, qui vend des produits cosmétiques naturels (beurre de karité, huiles, savons) dans sa boutique de N''Djamena et veut développer ses ventes grâce aux réseaux sociaux.

> **Objectifs de ce chapitre**
> - Choisir les réseaux sociaux adaptés à son activité
> - Créer une page Facebook professionnelle complète
> - Rédiger une présentation claire et convaincante
> - Construire une identité visuelle cohérente
> - Préparer les premières publications et attirer les premiers abonnés

## Choisir ses réseaux

Inutile d''être partout : mieux vaut être **présent et actif** sur deux réseaux que fantôme sur six.

| Réseau | Public et usages | Pour Zénaba ? |
| --- | --- | --- |
| **Facebook** | Très large public, toutes générations ; pages, groupes, Marketplace | Oui, vitrine principale |
| **WhatsApp** | Messagerie la plus utilisée ; statuts, catalogue, groupes | Oui, pour vendre et fidéliser |
| **TikTok** | Jeunes, vidéos courtes, forte viralité | Oui, plus tard, pour les démonstrations |
| **Instagram** | Visuels soignés, jeunes urbains | Possible, secondaire |
| **LinkedIn** | Professionnels, recrutement, entreprise à entreprise | Non pour la vente de cosmétiques |

> **Info** : choisis tes réseaux en fonction de **tes clients**, pas de tes préférences. Demande simplement à tes clients actuels quels réseaux ils utilisent chaque jour.

## Créer la page Facebook

Une **page** est différente d''un profil personnel : elle est faite pour une activité, permet d''avoir des abonnés sans limite, donne accès aux statistiques et à la publicité. Ne fais jamais la promotion de ton commerce depuis ton profil personnel.

Création : depuis ton compte Facebook, menu **Pages → Créer une page**. Les éléments à soigner :

- **Le nom** : le nom commercial, simple et facile à rechercher. « Zénaba Cosmétiques Naturels » plutôt que « ZCN Officiel 235 ».
- **La catégorie** : la bonne catégorie aide Facebook à présenter ta page aux bonnes personnes (« Produits de beauté, cosmétiques et soins personnels »).
- **La photo de profil** : le logo, lisible même en tout petit, ou une photo du visage si c''est ton image qui porte l''activité.
- **La photo de couverture** : une belle image qui montre ce que tu vends, avec éventuellement un court message (« Livraison partout à N''Djamena »).
- **L''adresse et les horaires** : précis, avec un repère connu (« face à la pharmacie X, quartier Moursal »).
- **Les contacts** : numéro de téléphone, **bouton WhatsApp** (action « Envoyer un message WhatsApp »).
- **Le nom d''utilisateur** : pour obtenir une adresse courte du type `facebook.com/zenabacosmetiques`.

## La présentation

La section « À propos » doit répondre en quelques lignes à quatre questions : **quoi**, **pour qui**, **pourquoi toi**, **comment acheter**.

> **Exemple** : « Cosmétiques 100 % naturels fabriqués à N''Djamena : beurre de karité pur, huiles et savons pour la peau et les cheveux. Des produits sans produits chimiques agressifs, adaptés au climat sec du Sahel. Commande sur WhatsApp, livraison dans toute la ville en 24 h. »

> **Attention** : évite les promesses exagérées ou fausses, en particulier sur la santé (« guérit toutes les maladies de peau »). Elles font fuir les clients sérieux, peuvent te mettre en tort et violent les règles de publicité des plateformes.

## L''identité visuelle

Une page professionnelle se reconnaît au premier coup d''œil grâce à sa cohérence :

- **2 ou 3 couleurs** principales, toujours les mêmes (par exemple un vert naturel, un beige et un doré) ;
- **une ou deux polices** pour les textes sur les images ;
- un **style photo** reconnaissable : même fond, même lumière, même cadrage ;
- le **logo** discret sur les visuels.

L''application gratuite **Canva** propose des modèles de publications, de couvertures et de logos, utilisables sur smartphone.

## Les premières publications

Avant d''inviter des gens à aimer la page, publie **6 à 9 contenus** pour qu''elle ne paraisse pas vide :

1. Une publication de bienvenue qui présente la boutique et son histoire.
2. Trois publications de produits avec photo, prix et façon de commander.
3. Une photo de la boutique ou de la fabrication (les coulisses inspirent confiance).
4. Un conseil utile (« Comment utiliser le beurre de karité sur des cheveux secs »).
5. Un témoignage client, avec son accord.
6. Les informations pratiques : livraison, paiement par mobile money, horaires.

> **Astuce** : épingle en haut de la page la publication qui présente l''offre et la façon de commander. C''est elle que verront d''abord les nouveaux visiteurs.

## Attirer les premiers abonnés

- Invite tes contacts Facebook à aimer la page (la fonction d''invitation est prévue pour cela).
- Partage la page dans tes statuts WhatsApp avec son lien.
- Affiche un **code QR** de la page dans la boutique et sur les sacs ou les étiquettes.
- Demande à tes clients satisfaits de **laisser un avis** et de recommander la page.
- Participe aux **groupes Facebook** de ton quartier ou de ta ville, en apportant des conseils utiles plutôt qu''en publiant uniquement de la publicité (respecte toujours les règles du groupe).

## À toi de jouer

Choisis une activité réelle (la tienne, celle d''un proche ou d''un commerce de ton quartier) :

1. Identifie ses clients et choisis deux réseaux sociaux en justifiant ce choix.
2. Rédige le nom de la page, la catégorie et la présentation « À propos » (5 lignes maximum).
3. Définis l''identité visuelle : couleurs, polices, style photo.
4. Crée dans Canva la photo de couverture.
5. Rédige les 6 premières publications avec leur texte et une description de l''image.
6. Liste 5 actions concrètes pour obtenir les 100 premiers abonnés.

> **Pour t''auto-évaluer** : montre ta page (ou ta maquette) à une personne pendant 10 secondes. Si elle sait dire ce qui est vendu, où, et comment commander, ta page est efficace.

## Vérifie tes acquis

1. Pourquoi utiliser une page plutôt que son profil personnel pour son commerce ?
2. À quelles quatre questions doit répondre la présentation de la page ?
3. Pourquoi publier quelques contenus avant d''inviter des abonnés ?

> **Réponses** : 1. Parce que la page est conçue pour une activité : abonnés illimités, statistiques, publicité, bouton de contact. 2. Quoi, pour qui, pourquoi toi, comment acheter. 3. Pour que les visiteurs trouvent une page vivante et crédible dès leur première visite.

## En résumé

- Choisis **deux réseaux** utilisés par tes clients plutôt que d''être partout.
- Une **page professionnelle** complète : nom clair, catégorie, photos, adresse, horaires, contact WhatsApp.
- Une présentation qui dit **quoi, pour qui, pourquoi toi, comment acheter**, sans promesse exagérée.
- Une **identité visuelle** cohérente : couleurs, polices, style photo.
- Des premières publications variées avant de chercher des abonnés.

## Pour aller plus loin

- Demande au mentor IA : « Propose 5 idées de noms et une présentation Facebook pour une boutique de [ton activité] à N''Djamena. »'
WHERE t.slug = 'marketing-digital-reseaux-sociaux' AND l.title = 'Créer une page professionnelle efficace';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Profil, catalogue, messages automatiques, réponses rapides, étiquettes et statuts.', l.duration_minutes = 25, l.content = 'Pour Zénaba, presque toutes les ventes se concluent sur WhatsApp : les clientes voient un produit sur Facebook ou dans un statut, puis écrivent pour demander le prix, la disponibilité et la livraison. Avec un simple WhatsApp personnel, elle mélange messages de famille et de clientes, oublie de répondre et répète cent fois les mêmes informations. **WhatsApp Business** est une application gratuite pensée pour les commerçants, qui règle ces problèmes.

> **Objectifs de ce chapitre**
> - Configurer un profil professionnel complet
> - Créer un catalogue de produits
> - Automatiser l''accueil et les absences
> - Gagner du temps avec les réponses rapides et les étiquettes
> - Utiliser les statuts et les listes de diffusion sans spammer

## WhatsApp ou WhatsApp Business ?

**WhatsApp Business** est une application séparée, gratuite, disponible sur Android et iPhone. Elle fonctionne comme WhatsApp, avec des outils en plus pour les entreprises. Bonne pratique : utiliser un **numéro dédié** à l''activité, distinct du numéro personnel.

> **Info** : il existe aussi la **plateforme WhatsApp Business** (anciennement API), destinée aux entreprises qui envoient de gros volumes de messages automatisés (banques, opérateurs). Pour un petit commerce, l''application gratuite suffit largement.

## Le profil professionnel

Dans **Outils pour les professionnels → Profil professionnel** :

- photo de profil : le logo ou une photo professionnelle ;
- nom de l''entreprise ;
- catégorie ;
- description courte ;
- adresse, avec un repère ;
- horaires d''ouverture ;
- lien vers la page Facebook.

Un profil complet rassure : la cliente sait qu''elle parle à un vrai commerce.

## Le catalogue

Le **catalogue** est une vitrine dans WhatsApp. Pour chaque produit :

- une **photo** nette, sur fond simple ;
- un **nom** clair (« Beurre de karité pur, pot de 250 g ») ;
- le **prix** ;
- une **description** courte : usage, ingrédients, conseils ;
- éventuellement un code produit.

Les clientes consultent le catalogue depuis le profil et peuvent envoyer un produit directement dans la conversation : fini les « c''est combien la crème dans votre statut d''hier ? ».

> **Astuce** : regroupe les produits en **collections** (Soins du visage, Soins des cheveux, Savons) et mets le catalogue à jour dès qu''un produit est en rupture. Une cliente déçue qu''un produit affiché ne soit plus disponible est une cliente perdue.

## Les messages automatiques

### Le message d''accueil

Envoyé automatiquement au premier message d''une nouvelle cliente, ou après 14 jours sans échange :

> « Bienvenue chez Zénaba Cosmétiques Naturels ! Découvrez nos produits dans le catalogue. Indiquez-nous le produit souhaité et votre quartier pour la livraison. Paiement à la livraison ou par mobile money. »

### Le message d''absence

Envoyé en dehors des horaires d''ouverture :

> « Merci pour votre message ! La boutique est fermée pour le moment. Nous vous répondons dès demain à partir de 8 h. »

## Les réponses rapides

Les questions reviennent toujours : prix de la livraison, modes de paiement, adresse de la boutique. Les **réponses rapides** permettent d''enregistrer ces textes et de les insérer en tapant `/` suivi d''un raccourci :

| Raccourci | Message |
| --- | --- |
| `/livraison` | « Livraison à N''Djamena sous 24 h : 1 000 FCFA dans les quartiers proches, 1 500 FCFA au-delà. Gratuite dès 15 000 FCFA d''achat. » |
| `/paiement` | « Vous pouvez payer en espèces à la livraison ou par Airtel Money / Moov Money au numéro… » |
| `/adresse` | « Notre boutique : quartier Moursal, face à… Ouverte du lundi au samedi de 8 h à 19 h. » |

## Les étiquettes

Les **étiquettes** classent les conversations par couleur : Nouvelle cliente, Commande en cours, Payé, Livré, À relancer. En un coup d''œil, Zénaba voit les commandes à préparer et les clientes à recontacter. Elle peut aussi filtrer les discussions par étiquette.

> **Attention** : réponds vite. Une cliente qui attend plusieurs heures une réponse sur un prix achète souvent ailleurs. Si tu ne peux pas répondre immédiatement, le message d''accueil doit au moins indiquer un délai.

## Les statuts

Les **statuts** sont vus par les contacts qui ont enregistré ton numéro. C''est un excellent canal, gratuit, pour :

- présenter un nouveau produit ;
- montrer les coulisses (fabrication du savon, arrivée d''une commande) ;
- partager un témoignage ou une photo de cliente satisfaite (avec son accord) ;
- annoncer une promotion limitée.

Publie **régulièrement**, 2 à 5 statuts par jour sans plus : trop de statuts lassent. Demande à tes clientes d''enregistrer ton numéro, sinon elles ne verront pas tes statuts.

## Les listes de diffusion et les groupes

- Une **liste de diffusion** envoie un même message à plusieurs contacts, qui le reçoivent individuellement. Seuls les contacts qui ont enregistré ton numéro le reçoivent.
- Un **groupe** permet des échanges entre tous les membres, utile pour une communauté de clientes fidèles.

> **Attention** : n''envoie des messages promotionnels qu''aux personnes qui ont accepté d''en recevoir, et avec modération (une fois par semaine au maximum). Les envois massifs non désirés poussent les gens à te bloquer ou à te signaler, et WhatsApp peut restreindre ton compte.

## Le lien et le code QR

WhatsApp Business génère un **lien court** (`wa.me/235XXXXXXXX`) et un **code QR** qui ouvrent directement une conversation avec toi. Place-les sur la page Facebook, les publications, les étiquettes de produits et dans la boutique.

## À toi de jouer

Pour l''activité choisie au chapitre précédent :

1. Rédige le profil professionnel complet.
2. Prépare 5 fiches de catalogue (nom, prix, description de 2 lignes).
3. Rédige le message d''accueil et le message d''absence.
4. Crée 5 réponses rapides avec leur raccourci.
5. Définis 5 étiquettes et leur signification.
6. Planifie les statuts d''une semaine : un tableau avec, pour chaque jour, deux idées de statuts.

> **Pour t''auto-évaluer** : fais tester ta configuration par un ami qui joue le rôle d''un client. Il doit obtenir le prix, la livraison et le mode de paiement en moins de deux minutes, sans que tu tapes de long message.

## Vérifie tes acquis

1. Pourquoi utiliser un numéro dédié pour son activité ?
2. À quoi servent les réponses rapides ?
3. Quelle condition faut-il remplir pour qu''un contact voie tes statuts et reçoive tes listes de diffusion ?

> **Réponses** : 1. Pour séparer vie personnelle et activité professionnelle et garder un historique clair des clients. 2. À insérer en un instant des réponses enregistrées aux questions fréquentes. 3. Il doit avoir enregistré ton numéro dans ses contacts.

## En résumé

- **WhatsApp Business** est gratuit et ajoute des outils professionnels, idéalement sur un numéro dédié.
- Un **profil** complet et un **catalogue** à jour remplacent de longs échanges.
- **Message d''accueil**, **message d''absence** et **réponses rapides** font gagner du temps.
- Les **étiquettes** organisent le suivi des commandes.
- **Statuts** réguliers et listes de diffusion avec modération, uniquement pour les contacts d''accord.

## Pour aller plus loin

- Demande au mentor IA : « Rédige 7 statuts WhatsApp pour une semaine de promotion d''une boutique de [ton activité]. »'
WHERE t.slug = 'marketing-digital-reseaux-sociaux' AND l.title = 'WhatsApp Business pour son activité';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Photos de produits, vidéos courtes, textes qui font agir et calendrier de publication.', l.duration_minutes = 30, l.content = 'Pas besoin d''un appareil photo coûteux ni d''une agence pour produire de beaux contenus : un smartphone, de la lumière naturelle et quelques techniques suffisent. Ce qui compte, c''est de **régulièrement** publier des contenus **utiles ou intéressants** pour tes clients, pas seulement des publicités. Zénaba va apprendre à photographier ses produits, tourner de courtes vidéos et organiser ses publications.

> **Objectifs de ce chapitre**
> - Prendre de belles photos de produits avec un smartphone
> - Tourner et monter une vidéo courte
> - Rédiger des textes qui donnent envie d''agir
> - Varier les types de contenus
> - Organiser un calendrier de publication

## Photographier ses produits

### La lumière

La lumière fait 80 % de la qualité d''une photo. La meilleure est la **lumière naturelle douce** : près d''une fenêtre, ou dehors à l''ombre, le matin ou en fin d''après-midi. Évite le soleil direct de midi, qui crée des ombres dures et des reflets, et la lumière jaune des ampoules le soir.

### Le fond et la composition

- Un **fond simple** et propre : un drap uni, une planche en bois, une feuille de papier blanc ou un pagne aux couleurs sobres.
- Le produit **au centre** ou selon la **règle des tiers** : active la grille dans l''application appareil photo et place le produit sur une des intersections.
- Des **accessoires** qui racontent une histoire : des noix de karité à côté du pot de beurre, une feuille verte, une serviette.
- Plusieurs **angles** : de face, de dessus, en gros plan sur la texture.

### Les réglages

- **Nettoie l''objectif** avec un tissu doux : une trace de doigt rend toutes les photos floues.
- Touche l''écran sur le produit pour faire la **mise au point**.
- N''utilise pas le **zoom numérique**, qui dégrade l''image : rapproche-toi plutôt.
- Évite le **flash** sur les produits brillants.

> **Astuce** : fabrique un petit « studio » pour moins de 2 000 FCFA : une grande feuille de carton blanc courbée contre un mur, près d''une fenêtre, et un second carton blanc en face pour renvoyer la lumière et adoucir les ombres.

### La retouche légère

Avec des applications gratuites comme **Snapseed** ou l''éditeur intégré du téléphone : recadrer, redresser, augmenter légèrement la luminosité et le contraste. Ne modifie jamais les couleurs du produit : la cliente doit recevoir exactement ce qu''elle a vu.

## Tourner des vidéos courtes

Les vidéos courtes (15 à 60 secondes, au **format vertical**) sont les contenus les plus vus sur Facebook, TikTok et dans les statuts WhatsApp.

Une structure simple et efficace :

1. **L''accroche** (2 à 3 premières secondes) : une question ou une image forte. « Tes cheveux cassent avec la chaleur ? »
2. **Le contenu** : la démonstration, le conseil, l''avant/après.
3. **L''appel à l''action** : « Commande sur WhatsApp, lien dans la description. »

Idées de vidéos pour Zénaba :

- la fabrication d''un savon en accéléré ;
- une démonstration d''application du beurre de karité sur des cheveux ;
- trois erreurs à éviter pour prendre soin de sa peau en saison sèche ;
- le déballage d''un colis livré, filmé par une cliente avec son accord.

Conseils de tournage :

- filme à la **verticale** ;
- **stabilise** le téléphone (appuyé sur une pile de livres ou sur un petit trépied) ;
- soigne le **son** : parle près du téléphone, dans un endroit calme, ou utilise un petit micro-cravate ;
- ajoute des **sous-titres** : beaucoup de gens regardent sans le son.

Le montage se fait facilement avec **CapCut** ou **InShot** sur smartphone : couper les passages inutiles, ajouter des sous-titres automatiques, une musique libre de droits et le logo.

> **Attention** : n''utilise pas de musique protégée par des droits d''auteur trouvée n''importe où : la plateforme peut couper le son ou supprimer la vidéo. Utilise les bibliothèques musicales fournies par les applications et les plateformes.

## Écrire des textes qui font agir

- **La première ligne** est décisive : c''est souvent la seule visible avant « Voir plus ».
- Parle du **bénéfice** pour la cliente plutôt que du produit lui-même : « Des cheveux doux et forts malgré l''harmattan » plutôt que « Beurre de karité 250 g ».
- Des **phrases courtes**, quelques émojis pertinents, des retours à la ligne.
- Un **appel à l''action** clair à la fin : « Écris-nous sur WhatsApp au 66 XX XX XX ».
- **Pose des questions** pour faire réagir : « Et toi, quelle est ta routine pour les cheveux ? »

## Varier les contenus

Une page qui ne publie que des promotions lasse vite. Une règle simple : sur 5 publications, **une seule** est directement commerciale. Les autres :

| Type | Objectif | Exemple |
| --- | --- | --- |
| Conseil | Être utile, montrer son expertise | « 3 astuces pour protéger sa peau du soleil » |
| Coulisses | Créer de la confiance | La fabrication des savons |
| Preuve sociale | Rassurer | Avis et photos de clientes |
| Divertissement ou question | Faire réagir | « Karité ou huile de coco : tu es team quoi ? » |
| Offre | Vendre | « Ce week-end : -10 % sur les savons » |

## Le calendrier de publication

La **régularité** compte plus que la quantité. Mieux vaut 3 publications par semaine pendant un an que 3 par jour pendant deux semaines puis plus rien.

Un calendrier simple dans un tableau : jour, réseau, type de contenu, sujet, texte, statut (à faire, prêt, publié). Prépare les contenus de la semaine en une seule séance, et programme-les avec **Meta Business Suite** (gratuit), qui publie automatiquement sur Facebook et Instagram à l''heure choisie.

> **Info** : tiens compte des moments forts locaux pour tes contenus : la rentrée scolaire, le Ramadan et la fête de fin du Ramadan, la Tabaski, Noël, la fête de l''Indépendance du 11 août, la saison des pluies, la saison sèche et l''harmattan.

## À toi de jouer

Pour l''activité choisie :

1. Fabrique un petit studio et prends 5 photos d''un produit (fond simple, lumière naturelle, plusieurs angles). Compare une photo « avant » et une photo « après » ces conseils.
2. Tourne et monte une vidéo verticale de 30 secondes avec accroche, contenu et appel à l''action, sous-titrée.
3. Rédige 3 textes de publication en appliquant les conseils d''écriture.
4. Construis le calendrier d''un mois : 3 publications par semaine, en respectant la règle d''une publication commerciale sur cinq, et en intégrant un moment fort local.

> **Pour t''auto-évaluer** : montre ta vidéo à trois personnes. Si elles comprennent le message sans le son et savent comment commander à la fin, ta vidéo est réussie.

## Vérifie tes acquis

1. Quelle est la meilleure lumière pour photographier un produit ?
2. Quelles sont les trois parties d''une vidéo courte efficace ?
3. Pourquoi ne pas publier uniquement des promotions ?

> **Réponses** : 1. Une lumière naturelle douce, près d''une fenêtre ou à l''ombre. 2. L''accroche, le contenu et l''appel à l''action. 3. Parce que cela lasse les abonnés ; les contenus utiles, les coulisses et les avis créent la confiance qui fait vendre.

## En résumé

- **Lumière naturelle**, fond simple, objectif propre et plusieurs angles pour de belles photos.
- Des **vidéos verticales courtes** : accroche, contenu, appel à l''action, sous-titres.
- Des textes centrés sur le **bénéfice**, avec une première ligne forte et un appel à l''action.
- **Varier** les contenus : une publication commerciale sur cinq.
- Un **calendrier** régulier, préparé à l''avance et programmé.

## Pour aller plus loin

- Demande au mentor IA : « Donne-moi 10 idées de vidéos courtes pour une boutique de [ton activité], avec l''accroche de chacune. »'
WHERE t.slug = 'marketing-digital-reseaux-sociaux' AND l.title = 'Créer du contenu avec un smartphone';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Objectifs, indicateurs, statistiques, lien avec les ventes et publicité à petit budget.', l.duration_minutes = 30, l.content = 'Zénaba publie régulièrement depuis deux mois. Mais est-ce que cela fait vendre ? Quelles publications marchent, lesquelles ne servent à rien ? Faut-il continuer les vidéos ? Sans mesure, on avance à l''aveugle et on dépense temps et argent au hasard. Dans ce chapitre, tu apprends à lire les **statistiques** des réseaux sociaux, à suivre quelques **indicateurs** simples et à **ajuster** ta stratégie.

> **Objectifs de ce chapitre**
> - Se fixer des objectifs mesurables
> - Comprendre les indicateurs clés : portée, engagement, clics, messages, ventes
> - Lire les statistiques de Meta Business Suite
> - Relier les publications aux ventes réelles
> - Analyser les résultats et décider quoi changer
> - Découvrir la publicité payante avec un petit budget

## Se fixer des objectifs

Un bon objectif est **précis**, **chiffré** et **daté** :

- trop vague : « avoir plus de clients » ;
- précis : « recevoir 60 demandes de commande sur WhatsApp par mois d''ici fin décembre ».

Le nombre d''abonnés n''est pas un objectif en soi : 5 000 abonnés qui n''achètent jamais rapportent moins que 500 abonnés fidèles de ton quartier.

## Les indicateurs clés

| Indicateur | Ce qu''il mesure | Question à laquelle il répond |
| --- | --- | --- |
| **Portée** | Nombre de personnes qui ont vu la publication | Mes contenus sont-ils vus ? |
| **Impressions** | Nombre total d''affichages (une personne peut voir plusieurs fois) | Combien de fois mes contenus s''affichent-ils ? |
| **Engagement** | Réactions, commentaires, partages, enregistrements | Mes contenus intéressent-ils ? |
| **Taux d''engagement** | Engagement divisé par la portée | Quelle part de ceux qui voient réagissent ? |
| **Clics** | Clics sur le lien ou le bouton WhatsApp | Mes contenus donnent-ils envie d''agir ? |
| **Messages reçus** | Nouvelles conversations démarrées | Combien de personnes me contactent ? |
| **Ventes** | Commandes réellement conclues | Est-ce que ça rapporte ? |

Ces indicateurs forment un **entonnoir** : beaucoup de personnes voient, une partie réagit, quelques-unes écrivent, et une partie achète. Chaque étape te dit où se situe le problème.

> **Info** : un exemple de calcul : une publication vue par 2 000 personnes, avec 80 réactions et commentaires, a un taux d''engagement de 80 ÷ 2 000 = 4 %. Compare tes publications entre elles plutôt qu''à des chiffres trouvés sur Internet, qui varient beaucoup selon les secteurs et les pays.

## Où trouver les statistiques ?

- **Meta Business Suite** (application mobile et site web, gratuit) : les statistiques de la page Facebook et du compte Instagram, publication par publication, avec la portée, l''engagement, les clics et l''évolution des abonnés. On y trouve aussi les informations sur le **public** : âge, genre, villes.
- **TikTok** : les statistiques sont disponibles avec un compte professionnel (gratuit).
- **WhatsApp Business** : les statistiques des messages sont très limitées. Le meilleur outil reste ton propre suivi, grâce aux étiquettes.

## Relier les publications aux ventes

Les plateformes ne savent pas qui a acheté chez toi : c''est à toi de faire le lien.

- **Demande** systématiquement à chaque nouvelle cliente : « Comment nous avez-vous connus ? » (Facebook, statut WhatsApp, TikTok, bouche-à-oreille, passage devant la boutique).
- Utilise des **codes promo différents** selon le canal (« FB10 » sur Facebook, « TIK10 » sur TikTok).
- Tiens un **tableau de suivi** des ventes :

| Date | Cliente | Produit | Montant | Source | Publication liée |
| --- | --- | --- | --- | --- | --- |
| 03/11 | Mariam | Karité 250 g | 3 500 | Facebook | Vidéo cheveux du 01/11 |
| 04/11 | Aché | Savon x3 | 4 500 | Statut WhatsApp | Promo savons |

## Analyser et décider

Une fois par mois, Zénaba prend 30 minutes pour analyser :

1. **Les 3 meilleures publications** du mois (en messages et ventes générés, pas seulement en mentions « J''aime ») : qu''ont-elles en commun ? Format, sujet, heure, ton ?
2. **Les 3 moins bonnes** : pourquoi n''ont-elles pas marché ?
3. **Les canaux** qui apportent le plus de ventes.
4. **Les décisions** pour le mois suivant : faire plus de ce qui marche, arrêter ou modifier ce qui ne marche pas, tester une nouveauté.

> **Astuce** : ne change qu''**une seule chose à la fois** (l''heure de publication, ou le format, ou le type d''accroche) pour savoir ce qui a réellement fait la différence. C''est le principe du **test A/B**.

## La publicité payante, avec prudence

Les réseaux permettent de **booster** une publication ou de créer une publicité pour toucher plus de monde, ciblé par zone géographique, âge et centres d''intérêt. Quelques règles pour débuter :

- commence par booster une publication qui **marche déjà bien** naturellement ;
- cible **précisément** : par exemple, femmes de 20 à 45 ans à N''Djamena et dans un rayon limité ;
- choisis un objectif de **messages** WhatsApp ou Messenger plutôt que de simples « J''aime » ;
- teste avec un **petit budget** sur quelques jours, puis compare le coût par message et le nombre de ventes obtenues ;
- vérifie le **mode de paiement** accepté par la plateforme (carte bancaire ou autre solution disponible depuis le Tchad).

Le calcul qui compte : si une publicité coûte 10 000 FCFA et rapporte 8 ventes avec 1 500 FCFA de bénéfice chacune, elle a rapporté 12 000 FCFA de bénéfice, soit 2 000 FCFA de plus que son coût. Elle est rentable, de peu.

> **Attention** : n''achète jamais de faux abonnés ou de faux « J''aime ». Ils n''achètent rien, faussent tes statistiques et réduisent la visibilité de tes vraies publications.

## À toi de jouer

Voici les statistiques d''un mois de Zénaba :

| Publication | Portée | Réactions et commentaires | Messages WhatsApp | Ventes |
| --- | --- | --- | --- | --- |
| Photo promo savons | 1 800 | 45 | 6 | 3 |
| Vidéo cheveux en saison sèche | 6 500 | 380 | 31 | 14 |
| Témoignage cliente | 2 200 | 150 | 9 | 5 |
| Photo boutique | 900 | 20 | 1 | 0 |

1. Calcule le taux d''engagement de chaque publication.
2. Calcule, pour chacune, le taux de conversion des messages en ventes.
3. Quelle publication est la plus efficace ? Que conseilles-tu à Zénaba pour le mois prochain ?
4. Fixe-lui deux objectifs précis, chiffrés et datés.
5. Construis ton propre tableau de suivi des ventes avec la colonne Source, et utilise-le pendant un mois.

> **Réponses des étapes 1 à 3** : taux d''engagement : 2,5 % ; 5,8 % ; 6,8 % ; 2,2 %. Conversion messages vers ventes : 50 % ; 45 % ; 56 % ; 0 %. La vidéo est de loin la plus efficace en volume (14 ventes) ; le témoignage convertit très bien. Conseil : produire plus de vidéos de conseils et de témoignages, et en booster une avec un petit budget.

## Vérifie tes acquis

1. Pourquoi le nombre d''abonnés n''est-il pas un bon objectif à lui seul ?
2. Comment calcule-t-on le taux d''engagement ?
3. Comment savoir de quel réseau viennent les ventes ?

> **Réponses** : 1. Parce que des abonnés qui n''achètent pas ne rapportent rien ; ce qui compte, ce sont les messages et les ventes. 2. En divisant l''engagement (réactions, commentaires, partages) par la portée. 3. En demandant aux clients comment ils ont connu le commerce, avec des codes promo par canal et un tableau de suivi.

## En résumé

- Des objectifs **précis, chiffrés et datés**, centrés sur les messages et les ventes.
- Indicateurs clés : **portée**, **engagement**, **clics**, **messages**, **ventes** : un entonnoir.
- **Meta Business Suite** donne les statistiques ; ton **tableau de suivi** relie les publications aux ventes.
- Chaque mois : analyser les meilleures et les moins bonnes publications, décider, tester une seule chose à la fois.
- La **publicité** se teste avec un petit budget, un ciblage précis et un calcul de rentabilité.

## Pour aller plus loin

- Demande au mentor IA : « Analyse mes statistiques du mois : [colle tes chiffres]. Quelles décisions me conseilles-tu ? »'
WHERE t.slug = 'marketing-digital-reseaux-sociaux' AND l.title = 'Suivre ses résultats simplement';


-- =====================================================================
-- Informatique Bancaire & Finance Numérique (informatique-bancaire)
-- =====================================================================
UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Modules, écritures comptables, fin de journée et écosystème du système bancaire central.', l.duration_minutes = 30, l.content = 'Quand une cliente dépose 200 000 FCFA à son agence de Moundou, le montant apparaît instantanément sur son compte, consultable depuis l''agence de N''Djamena, l''application mobile ou un guichet automatique. Derrière cette simplicité se trouve le **core banking system** (système bancaire central) : le logiciel au cœur de toute banque, qui tient les comptes de tous les clients et enregistre chaque opération. Les informaticiens qui le maîtrisent sont très recherchés par les banques et les établissements de microfinance.

Dans ce parcours, tu suis **Mahamat**, jeune ingénieur recruté à la direction des systèmes d''information d''une banque commerciale de N''Djamena.

> **Objectifs de ce chapitre**
> - Comprendre le rôle d''un core banking system
> - Connaître ses principaux modules
> - Comprendre le traitement de fin de journée
> - Identifier les systèmes qui gravitent autour du core banking
> - Connaître les grands éditeurs et les métiers associés

## Le rôle du core banking

Le core banking est le **registre central** de la banque. Il :

- gère la **fiche de chaque client** et ses **comptes** ;
- enregistre **chaque opération** : dépôts, retraits, virements, frais, intérêts ;
- calcule les **soldes** en temps réel ;
- produit la **comptabilité** de la banque ;
- applique les **règles** : plafonds, frais, taux, autorisations.

Le mot « central » est important : toutes les agences et tous les canaux (guichet, distributeurs, application mobile, agents) consultent et mettent à jour **le même système**, en temps réel. Avant les systèmes centralisés, chaque agence tenait ses propres comptes et les rapprochements prenaient des jours.

## Les principaux modules

| Module | Rôle | Exemple |
| --- | --- | --- |
| **Clients** (CIF, fiche client unique) | Identité, documents, profil de risque | Création de la fiche d''Achta avec sa pièce d''identité |
| **Comptes** | Comptes courants, d''épargne, à terme | Ouverture d''un compte d''épargne |
| **Opérations de guichet** | Dépôts, retraits, change | Retrait de 50 000 FCFA au guichet |
| **Virements et paiements** | Virements internes, nationaux, internationaux | Paiement d''un fournisseur au Cameroun |
| **Crédits** | Demandes, déblocage, échéanciers, remboursements, impayés | Prêt de 2 000 000 FCFA sur 24 mois |
| **Comptabilité générale** | Écritures comptables, grand livre | Enregistrement automatique de chaque opération en débit et crédit |
| **Reporting** | États pour la direction et le régulateur | Rapport mensuel des crédits en souffrance |

> **Info** : chaque opération du core banking produit des **écritures comptables** en partie double : un compte est débité, un autre est crédité du même montant. Un retrait de 50 000 FCFA débite le compte du client et crédite la caisse de l''agence. C''est ce qui garantit que la banque est toujours « équilibrée ».

## Le traitement de fin de journée

Chaque soir, après la fermeture des agences, le core banking lance un ensemble de traitements automatiques appelé **fin de journée** (*End Of Day*, EOD) ou **batch** :

1. Clôture des caisses des agences.
2. Calcul et comptabilisation des **intérêts** courus sur les comptes et les crédits.
3. Prélèvement des **frais** de tenue de compte et des échéances de prêts.
4. Classement des crédits **impayés** selon leur retard.
5. Production des **états** et des fichiers d''échange avec d''autres systèmes.
6. Changement de la **date comptable** au jour suivant.

Le batch est une opération critique : s''il échoue, les agences ne peuvent pas ouvrir normalement le lendemain. Les équipes informatiques le surveillent de près, souvent la nuit, avec des **sauvegardes** avant et après.

> **Attention** : on ne modifie jamais directement les données du core banking dans la base de données pour « corriger » un solde. Toute correction passe par une **opération** tracée et validée dans l''application, avec l''écriture comptable correspondante. Une modification directe fausserait la comptabilité et constituerait une faute grave.

## L''écosystème autour du core banking

Le core banking ne travaille pas seul. Il échange en permanence avec de nombreux systèmes :

| Système | Rôle |
| --- | --- |
| **Monétique** | Cartes bancaires, distributeurs automatiques (GAB), terminaux de paiement |
| **Banque digitale** | Application mobile, banque en ligne, notifications SMS |
| **Mobile money** | Transferts entre comptes bancaires et portefeuilles mobile money |
| **SWIFT** | Messages des virements internationaux |
| **Systèmes interbancaires régionaux** | Échanges entre banques de la zone CEMAC, compensation et règlement |
| **Lutte contre le blanchiment** (LCB-FT) | Filtrage des noms sur les listes de sanctions, détection des opérations suspectes |
| **Reporting réglementaire** | États transmis à la BEAC et à la COBAC |
| **Gestion électronique des documents** | Numérisation des pièces d''identité et des contrats |

Toutes ces liaisons passent par des **interfaces** : fichiers échangés à heure fixe, API, files de messages. Une grande partie du travail des informaticiens bancaires consiste à faire fonctionner et à surveiller ces interfaces.

## Les grands éditeurs

Peu de banques développent leur propre core banking : elles achètent un progiciel et le paramètrent. Parmi les éditeurs présents en Afrique : **Temenos** (Transact, anciennement T24), **Oracle** (FLEXCUBE), **Sopra Banking Software** (Amplitude), ainsi que des éditeurs spécialisés dans la microfinance. Les concepts restent les mêmes d''un produit à l''autre.

## Les métiers

- **Administrateur fonctionnel** du core banking : paramètre les produits (frais, taux), gère les habilitations, assiste les utilisateurs.
- **Ingénieur d''exploitation** : surveille les traitements de nuit et les interfaces.
- **Développeur et intégrateur** : interfaces, rapports, API, application mobile.
- **Analyste reporting** : produit les états réglementaires et de gestion, souvent en SQL.
- **Chef de projet** : migrations de système, nouveaux produits, mises en conformité.

## À toi de jouer

1. Dessine le schéma de l''écosystème du core banking de la banque de Mahamat : le core banking au centre, et au moins six systèmes connectés, avec la nature des échanges.
2. Décris toutes les étapes, et les écritures comptables simplifiées, d''un dépôt de 200 000 FCFA au guichet de Moundou.
3. Classe les traitements de fin de journée par ordre logique et explique ce qui se passerait si le calcul des intérêts n''était pas effectué une nuit.
4. Un agent te demande de « modifier directement le solde d''un client dans la base » pour corriger une erreur de saisie. Rédige ta réponse et la bonne procédure.

> **Éléments de correction pour l''étape 2** : le caissier vérifie l''identité, saisit l''opération, compte les espèces ; le core banking crédite le compte de la cliente et débite le compte de caisse de l''agence de 200 000 FCFA ; le solde est immédiatement visible dans toutes les agences et sur l''application ; un reçu est remis, et éventuellement un SMS envoyé.

## Vérifie tes acquis

1. Pourquoi dit-on que le core banking est « central » ?
2. Que se passe-t-il pendant la fin de journée ?
3. Pourquoi ne jamais modifier directement un solde dans la base de données ?

> **Réponses** : 1. Parce que toutes les agences et tous les canaux utilisent le même système, en temps réel. 2. Clôture des caisses, calcul des intérêts, prélèvement des frais et échéances, classement des impayés, production des états et changement de date comptable. 3. Parce que cela fausserait la comptabilité et contournerait la traçabilité et les contrôles : toute correction doit passer par une opération tracée.

## En résumé

- Le **core banking** est le registre central : clients, comptes, opérations, comptabilité.
- Modules : clients, comptes, guichet, virements, crédits, comptabilité générale, reporting.
- Chaque opération produit des **écritures comptables** en partie double.
- La **fin de journée** (batch) calcule intérêts et frais et change la date comptable.
- Le core banking est relié à la monétique, au mobile money, à SWIFT, à la LCB-FT et au reporting réglementaire.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi la comptabilité en partie double avec 5 exemples d''opérations bancaires. »'
WHERE t.slug = 'informatique-bancaire' AND l.title = 'Qu''est-ce qu''un système core banking ?';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Profils d''habilitation, séparation des tâches, quatre yeux, comptes à privilèges et sécurité des clients.', l.duration_minutes = 30, l.content = 'Dans une banque, la menace ne vient pas seulement de l''extérieur. Un agent qui crée un faux client et lui accorde un prêt, un employé qui consulte par curiosité le compte d''un ministre, un compte d''administrateur partagé entre plusieurs techniciens : beaucoup de fraudes bancaires viennent de l''**intérieur**. La sécurité des accès et des transactions est donc au cœur du métier de Mahamat.

> **Objectifs de ce chapitre**
> - Appliquer le principe du moindre privilège avec des profils d''habilitation
> - Mettre en place la séparation des tâches et le contrôle à quatre yeux
> - Gérer le cycle de vie des comptes utilisateurs
> - Protéger les comptes à privilèges
> - Sécuriser les transactions des clients sur les canaux numériques

## Le moindre privilège et les profils

Chaque utilisateur ne doit avoir accès qu''aux **fonctions strictement nécessaires** à son poste. Dans le core banking, on crée des **profils d''habilitation** par métier plutôt que d''attribuer des droits individuellement :

| Profil | Droits principaux | Interdits |
| --- | --- | --- |
| Caissier | Dépôts, retraits dans la limite de son plafond, consultation des soldes | Création de clients, crédits |
| Chargé de clientèle | Création et mise à jour des clients, ouverture de comptes | Opérations de caisse |
| Analyste crédit | Montage des dossiers de crédit | Validation finale de ses propres dossiers |
| Chef d''agence | Validations au-delà des plafonds | Paramétrage du système |
| Administrateur fonctionnel | Paramétrage des produits et des profils | Opérations sur les comptes des clients |

> **Info** : on parle de **contrôle d''accès basé sur les rôles** (RBAC). Quand un employé change de poste, on change son profil, et ses anciens droits disparaissent automatiquement.

## La séparation des tâches et les quatre yeux

La **séparation des tâches** interdit qu''une même personne puisse réaliser seule une opération sensible de bout en bout. Exemple : la personne qui **saisit** un virement important ne peut pas être celle qui le **valide**.

Le **contrôle à quatre yeux** (ou double validation) en est l''application : une opération sensible est saisie par un premier utilisateur, puis vérifiée et autorisée par un second, dans le système.

Opérations typiquement soumises aux quatre yeux :

- virements au-delà d''un certain montant ;
- déblocage d''un crédit ;
- modification des coordonnées d''un client (téléphone, adresse), car c''est une étape classique des fraudes ;
- annulation d''une opération ;
- modification du paramétrage (taux, frais, plafonds).

> **Attention** : la double validation ne sert à rien si le valideur clique sans regarder, ou si deux collègues se « prêtent » leurs codes. La sensibilisation et le contrôle régulier des validations sont indispensables.

## Le cycle de vie des comptes utilisateurs

| Étape | Bonne pratique |
| --- | --- |
| **Arrivée** | Compte créé sur demande écrite du responsable hiérarchique, avec le profil du poste |
| **Changement de poste** | Ancien profil retiré, nouveau profil attribué, jamais un cumul |
| **Absence longue** | Compte suspendu |
| **Départ** | Compte désactivé **le jour même**, accès distants compris |
| **Revue périodique** | Chaque trimestre, les responsables confirment la liste de leurs collaborateurs et de leurs droits |

Les **comptes partagés** (« guichet1 » utilisé par plusieurs caissiers) sont interdits : chaque action doit pouvoir être attribuée à une personne précise.

## Les comptes à privilèges

Les administrateurs des serveurs, des bases de données et du réseau disposent de droits très étendus. Ces **comptes à privilèges** sont la cible favorite des attaquants. Mesures essentielles :

- des **comptes nominatifs** pour chaque administrateur, distincts de leur compte de travail quotidien ;
- l''**authentification à deux facteurs** obligatoire ;
- un **coffre-fort** de mots de passe pour les comptes techniques, avec des mots de passe changés régulièrement ;
- l''**enregistrement** des sessions d''administration (solutions de gestion des accès à privilèges, PAM) ;
- l''accès aux serveurs uniquement depuis des **postes d''administration** dédiés.

## Sécuriser les transactions des clients

Pour la banque en ligne, l''application mobile et les cartes :

- **Authentification forte** du client : mot de passe ou code, plus un second facteur (code envoyé par SMS, application, biométrie du téléphone).
- **Confirmation** des opérations sensibles (ajout d''un bénéficiaire, gros virement) par un second facteur.
- **Plafonds** par opération et par jour, que le client peut parfois ajuster.
- **Notifications** en temps réel par SMS ou dans l''application pour chaque opération : le client détecte lui-même une opération qu''il n''a pas faite.
- **Chiffrement** des échanges (HTTPS, TLS) et protection de l''application contre la modification.
- **Surveillance anti-fraude** : détection des comportements inhabituels (connexion depuis un nouvel appareil suivie d''un gros virement, opérations à 3 h du matin).

> **Astuce** : la notification SMS de chaque opération est l''une des mesures les plus efficaces et les moins coûteuses contre la fraude : le client devient un détecteur. Assure-toi que le numéro de téléphone du client ne peut pas être modifié sans contrôle à quatre yeux.

## À toi de jouer

1. Construis la **matrice des habilitations** d''une agence : en lignes les profils (caissier, chargé de clientèle, analyste crédit, chef d''agence, contrôleur interne), en colonnes une dizaine de fonctions du core banking, avec pour chaque case : Saisir, Valider, Consulter ou Aucun accès.
2. Repère dans ta matrice les **conflits** de séparation des tâches à éviter.
3. Rédige la **procédure de départ** d''un employé, étape par étape, avec les responsables de chaque étape.
4. Un fraudeur a convaincu un agent de changer le numéro de téléphone d''un client, puis a vidé son compte via l''application mobile. Quelles mesures auraient permis d''éviter ou de détecter cette fraude ?

> **Éléments de correction pour l''étape 4** : contrôle à quatre yeux et vérification d''identité renforcée pour tout changement de numéro ; notification envoyée à l''ancien numéro lors du changement ; délai de sécurité ou plafonds réduits après un changement de numéro ou d''appareil ; surveillance anti-fraude des virements inhabituels ; revue des modifications sensibles par le contrôle interne.

## Vérifie tes acquis

1. Qu''est-ce que le contrôle à quatre yeux ?
2. Pourquoi les comptes partagés sont-ils interdits ?
3. Quand faut-il désactiver le compte d''un employé qui quitte la banque ?

> **Réponses** : 1. Une opération sensible est saisie par une personne puis validée par une seconde dans le système. 2. Parce qu''on ne peut plus attribuer chaque action à une personne précise. 3. Le jour même de son départ, y compris ses accès à distance.

## En résumé

- **Moindre privilège** : des profils d''habilitation par métier (RBAC).
- **Séparation des tâches** et **quatre yeux** pour les opérations sensibles, dont les changements de coordonnées.
- Un **cycle de vie** des comptes maîtrisé, des revues périodiques, aucun compte partagé.
- Les **comptes à privilèges** sont nominatifs, protégés par 2FA, enregistrés et gérés dans un coffre-fort.
- Côté clients : authentification forte, plafonds, **notifications** et surveillance anti-fraude.

## Pour aller plus loin

- Demande au mentor IA : « Aide-moi à construire une matrice de séparation des tâches pour le processus de crédit d''une banque. »'
WHERE t.slug = 'informatique-bancaire' AND l.title = 'Sécuriser les accès et les transactions';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Autorités, exigences prudentielles, reporting, LCB-FT et impact sur les systèmes.', l.duration_minutes = 30, l.content = 'Une banque ne peut pas faire ce qu''elle veut : elle manipule l''argent des déposants et participe au financement de l''économie. Dans les six pays de la CEMAC (Cameroun, Centrafrique, Congo, Gabon, Guinée équatoriale et Tchad), les banques et les établissements de microfinance sont encadrés par des autorités régionales. Pour l''informaticien bancaire, la **conformité** n''est pas qu''une affaire de juristes : une grande partie des exigences se traduisent directement dans les systèmes d''information.

> **Objectifs de ce chapitre**
> - Connaître le rôle de la BEAC et de la COBAC
> - Comprendre les grandes familles d''exigences réglementaires
> - Comprendre la lutte contre le blanchiment et le financement du terrorisme
> - Identifier l''impact de la réglementation sur les systèmes d''information
> - Comprendre le rôle de la fonction conformité et du contrôle interne

> **Attention** : ce chapitre présente les grands principes. Les textes réglementaires évoluent et sont précis : en situation professionnelle, réfère-toi toujours aux règlements en vigueur et à la direction de la conformité de ton établissement.

## Les autorités

| Autorité | Rôle |
| --- | --- |
| **BEAC** (Banque des États de l''Afrique Centrale) | Banque centrale commune : émet le franc CFA d''Afrique centrale (XAF), conduit la politique monétaire, organise et supervise les systèmes de paiement |
| **COBAC** (Commission Bancaire de l''Afrique Centrale) | Superviseur bancaire régional : agrée et contrôle les banques et établissements de microfinance, édicte des règlements prudentiels, peut sanctionner |
| **Autorités nationales** | Le ministère des Finances, et pour la lutte contre le blanchiment une cellule de renseignement financier nationale qui reçoit les déclarations de soupçon |
| **GABAC** (Groupe d''Action contre le Blanchiment d''Argent en Afrique Centrale) | Organisme régional qui coordonne la lutte contre le blanchiment et le financement du terrorisme |

## Les grandes familles d''exigences

### Les règles prudentielles

Elles visent la **solidité** des établissements : niveau minimal de fonds propres, ratios de solvabilité et de liquidité, limitation des risques concentrés sur un seul client ou un seul secteur, classement et provisionnement des créances en souffrance. Le système d''information doit produire **automatiquement et de façon fiable** les données nécessaires au calcul de ces ratios.

### Le reporting réglementaire

Les établissements transmettent périodiquement au régulateur des **états** normalisés : situation comptable, ratios, crédits, risques. Ces états sont produits à partir du core banking selon le **plan comptable** applicable aux établissements de la zone. Une erreur de paramétrage comptable devient une erreur dans les états réglementaires.

### Le contrôle interne et la gestion des risques

Les établissements doivent disposer d''un dispositif de **contrôle interne**, avec des contrôles permanents et périodiques, une fonction **conformité** et une **gestion des risques** couvrant aussi les risques opérationnels et informatiques : continuité d''activité, sécurité des systèmes, externalisation.

### La protection des clients

Transparence des tarifs, information sur les conditions des crédits, traitement des réclamations, confidentialité des données (secret bancaire).

## La lutte contre le blanchiment et le financement du terrorisme

Le **blanchiment** consiste à faire paraître légal de l''argent issu d''activités criminelles (corruption, trafics). Le **financement du terrorisme** peut utiliser de l''argent d''origine légale ou illégale. Les établissements financiers sont en première ligne : on parle de **LCB-FT**.

Leurs obligations principales :

1. **Connaître son client** (KYC) : vérifier l''identité, l''adresse, l''activité, l''origine des fonds, et mettre à jour ces informations.
2. **Évaluer le risque** de chaque client : risque plus élevé pour certaines activités, certains pays ou les **personnes politiquement exposées** (PPE), par exemple de hauts responsables publics et leurs proches.
3. **Filtrer** les clients et les opérations sur les **listes de sanctions** (Nations unies et autres listes applicables).
4. **Surveiller les opérations** et repérer celles qui sont inhabituelles ou incohérentes avec le profil du client.
5. **Déclarer les soupçons** à la cellule de renseignement financier, sans en informer le client.
6. **Conserver** les documents et l''historique des opérations pendant la durée réglementaire.

> **Info** : un exemple de scénario de surveillance : un client déclaré comme petit commerçant, avec habituellement 300 000 FCFA de mouvements par mois, reçoit soudainement 15 virements de l''étranger pour un total de 40 000 000 FCFA, immédiatement retirés en espèces. Le système doit générer une **alerte** analysée par la conformité.

## L''impact sur les systèmes d''information

La réglementation se traduit en exigences très concrètes pour l''informatique :

| Exigence | Traduction dans les systèmes |
| --- | --- |
| KYC | Champs obligatoires dans la fiche client, numérisation des pièces, alertes sur les dossiers incomplets ou expirés |
| Filtrage des sanctions | Outil de filtrage connecté au core banking et aux virements, listes mises à jour automatiquement |
| Surveillance des opérations | Scénarios de détection paramétrés, gestion des alertes, traçabilité de leur traitement |
| Reporting | Requêtes et états fiables, contrôles de cohérence, historique des versions |
| Conservation | Archivage des données et documents pendant la durée exigée, avec possibilité de les retrouver |
| Continuité | Sauvegardes, site de secours, plans de reprise testés |
| Sécurité | Habilitations, journalisation, protection des données |

## La fonction conformité et le rôle de l''informaticien

La **direction de la conformité** veille au respect des règles et traite les alertes LCB-FT. L''**audit interne** vérifie périodiquement l''efficacité du dispositif. L''informaticien bancaire :

- **paramètre** et **maintient** les outils (filtrage, scénarios, reporting) ;
- **fournit** des extractions fiables aux équipes conformité et audit ;
- **garantit** la traçabilité et l''intégrité des données ;
- **alerte** quand une évolution du système risque d''affecter la conformité.

> **Astuce** : quand tu développes un nouveau produit ou un nouveau canal (par exemple l''ouverture de compte en ligne), associe la conformité **dès le début** du projet. Ajouter les contrôles à la fin coûte toujours plus cher, et peut retarder un lancement.

## À toi de jouer

1. Résume en un tableau le rôle de la BEAC, de la COBAC, du GABAC et de la cellule nationale de renseignement financier.
2. Liste les champs obligatoires de la fiche client d''une banque pour satisfaire le KYC, en distinguant particulier et entreprise.
3. Propose trois **scénarios de surveillance** LCB-FT adaptés à une banque tchadienne, avec pour chacun le seuil et la période.
4. La banque lance l''ouverture de compte depuis l''application mobile. Liste les exigences de conformité à intégrer dans le projet et leur traduction technique.

> **Exemples de scénarios pour l''étape 3** : dépôts en espèces fractionnés juste sous un seuil de déclaration sur une courte période ; activité d''un compte sans commune mesure avec le profil déclaré du client ; virements vers ou depuis des pays à haut risque ; compte dormant soudain réactivé avec de gros mouvements.

## Vérifie tes acquis

1. Quel est le rôle principal de la COBAC ?
2. Que signifie KYC et pourquoi est-ce important ?
3. Un employé doit-il prévenir le client lorsqu''une déclaration de soupçon est faite ?

> **Réponses** : 1. Agréer et superviser les banques et établissements de microfinance de la CEMAC, édicter des règles prudentielles et sanctionner. 2. *Know Your Customer*, connaître son client : c''est la base de la lutte contre le blanchiment et la fraude. 3. Non, il est interdit d''en informer le client.

## En résumé

- **BEAC** (banque centrale, systèmes de paiement) et **COBAC** (supervision bancaire) encadrent les établissements de la CEMAC.
- Exigences : règles **prudentielles**, **reporting**, **contrôle interne**, protection des clients.
- **LCB-FT** : KYC, évaluation du risque, filtrage des sanctions, surveillance, déclaration de soupçon, conservation.
- Chaque exigence se traduit dans les **systèmes d''information**.
- L''informaticien travaille main dans la main avec la **conformité**, dès le début des projets.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi les trois étapes du blanchiment d''argent (placement, empilement, intégration) avec des exemples. »'
WHERE t.slug = 'informatique-bancaire' AND l.title = 'Notions de conformité BEAC/COBAC';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Événements à tracer, contenu des journaux, intégrité, SIEM et enquêtes.', l.duration_minutes = 30, l.content = 'Un client conteste un retrait de 500 000 FCFA effectué sur son compte il y a trois mois. Qui a saisi l''opération ? Depuis quel poste ? Qui l''a validée ? À quelle heure exacte ? Le plafond a-t-il été modifié juste avant ? Pour répondre, la banque doit pouvoir **retrouver la trace** de chaque action dans ses systèmes. C''est le rôle de la **journalisation** : enregistrer qui fait quoi, quand et d''où, de façon fiable et inaltérable.

> **Objectifs de ce chapitre**
> - Comprendre à quoi servent les journaux dans une banque
> - Savoir quels événements enregistrer et quelles informations y mettre
> - Garantir l''intégrité et la conservation des journaux
> - Centraliser et analyser les journaux
> - Utiliser les journaux lors d''une enquête

## À quoi servent les journaux ?

- **Prouver** : en cas de litige avec un client, de fraude ou de contrôle du régulateur.
- **Détecter** : repérer une attaque ou un comportement anormal, idéalement pendant qu''il se produit.
- **Comprendre** : reconstituer le déroulement d''un incident pour corriger et éviter qu''il se reproduise.
- **Dissuader** : un employé qui sait que ses actions sont tracées hésite davantage à frauder.

## Quels événements enregistrer ?

| Domaine | Événements |
| --- | --- |
| **Authentification** | Connexions réussies et échouées, déconnexions, verrouillages de compte |
| **Habilitations** | Création, modification et suppression de comptes utilisateurs et de profils |
| **Opérations sensibles** | Saisie, validation, annulation des transactions ; dépassements de plafond |
| **Données clients** | Modification des coordonnées, consultation de comptes sensibles (personnalités, employés) |
| **Paramétrage** | Changement des taux, frais, plafonds, règles |
| **Administration technique** | Accès aux serveurs et bases de données, commandes d''administration, modifications de configuration |
| **Sécurité** | Alertes antivirus, blocages du pare-feu, tentatives d''accès refusées |

## Le contenu d''une ligne de journal

Une bonne entrée de journal répond aux questions **qui, quoi, quand, où, sur quoi, avec quel résultat** :

```text
2026-10-08T14:32:07+01:00 | utilisateur=a.mahamat | profil=CAISSIER | poste=AG-MOU-G03 | ip=10.20.3.17
action=RETRAIT | compte=0012****4589 | montant=500000 XAF | reference=TRX-88412 | resultat=EN_ATTENTE_VALIDATION
```

- **L''horodatage** précis, avec le fuseau horaire.
- **L''identité** de l''utilisateur (nominative, jamais un compte partagé).
- **Le poste** ou l''adresse IP d''origine.
- **L''action** et **l''objet** concerné.
- **Le résultat** : réussi, refusé, en attente.

> **Attention** : ne journalise jamais de **mots de passe**, de **codes PIN** ni de numéros de carte complets. Masque les données sensibles (`0012****4589`). Un journal qui contient des secrets devient lui-même une cible.

## La synchronisation des horloges

Pour reconstituer un incident à partir des journaux de plusieurs systèmes (core banking, serveur d''application mobile, pare-feu), il faut que leurs horloges soient **synchronisées**. Tous les serveurs se règlent sur une même source de temps grâce au protocole **NTP**. Un décalage de quelques minutes entre deux serveurs suffit à rendre une enquête très difficile.

## Intégrité et conservation

Un journal n''a de valeur que s''il est **fiable**. Un administrateur malveillant ne doit pas pouvoir effacer la trace de ses propres actions.

- **Envoyer les journaux en temps réel vers un serveur central** dédié, administré par une équipe différente de celle des systèmes surveillés.
- **Protéger contre la modification** : droits d''écriture seulement en ajout, stockage non modifiable, empreintes cryptographiques qui permettent de détecter toute altération.
- **Conserver** les journaux pendant la durée exigée par la réglementation et la politique de l''établissement, avec des **sauvegardes**.
- **Contrôler l''accès** aux journaux eux-mêmes, et journaliser ces accès.

> **Info** : la durée de conservation dépend du type de journal et des exigences applicables. Elle est fixée par la politique de l''établissement, en lien avec la conformité et la réglementation. Les journaux d''opérations doivent souvent être conservés plusieurs années.

## Centraliser et analyser : le SIEM

Avec des millions d''événements par jour, impossible de tout lire. Les banques utilisent un **SIEM** (*Security Information and Event Management*), un outil qui :

- **collecte** et centralise les journaux de tous les systèmes ;
- **corrèle** les événements de sources différentes ;
- déclenche des **alertes** selon des règles ;
- permet des **recherches** rapides lors d''une enquête.

Exemples de règles d''alerte :

- plus de 5 connexions échouées sur un même compte en 10 minutes ;
- connexion d''un utilisateur en dehors de ses horaires habituels, ou depuis deux agences différentes à quelques minutes d''intervalle ;
- consultation d''un grand nombre de comptes clients par un même employé en peu de temps ;
- création d''un compte administrateur en dehors de la procédure ;
- désactivation de la journalisation sur un serveur.

Des solutions commerciales et libres existent (par exemple **Wazuh** ou la suite **Elastic**). L''essentiel est que quelqu''un **traite réellement** les alertes : un SIEM dont personne ne regarde les alertes n''apporte rien.

## Mener une enquête avec les journaux

Reprenons le retrait contesté de 500 000 FCFA :

1. **Identifier** l''opération dans le core banking : référence, date, montant.
2. **Retrouver** dans les journaux qui l''a saisie, depuis quel poste, et qui l''a validée.
3. **Vérifier** les événements autour : modification récente des coordonnées du client ? changement de plafond ? connexions inhabituelles de l''utilisateur ?
4. **Croiser** avec les autres sources : vidéosurveillance de l''agence à l''heure exacte, signature sur le bordereau, journaux de l''application mobile.
5. **Conserver les preuves** : extraire et sécuriser les journaux concernés pour une éventuelle procédure.
6. **Rédiger** un rapport factuel, chronologique, avec les sources de chaque élément.

## À toi de jouer

1. Liste les 15 événements à journaliser en priorité dans le core banking de la banque de Mahamat, avec les informations à enregistrer pour chacun.
2. Écris 3 exemples de lignes de journal (connexion échouée, modification de plafond, consultation d''un compte sensible) en masquant les données sensibles.
3. Propose 5 règles d''alerte pour le SIEM, avec le seuil et l''action attendue de l''équipe de sécurité.
4. Rédige la procédure d''enquête pour une contestation de virement depuis l''application mobile.

> **Pour t''auto-évaluer** : pour chacune de tes règles d''alerte, demande-toi qui la reçoit, en combien de temps elle doit être traitée et quelle est la première action. Une alerte sans responsable ni action définie ne sert à rien.

## Vérifie tes acquis

1. À quelles questions doit répondre une entrée de journal ?
2. Pourquoi faut-il synchroniser les horloges des serveurs ?
3. Pourquoi envoyer les journaux vers un serveur central géré par une autre équipe ?

> **Réponses** : 1. Qui, quoi, quand, où, sur quoi et avec quel résultat. 2. Pour pouvoir reconstituer précisément la chronologie d''un incident à partir de plusieurs systèmes. 3. Pour éviter qu''un administrateur malveillant puisse effacer ou modifier la trace de ses propres actions.

## En résumé

- Les journaux servent à **prouver**, **détecter**, **comprendre** et **dissuader**.
- On trace authentification, habilitations, opérations sensibles, données clients, paramétrage et administration.
- Une entrée de journal dit **qui, quoi, quand, où, sur quoi, avec quel résultat**, sans jamais de secret en clair.
- Horloges synchronisées (**NTP**), journaux **centralisés**, **protégés** contre la modification et **conservés**.
- Un **SIEM** corrèle et alerte ; une enquête croise journaux et autres preuves.

## Pour aller plus loin

- Demande au mentor IA : « Comment installer Wazuh pour centraliser les journaux de quelques serveurs Linux ? »'
WHERE t.slug = 'informatique-bancaire' AND l.title = 'Traçabilité et journalisation';


-- =====================================================================
-- Télécom & Opérateurs Mobiles (telecom-operateurs)
-- =====================================================================
UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Accès radio, transmission, cœur de réseau, générations, SIM, fréquences et défis du terrain.', l.duration_minutes = 30, l.content = 'Quand tu appelles ta famille depuis N''Djamena vers Sarh, ta voix parcourt en une fraction de seconde des antennes, des liaisons hertziennes ou en fibre, des centres de commutation et des serveurs. Comprendre ce chemin est la base de tous les métiers des télécoms : ingénieur radio, technicien de maintenance des sites, ingénieur transmission, ingénieur cœur de réseau, superviseur NOC.

Dans ce parcours, tu suis **Brahim**, jeune ingénieur qui vient d''intégrer la direction technique d''un opérateur mobile tchadien.

> **Objectifs de ce chapitre**
> - Comprendre l''architecture d''un réseau mobile : accès radio, transmission, cœur de réseau
> - Connaître le principe des cellules et du handover
> - Comparer les générations 2G, 3G, 4G et 5G
> - Comprendre le rôle des fréquences et de la carte SIM
> - Connaître les défis du déploiement au Tchad

## Les trois grandes parties du réseau

| Partie | Rôle | Éléments |
| --- | --- | --- |
| **Réseau d''accès radio** | Relier les téléphones au réseau par ondes radio | Antennes et stations de base sur les pylônes (sites) |
| **Réseau de transmission** (*backhaul*) | Relier les sites entre eux et au cœur de réseau | Faisceaux hertziens, fibre optique, parfois satellite |
| **Cœur de réseau** | Gérer les abonnés, établir les appels et les sessions data, relier aux autres réseaux et à Internet | Serveurs et commutateurs dans les centres techniques |

## Les cellules

Le territoire est découpé en **cellules** : la zone couverte par une antenne. Un **site** (un pylône) porte souvent trois antennes orientées dans des directions différentes, donc trois cellules, ou **secteurs**.

- En ville, les cellules sont **petites** et nombreuses : beaucoup d''utilisateurs se partagent la capacité.
- En zone rurale, elles sont **grandes** pour couvrir de vastes espaces avec peu de sites.

Quand tu te déplaces pendant un appel, ton téléphone passe d''une cellule à l''autre sans coupure : c''est le **handover** (transfert intercellulaire).

> **Info** : la capacité d''une cellule est **partagée**. C''est pourquoi l''Internet mobile ralentit à l''heure de pointe dans un marché ou un stade : des centaines de personnes se partagent la même antenne.

## Les générations

| Génération | Apport principal | Débits typiques | Équipement radio |
| --- | --- | --- | --- |
| **2G** (GSM) | Appels et SMS numériques ; data très lente (GPRS, EDGE) | Quelques dizaines de kbit/s | BTS |
| **3G** (UMTS) | Internet mobile utilisable | Quelques Mbit/s | NodeB |
| **4G** (LTE) | Internet mobile rapide, tout en IP | Plusieurs dizaines de Mbit/s | eNodeB |
| **5G** | Très hauts débits, latence très faible, objets connectés massifs | Centaines de Mbit/s et plus | gNodeB |

Les générations **coexistent** : la 2G reste essentielle pour la voix, les SMS et l''USSD (donc le mobile money) sur les téléphones simples et dans les zones rurales ; la 4G porte l''essentiel de l''Internet mobile dans les villes.

## Le cœur de réseau

Le cœur de réseau :

- **identifie et authentifie** les abonnés grâce à la carte SIM et à la base des abonnés (HLR en 2G/3G, HSS en 4G, UDM en 5G) ;
- **localise** les abonnés pour pouvoir leur acheminer les appels ;
- **établit** les appels et les sessions data ;
- **relie** le réseau aux autres opérateurs (interconnexion), à l''international et à Internet ;
- **collecte** les informations de consommation pour la facturation.

En 4G, le cœur de réseau s''appelle **EPC** (*Evolved Packet Core*) ; en 5G, le **5GC**, construit sur des fonctions logicielles.

## La carte SIM

La **carte SIM** contient l''identité de l''abonné (l''**IMSI**) et une **clé secrète** partagée avec le réseau. À chaque connexion, le réseau envoie une question que seule une SIM authentique peut résoudre avec cette clé : c''est l''**authentification**. La clé ne circule jamais sur les ondes. Le numéro de téléphone (le **MSISDN**) est associé à l''IMSI dans la base des abonnés.

> **Attention** : c''est pour cette raison que la fraude au changement de carte SIM est si grave : le fraudeur obtient une SIM authentique associée au numéro de la victime. L''enregistrement et la vérification d''identité lors des remplacements de SIM sont des contrôles essentiels pour l''opérateur.

## Les fréquences

Les ondes radio utilisent des **bandes de fréquences**, ressource rare attribuée par l''État à chaque opérateur via le régulateur. Règle générale :

- les **basses fréquences** (par exemple autour de 800 ou 900 MHz) portent **loin** et traversent bien les murs : idéales pour couvrir les zones rurales ;
- les **hautes fréquences** (1 800 MHz, 2 600 MHz, 3,5 GHz) offrent **plus de capacité** mais portent moins loin : idéales en ville.

## Les défis du terrain au Tchad

- **Un territoire immense** et peu densément peuplé : couvrir les zones rurales coûte cher pour peu d''abonnés.
- **L''énergie** : beaucoup de sites ne sont pas raccordés au réseau électrique. Ils fonctionnent avec des **groupes électrogènes**, des **panneaux solaires** et des **batteries**, dont la maintenance et l''approvisionnement en carburant sont un enjeu majeur.
- **La chaleur et le sable** : les équipements doivent être protégés, refroidis et nettoyés.
- **La transmission** : la fibre optique se déploie progressivement ; de nombreux sites sont reliés par faisceaux hertziens, et les plus isolés parfois par satellite.
- **La sécurité** des sites et du carburant.

## À toi de jouer

1. Dessine le schéma du trajet d''un appel entre deux abonnés du même opérateur, l''un à N''Djamena, l''autre à Sarh, en nommant chaque partie du réseau traversée.
2. Explique pourquoi un opérateur utiliserait la bande 800 MHz pour couvrir une zone rurale et la bande 1 800 MHz en centre-ville.
3. Un village se plaint : « On capte le réseau mais Internet est inutilisable le soir. » Propose deux hypothèses et la vérification à faire pour chacune.
4. Liste les équipements d''un site rural alimenté sans réseau électrique et les tâches de maintenance régulières associées.

> **Éléments de correction pour l''étape 3** : saturation de la cellule aux heures de pointe (vérifier le taux d''utilisation de la cellule le soir) ; capacité insuffisante de la transmission du site, par exemple un faisceau hertzien de faible débit (vérifier l''occupation du lien de transmission). On peut aussi soupçonner une couverture seulement 2G dans le village.

## Vérifie tes acquis

1. Quelles sont les trois grandes parties d''un réseau mobile ?
2. Qu''est-ce que le handover ?
3. Pourquoi la 2G reste-t-elle importante au Tchad ?

> **Réponses** : 1. Le réseau d''accès radio, le réseau de transmission et le cœur de réseau. 2. Le passage d''une cellule à une autre sans coupure pendant un appel ou une session. 3. Parce qu''elle porte la voix, les SMS et l''USSD (donc le mobile money) sur tous les téléphones, y compris en zone rurale.

## En résumé

- Un réseau mobile = **accès radio** + **transmission** + **cœur de réseau**.
- Le territoire est découpé en **cellules** ; le **handover** assure la continuité.
- 2G, 3G, 4G et 5G **coexistent**, chacune avec ses usages.
- La **SIM** authentifie l''abonné grâce à une clé secrète ; les **fréquences** sont attribuées par l''État.
- Au Tchad : grandes distances, énergie hors réseau, chaleur et transmission sont les défis majeurs.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi la différence entre un faisceau hertzien et une liaison en fibre optique pour relier des sites mobiles. »'
WHERE t.slug = 'telecom-operateurs' AND l.title = 'Comment fonctionne un réseau mobile (2G à 5G) ?';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Alarmes, cycle de vie des incidents, escalade, indicateurs de qualité et changements.', l.duration_minutes = 30, l.content = 'Il est 2 h du matin. Un site de la périphérie de N''Djamena vient de tomber en panne, et des milliers d''abonnés n''ont plus de réseau. Dans une salle remplie d''écrans, une alarme rouge s''affiche. L''équipe de nuit du **NOC** (*Network Operations Center*, centre de supervision réseau) doit comprendre ce qui se passe, agir, prévenir les bonnes personnes et faire revenir le service le plus vite possible. Le NOC est le poste de pilotage de l''opérateur, ouvert 24 heures sur 24, 7 jours sur 7.

> **Objectifs de ce chapitre**
> - Comprendre les missions d''un NOC
> - Gérer les alarmes : niveaux de gravité, corrélation, priorisation
> - Suivre le cycle de vie d''un incident et l''escalade
> - Connaître les indicateurs de qualité du réseau
> - Distinguer incident et changement planifié

## Les missions du NOC

- **Surveiller** en permanence l''état du réseau : sites, transmission, cœur de réseau, plateformes de services.
- **Détecter** les pannes et les dégradations, idéalement avant que les clients ne s''en plaignent.
- **Diagnostiquer** et résoudre à distance ce qui peut l''être (redémarrage d''un équipement, bascule sur un lien de secours).
- **Dépêcher** les équipes de terrain quand une intervention physique est nécessaire.
- **Escalader** vers les experts et les fournisseurs quand le problème dépasse le premier niveau.
- **Informer** le service client, la direction et parfois les partenaires.
- **Suivre** les indicateurs de qualité et produire des rapports.

## Les alarmes

Chaque équipement envoie des **alarmes** au système de supervision (**NMS**, *Network Management System*). Elles sont classées par gravité :

| Gravité | Signification | Exemple |
| --- | --- | --- |
| **Critique** | Service interrompu pour des clients | Site hors service, lien de transmission coupé |
| **Majeure** | Service fortement dégradé ou risque imminent | Batteries du site en décharge, plus que 2 heures d''autonomie |
| **Mineure** | Dégradation limitée | Une des trois cellules d''un site indisponible |
| **Avertissement** | À surveiller | Température élevée dans le local technique |

Un même problème génère souvent **beaucoup d''alarmes** : si un lien de transmission tombe, tous les sites qui en dépendent remontent une alarme. Le NOC doit identifier la **cause racine** (le lien) plutôt que de traiter vingt alarmes séparées. Les outils modernes font une partie de cette **corrélation** automatiquement.

> **Info** : au Tchad, une grande partie des alarmes des sites concerne l''**énergie** : coupure du réseau électrique, groupe électrogène en panne ou à court de carburant, batteries faibles. Anticiper ces alarmes (surveillance du niveau de carburant, de l''état des batteries) évite de nombreuses coupures.

## Le cycle de vie d''un incident

1. **Détection** : une alarme apparaît, ou un client signale un problème.
2. **Enregistrement** : un **ticket** est créé avec l''heure, la zone et l''impact.
3. **Qualification** : quel est l''impact (nombre d''abonnés, services touchés) ? Quelle priorité ?
4. **Diagnostic et action** : tests à distance, puis intervention à distance ou envoi d''une équipe.
5. **Escalade** si le délai ou la complexité le demande.
6. **Résolution** : le service est rétabli, on vérifie que les indicateurs sont revenus à la normale.
7. **Clôture** : le ticket est complété avec la cause et la solution.
8. **Analyse** : pour les incidents majeurs, une analyse post-incident identifie la cause racine et les actions pour éviter qu''il se reproduise.

## L''escalade

L''**escalade** fait intervenir un niveau supérieur de compétence ou de décision :

- **escalade fonctionnelle** : vers une équipe plus experte (niveau 1 du NOC, puis niveau 2 des ingénieurs spécialisés, puis niveau 3 du fournisseur d''équipement) ;
- **escalade hiérarchique** : vers les responsables, pour les incidents qui ont un fort impact ou qui durent.

Une **matrice d''escalade** écrite précise qui appeler, quand et pour quel type d''incident. Par exemple : site critique hors service depuis plus d''une heure, on prévient le responsable régional ; cœur de réseau touché, on prévient immédiatement la direction technique.

> **Attention** : pendant un incident majeur, la **communication** est aussi importante que la technique. Le service client doit savoir quoi répondre aux abonnés, et la direction doit recevoir des points réguliers, même quand il n''y a pas encore de solution.

## Les indicateurs de qualité

Le NOC suit des **indicateurs clés** (KPI) :

| Indicateur | Signification |
| --- | --- |
| **Disponibilité des sites** | Pourcentage du temps où les sites sont en service |
| **Taux de succès d''établissement des appels** | Part des tentatives d''appel qui aboutissent |
| **Taux de coupure d''appels** | Part des appels interrompus anormalement |
| **Taux de succès des sessions data** | Part des connexions Internet réussies |
| **Débit moyen** | Vitesse moyenne de l''Internet mobile |
| **MTTR** (*Mean Time To Repair*) | Temps moyen de rétablissement après une panne |

Ces indicateurs servent à piloter l''amélioration du réseau, et certains font l''objet d''exigences de qualité de service fixées par le régulateur.

## Incidents et changements planifiés

Toute intervention **planifiée** sur le réseau (mise à jour logicielle, remplacement d''un équipement, extension) suit une procédure de **gestion des changements** : demande, évaluation des risques, validation, planification dans une fenêtre de faible trafic (souvent la nuit), plan de retour arrière, information du NOC. Sans cela, le NOC risque de traiter comme une panne ce qui est en réalité une intervention, ou une intervention mal préparée peut provoquer une panne majeure.

## À toi de jouer

1. Classe ces alarmes par gravité et par ordre de priorité de traitement : température élevée sur un site rural ; lien de transmission coupé alimentant 12 sites ; une cellule hors service sur un site urbain ; batteries d''un site à 20 % avec groupe électrogène en panne.
2. Pour le lien de transmission coupé, décris les étapes du cycle de vie de l''incident, de la détection à l''analyse post-incident.
3. Rédige la matrice d''escalade d''un NOC : types d''incidents, délais, personnes à prévenir.
4. Rédige le message d''information au service client pour une coupure touchant trois quartiers de N''Djamena.

> **Éléments de correction pour l''étape 1** : priorité 1, le lien coupé (critique, 12 sites touchés) ; priorité 2, les batteries à 20 % sans groupe (majeure : le site va tomber, il faut envoyer une équipe tout de suite) ; priorité 3, la cellule hors service (mineure) ; priorité 4, la température (avertissement, à surveiller).

## Vérifie tes acquis

1. Pourquoi faut-il chercher la cause racine quand de nombreuses alarmes apparaissent en même temps ?
2. Que signifie MTTR ?
3. Pourquoi une intervention planifiée doit-elle être signalée au NOC ?

> **Réponses** : 1. Parce qu''un seul problème (un lien coupé) peut générer de nombreuses alarmes ; le résoudre règle toutes les autres. 2. *Mean Time To Repair*, le temps moyen de rétablissement après une panne. 3. Pour que le NOC ne la traite pas comme un incident et puisse réagir si elle se passe mal.

## En résumé

- Le **NOC** surveille le réseau 24 h/24, détecte, diagnostique, dépêche, escalade et informe.
- Les **alarmes** sont classées par gravité ; la **corrélation** identifie la cause racine.
- Chaque incident suit un **cycle de vie** tracé dans un ticket, jusqu''à l''analyse post-incident.
- Une **matrice d''escalade** et une bonne **communication** sont indispensables.
- Les **KPI** (disponibilité, coupures, MTTR…) pilotent la qualité ; les changements planifiés suivent une procédure.

## Pour aller plus loin

- Demande au mentor IA : « Propose-moi un modèle de rapport post-incident pour une coupure réseau majeure. »'
WHERE t.slug = 'telecom-operateurs' AND l.title = 'Le rôle du NOC (supervision réseau)';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'OCS, chaîne des CDR, revenue assurance, catalogue d''offres, provisioning et CRM.', l.duration_minutes = 30, l.content = 'Quand tu actives un forfait internet de 1 Go par USSD, ton solde est débité, le forfait s''active en quelques secondes, un SMS te le confirme, et chaque mégaoctet consommé est décompté. Derrière cette expérience se cachent les **systèmes informatiques de l''opérateur**, regroupés en deux familles : les **BSS**, tournés vers le client et le commerce, et les **OSS**, tournés vers le réseau. Ce sont des domaines riches en emplois pour les informaticiens.

> **Objectifs de ce chapitre**
> - Distinguer BSS et OSS
> - Comprendre la facturation en temps réel du prépayé
> - Suivre la chaîne de la consommation à la facturation
> - Comprendre le provisioning d''un service
> - Connaître le rôle du CRM et de la gestion du catalogue d''offres

## BSS et OSS

| Famille | Signification | Rôle | Exemples |
| --- | --- | --- | --- |
| **BSS** | *Business Support Systems* | Tout ce qui concerne le **client** et le **commerce** | Catalogue d''offres, facturation, CRM, gestion des commandes, recouvrement, distribution |
| **OSS** | *Operations Support Systems* | Tout ce qui concerne le **réseau** | Supervision, inventaire du réseau, gestion des incidents et des changements, gestion des performances |

Les deux sont reliés : quand un client souscrit une offre dans le BSS, le réseau doit être configuré pour lui fournir le service.

## Le prépayé et la facturation en temps réel

Au Tchad, comme dans la plupart des pays africains, la grande majorité des abonnés sont en **prépayé** : ils rechargent du crédit et le consomment. Il faut donc vérifier **avant et pendant** chaque usage que le client dispose d''un solde suffisant. C''est le rôle de l''**OCS** (*Online Charging System*, système de taxation en ligne) :

1. Le client lance un appel.
2. Le cœur de réseau interroge l''OCS : « Ce client peut-il appeler, et combien de temps ? »
3. L''OCS vérifie le solde, applique le **tarif** (destination, heure, forfait en cours) et **réserve** un crédit correspondant à quelques minutes.
4. Pendant l''appel, la réservation est renouvelée et décomptée.
5. Si le solde est épuisé, l''OCS demande la coupure de l''appel.
6. À la fin, l''OCS débite la consommation réelle et libère le reste.

Tout cela se passe en quelques millisecondes, des millions de fois par jour. L''OCS est donc un système **critique** : s''il tombe, plus personne ne peut appeler ni naviguer.

> **Info** : le même mécanisme s''applique à la data : l''OCS accorde des « tranches » de mégaoctets, décomptées du forfait ou du crédit principal.

## La chaîne de la consommation

Pour les usages facturés après coup (abonnés postpayés, entreprises, interconnexion avec les autres opérateurs, roaming), on suit une chaîne en plusieurs étapes :

1. **Collecte** : les équipements du réseau produisent des **CDR** (*Call Detail Records*), des enregistrements de chaque appel, SMS ou session data (numéros, date, durée, volume, cellule).
2. **Médiation** : un système collecte les CDR de tous les équipements, les vérifie, élimine les doublons et les met dans un format commun.
3. **Valorisation** (*rating*) : chaque événement reçoit un prix selon l''offre du client.
4. **Facturation** (*billing*) : les montants sont regroupés en factures, avec remises et taxes.
5. **Recouvrement** : suivi des paiements, relances, suspension en cas d''impayé.

> **Attention** : une erreur à n''importe quelle étape fait perdre de l''argent à l''opérateur ou facture à tort des clients. C''est pourquoi les opérateurs ont des équipes de **revenue assurance** (assurance des revenus) qui comparent les données de chaque étape pour détecter les **fuites de revenus**, par exemple des CDR perdus en médiation ou une offre mal paramétrée.

## Le catalogue d''offres

Les équipes marketing créent constamment de nouvelles offres : forfaits jour, semaine, mois, forfaits nuit, bonus de recharge, forfaits réseaux sociaux. Le **catalogue de produits** du BSS décrit chaque offre : prix, durée de validité, volumes, conditions, règles de priorité entre plusieurs forfaits actifs.

Le paramétrage d''une nouvelle offre est une opération délicate : il faut la **tester** dans un environnement de préproduction avant le lancement. Un forfait mal paramétré (validité infinie, volume illimité par erreur) peut coûter très cher en quelques heures.

## Le provisioning

Le **provisioning** est l''activation technique d''un service dans le réseau après une commande commerciale. Exemples :

- activation d''une nouvelle carte SIM : enregistrement de l''IMSI et du numéro dans la base des abonnés, avec les services autorisés ;
- activation de l''Internet mobile ou du roaming ;
- changement d''offre ;
- suspension d''une ligne volée.

Un système de **gestion des commandes** orchestre ces actions automatiquement entre le BSS et les équipements du réseau.

## Le CRM et la relation client

Le **CRM** (*Customer Relationship Management*) regroupe les informations sur chaque client : identité (enregistrement obligatoire des cartes SIM), offres souscrites, historique des interactions avec le service client, réclamations. Il est utilisé par les conseillers des agences et du centre d''appels, et alimente les campagnes marketing (par exemple, proposer un forfait adapté à un client qui consomme beaucoup de data).

## À toi de jouer

1. Classe ces systèmes en BSS ou OSS : OCS, supervision des sites, CRM, inventaire des équipements réseau, médiation, gestion des tickets d''incident, catalogue d''offres, gestion des performances radio.
2. Décris étape par étape ce qui se passe dans les systèmes quand un client achète par USSD un forfait internet de 1 Go à 1 000 FCFA, puis navigue.
3. Le marketing veut lancer un « forfait nuit » : 2 Go utilisables de minuit à 6 h, valable 1 jour. Liste les paramètres à définir dans le catalogue et les tests à réaliser avant le lancement.
4. L''équipe revenue assurance constate que le nombre de CDR data en sortie de médiation est inférieur de 3 % à celui des équipements réseau. Quelles hypothèses formules-tu et quelles vérifications proposes-tu ?

> **Éléments de correction pour l''étape 4** : des fichiers de CDR perdus ou rejetés en médiation (vérifier les fichiers en erreur), un équipement mal configuré dont les CDR ne sont pas collectés, une règle de dédoublonnage trop large. On compare les volumes équipement par équipement et heure par heure pour localiser l''écart.

## Vérifie tes acquis

1. Quelle est la différence entre BSS et OSS ?
2. Pourquoi l''OCS est-il un système critique ?
3. Qu''est-ce qu''un CDR ?

> **Réponses** : 1. Les BSS concernent le client et le commerce (offres, facturation, CRM), les OSS concernent l''exploitation du réseau. 2. Parce qu''il autorise et décompte en temps réel chaque appel et chaque session des clients prépayés : s''il tombe, les services s''arrêtent. 3. Un enregistrement détaillé d''un appel, d''un SMS ou d''une session data produit par le réseau.

## En résumé

- **BSS** : client et commerce ; **OSS** : réseau et exploitation.
- Le **prépayé** repose sur l''**OCS**, qui autorise et décompte en temps réel.
- La chaîne **CDR → médiation → valorisation → facturation → recouvrement** ; la **revenue assurance** traque les fuites.
- Le **catalogue d''offres** se paramètre et se teste avec soin.
- Le **provisioning** active les services dans le réseau ; le **CRM** gère la relation client.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi le rôle de la revenue assurance chez un opérateur avec trois exemples de fuites de revenus. »'
WHERE t.slug = 'telecom-operateurs' AND l.title = 'BSS/OSS : facturation et gestion des abonnés';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Architecture de la plateforme, disponibilité, réseau d''agents, intégrations, sécurité et réconciliation.', l.duration_minutes = 30, l.content = 'Pour l''abonné, le mobile money se résume à un menu USSD et quelques SMS. Pour l''opérateur et sa filiale de services financiers, c''est une activité complète, avec une plateforme informatique critique, un réseau de milliers d''agents, des partenaires bancaires, des obligations réglementaires strictes et une surveillance permanente de la fraude. Brahim rejoint l''équipe technique de la plateforme mobile money : voici ce qu''il découvre.

> **Objectifs de ce chapitre**
> - Comprendre l''architecture technique d''une plateforme mobile money
> - Comprendre la gestion du réseau d''agents et de la liquidité
> - Connaître les intégrations avec les partenaires
> - Comprendre les exigences de disponibilité et de sécurité
> - Connaître les obligations de conformité et la réconciliation

## L''architecture technique

| Composant | Rôle |
| --- | --- |
| **Passerelle USSD** | Reçoit les sessions USSD du réseau et les transmet à la plateforme ; renvoie les menus |
| **Plateforme mobile money** (le cœur) | Tient les comptes de monnaie électronique (portefeuilles), exécute les transactions, applique les règles (plafonds, frais, commissions) |
| **Passerelle SMS** | Envoie les confirmations de transaction |
| **Application mobile** et **API** | Canaux pour les smartphones et pour les partenaires (marchands, banques, agrégateurs) |
| **Module de gestion des agents** | Hiérarchie des distributeurs et agents, commissions |
| **Outils de lutte contre la fraude et LCB-FT** | Surveillance des transactions, alertes |
| **Entrepôt de données** et reporting | Analyses, états réglementaires |

La plateforme est **distincte** de la facturation télécom : l''argent électronique n''est pas du crédit téléphonique. Les deux systèmes communiquent seulement pour certains usages, comme l''achat de crédit avec son portefeuille mobile money.

> **Info** : chaque transaction est **atomique** : le débit d''un portefeuille et le crédit de l''autre se font ensemble, ou pas du tout. Une transaction à moitié exécutée, où l''argent quitte un compte sans arriver dans l''autre, est l''un des pires incidents possibles.

## La disponibilité, une exigence vitale

Pour des millions de personnes, le mobile money est **le** moyen de payer et de recevoir de l''argent. Une panne de quelques heures bloque des salaires, des achats de médicaments, des envois familiaux. La plateforme est donc conçue pour une très haute disponibilité :

- serveurs et bases de données **redondants**, avec bascule automatique ;
- **site de secours** capable de reprendre l''activité ;
- **supervision** permanente (temps de réponse, taux de transactions réussies, files d''attente de la passerelle USSD) ;
- mises à jour planifiées la nuit, testées et accompagnées d''un plan de retour arrière.

## La gestion du réseau d''agents

Le réseau d''agents est organisé en hiérarchie : **super-distributeurs**, **distributeurs**, **agents**. La plateforme gère :

- la **création** et la vérification des agents ;
- leurs **plafonds** et leurs droits ;
- le calcul et le versement des **commissions** ;
- les **transferts de float** entre niveaux de la hiérarchie.

La **liquidité** est un sujet central : chaque agent doit disposer d''assez d''espèces et de float pour servir ses clients. L''opérateur suit les niveaux de float des agents, repère ceux qui en manquent et organise le rééquilibrage, notamment dans les zones rurales éloignées des banques. Un agent sans liquidité, c''est un client qui ne peut pas retirer son argent.

## Les intégrations avec les partenaires

La plateforme est reliée à de nombreux partenaires, le plus souvent par **API** :

- **banques** : transferts entre comptes bancaires et portefeuilles, et compte de cantonnement ;
- **facturiers** : sociétés d''électricité et d''eau, bouquets TV, écoles, impôts ;
- **marchands** et **agrégateurs de paiement** ;
- **transferts internationaux** avec des partenaires de transfert d''argent ;
- **interopérabilité** avec les autres opérateurs et les systèmes interbancaires régionaux.

Chaque intégration suit un processus : contrat, spécifications techniques, environnement de test, recette, mise en production, puis **supervision** du flux et réconciliation régulière.

## La sécurité

- **Authentification** des clients par code PIN, jamais stocké en clair, avec blocage après plusieurs erreurs.
- **Chiffrement** des échanges avec les partenaires et protection des API (identifiants, signatures, listes d''adresses autorisées).
- **Séparation des tâches** et **double validation** pour les opérations internes sensibles : ajustement de solde, création de monnaie électronique contre dépôt bancaire, modification des tarifs.
- **Contrôle du changement de SIM** : blocage temporaire des opérations mobile money après un remplacement de carte SIM.
- **Journalisation** complète de toutes les actions, y compris celles des administrateurs.

> **Attention** : la **création de monnaie électronique** doit toujours correspondre à un dépôt réel sur le compte de cantonnement. Elle fait l''objet des contrôles les plus stricts : double validation, rapprochement quotidien avec le relevé bancaire, audit.

## Conformité et réconciliation

En tant qu''activité de services de paiement, le mobile money est encadré par la réglementation de la zone CEMAC, sous la supervision de la **BEAC** et de la **COBAC**. Cela implique notamment :

- l''**identification des clients** (KYC) et des plafonds selon le niveau d''identification ;
- la **lutte contre le blanchiment** : surveillance des transactions, déclarations de soupçon ;
- la **protection des fonds** des clients sur le compte de cantonnement ;
- des **rapports réguliers** au régulateur.

La **réconciliation** quotidienne est indispensable : la somme de tous les portefeuilles (clients, agents, marchands) doit correspondre exactement aux fonds conservés sur le compte de cantonnement. Les transactions avec chaque partenaire sont aussi rapprochées chaque jour, et tout écart est investigué.

## À toi de jouer

1. Dessine l''architecture de la plateforme mobile money, avec ses composants et ses partenaires, et indique les flux d''une transaction de paiement de facture d''électricité.
2. Liste 5 indicateurs que le NOC doit superviser en permanence sur la plateforme, avec un seuil d''alerte pour chacun.
3. Un incident technique a provoqué 120 transactions débitées chez l''expéditeur mais non créditées chez le destinataire. Rédige le plan d''action : détection, correction, communication aux clients, prévention.
4. Explique en 5 lignes pourquoi la réconciliation quotidienne entre portefeuilles et compte de cantonnement est indispensable.

> **Éléments de correction pour l''étape 3** : identifier précisément les transactions concernées dans les journaux ; corriger par des opérations tracées et doublement validées (crédit des destinataires ou remboursement des expéditeurs) ; informer les clients par SMS et le service client ; analyser la cause racine (atomicité non respectée, délai d''attente entre deux systèmes) et corriger le logiciel ; renforcer la supervision des transactions incomplètes.

## Vérifie tes acquis

1. Pourquoi une transaction mobile money doit-elle être atomique ?
2. Pourquoi bloque-t-on temporairement le mobile money après un changement de SIM ?
3. Que doit-on vérifier chaque jour lors de la réconciliation avec le compte de cantonnement ?

> **Réponses** : 1. Pour que l''argent ne puisse jamais quitter un compte sans arriver dans l''autre : débit et crédit se font ensemble ou pas du tout. 2. Pour limiter la fraude au changement de SIM, qui permet à un fraudeur de prendre le contrôle du compte de la victime. 3. Que la somme de tous les portefeuilles correspond exactement aux fonds réels conservés sur le compte de cantonnement.

## En résumé

- La plateforme comprend passerelles USSD et SMS, cœur transactionnel, API, gestion des agents, anti-fraude et reporting.
- Les transactions sont **atomiques** ; la **disponibilité** est vitale : redondance, site de secours, supervision.
- La gestion du **réseau d''agents** et de la **liquidité** conditionne le service aux clients.
- De nombreuses **intégrations** par API relient banques, facturiers, marchands et partenaires.
- Sécurité stricte, conformité **BEAC/COBAC** et **réconciliation** quotidienne protègent l''argent des clients.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi comment fonctionne une transaction atomique dans une base de données, avec un exemple de transfert d''argent. »'
WHERE t.slug = 'telecom-operateurs' AND l.title = 'Mobile money côté opérateur';


-- =====================================================================
-- Régulation & Conformité Numérique (regulation-conformite-numerique)
-- =====================================================================
UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Pourquoi réguler, rôle de l''ARCEP, missions, outils et autres acteurs du numérique.', l.duration_minutes = 30, l.content = 'Pourquoi un opérateur ne peut-il pas utiliser n''importe quelle fréquence radio ? Qui décide du prix auquel deux opérateurs s''échangent les appels ? Qui vérifie que le réseau mobile offre une qualité de service correcte, ou qu''un téléphone importé ne brouille pas les autres ? Dans le secteur des communications électroniques, ces questions relèvent d''une **autorité de régulation**. Au Tchad, c''est l''**ARCEP** (Autorité de Régulation des Communications Électroniques et des Postes).

Dans ce parcours, tu suis **Hawa**, ingénieure télécom qui rejoint une direction technique chargée de la régulation, et qui découvre ce métier à la frontière de la technique, du droit et de l''économie.

> **Objectifs de ce chapitre**
> - Comprendre pourquoi les télécommunications sont régulées
> - Distinguer le rôle de l''État, du régulateur et des opérateurs
> - Connaître les grandes missions d''un régulateur des communications électroniques
> - Comprendre les principaux outils de régulation
> - Connaître les autres acteurs de la régulation du numérique

> **Attention** : ce parcours présente des principes généraux. Les textes législatifs et réglementaires, ainsi que l''organisation exacte des institutions, évoluent : en situation professionnelle, réfère-toi toujours aux textes en vigueur publiés officiellement.

## Pourquoi réguler ?

Le secteur des télécommunications présente des caractéristiques particulières :

- **Des ressources rares** : les fréquences radio et les numéros de téléphone sont limités et appartiennent au domaine public.
- **Des coûts d''entrée énormes** : construire un réseau national coûte très cher, ce qui limite naturellement le nombre d''acteurs et peut créer des positions dominantes.
- **Des effets de réseau** : un opérateur doit pouvoir joindre les clients des autres, ce qui impose l''**interconnexion**.
- **Un service essentiel** : les communications sont indispensables à l''économie, à la sécurité et à la vie sociale, y compris dans les zones peu rentables.

Sans régulation, on risquerait des prix excessifs, une concurrence faussée, des brouillages entre réseaux et des zones entières laissées sans service.

## Qui fait quoi ?

| Acteur | Rôle |
| --- | --- |
| **Le Parlement et le Gouvernement** | Votent et prennent les lois et décrets ; définissent la politique sectorielle (le ministère chargé des télécommunications et du numérique) |
| **Le régulateur** (ARCEP) | Met en œuvre et fait respecter le cadre légal de façon technique et indépendante ; contrôle ; règle les différends ; peut sanctionner |
| **Les opérateurs et fournisseurs** | Exploitent les réseaux et services dans le respect de leurs obligations |
| **Les consommateurs** | Bénéficient des services ; peuvent porter réclamation |

Le principe d''un régulateur **indépendant** est de séparer la fonction de contrôle de celle d''opérateur ou d''actionnaire, que l''État exerce parfois aussi, pour garantir l''équité entre tous les acteurs.

## Les grandes missions

| Mission | Exemples |
| --- | --- |
| **Attribution des autorisations** | Instruire les dossiers de licences et d''autorisations, en lien avec le Gouvernement |
| **Gestion du spectre** | Assigner les fréquences, contrôler leur bon usage, lutter contre les brouillages |
| **Gestion de la numérotation** | Attribuer les blocs de numéros, les codes courts et les codes USSD |
| **Interconnexion** | Encadrer les conditions et les tarifs d''échange de trafic entre opérateurs |
| **Concurrence** | Identifier les opérateurs puissants sur un marché et leur imposer des obligations |
| **Qualité de service** | Fixer des exigences, mesurer et publier les résultats |
| **Protection des consommateurs** | Transparence tarifaire, traitement des réclamations, identification des abonnés |
| **Homologation** | Vérifier la conformité des équipements radio et terminaux mis sur le marché |
| **Service universel** | Contribuer à étendre la couverture aux zones non rentables |
| **Règlement des différends** | Trancher les litiges entre opérateurs |
| **Contrôle et sanction** | Enquêter, mettre en demeure, sanctionner les manquements |

> **Info** : un exemple concret de mission technique : quand une radio FM ou un réseau mobile se plaint de brouillages, les équipes de contrôle du spectre se déplacent avec des appareils de mesure pour localiser l''émetteur perturbateur et faire cesser le brouillage.

## Les outils du régulateur

- **Les décisions** : actes juridiques qui s''imposent aux opérateurs (attribution de fréquences, encadrement d''un tarif d''interconnexion).
- **Les consultations publiques** : avant une décision importante, le régulateur publie un projet et recueille l''avis des acteurs.
- **Les enquêtes et mesures** : campagnes de mesure de la qualité de service, collecte de données auprès des opérateurs.
- **Les indicateurs de marché** : nombre d''abonnés, trafic, revenus, prix, publiés dans des observatoires.
- **Les audits et contrôles** sur place.
- **Les sanctions** : avertissements, mises en demeure, amendes, et dans les cas graves suspension ou retrait d''autorisation.

## Les autres acteurs de la régulation du numérique

Le numérique ne se limite pas aux réseaux. Au Tchad comme ailleurs, plusieurs institutions interviennent selon les sujets :

- une agence chargée de la **sécurité des systèmes d''information** et de la **certification électronique** : au Tchad, l''**ANSICE** (Agence Nationale de Sécurité Informatique et de Certification Électronique) ;
- l''autorité compétente en matière de **protection des données personnelles** ;
- pour les **services financiers numériques**, la BEAC et la COBAC ;
- pour l''audiovisuel, l''autorité de régulation des médias ;
- au niveau régional et international : les organisations de la CEMAC et de la CEEAC, l''**UIT** (Union internationale des télécommunications) qui coordonne notamment le spectre à l''échelle mondiale, et les associations de régulateurs africains.

## Les métiers de la régulation

Ingénieur spectre, ingénieur qualité de service, analyste économique des marchés, juriste, auditeur technique, spécialiste de la cybersécurité, chargé de la protection des consommateurs. Les profils techniques capables de dialoguer avec juristes et économistes sont particulièrement recherchés.

## À toi de jouer

1. Recherche le site officiel de l''ARCEP Tchad et relève trois publications récentes (décisions, communiqués, rapports, indicateurs). Pour chacune, indique à quelle mission elle se rattache.
2. Explique en 5 lignes pourquoi les fréquences radio doivent être gérées par une autorité publique.
3. Pour chacune des situations suivantes, indique l''acteur compétent et la mission concernée : un opérateur refuse de connecter les appels d''un nouvel entrant ; des abonnés d''une ville se plaignent d''appels coupés en permanence ; un importateur veut vendre un nouveau modèle de routeur Wi-Fi ; une banque veut lancer un service de paiement mobile.
4. Dessine la carte des institutions qui interviennent dans le numérique au Tchad et leurs relations.

> **Éléments de correction pour l''étape 3** : le régulateur des communications électroniques (interconnexion, règlement des différends) ; le régulateur (qualité de service, contrôle) ; le régulateur (homologation des équipements) ; la BEAC et la COBAC (services de paiement), en lien avec le régulateur des télécoms pour l''accès aux services USSD et SMS.

## Vérifie tes acquis

1. Pourquoi le secteur des télécommunications est-il régulé ?
2. Quelle est la différence entre le rôle du ministère et celui du régulateur ?
3. Cite trois outils dont dispose un régulateur.

> **Réponses** : 1. À cause de ressources rares (fréquences, numéros), de coûts d''entrée élevés qui limitent la concurrence, du besoin d''interconnexion et du caractère essentiel du service. 2. Le ministère définit la politique sectorielle ; le régulateur met en œuvre et fait respecter le cadre de façon technique et indépendante. 3. Par exemple les décisions, les consultations publiques, les campagnes de mesure, les audits et les sanctions.

## En résumé

- Les télécoms sont régulées à cause de **ressources rares**, de **coûts d''entrée** élevés, de l''**interconnexion** et de leur caractère **essentiel**.
- L''État définit la politique, le **régulateur** (ARCEP au Tchad) la met en œuvre de façon indépendante.
- Missions : autorisations, spectre, numérotation, interconnexion, concurrence, qualité de service, consommateurs, homologation, service universel.
- Outils : décisions, consultations, mesures, audits, sanctions.
- D''autres institutions régulent le numérique : sécurité (ANSICE), données personnelles, services financiers, UIT.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi ce qu''est un opérateur puissant sur un marché et quelles obligations un régulateur peut lui imposer. »'
WHERE t.slug = 'regulation-conformite-numerique' AND l.title = 'Qu''est-ce qu''une autorité de régulation (ARCEP) ?';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Régimes d''autorisation, cahier des charges, fréquences, numérotation, homologation et qualité de service.', l.duration_minutes = 30, l.content = 'Une entreprise de N''Djamena veut proposer un accès Internet sans fil aux commerces de la ville. Une autre veut importer des routeurs Wi-Fi. Un opérateur veut ouvrir un nouveau service de messagerie par SMS pour les écoles. Chacune doit se poser la même question : **de quelle autorisation ai-je besoin, et quelles règles techniques dois-je respecter ?** Hawa est chargée d''instruire ce type de dossiers et d''en contrôler la conformité.

> **Objectifs de ce chapitre**
> - Connaître les grands régimes d''autorisation des activités de communications électroniques
> - Comprendre les obligations attachées à une licence
> - Comprendre l''attribution et le contrôle des fréquences et des numéros
> - Connaître le principe de l''homologation des équipements
> - Comprendre les obligations de qualité de service et leur contrôle

> **Info** : les catégories, procédures et montants précis sont fixés par la loi et les textes d''application du pays. Ce chapitre présente la logique générale que l''on retrouve dans la plupart des cadres réglementaires, dont celui du Tchad : vérifie toujours le détail dans les textes en vigueur et auprès du régulateur.

## Les régimes d''autorisation

Plus une activité utilise de ressources rares ou a d''impact, plus le régime est exigeant :

| Régime | Activités typiques | Caractéristiques |
| --- | --- | --- |
| **Licence individuelle** | Réseaux ouverts au public utilisant des fréquences (opérateurs mobiles), réseaux d''infrastructure nationaux | Nombre limité, souvent attribuée par appel d''offres, cahier des charges détaillé, redevances importantes, durée déterminée |
| **Autorisation** | Fournisseurs d''accès Internet, réseaux indépendants, certains services | Délivrée sur dossier à ceux qui remplissent les conditions |
| **Déclaration** | Services à valeur ajoutée, certaines activités à faible impact | Simple déclaration préalable au régulateur |
| **Activité libre** | Réseaux internes sans ressources rares | Aucune formalité particulière, mais respect des règles générales |

## Le cahier des charges

Une licence s''accompagne d''un **cahier des charges** qui fixe les obligations de l''opérateur, par exemple :

- **couverture** : population ou localités à couvrir, avec un calendrier ;
- **qualité de service** : valeurs minimales des indicateurs ;
- **interconnexion** : obligation de connecter les autres réseaux ;
- **identification des abonnés** : enregistrement des cartes SIM ;
- **obligations de défense et de sécurité publique** : notamment les réquisitions légales et la continuité du service ;
- **contributions financières** : redevances, contribution au service universel ;
- **fourniture d''informations** au régulateur : données de trafic, d''abonnés, financières.

Le régulateur contrôle régulièrement le respect de ces obligations ; les manquements peuvent entraîner des sanctions.

## Les fréquences

Le spectre radio est divisé en bandes attribuées à des services (mobile, radiodiffusion, satellite, aéronautique, défense…), en cohérence avec les règles internationales de l''**UIT**. Le régulateur :

- **assigne** à chaque utilisateur des fréquences précises, pour une zone et une puissance données ;
- perçoit des **redevances** d''utilisation ;
- **contrôle** le spectre par des stations et des campagnes de mesure ;
- traite les **brouillages**.

> **Attention** : émettre sur une fréquence sans autorisation, même avec un petit équipement, est une infraction. Les liaisons radio d''une entreprise (talkies-walkies professionnels, faisceaux hertziens) nécessitent une autorisation. Seules certaines bandes, comme celles utilisées par le Wi-Fi, sont d''usage libre sous conditions de puissance.

## La numérotation

Le **plan national de numérotation** organise les numéros du pays : préfixes des opérateurs mobiles, numéros fixes, numéros courts d''urgence, codes USSD, numéros spéciaux. Le régulateur attribue des **blocs de numéros** aux opérateurs et des **numéros courts** ou **codes USSD** aux services (banques, écoles, services publics), et veille à leur bonne utilisation.

## L''homologation des équipements

Avant d''être vendu ou utilisé dans le pays, un équipement radio ou un terminal (téléphone, routeur, émetteur) doit en principe être **homologué**. L''homologation vérifie notamment :

- qu''il respecte les **normes techniques** (bandes de fréquences, puissance d''émission) et ne provoque pas de brouillage ;
- qu''il est **sûr** pour les utilisateurs (sécurité électrique, exposition aux ondes) ;
- qu''il est **compatible** avec les réseaux du pays.

Le dossier comprend généralement les rapports de tests d''un laboratoire reconnu, les déclarations de conformité du fabricant et les caractéristiques techniques.

## La qualité de service

Le régulateur fixe des **indicateurs de qualité de service** (taux de réussite des appels, taux de coupure, qualité de la voix, débits data, délais d''envoi des SMS) et des valeurs minimales. Il les contrôle par :

- les **données transmises** par les opérateurs ;
- des **campagnes de mesure** indépendantes, avec des véhicules équipés de téléphones de test qui parcourent les villes et les routes (*drive tests*), ou des mesures à pied dans les bâtiments ;
- l''analyse des **réclamations** des consommateurs.

Les résultats sont souvent **publiés**, ce qui encourage les opérateurs à s''améliorer.

## Le contrôle de conformité

Contrôler un opérateur ou un fournisseur, c''est comparer ses pratiques aux obligations :

1. **Référentiel** : les obligations applicables (loi, cahier des charges, décisions).
2. **Collecte** : données, documents, visites de sites, mesures.
3. **Constat** : écarts entre les obligations et la réalité.
4. **Procédure contradictoire** : l''opérateur peut répondre et s''expliquer.
5. **Décision** : mise en demeure de corriger dans un délai, puis sanction si nécessaire.

Le chapitre suivant détaille la méthode de l''audit technique.

## À toi de jouer

1. Pour chacun des projets suivants, indique le régime d''autorisation probable et justifie : un opérateur mobile national ; un fournisseur d''accès Internet par Wi-Fi longue portée dans une ville ; un service d''envoi de SMS aux parents d''élèves ; une entreprise qui installe un réseau Wi-Fi dans ses propres bureaux.
2. Rédige la liste des obligations que tu inscrirais dans le cahier des charges d''un nouvel opérateur mobile, en 10 points, avec un indicateur mesurable pour chacun.
3. Prépare la liste des pièces d''un dossier d''homologation pour un modèle de routeur 4G.
4. Conçois une campagne de mesure de la qualité de service dans une ville : indicateurs, parcours, nombre de mesures, période, publication.

> **Éléments de correction pour l''étape 1** : licence individuelle (réseau ouvert au public avec fréquences) ; autorisation, plus une assignation de fréquences si la bande n''est pas libre ; déclaration ou autorisation de service à valeur ajoutée, avec attribution d''un numéro court ; activité libre (réseau interne sur bande Wi-Fi libre, avec un équipement homologué).

## Vérifie tes acquis

1. Pourquoi une licence d''opérateur mobile est-elle plus exigeante qu''une simple déclaration ?
2. Qu''est-ce que l''homologation d''un équipement ?
3. Comment un régulateur mesure-t-il de façon indépendante la qualité de service ?

> **Réponses** : 1. Parce qu''elle donne accès à des ressources rares (fréquences, numéros) et a un fort impact sur le public et la concurrence. 2. La vérification qu''un équipement respecte les normes techniques, de sécurité et de compatibilité avant sa mise sur le marché. 3. Par des campagnes de mesure sur le terrain, notamment des drive tests avec des téléphones de test.

## En résumé

- Les régimes vont de la **licence individuelle** à l''**activité libre**, selon les ressources utilisées et l''impact.
- Un **cahier des charges** fixe couverture, qualité, interconnexion, identification, sécurité et contributions.
- Le régulateur **assigne** et **contrôle** les fréquences, attribue les **numéros** et les codes USSD.
- L''**homologation** vérifie la conformité des équipements.
- La **qualité de service** est mesurée et publiée ; le **contrôle de conformité** suit une procédure contradictoire.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi comment se déroule un drive test et quels indicateurs il mesure. »'
WHERE t.slug = 'regulation-conformite-numerique' AND l.title = 'Licences et conformité technique';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Préparer, collecter des preuves, formuler des constats et recommandations, rapporter et suivre.', l.duration_minutes = 30, l.content = 'Le régulateur a reçu de nombreuses plaintes d''abonnés d''une ville secondaire : appels coupés, Internet très lent, forfaits qui disparaissent plus vite que prévu. Hawa est chargée de mener un **audit technique** pour établir les faits. Un audit n''est ni une impression, ni une accusation : c''est une démarche **méthodique**, fondée sur des **preuves**, qui compare la réalité à un **référentiel** et aboutit à des constats et des recommandations. La même méthode s''applique à un audit de sécurité informatique dans une entreprise ou un audit de conformité dans une banque.

> **Objectifs de ce chapitre**
> - Connaître les étapes d''un audit technique
> - Définir le périmètre, le référentiel et les critères
> - Collecter des preuves fiables
> - Formuler des constats et des recommandations utiles
> - Rédiger un rapport d''audit et assurer le suivi

## Les principes de l''audit

- **Indépendance** : l''auditeur n''audite pas son propre travail et n''a pas d''intérêt dans le résultat.
- **Approche fondée sur les preuves** : chaque constat s''appuie sur des éléments vérifiables.
- **Objectivité** : on décrit les faits, sans jugement sur les personnes.
- **Confidentialité** : les informations recueillies sont protégées.
- **Contradictoire** : l''audité peut répondre aux constats avant la version finale.

## Étape 1 : préparer

### Le périmètre et les objectifs

On précise **ce qui est audité** et **ce qui ne l''est pas** : pour Hawa, la qualité des services voix et data de l''opérateur X dans la ville Y, sur les trois derniers mois, ainsi que l''exactitude du décompte des forfaits data.

### Le référentiel

C''est la **norme de comparaison** : le cahier des charges de l''opérateur, les décisions du régulateur sur la qualité de service, les conditions des offres publiées. Pour un audit de sécurité en entreprise, ce sera par exemple la politique de sécurité interne ou une norme comme l''**ISO/IEC 27001**.

### Le plan d''audit

Il liste les **points de contrôle**, les **méthodes** (mesures, entretiens, analyse de documents, tests), les **données à demander**, le **calendrier** et l''**équipe**. On envoie à l''audité une **lettre de mission** et une **demande de documents** à l''avance.

> **Astuce** : une analyse des données disponibles **avant** la visite (plaintes reçues, indicateurs transmis, résultats de mesures précédentes) permet de cibler les points de contrôle et de gagner beaucoup de temps sur place.

## Étape 2 : collecter les preuves

Les principales techniques :

| Technique | Exemple dans l''audit d''Hawa |
| --- | --- |
| **Mesures** | Campagne de drive tests dans la ville : appels de test, téléchargements, mesures de couverture |
| **Analyse de données** | Indicateurs du NOC de l''opérateur, statistiques de trafic des sites de la ville |
| **Revue documentaire** | Liste des sites et de leur état, tickets d''incidents, rapports de maintenance |
| **Entretiens** | Responsable régional, ingénieurs radio, équipe du NOC |
| **Observation et visite** | Visite de sites : énergie, batteries, état des équipements |
| **Tests** | Achat de forfaits data avec des cartes SIM de test et comparaison entre volume consommé et volume décompté |

Une **preuve fiable** est :

- **pertinente** : elle concerne bien le point de contrôle ;
- **suffisante** : en quantité assez grande pour conclure (un échantillon représentatif, pas un cas isolé) ;
- **traçable** : on sait d''où elle vient, quand et comment elle a été obtenue ;
- **conservée** de façon sécurisée.

> **Attention** : quand tu travailles sur des données d''abonnés (relevés de consommation, tickets de réclamation), respecte strictement la confidentialité et la protection des données personnelles : n''extrais que ce qui est nécessaire, et anonymise autant que possible.

### L''échantillonnage

Impossible de tout vérifier. On choisit un **échantillon** : 30 sites sur 120, 50 réclamations sur 2 000, 20 achats de forfait de test. L''échantillon doit être **représentatif** (différents quartiers, différentes heures) et sa méthode de sélection **documentée**.

## Étape 3 : analyser et formuler les constats

Un **constat** compare ce qui est observé au référentiel. Il se rédige en quatre parties :

| Élément | Exemple |
| --- | --- |
| **Critère** (ce qui est attendu) | Le cahier des charges impose un taux de coupure des appels inférieur à un seuil fixé |
| **Fait constaté** | Les mesures montrent un taux de coupure deux fois supérieur à ce seuil dans quatre quartiers, aux heures de pointe |
| **Cause** | Huit sites de ces quartiers sont saturés le soir ; trois sites subissent des coupures d''énergie répétées faute de batteries fonctionnelles |
| **Conséquence** | Dégradation du service pour les abonnés, manquement aux obligations du cahier des charges |

Les constats sont classés par **niveau de gravité** (majeur, modéré, mineur) pour aider à prioriser.

## Étape 4 : recommander

Une bonne **recommandation** est **précise**, **réaliste**, **mesurable** et **assortie d''un délai** :

- vague : « Améliorer la qualité de service » ;
- utile : « Remplacer les batteries des trois sites identifiés sous 30 jours et ajouter de la capacité sur les huit sites saturés sous 90 jours, avec un rapport mensuel des indicateurs de ces sites au régulateur. »

## Étape 5 : le rapport et le contradictoire

Le **rapport d''audit** contient :

1. une **synthèse** d''une page pour les décideurs : contexte, conclusion générale, constats majeurs ;
2. le **périmètre**, le **référentiel** et la **méthodologie** (y compris l''échantillonnage et ses limites) ;
3. les **constats** détaillés avec leurs preuves ;
4. les **recommandations** priorisées ;
5. les **réponses de l''audité** ;
6. les **annexes** : données, résultats de mesures, liste des documents.

Le projet de rapport est transmis à l''audité, qui peut apporter des précisions ou contester des constats avec des éléments. L''auditeur en tient compte, puis finalise.

## Étape 6 : le suivi

Un audit n''a de valeur que si les recommandations sont **mises en œuvre**. On tient un **tableau de suivi** : recommandation, responsable, délai, état d''avancement, preuves de réalisation. Une **mesure de contrôle** après les délais vérifie l''amélioration réelle.

## À toi de jouer

Tu es chargé de l''audit du décompte des forfaits data d''un opérateur, à la suite de plaintes d''abonnés.

1. Rédige le périmètre, les objectifs et le référentiel de l''audit.
2. Construis le plan d''audit : 6 points de contrôle, avec pour chacun la technique et les données demandées.
3. Conçois le protocole de test : nombre de cartes SIM de test, forfaits achetés, usages réalisés, mesure indépendante de la consommation (application de mesure, journal d''un serveur de test), critère d''écart acceptable.
4. Rédige un constat fictif complet (critère, fait, cause, conséquence) et la recommandation associée.
5. Rédige la synthèse d''une page du rapport.

> **Pour t''auto-évaluer** : relis chacun de tes constats. Un lecteur extérieur doit pouvoir retrouver la preuve qui le fonde, et comprendre ce qui est attendu de l''audité, sans avoir besoin de t''appeler.

## Vérifie tes acquis

1. Qu''est-ce qu''un référentiel d''audit ?
2. Quelles sont les quatre parties d''un constat ?
3. Pourquoi la phase contradictoire est-elle importante ?

> **Réponses** : 1. La norme de comparaison (loi, cahier des charges, politique, norme) à laquelle on confronte la réalité observée. 2. Le critère, le fait constaté, la cause et la conséquence. 3. Elle permet à l''audité d''apporter des éléments, corrige d''éventuelles erreurs et renforce la solidité et l''acceptation du rapport.

## En résumé

- Un audit compare la réalité à un **référentiel**, avec **indépendance**, **objectivité** et **preuves**.
- Étapes : préparer, collecter, analyser, recommander, rapporter (avec contradictoire), suivre.
- Les preuves doivent être **pertinentes**, **suffisantes**, **traçables** et **conservées** ; l''échantillon est représentatif et documenté.
- Un constat = **critère, fait, cause, conséquence** ; une recommandation est précise, mesurable et datée.
- Le **suivi** des recommandations donne sa valeur à l''audit.

## Pour aller plus loin

- Demande au mentor IA : « Aide-moi à transformer ces observations en constats d''audit structurés : [tes observations]. »'
WHERE t.slug = 'regulation-conformite-numerique' AND l.title = 'Mener un audit technique';

UPDATE lessons l
JOIN modules m ON m.id = l.module_id
JOIN tracks t ON t.id = m.track_id
SET l.summary = 'Principes, droits des personnes, obligations, protection dès la conception et violations.', l.duration_minutes = 30, l.content = 'Un opérateur connaît, pour chacun de ses millions d''abonnés, son identité, ses appels, ses déplacements de cellule en cellule, ses recharges, souvent ses transactions mobile money. Une banque connaît les revenus et les dépenses de ses clients. Une application de santé connaît leurs maladies. Ces **données personnelles** ont une grande valeur, et leur mauvaise utilisation peut causer des torts considérables : fraude, discrimination, surveillance, atteinte à la vie privée. Leur protection est devenue un domaine majeur de la conformité numérique.

> **Objectifs de ce chapitre**
> - Définir les données personnelles et les traitements
> - Connaître les principes de la protection des données
> - Connaître les droits des personnes concernées
> - Connaître les obligations des responsables de traitement
> - Appliquer la protection des données dès la conception et gérer une violation

> **Attention** : le Tchad dispose d''une législation relative à la protection des données à caractère personnel, et des textes régionaux existent également. Les principes présentés ici sont communs à la plupart des cadres modernes (y compris le RGPD européen, souvent appliqué par les entreprises internationales). Pour les obligations exactes (formalités auprès de l''autorité compétente, durées, sanctions), réfère-toi toujours aux textes en vigueur.

## Les notions de base

- Une **donnée personnelle** est toute information relative à une personne identifiée ou identifiable : nom, numéro de téléphone, numéro de carte SIM, adresse IP, localisation, photo, voix, empreinte digitale.
- Un **traitement** est toute opération sur ces données : collecte, enregistrement, consultation, modification, transmission, suppression.
- Le **responsable du traitement** est l''organisme qui décide des finalités et des moyens du traitement (l''opérateur, la banque).
- Le **sous-traitant** traite les données pour le compte du responsable (un prestataire d''hébergement, un centre d''appels externalisé).
- Les **données sensibles** bénéficient d''une protection renforcée : santé, opinions politiques, religieuses ou philosophiques, origine ethnique, données biométriques, et souvent les infractions.

## Les principes

| Principe | En pratique pour un opérateur |
| --- | --- |
| **Licéité, loyauté, transparence** | Informer clairement les abonnés de l''usage de leurs données, sur une base légale (contrat, obligation légale, consentement…) |
| **Finalité déterminée** | Les données de localisation collectées pour faire fonctionner le réseau ne sont pas revendues pour de la publicité sans base légale |
| **Minimisation** | Ne collecter que les données nécessaires à la finalité |
| **Exactitude** | Permettre la mise à jour des informations des abonnés |
| **Durée de conservation limitée** | Supprimer ou anonymiser les données au-delà de la durée nécessaire ou légale |
| **Sécurité et confidentialité** | Protéger contre l''accès non autorisé, la perte et la fuite |
| **Responsabilité** | Pouvoir démontrer la conformité : registre, procédures, preuves |

## Les droits des personnes

Les cadres de protection des données reconnaissent généralement aux personnes :

- le droit d''**information** : savoir qui traite leurs données et pourquoi ;
- le droit d''**accès** : obtenir une copie de leurs données ;
- le droit de **rectification** des données inexactes ;
- le droit d''**opposition**, notamment à la prospection commerciale ;
- le droit à l''**effacement** dans certaines conditions.

L''organisme doit prévoir une **procédure** pour recevoir et traiter ces demandes dans les délais, après avoir vérifié l''identité du demandeur.

> **Info** : pour un opérateur, le droit d''opposition se traduit très concrètement par la possibilité de ne plus recevoir de SMS promotionnels, avec un moyen simple de se désinscrire.

## Les obligations du responsable de traitement

- **Formalités** auprès de l''autorité de protection des données lorsque la loi les prévoit (déclaration ou demande d''autorisation, notamment pour les données sensibles ou certains transferts).
- **Registre des traitements** : la liste des traitements, leurs finalités, les données concernées, les destinataires, les durées de conservation, les mesures de sécurité.
- **Contrats avec les sous-traitants**, qui fixent leurs obligations de sécurité et de confidentialité.
- **Encadrement des transferts hors du pays**, par exemple lorsque des données sont hébergées dans un centre de données à l''étranger.
- **Sécurité** : contrôle des accès, chiffrement, journalisation, sauvegardes, sensibilisation du personnel.
- **Délégué à la protection des données** (DPO), dans les organismes où il est requis ou recommandé, qui conseille et contrôle en interne.

## La protection des données dès la conception

Le principe de **protection des données dès la conception** (*privacy by design*) demande d''intégrer la protection **dès le début** d''un projet, plutôt que de la rajouter à la fin :

- se demander pour chaque champ de formulaire s''il est vraiment nécessaire ;
- prévoir dès le départ les **durées de conservation** et la suppression automatique ;
- **pseudonymiser** les données utilisées pour les statistiques et les tests ;
- limiter les **accès** selon les profils ;
- choisir des **réglages par défaut** protecteurs (par exemple, partage de la localisation désactivé par défaut).

Pour les projets à risque élevé (biométrie, surveillance à grande échelle, données sensibles), on réalise une **analyse d''impact** relative à la protection des données avant le lancement.

> **Astuce** : les environnements de test et de développement sont une source classique de fuites : des copies complètes de la base clients y sont souvent stockées avec une sécurité moindre. Utilise des données **fictives** ou **anonymisées** pour les tests.

## Gérer une violation de données

Une **violation** est un incident qui entraîne la destruction, la perte, l''altération, la divulgation ou l''accès non autorisé à des données personnelles : piratage, ordinateur volé, fichier envoyé au mauvais destinataire, employé qui consulte des données sans raison.

1. **Contenir** l''incident : couper l''accès, changer les mots de passe, isoler les systèmes.
2. **Évaluer** : quelles données, combien de personnes, quels risques pour elles ?
3. **Notifier** l''autorité compétente et, si le risque est élevé, les personnes concernées, lorsque la loi l''exige et dans les délais prévus.
4. **Corriger** la cause et renforcer les mesures.
5. **Documenter** l''incident dans un registre des violations.

## À toi de jouer

Un opérateur veut lancer une application qui propose aux abonnés des offres personnalisées en fonction de leurs habitudes de consommation et de leurs lieux fréquentés.

1. Liste les données personnelles que l''application utiliserait et identifie celles qui sont les plus sensibles.
2. Pour chaque principe de la protection des données, indique une exigence concrète pour ce projet.
3. Rédige le texte d''information présenté à l''abonné à l''ouverture de l''application (8 lignes maximum, langage simple).
4. Propose 5 mesures de protection dès la conception.
5. Rédige la procédure de traitement d''une demande d''accès d''un abonné à ses données.

> **Éléments de correction** : la localisation (lieux fréquentés) est la donnée la plus sensible : elle révèle domicile, lieu de travail, habitudes, voire lieux de culte ou de soins. Exigences : consentement explicite pour la localisation, possibilité de refuser sans perdre le service de base, durée de conservation courte, données agrégées plutôt que précises, aucune revente sans base légale.

## Vérifie tes acquis

1. Une adresse IP ou un numéro de carte SIM est-il une donnée personnelle ?
2. Qu''est-ce que le principe de minimisation ?
3. Que faut-il faire en premier lors d''une violation de données ?

> **Réponses** : 1. Oui, car ils permettent d''identifier indirectement une personne. 2. Ne collecter que les données strictement nécessaires à la finalité poursuivie. 3. Contenir l''incident pour limiter la fuite, puis évaluer, notifier si nécessaire, corriger et documenter.

## En résumé

- Une **donnée personnelle** identifie directement ou indirectement une personne ; certaines sont **sensibles**.
- Principes : licéité, **finalité**, **minimisation**, exactitude, durée limitée, sécurité, responsabilité.
- Les personnes ont des **droits** : information, accès, rectification, opposition, effacement.
- Le responsable de traitement accomplit les **formalités**, tient un **registre**, encadre sous-traitants et transferts, et sécurise.
- **Protection dès la conception**, analyse d''impact pour les projets à risque, procédure en cas de **violation**.

## Pour aller plus loin

- Demande au mentor IA : « Aide-moi à rédiger le registre des traitements d''une petite entreprise : clients, salariés, prospects. »'
WHERE t.slug = 'regulation-conformite-numerique' AND l.title = 'Protection des données personnelles';
