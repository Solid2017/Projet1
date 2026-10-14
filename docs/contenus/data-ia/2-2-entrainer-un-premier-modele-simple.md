Place à la pratique ! Dans ce chapitre, tu vas entraîner ton premier modèle avec **scikit-learn**, la bibliothèque Python de référence pour le machine learning classique. L'objectif : prédire le chiffre d'affaires journalier de la boutique de Moussa à partir de quelques informations sur la journée.

> **Objectifs de ce chapitre**
> - Préparer les variables explicatives et la cible
> - Séparer les données en entraînement et test
> - Entraîner une régression linéaire avec scikit-learn
> - Évaluer le modèle et interpréter ses erreurs
> - Utiliser le modèle pour une nouvelle prédiction

## Les données

Moussa a noté, pour 60 jours, le chiffre d'affaires et quelques informations. Voici un extrait de `journees.csv` :

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

> **Info** : les modèles ne comprennent que des nombres. Une information « oui/non » se code en 1/0 ; une catégorie comme le jour de la semaine se transforme en plusieurs colonnes 0/1. On appelle cela l'**encodage**.

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

La **régression linéaire** cherche la meilleure formule de la forme : chiffre d'affaires = base + a × jour_du_mois + b × est_weekend + c × est_jour_de_paie + d × pluie.

```python
modele = LinearRegression()
modele.fit(X_train, y_train)
```

C'est tout : `fit()` est l'étape d'apprentissage. Le modèle a trouvé les coefficients a, b, c, d.

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

On peut le lire ainsi : un jour de paie rapporte environ 18 500 FCFA de plus, la pluie fait perdre environ 9 800 FCFA, et les ventes baissent légèrement au fil du mois (l'argent des clients s'épuise). C'est l'un des grands atouts de la régression linéaire : elle est **explicable**.

> **Attention** : un coefficient montre une **association**, pas forcément une cause. Si les ventes baissent les jours de pluie, c'est peut-être parce que les clients sortent moins… ou parce que la boutique ferme plus tôt. Discute toujours des résultats avec la personne du terrain.

## Évaluer le modèle

```python
predictions = modele.predict(X_test)
erreur = mean_absolute_error(y_test, predictions)
print(f"Erreur moyenne : {erreur:.0f} FCFA")
```

L'**erreur absolue moyenne** dit de combien le modèle se trompe en moyenne. Pour savoir si c'est bien, compare-la à une méthode naïve : prédire chaque jour la moyenne des ventes.

```python
naif = [y_train.mean()] * len(y_test)
print(f"Erreur du modèle naïf : {mean_absolute_error(y_test, naif):.0f} FCFA")
```

Si ton modèle ne fait pas nettement mieux que la méthode naïve, il n'apporte rien.

## Prédire une nouvelle journée

Demain est le 28 du mois, un mardi, pas un jour de paie, et la météo annonce de la pluie :

```python
demain = pd.DataFrame([{"jour_du_mois": 28, "est_weekend": 0, "est_jour_de_paie": 0, "pluie": 1}])
print(f"Prévision : {modele.predict(demain)[0]:.0f} FCFA")
```

Moussa peut maintenant adapter son stock et ses horaires.

## À toi de jouer

1. Crée dans Colab un fichier `journees.csv` d'au moins 30 lignes (invente des données cohérentes : plus de ventes les jours de paie, moins quand il pleut).
2. Entraîne une régression linéaire et affiche ses coefficients.
3. Calcule l'erreur moyenne du modèle et celle du modèle naïf.
4. Ajoute une variable `est_jour_de_fete` (Tabaski, Noël, fête de l'Indépendance…) et observe si l'erreur diminue.
5. Rédige en trois phrases, pour Moussa, ce que le modèle lui apprend.

> **Pour t'auto-évaluer** : ton travail est réussi si ton modèle bat nettement le modèle naïf et si tes trois phrases pour Moussa ne contiennent aucun mot technique.

## Vérifie tes acquis

1. Que fait la méthode `fit()` ?
2. Pourquoi comparer le modèle à une prédiction naïve ?
3. Un coefficient de +18 500 pour `est_jour_de_paie` prouve-t-il que la paie cause les ventes ?

> **Réponses** : 1. Elle entraîne le modèle sur les données d'entraînement. 2. Pour vérifier que le modèle apporte réellement quelque chose par rapport à une méthode simple. 3. Non, il montre une association ; la causalité doit être confirmée par la connaissance du terrain.

## En résumé

- `X` contient les variables explicatives, `y` la cible ; tout doit être numérique.
- `train_test_split` sépare entraînement et test.
- `LinearRegression().fit()` entraîne le modèle, `predict()` fait des prédictions.
- L'**erreur absolue moyenne** mesure la qualité ; compare-la toujours à un modèle naïf.
- Les coefficients d'une régression linéaire s'interprètent, mais indiquent des associations, pas des causes.

## Pour aller plus loin

- [La documentation de scikit-learn](https://scikit-learn.org/stable/user_guide.html) (en anglais, avec de nombreux exemples)
- Demande au mentor IA : « Comment remplacer ma régression linéaire par un arbre de décision et comparer les deux ? »
