Les tests du prototype SantéRDV ont confirmé le parcours. Mariam passe maintenant au **design visuel** (l'UI). Son objectif n'est pas de « faire joli », mais de guider l'œil : en une seconde, l'utilisateur doit voir ce qui est le plus important sur l'écran et ce qu'il doit faire ensuite. C'est le rôle de la **hiérarchie visuelle**, et la **typographie** en est l'outil principal.

> **Objectifs de ce chapitre**
> - Comprendre comment l'œil parcourt un écran
> - Créer une hiérarchie avec la taille, le contraste, la couleur et l'espace
> - Choisir et combiner des polices lisibles
> - Construire une échelle typographique et une palette de couleurs
> - Utiliser l'espacement et l'alignement

## Ce qui attire l'œil

Sur un écran, le regard est attiré d'abord par :

- ce qui est **plus grand** ;
- ce qui est **plus contrasté** (foncé sur clair, couleur vive au milieu de gris) ;
- ce qui est **isolé**, entouré d'espace vide ;
- ce qui est **en haut** de l'écran ;
- les **visages** et les images.

La hiérarchie visuelle consiste à utiliser ces leviers volontairement pour que l'ordre de lecture corresponde à l'ordre d'importance.

> **Astuce** : le **test du plissement d'yeux** : plisse les yeux devant ton écran jusqu'à ce que le texte devienne flou. Les éléments qui restent visibles sont ceux qui dominent. Si ce n'est pas le bouton principal ou l'information clé, ta hiérarchie est à revoir.

## Les leviers de la hiérarchie

| Levier | Exemple sur la fiche d'un centre de santé |
| --- | --- |
| Taille | Le nom du centre en grand, l'adresse en plus petit |
| Graisse | L'heure de passage estimée en gras |
| Couleur | Le bouton « Prendre un ticket » dans la couleur principale, seul élément coloré |
| Contraste | Les informations secondaires en gris moyen |
| Espace | Un grand espace autour du bouton principal |
| Position | L'information la plus utile tout en haut |

Ne les utilise pas tous à la fois : si tout est gros, gras et coloré, plus rien ne ressort.

## La typographie

### Choisir une police

Pour une interface, privilégie une police **sans empattements** (*sans-serif*), très lisible sur écran et en petite taille : **Inter**, **Roboto**, **Open Sans**, **Noto Sans** sont gratuites (Google Fonts). Vérifie qu'elle gère les accents français et, si besoin, l'alphabet arabe : la famille **Noto Sans Arabic** est conçue pour s'harmoniser avec Noto Sans.

Règle simple : **une ou deux polices maximum** dans toute l'application. Une seule police bien utilisée, avec plusieurs graisses, suffit largement.

### L'échelle typographique

On définit à l'avance un petit nombre de tailles, utilisées partout de façon cohérente :

| Style | Taille | Graisse | Usage |
| --- | --- | --- | --- |
| Titre 1 | 24 px | Gras | Titre de l'écran |
| Titre 2 | 18 px | Semi-gras | Titres de sections, noms des centres |
| Corps | 16 px | Normal | Texte courant |
| Légende | 13 px | Normal | Informations secondaires (distance, horaires) |

> **Attention** : sur mobile, ne descends pas sous **16 px** pour le texte principal. Les utilisateurs plus âgés ou ceux qui ont une vue fatiguée doivent pouvoir lire sans zoomer.

### La lisibilité

- **Interligne** : environ 1,4 à 1,6 fois la taille du texte.
- **Longueur de ligne** : 45 à 75 caractères pour un texte confortable.
- **Alignement à gauche** pour le français (à droite pour l'arabe) ; évite le texte justifié sur mobile, qui crée des trous.
- **Pas de texte entièrement en majuscules** pour les paragraphes : c'est plus difficile à lire.

## La couleur

Une palette d'interface se construit simplement :

- une **couleur principale** pour les actions (boutons, liens) ;
- des **neutres** (blanc, gris clairs et foncés) pour le fond et le texte : ils représentent la grande majorité de l'écran ;
- des **couleurs de statut** : vert (succès), orange (attention), rouge (erreur).

> **Info** : les couleurs ont des significations culturelles. Pour une application de santé au Tchad, Mariam évite d'utiliser du rouge vif pour des éléments neutres, car il évoque l'urgence ou le danger.

## L'espacement et l'alignement

L'espace vide n'est pas de l'espace perdu : il **regroupe** et **sépare**. Des éléments proches sont perçus comme liés (le nom d'un centre et son adresse) ; un espace plus grand sépare des groupes différents (deux centres dans une liste).

Utilise une **grille d'espacement** basée sur un multiple de 8 : 8, 16, 24, 32, 48 px. Cela donne une régularité que l'œil perçoit, même sans la remarquer. Et aligne les éléments sur les mêmes bords : un écran bien aligné paraît immédiatement plus professionnel.

## À toi de jouer

Reprends l'écran principal de ton prototype du chapitre précédent :

1. Classe tous les éléments de l'écran par ordre d'importance (de 1 à N).
2. Définis ton échelle typographique (4 styles maximum) avec une seule police.
3. Choisis une palette : une couleur principale, trois neutres et trois couleurs de statut.
4. Redessine l'écran dans Figma en appliquant ces choix et une grille d'espacement de 8 px.
5. Fais le test du plissement d'yeux : l'élément le plus visible correspond-il à ton numéro 1 ?
6. Montre l'écran pendant 5 secondes à une personne, cache-le, et demande-lui ce dont elle se souvient.

> **Pour t'auto-évaluer** : si la personne se souvient de l'information principale et du bouton à utiliser, ta hiérarchie fonctionne.

## Vérifie tes acquis

1. Cite trois leviers de hiérarchie visuelle.
2. Quelle taille minimale recommander pour le texte principal sur mobile ?
3. Pourquoi limiter le nombre de polices ?

> **Réponses** : 1. Par exemple la taille, la graisse, la couleur, le contraste, l'espace ou la position. 2. 16 px. 3. Pour garder une interface cohérente et lisible ; trop de polices donnent une impression de désordre.

## En résumé

- La **hiérarchie visuelle** fait correspondre l'ordre de lecture à l'ordre d'importance.
- Leviers : taille, graisse, couleur, contraste, espace, position. Ne pas tout mettre en avant.
- Une ou deux polices lisibles, une **échelle typographique** de quelques tailles, 16 px minimum sur mobile.
- Une palette simple : couleur principale, neutres, couleurs de statut.
- L'**espace** et l'**alignement** structurent l'écran ; une grille de 8 px aide à rester régulier.

## Pour aller plus loin

- [Google Fonts](https://fonts.google.com/) pour trouver des polices gratuites, dont les familles Noto
- Demande au mentor IA : « Analyse la hiérarchie visuelle de cet écran : [décris ton écran]. Qu'est-ce qui attire l'œil en premier ? »
