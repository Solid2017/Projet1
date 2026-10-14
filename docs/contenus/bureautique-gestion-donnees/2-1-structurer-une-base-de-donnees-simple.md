Le fichier Excel de la coopérative a grandi : une seule feuille contient maintenant les livraisons, avec à chaque ligne le nom, le village et le téléphone du membre. Quand Néloumta change de numéro, Kaltouma doit corriger 85 lignes, et elle en oublie toujours quelques-unes. Le problème ne vient pas d'Excel, mais de la **structure** des données. Dans ce chapitre, tu apprends à organiser des données comme une vraie **base de données**.

> **Objectifs de ce chapitre**
> - Comprendre les notions de table, d'enregistrement et de champ
> - Éviter les répétitions grâce à des tables séparées
> - Utiliser des identifiants uniques et des relations
> - Choisir le bon type de donnée pour chaque champ
> - Découvrir les outils adaptés : tableur, Access, LibreOffice Base, applications de base de données

## Le vocabulaire

| Terme | Signification | Exemple |
| --- | --- | --- |
| **Table** | Un ensemble de données d'un même type | La table des membres |
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
- **Incohérences** : une ligne finit avec l'ancien numéro, une autre avec le nouveau. Lequel est le bon ?
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

Chaque information n'est écrite **qu'une seule fois**. Le téléphone de Néloumta est dans une seule cellule : on le corrige une fois, et c'est fini. La table Livraisons ne contient que l'**identifiant** du membre, qui fait le lien avec la table Membres : c'est une **relation**.

> **Info** : on parle de relation **un à plusieurs** : un membre peut avoir plusieurs livraisons, mais chaque livraison concerne un seul membre. C'est la relation la plus courante dans les bases de données.

## L'identifiant unique

Pourquoi ne pas utiliser simplement le nom comme lien ? Parce que deux membres peuvent porter le même nom, qu'un nom peut être écrit de plusieurs façons et qu'il peut changer. L'identifiant (`M007`) :

- est **unique** : deux membres n'ont jamais le même ;
- ne **change jamais** ;
- ne porte **aucune signification** qui pourrait évoluer (pas le village dans le code, par exemple).

> **Attention** : n'utilise pas le numéro de téléphone comme identifiant : les gens changent de numéro, et certains partagent un téléphone avec leur famille.

## Choisir le bon type de donnée

| Type | Champs concernés | Pourquoi c'est important |
| --- | --- | --- |
| Texte | Nom, village, produit | — |
| Nombre | Quantité, prix | Permet les calculs ; pas d'unité dans la cellule (« 450 », pas « 450 kg ») |
| Date | Date de livraison | Permet de trier, de grouper par mois, de calculer des durées |
| Liste de choix | Produit, village | Évite les fautes de frappe et les variantes |
| Oui/Non | Payé, membre actif | Permet de filtrer facilement |

> **Astuce** : le numéro de téléphone se stocke en **texte**, pas en nombre : on ne fait pas de calcul dessus, et le format nombre supprimerait un éventuel zéro ou l'indicatif `+235`.

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

Kaltouma veut aussi suivre les **paiements** versés aux membres (date, montant, mode : espèces ou mobile money) et les **villages** (nom, chef de village, distance jusqu'au magasin de Sarh).

1. Identifie les tables nécessaires et liste les champs de chacune, avec leur type.
2. Choisis le format des identifiants de chaque table.
3. Indique les relations entre les tables (qui est lié à qui, un à plusieurs).
4. Crée ces tables dans un classeur (une feuille par table) avec quelques lignes d'exemple.
5. Dans la feuille Paiements, affiche automatiquement le nom et le village du membre à partir de son identifiant.
6. Calcule pour chaque membre : total livré, total payé, reste à payer.

> **Éléments de correction** : quatre tables : Villages (id_village…), Membres (id_membre, nom, id_village, téléphone…), Livraisons (id_livraison, date, id_membre, produit, quantité, prix), Paiements (id_paiement, date, id_membre, montant, mode). Un village a plusieurs membres ; un membre a plusieurs livraisons et plusieurs paiements.

## Vérifie tes acquis

1. Pourquoi ne faut-il pas répéter les informations d'un membre à chaque livraison ?
2. Quelles sont les qualités d'un bon identifiant ?
3. Pourquoi stocker un numéro de téléphone en texte ?

> **Réponses** : 1. Parce que les mises à jour deviennent pénibles et provoquent des incohérences. 2. Il est unique, ne change jamais et ne porte pas de signification susceptible d'évoluer. 3. Parce qu'on ne calcule pas dessus et que le format nombre peut supprimer des caractères comme le `+` ou un zéro initial.

## En résumé

- Une base de données s'organise en **tables**, **enregistrements** et **champs**.
- **Une table par sujet** : chaque information n'est écrite qu'une fois.
- Les tables sont reliées par des **identifiants uniques** (relation un à plusieurs).
- Chaque champ a le bon **type** : texte, nombre, date, liste, oui/non.
- Tableur pour commencer, puis Access, LibreOffice Base, AppSheet ou MySQL quand les besoins grandissent.

## Pour aller plus loin

- Demande au mentor IA : « Aide-moi à concevoir les tables d'une base de données pour gérer les élèves, les classes et les paiements d'une école. »
