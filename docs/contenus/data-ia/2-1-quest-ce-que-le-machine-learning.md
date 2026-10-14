Le **machine learning** (apprentissage automatique) est la technique derrière la reconnaissance vocale, les filtres anti-spam ou la détection de fraude Mobile Money. Son principe est simple à énoncer : au lieu d'écrire des règles à la main, on montre à l'ordinateur des exemples, et il **apprend** les règles tout seul.

> **Objectifs de ce chapitre**
> - Comprendre la différence entre programmation classique et machine learning
> - Distinguer apprentissage supervisé et non supervisé
> - Différencier régression et classification
> - Comprendre pourquoi on sépare données d'entraînement et de test
> - Connaître les limites et les biais d'un modèle

## Programmer ou apprendre ?

En **programmation classique**, tu écris les règles : « si le montant dépasse 500 000 FCFA et que le numéro est nouveau, alors bloque la transaction ». Tu donnes des règles et des données, l'ordinateur produit des réponses.

En **machine learning**, tu donnes des données **et** les réponses attendues (des milliers de transactions déjà étiquetées « fraude » ou « normale »). L'algorithme en déduit les règles. Il produit un **modèle**, qu'on applique ensuite à de nouvelles données.

C'est utile quand les règles sont trop nombreuses ou trop subtiles pour être écrites à la main : reconnaître une écriture, estimer le prix d'une maison, détecter un comportement inhabituel.

## Le vocabulaire de base

Reprenons les données de Moussa. Il veut prédire ses ventes de la journée.

- Les **variables explicatives** (*features*) sont les informations connues à l'avance : jour de la semaine, jour du mois, présence d'une fête, pluie ou non.
- La **variable cible** (*target*) est ce qu'on veut prédire : le chiffre d'affaires du jour.
- Un **exemple** est une ligne de données : une journée passée, avec ses variables et sa cible.
- Le **modèle** est la formule apprise qui relie les variables à la cible.

## Les grandes familles

### L'apprentissage supervisé

On dispose d'exemples **avec la bonne réponse**. Deux cas :

| Tâche | La cible est… | Exemple au Tchad |
| --- | --- | --- |
| **Régression** | un nombre | Prédire le chiffre d'affaires de demain, le rendement d'un champ de sorgho |
| **Classification** | une catégorie | Classer une transaction en « fraude » ou « normale », un SMS en « spam » ou non |

### L'apprentissage non supervisé

On a des données **sans réponse** et on cherche une structure cachée. Exemple : regrouper automatiquement les clients d'une banque en profils similaires (petits épargnants, commerçants, salariés). On parle de **clustering**.

> **Info** : les grands modèles de langage comme le mentor IA de cette plateforme sont aussi issus du machine learning, entraînés sur d'immenses quantités de textes. Le principe de base reste le même : apprendre à partir d'exemples.

## Entraîner et tester

Un modèle doit être bon sur des données **qu'il n'a jamais vues**. On découpe donc les données en deux :

- l'**ensemble d'entraînement** (souvent 80 %) sert à apprendre ;
- l'**ensemble de test** (20 %) sert à mesurer la performance, comme un examen final.

Pense à un élève qui apprend par cœur les corrigés des exercices : il aura 20/20 sur ces exercices, mais échouera à l'examen s'il n'a pas compris. Un modèle qui « apprend par cœur » ses données d'entraînement fait du **surapprentissage** (*overfitting*) : excellent à l'entraînement, mauvais sur le test.

> **Attention** : ne mesure jamais la performance d'un modèle sur les données qui ont servi à l'entraîner. Le score serait trompeur et trop optimiste.

## Mesurer la performance

- En **régression**, on regarde l'erreur moyenne : « en moyenne, le modèle se trompe de 3 200 FCFA par jour ».
- En **classification**, on regarde l'**exactitude** (le pourcentage de bonnes réponses), mais pas seulement. Si 99 % des transactions sont normales, un modèle qui répond toujours « normale » a 99 % d'exactitude… et ne détecte aucune fraude. On regarde donc aussi combien de fraudes réelles il attrape.

## Les limites et les biais

Un modèle reproduit ce qu'il voit dans les données, y compris les injustices. Si une banque entraîne un modèle d'octroi de crédit sur un historique où les femmes commerçantes obtenaient rarement des prêts, le modèle risque de continuer à les refuser, même solvables.

Avant de déployer un modèle, pose-toi toujours ces questions :

- Les données représentent-elles bien toute la population concernée (villes et zones rurales, hommes et femmes, langues) ?
- Qui sera affecté si le modèle se trompe, et comment pourra-t-il contester ?
- Le modèle est-il encore valable si la situation change (crise, nouvelle réglementation) ?

## À toi de jouer

Pour chacune des situations suivantes, indique s'il s'agit de régression, de classification ou de clustering, puis cite deux variables explicatives possibles :

1. Prédire le nombre de patients qui viendront demain dans un centre de santé de Moundou.
2. Détecter si une photo de feuille de manioc montre une maladie.
3. Regrouper les abonnés d'un opérateur selon leurs habitudes de consommation.
4. Estimer le loyer d'un appartement à N'Djamena.

> **Réponses** : 1. Régression (jour de la semaine, saison des pluies, épidémie en cours). 2. Classification (couleur des taches, forme des feuilles, à partir des pixels de l'image). 3. Clustering (volume d'appels, data consommée, montant des recharges). 4. Régression (quartier, nombre de pièces, accès à l'eau et à l'électricité).

## Vérifie tes acquis

1. Quelle est la différence entre la variable cible et les variables explicatives ?
2. Pourquoi sépare-t-on les données en entraînement et test ?
3. Qu'est-ce que le surapprentissage ?

> **Réponses** : 1. La cible est ce qu'on veut prédire ; les variables explicatives sont les informations utilisées pour la prédire. 2. Pour mesurer la performance sur des données que le modèle n'a jamais vues. 3. Un modèle qui mémorise ses données d'entraînement au lieu de généraliser, et qui échoue sur de nouvelles données.

## En résumé

- Le machine learning apprend des règles à partir d'**exemples** au lieu de les programmer à la main.
- **Supervisé** : régression (prédire un nombre) ou classification (prédire une catégorie). **Non supervisé** : trouver des groupes.
- On entraîne sur une partie des données et on **teste** sur une autre.
- Le **surapprentissage** donne de bons scores à l'entraînement mais de mauvais résultats en réalité.
- Un modèle peut reproduire des **biais** : vérifie toujours qui risque d'être pénalisé.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi la différence entre régression et classification avec trois exemples tirés de l'agriculture tchadienne. »
