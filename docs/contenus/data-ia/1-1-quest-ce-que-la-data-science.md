Chaque fois que tu achètes du crédit, que tu payes par Mobile Money ou que tu likes une publication, tu produis des **données**. Les entreprises, les ONG et les administrations en accumulent des millions. La **data science** est le métier qui transforme ces données brutes en décisions : quel produit commander, quelle région aider en priorité, quel client risque de partir.

Dans ce parcours, tu suivras **Moussa**, qui tient une boutique de recharges et d'accessoires téléphoniques au marché de Dembé à N'Djamena. Il note ses ventes depuis un an et voudrait savoir quoi en faire.

> **Objectifs de ce chapitre**
> - Définir la data science et ses grandes étapes
> - Distinguer donnée, information et décision
> - Connaître les métiers de la donnée
> - Reconnaître les types de données et les problèmes de qualité

## De la donnée à la décision

Une **donnée** est un fait brut : « 12/03, chargeur USB-C, 2 500 FCFA ». Seule, elle ne dit pas grand-chose. En regroupant des milliers de données, on obtient une **information** : « les chargeurs se vendent surtout en début de mois ». Cette information mène à une **décision** : « je commande mon stock de chargeurs le 25 de chaque mois ».

La data science est l'ensemble des méthodes (statistiques, programmation, visualisation) qui permettent de passer de la donnée à la décision.

## Le cycle d'un projet data

Un projet data suit presque toujours les mêmes étapes :

1. **Poser la question** : que veut-on savoir ou prédire ? Par exemple : « Quels jours dois-je avoir plus de stock ? »
2. **Collecter les données** : cahier de ventes, fichier Excel, export d'une application, enquête terrain.
3. **Nettoyer les données** : corriger les fautes de saisie, retirer les doublons, gérer les cases vides. C'est souvent 60 à 80 % du travail.
4. **Explorer et visualiser** : calculer des moyennes, tracer des graphiques, repérer des tendances.
5. **Modéliser** : construire un modèle statistique ou de machine learning si la question l'exige.
6. **Communiquer** : présenter les résultats simplement à ceux qui décident.

> **Attention** : l'étape la plus souvent négligée est la première. Une analyse brillante qui répond à une mauvaise question ne sert à rien. Prends toujours le temps de reformuler la question avec la personne qui la pose.

## Les types de données

| Type | Exemple chez Moussa | Ce qu'on peut calculer |
| --- | --- | --- |
| Numérique continu | Montant d'une vente : 2 500 FCFA | Moyenne, somme, écart |
| Numérique discret | Nombre d'articles vendus : 3 | Somme, moyenne |
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

> **Info** : on dit en anglais *garbage in, garbage out* : des données de mauvaise qualité donnent des conclusions fausses, quel que soit le talent de l'analyste.

## Les métiers de la donnée

- **Data analyst** : nettoie, analyse et visualise les données pour répondre à des questions concrètes. C'est le métier le plus accessible pour commencer.
- **Data scientist** : construit des modèles prédictifs avec le machine learning.
- **Data engineer** : construit les « tuyaux » qui collectent et stockent les données de façon fiable.
- **Chargé de suivi-évaluation** : très recherché dans les ONG au Tchad, il analyse les données des projets pour mesurer leur impact.

Les outils de base sont les mêmes pour tous : un **tableur** (Excel, Google Sheets), le langage **Python** et ses bibliothèques, et le langage **SQL** pour interroger les bases de données.

## À toi de jouer

Moussa te confie ce besoin : « Je veux gagner plus d'argent avec ma boutique. »

1. Reformule ce besoin en **trois questions précises** auxquelles les données peuvent répondre.
2. Pour chaque question, liste les **colonnes** dont tu aurais besoin dans le fichier de ventes.
3. Repère au moins **trois problèmes de qualité** dans le tableau ci-dessus et propose une règle de saisie pour chacun.

> **Exemple de réponse** : « Quels sont les 5 articles qui rapportent le plus de bénéfice ? » (colonnes : article, prix de vente, prix d'achat, quantité). « Quels jours de la semaine vend-on le plus ? » (date, montant). « Quels articles sont demandés mais pas en stock ? » (texte des demandes clients). Règles de saisie : une liste fixe de noms d'articles, des dates au format JJ/MM/AAAA, des prix en chiffres sans « F ».

## Vérifie tes acquis

1. Quelle est généralement l'étape la plus longue d'un projet data ?
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

- Demande au mentor IA : « Propose-moi un mini-projet data à faire avec les données d'une petite entreprise tchadienne. »
