Dans presque tous les bureaux du Tchad, administration, ONG, commerce ou banque, une compétence revient dans les offres d'emploi : « maîtrise d'Excel ». Un tableur bien utilisé fait gagner des heures de calcul et évite les erreurs. Dans ce chapitre, tu apprends les formules que tout le monde utilise au quotidien, dans **Excel** comme dans **Google Sheets**.

Dans ce parcours, tu accompagnes **Kaltouma**, assistante administrative dans une coopérative agricole de Sarh qui collecte et vend le sésame et l'arachide de ses membres.

> **Objectifs de ce chapitre**
> - Comprendre la structure d'une formule
> - Utiliser les fonctions SOMME, MOYENNE, MIN, MAX, NB
> - Maîtriser les références relatives et absolues
> - Prendre des décisions avec SI
> - Compter et additionner sous condition avec NB.SI et SOMME.SI
> - Rechercher une valeur avec RECHERCHEV

## La structure d'une formule

Une formule commence **toujours** par le signe `=`. Elle peut contenir des nombres, des références de cellules, des opérateurs et des fonctions :

```text
=B2*C2
=SOMME(D2:D50)
=SI(D2>100000;"Gros livreur";"Petit livreur")
```

- `B2` désigne la cellule à la colonne B, ligne 2.
- `D2:D50` désigne la **plage** de D2 à D50.
- Les arguments d'une fonction sont séparés par un **point-virgule** dans les versions françaises d'Excel et de Google Sheets.

> **Info** : les fonctions portent des noms français dans un Excel en français (`SOMME`, `SI`) et anglais dans un Excel en anglais (`SUM`, `IF`). Les formules s'adaptent automatiquement quand on ouvre le fichier dans l'autre langue.

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
| `ARRONDI` | `=ARRONDI(E2/1000;0)` | Le montant en milliers, arrondi à l'unité |

## Références relatives et absolues

Kaltouma veut appliquer une retenue de 5 % sur chaque montant pour les frais de la coopérative. Elle écrit le taux une seule fois, dans la cellule H1. En F2 : `=E2*H1`. Mais en recopiant vers le bas, la formule devient `=E3*H2`, `=E4*H3`… : la référence au taux s'est décalée, et le résultat est faux.

Il faut **bloquer** la référence au taux avec le symbole `$` : `=E2*$H$1`. En recopiant, `E2` devient `E3`, `E4` (référence **relative**), mais `$H$1` reste fixe (référence **absolue**).

> **Astuce** : en cours de saisie d'une formule, place le curseur sur une référence et appuie sur **F4** : Excel ajoute ou retire les `$` automatiquement.

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

| Fonction | Exemple | Ce qu'elle calcule |
| --- | --- | --- |
| `NB.SI` | `=NB.SI(B2:B5;"Sésame")` | Le nombre de livraisons de sésame |
| `SOMME.SI` | `=SOMME.SI(B2:B5;"Sésame";C2:C5)` | La quantité totale de sésame livrée |
| `MOYENNE.SI` | `=MOYENNE.SI(B2:B5;"Arachide";C2:C5)` | La quantité moyenne par livraison d'arachide |
| `SOMME.SI.ENS` | `=SOMME.SI.ENS(C2:C5;B2:B5;"Sésame";A2:A5;"Néloumta")` | La quantité de sésame livrée par Néloumta (plusieurs conditions) |

## Rechercher une valeur avec RECHERCHEV

Kaltouma a une seconde feuille « Membres » avec le village et le téléphone de chaque membre. Pour afficher automatiquement le village d'un membre dans le tableau des livraisons :

```text
=RECHERCHEV(A2;Membres!A:C;2;FAUX)
```

- `A2` : la valeur cherchée (le nom du membre) ;
- `Membres!A:C` : le tableau où chercher, la valeur cherchée devant être dans sa **première colonne** ;
- `2` : le numéro de la colonne à renvoyer dans ce tableau (ici, le village) ;
- `FAUX` : une correspondance **exacte**. Ne l'oublie jamais, sinon Excel peut renvoyer une valeur approchante et fausse.

> **Info** : les versions récentes d'Excel proposent `RECHERCHEX`, plus souple : elle cherche dans n'importe quelle colonne et gère directement le cas « introuvable ». `RECHERCHEV` reste très répandue et fonctionne partout.

## Les erreurs courantes

| Erreur | Signification |
| --- | --- |
| `#DIV/0!` | Division par zéro (ou par une cellule vide) |
| `#N/A` | Valeur introuvable, souvent avec `RECHERCHEV` |
| `#NOM?` | Nom de fonction mal écrit |
| `#VALEUR!` | Calcul avec du texte, par exemple « 450 kg » au lieu de 450 |
| `#REF!` | Référence à une cellule supprimée |
| `#####` | Colonne trop étroite pour afficher le nombre |

La fonction `SIERREUR` permet d'afficher un message propre : `=SIERREUR(RECHERCHEV(A2;Membres!A:C;2;FAUX);"Membre inconnu")`.

## À toi de jouer

1. Recrée le tableau des livraisons avec au moins 10 lignes (sésame et arachide, plusieurs membres).
2. Calcule la colonne Montant, puis la retenue de 5 % avec une référence absolue, puis le net à payer.
3. Calcule le total, la moyenne, la plus grosse et la plus petite livraison.
4. Ajoute une colonne Prime : 10 000 FCFA au-delà de 1 000 kg, sinon 0.
5. Dans un petit tableau de synthèse, calcule avec `NB.SI` et `SOMME.SI` le nombre de livraisons et la quantité totale pour chaque produit.
6. Crée la feuille Membres et affiche automatiquement le village de chaque membre avec `RECHERCHEV`.

> **Contrôle avec les 4 lignes de l'exemple** : montants 292 500, 360 000, 195 000 et 240 000 FCFA, soit un total de 1 087 500 FCFA. Sésame : 2 livraisons pour 750 kg. Seule Achta touche la prime.

## Vérifie tes acquis

1. Par quel signe commence toute formule ?
2. Pourquoi écrire `$H$1` plutôt que `H1` dans une formule recopiée ?
3. Que signifie le dernier argument `FAUX` de `RECHERCHEV` ?

> **Réponses** : 1. Le signe égal `=`. 2. Pour que la référence reste fixe lors de la recopie de la formule. 3. Qu'on veut une correspondance exacte.

## En résumé

- Une formule commence par `=` ; les arguments se séparent par `;` en français.
- `SOMME`, `MOYENNE`, `MIN`, `MAX`, `NB` couvrent les calculs de base.
- `$` rend une référence **absolue** (touche F4) ; sans `$`, elle est **relative**.
- `SI`, `ET`, `OU` prennent des décisions ; `NB.SI` et `SOMME.SI` calculent sous condition.
- `RECHERCHEV(...;FAUX)` va chercher une information dans un autre tableau ; `SIERREUR` masque proprement les erreurs.

## Pour aller plus loin

- Demande au mentor IA : « Donne-moi 5 exercices Excel progressifs sur SI, NB.SI et RECHERCHEV avec un fichier de ventes. »
