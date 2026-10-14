La coopérative de Kaltouma a enregistré 2 400 livraisons sur la saison. Le président lui demande : « Combien de sésame a-t-on reçu par village et par mois ? Quels sont nos dix plus gros livreurs ? » Avec des formules, cela prendrait une demi-journée. Avec un **tableau croisé dynamique** (TCD), il faut deux minutes. C'est l'outil le plus puissant du tableur pour résumer de grandes quantités de données.

> **Objectifs de ce chapitre**
> - Préparer des données pour un tableau croisé dynamique
> - Créer un TCD et placer les champs
> - Changer le type de calcul (somme, nombre, moyenne)
> - Grouper par date, filtrer et trier
> - Créer un graphique croisé dynamique

## Préparer les données

Un TCD fonctionne à partir d'une **liste de données propre** :

- **une ligne par enregistrement** (une livraison) ;
- **une ligne d'en-têtes** unique, avec un titre dans chaque colonne ;
- **pas de ligne ni de colonne vide** au milieu ;
- **pas de cellules fusionnées** ;
- des données **cohérentes** : toujours « Sésame », pas « sesame » ou « Sésame blanc » au hasard ;
- des dates au format date et des nombres au format nombre.

| Date | Membre | Village | Produit | Quantité (kg) | Montant |
| --- | --- | --- | --- | --- | --- |
| 03/10/2026 | Néloumta | Balimba | Sésame | 450 | 292 500 |
| 03/10/2026 | Achta | Kemkian | Arachide | 1 200 | 360 000 |
| 05/10/2026 | Ngarlem | Balimba | Sésame | 300 | 195 000 |

> **Astuce** : transforme d'abord ta liste en **tableau** (dans Excel : **Insertion → Tableau**, ou **Ctrl+T**). Les nouvelles lignes ajoutées seront automatiquement prises en compte par le TCD après une simple actualisation.

## Créer un tableau croisé dynamique

Dans **Excel** :

1. Clique dans les données.
2. **Insertion → Tableau croisé dynamique**, puis choisis « Nouvelle feuille de calcul ».
3. Le volet **Champs** apparaît à droite : il liste les colonnes de tes données.

Dans **Google Sheets** : **Insertion → Tableau croisé dynamique**, puis l'éditeur s'ouvre sur la droite.

## Placer les champs

Le volet contient quatre zones :

| Zone | Rôle | Exemple |
| --- | --- | --- |
| **Lignes** | Les catégories affichées en lignes | Village |
| **Colonnes** | Les catégories affichées en colonnes | Produit |
| **Valeurs** | Ce qu'on calcule | Somme de Quantité (kg) |
| **Filtres** | Restreindre l'ensemble du tableau | Mois = octobre |

En glissant **Village** en Lignes, **Produit** en Colonnes et **Quantité** en Valeurs, on obtient immédiatement :

| Village | Arachide | Sésame | Total |
| --- | --- | --- | --- |
| Balimba | 2 300 | 4 150 | 6 450 |
| Kemkian | 5 800 | 1 200 | 7 000 |
| Total | 8 100 | 5 350 | 13 450 |

On peut changer la question en quelques secondes, simplement en déplaçant les champs : c'est pour cela qu'on l'appelle **dynamique**.

## Changer le calcul

Par défaut, un champ numérique est **additionné**. Pour un autre calcul, clique sur le champ dans la zone Valeurs, puis **Paramètres des champs de valeurs** (Excel) ou **Résumer par** (Sheets) :

- **Nombre** : combien de livraisons par village ;
- **Moyenne** : la quantité moyenne par livraison ;
- **Max** : la plus grosse livraison ;
- **% du total** : la part de chaque village dans la production.

> **Info** : on peut placer le même champ deux fois dans la zone Valeurs, par exemple « Somme de Quantité » et « Nombre de Quantité », pour voir à la fois le volume et le nombre de livraisons.

## Grouper, filtrer, trier

- **Grouper par date** : place le champ Date en Lignes, puis clic droit → **Grouper** → Mois. Les livraisons quotidiennes sont résumées par mois.
- **Filtrer** : utilise la petite flèche des en-têtes de lignes ou la zone Filtres pour n'afficher qu'un produit ou qu'une période.
- **Trier** : clic droit sur une valeur → Trier du plus grand au plus petit.
- **Top 10** : dans le filtre des lignes, **Filtres s'appliquant aux valeurs → 10 premiers**, pour obtenir les dix plus gros livreurs.

## Actualiser

Un TCD ne se met **pas** à jour automatiquement quand les données changent. Après avoir ajouté ou corrigé des livraisons : clic droit dans le TCD → **Actualiser** (Excel). Google Sheets actualise en général automatiquement.

> **Attention** : avant de présenter un résultat au président, actualise toujours le TCD. Un chiffre périmé dans une réunion abîme vite la confiance.

## Le graphique croisé dynamique

Un graphique parle souvent plus qu'un tableau. Dans Excel, clique dans le TCD puis **Analyse du tableau croisé dynamique → Graphique croisé dynamique**. Le graphique suit les filtres et les champs du TCD. Choisis :

- un **histogramme** pour comparer des villages ou des produits ;
- une **courbe** pour suivre l'évolution mois par mois ;
- un **secteur** seulement pour montrer quelques parts d'un total (3 à 5 catégories maximum).

## À toi de jouer

1. Crée une liste d'au moins 40 livraisons sur trois mois, avec cinq membres, trois villages et deux produits. Vérifie qu'elle respecte toutes les règles d'une liste propre.
2. Crée un TCD : quantité livrée par village et par produit.
3. Ajoute le nombre de livraisons à côté de la somme des quantités.
4. Groupe les dates par mois pour suivre l'évolution de la production.
5. Affiche le top 3 des membres par montant total.
6. Crée un graphique croisé dynamique de l'évolution mensuelle de la quantité de sésame.
7. Rédige en 4 phrases ce que le président de la coopérative doit retenir de ces chiffres.

> **Pour t'auto-évaluer** : ajoute 5 nouvelles livraisons à ta liste, actualise le TCD et vérifie que les totaux ont changé correctement. Si ce n'est pas le cas, ta source n'est sans doute pas définie comme un tableau.

## Vérifie tes acquis

1. Pourquoi faut-il éviter les cellules fusionnées dans les données source ?
2. Dans quelle zone place-t-on le champ à additionner ?
3. Un TCD se met-il à jour tout seul dans Excel quand les données changent ?

> **Réponses** : 1. Parce qu'elles empêchent le tableau croisé de lire correctement chaque ligne. 2. Dans la zone Valeurs. 3. Non, il faut l'actualiser.

## En résumé

- Un **TCD** résume en quelques clics des milliers de lignes.
- Les données source doivent être une **liste propre** : une ligne par enregistrement, des en-têtes, rien de vide ni de fusionné.
- Quatre zones : **Lignes**, **Colonnes**, **Valeurs**, **Filtres**.
- On change le calcul (somme, nombre, moyenne, %), on groupe par mois, on filtre et on trie.
- On **actualise** après chaque modification ; le graphique croisé dynamique illustre les résultats.

## Pour aller plus loin

- Demande au mentor IA : « Quelles questions utiles un responsable d'ONG peut-il poser à un tableau croisé dynamique de distributions alimentaires ? »
