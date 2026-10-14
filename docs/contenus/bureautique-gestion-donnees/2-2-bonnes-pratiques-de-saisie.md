Le jour où le président de la coopérative demande le total de sésame livré par Balimba, le tableau croisé dynamique de Kaltouma affiche trois lignes : « Balimba », « balimba » et « Balimba » (avec un espace en trop). Le total est faux. Les meilleurs outils ne servent à rien si les données sont mal saisies. Dans ce chapitre, tu apprends à **prévenir** les erreurs de saisie et à **nettoyer** celles qui sont déjà là.

> **Objectifs de ce chapitre**
> - Connaître les erreurs de saisie les plus fréquentes
> - Rédiger des règles de saisie claires
> - Utiliser la validation des données et les listes déroulantes
> - Nettoyer des données avec les fonctions et outils du tableur
> - Protéger et sauvegarder les fichiers

## Les erreurs les plus fréquentes

| Erreur | Exemple | Conséquence |
| --- | --- | --- |
| Variantes d'écriture | « Sésame », « sesame », « SESAME » | Comptées comme trois produits différents |
| Espaces en trop | « Balimba » avec un espace final | Invisible à l'œil, mais une catégorie de plus |
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

Pour la colonne Produit, choisis **Liste** et indique les valeurs autorisées (`Sésame;Arachide;Mil;Sorgho`) ou, mieux, une plage d'une feuille « Listes ». Ceux qui saisissent n'ont plus qu'à choisir : fini les variantes d'écriture.

### Les nombres et les dates

- Quantité : **Nombre entier** compris entre 1 et 10 000.
- Date : **Date** comprise entre le début et la fin de la campagne.

Ajoute un **message d'erreur** explicite : « La quantité doit être un nombre de kg entre 1 et 10 000, sans unité. »

> **Info** : la validation n'agit que sur les nouvelles saisies. Elle ne corrige pas les erreurs déjà présentes, et un copier-coller peut parfois la contourner. Le nettoyage reste nécessaire.

## Nettoyer les données existantes

### Les fonctions de nettoyage

| Fonction | Rôle | Exemple |
| --- | --- | --- |
| `SUPPRESPACE` | Supprime les espaces en trop | `=SUPPRESPACE(C2)` |
| `NOMPROPRE` | Majuscule au début de chaque mot | `=NOMPROPRE("néloumta ngarmadji")` → Néloumta Ngarmadji |
| `MAJUSCULE` / `MINUSCULE` | Tout en majuscules ou en minuscules | `=MAJUSCULE(D2)` |
| `SUBSTITUE` | Remplace un texte par un autre | `=SUBSTITUE(E2;" kg";"")` |
| `CNUM` | Convertit un texte en nombre | `=CNUM(SUBSTITUE(E2;" kg";""))` |

On applique la formule dans une colonne temporaire, puis on **copie** le résultat et on le **colle en valeurs** (Collage spécial → Valeurs) à la place des données d'origine, avant de supprimer la colonne temporaire.

### Les autres outils

- **Rechercher et remplacer** (**Ctrl+H**) : remplacer « sesame » par « Sésame » dans toute une colonne.
- **Supprimer les doublons** (Excel : **Données → Supprimer les doublons** ; Sheets : **Données → Nettoyage des données**) : à utiliser avec prudence, après avoir vérifié qu'il s'agit bien de vrais doublons.
- **Filtres** : afficher les valeurs d'une colonne permet de repérer immédiatement les variantes (« Balimba », « balimba »…).
- **Mise en forme conditionnelle** : colorer les cellules vides ou les doublons pour les repérer.

> **Attention** : avant tout nettoyage important, **fais une copie** du fichier d'origine. Une suppression de doublons trop large ou un remplacement mal ciblé peut détruire des données qu'on ne retrouvera pas.

## Protéger et sauvegarder

- **Protéger les feuilles** et les cellules de formules (**Révision → Protéger la feuille**) pour éviter qu'une formule soit effacée par erreur.
- **Limiter les accès** dans Google Sheets : en lecture seule pour ceux qui consultent, en modification pour ceux qui saisissent.
- **Sauvegarder** régulièrement : une copie datée chaque semaine (`livraisons_2026-10-12.xlsx`), sur un autre support ou dans le cloud. L'historique des versions de Google Sheets permet aussi de revenir en arrière.

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
3. Recrée l'extrait dans un tableur et nettoie-le avec les fonctions vues (`NOMPROPRE`, `SUPPRESPACE`, `SUBSTITUE`, `CNUM`) et Rechercher-remplacer.
4. Mets en place les validations : liste déroulante pour les produits et les villages, nombre entier pour la quantité, date pour la date.
5. Ajoute une mise en forme conditionnelle qui colore en rouge les quantités vides.
6. Crée la feuille « Lisez-moi » du classeur.

> **Erreurs à repérer** : nom en minuscules ou en majuscules, espace final après « Balimba », village sans majuscule, produit sans accent et en minuscules, unité « kg » dans la quantité, date en texte, doublon probable sur les deux dernières lignes (à vérifier avant de supprimer).

## Vérifie tes acquis

1. Pourquoi « 450 kg » pose-t-il problème dans une colonne de quantités ?
2. Quel outil empêche de saisir un produit qui n'est pas dans la liste ?
3. Que faut-il faire avant un nettoyage important ?

> **Réponses** : 1. Parce que la cellule devient du texte et ne peut plus être additionnée. 2. La validation des données avec une liste déroulante. 3. Une copie de sauvegarde du fichier.

## En résumé

- Variantes d'écriture, espaces, unités, dates en texte et doublons faussent les résultats.
- Des **règles de saisie** écrites et partagées sont la première protection.
- La **validation des données** et les **listes déroulantes** empêchent les erreurs.
- `SUPPRESPACE`, `NOMPROPRE`, `SUBSTITUE`, `CNUM`, Rechercher-remplacer et la suppression des doublons nettoient l'existant.
- Protéger les formules, limiter les accès et **sauvegarder** régulièrement.

## Pour aller plus loin

- Demande au mentor IA : « Comment créer une liste déroulante dépendante (le village dépend du canton) dans Excel ? »
