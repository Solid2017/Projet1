Une personne malvoyante qui utilise un lecteur d'écran, un agriculteur qui consulte son téléphone en plein soleil, une grand-mère dont les mains tremblent, un utilisateur daltonien, quelqu'un qui lit difficilement le français : tous doivent pouvoir utiliser SantéRDV. **L'accessibilité** consiste à concevoir des interfaces utilisables par **tous**, quelles que soient leurs capacités ou leur situation. Et ce qui aide les personnes en situation de handicap améliore presque toujours l'expérience de tout le monde.

> **Objectifs de ce chapitre**
> - Comprendre les différents types de handicap et de situations limitantes
> - Connaître les principes des règles WCAG
> - Vérifier les contrastes de couleur
> - Concevoir des zones tactiles, des formulaires et des messages accessibles
> - Penser aux utilisateurs peu à l'aise avec la lecture

## Pour qui concevoir ?

| Situation | Exemples | Ce qui aide |
| --- | --- | --- |
| Vision | Malvoyance, daltonisme, cécité | Contrastes forts, texte agrandissable, lecteur d'écran |
| Motricité | Tremblements, doigts abîmés par le travail manuel | Grandes zones tactiles, pas de gestes complexes |
| Audition | Surdité | Sous-titres, alternatives aux sons et messages vocaux |
| Cognition | Difficultés de concentration, de mémoire | Écrans simples, une tâche à la fois, langage clair |
| Situations temporaires | Bras cassé, plein soleil, environnement bruyant | Les mêmes solutions ! |
| Littératie | Lecture difficile | Icônes accompagnées de texte, phrases courtes, audio |

## Les règles WCAG

Les **WCAG** (*Web Content Accessibility Guidelines*) sont la référence internationale de l'accessibilité numérique. Elles reposent sur quatre principes : le contenu doit être

- **Perceptible** : on peut le voir, l'entendre ou le lire avec un lecteur d'écran ;
- **Utilisable** : on peut s'en servir au toucher, au clavier, sans limite de temps excessive ;
- **Compréhensible** : le texte et le fonctionnement sont clairs et prévisibles ;
- **Robuste** : il fonctionne avec les technologies d'assistance.

Le niveau **AA** est l'objectif visé par la plupart des organisations.

## Les contrastes

Le texte doit se détacher suffisamment du fond. Le niveau AA demande un **rapport de contraste** d'au moins :

- **4,5 pour 1** pour le texte normal ;
- **3 pour 1** pour le texte de grande taille et pour les icônes et bordures de champs.

Le gris clair sur fond blanc, très à la mode, échoue souvent à ce test. Vérifie tes couleurs avec un outil gratuit comme le vérificateur de contraste de WebAIM ou un plugin Figma comme **Stark** ou **Contrast**.

> **Info** : un bon contraste n'aide pas seulement les personnes malvoyantes : il rend l'application lisible en plein soleil, une situation très courante au Tchad.

## Ne pas compter que sur la couleur

Environ 8 % des hommes ont une forme de daltonisme. Si un créneau disponible est vert et un créneau complet est rouge, sans autre indication, certains utilisateurs ne voient pas la différence. Ajoute toujours un second indice : une **icône**, un **texte** (« Complet »), un **motif**.

## Des zones tactiles confortables

Chaque élément touchable (bouton, lien, case à cocher) doit mesurer au moins **44 × 44 points** sur iOS et **48 × 48 dp** sur Android, avec de l'espace entre deux éléments voisins. Un bouton trop petit est un calvaire pour des doigts épais, des mains qui tremblent ou un utilisateur dans un bus qui roule sur une route cahoteuse.

## Des formulaires accessibles

- Une **étiquette visible** au-dessus de chaque champ, jamais seulement un texte gris dans le champ qui disparaît dès qu'on commence à taper.
- Le **bon clavier** : clavier numérique pour un numéro de téléphone.
- Des **messages d'erreur clairs**, placés près du champ concerné, qui expliquent comment corriger : « Le numéro doit contenir 8 chiffres, par exemple 66 12 34 56 » plutôt que « Format invalide ».
- Ne pas effacer ce que l'utilisateur a déjà saisi en cas d'erreur.

> **Attention** : ne limite jamais le temps pour remplir un formulaire sans prévenir et sans permettre de prolonger. Une personne qui écrit lentement ou qui doit chercher un document perdrait tout.

## Les lecteurs d'écran

Les personnes aveugles utilisent un **lecteur d'écran** (TalkBack sur Android, VoiceOver sur iPhone) qui lit à voix haute les éléments de l'écran. Pour qu'il fonctionne bien :

- chaque image utile a une **description** (texte alternatif) ; les images décoratives sont ignorées ;
- chaque bouton-icône a un **nom** : un bouton loupe doit être annoncé « Rechercher », pas « Bouton » ;
- l'**ordre de lecture** suit l'ordre logique de l'écran.

> **Astuce** : active TalkBack sur ton téléphone Android (Paramètres, Accessibilité) et essaie d'utiliser ton application les yeux fermés pendant cinq minutes. L'expérience est très instructive. Note bien comment le désactiver avant de commencer !

## Un langage clair pour tous

- Des **phrases courtes**, un mot simple plutôt qu'un mot technique : « Votre ticket » plutôt que « Votre réservation de créneau ».
- Des **icônes accompagnées d'un mot** : une icône seule est souvent ambiguë.
- Des messages **traduits** (français et arabe), avec une mise en page qui s'inverse correctement pour l'arabe.
- Pour les utilisateurs qui lisent difficilement : des **messages vocaux** ou des confirmations par SMS très simples.

## À toi de jouer

Fais l'**audit d'accessibilité** de ton écran principal :

1. Vérifie le contraste de chaque couleur de texte avec un outil en ligne et corrige ceux qui sont sous 4,5:1.
2. Repère toute information transmise uniquement par la couleur et ajoute un second indice.
3. Mesure les zones tactiles et agrandis celles qui font moins de 48 px.
4. Réécris tous les messages d'erreur pour qu'ils expliquent comment corriger.
5. Écris le texte qu'un lecteur d'écran devrait annoncer pour chaque bouton-icône.
6. Simplifie trois textes de ton interface en remplaçant les mots techniques.

> **Pour t'auto-évaluer** : demande à une personne âgée de ton entourage d'utiliser ton prototype. Si elle accomplit la tâche principale sans lunettes spéciales ni aide, tu as fait un grand pas.

## Vérifie tes acquis

1. Quel rapport de contraste minimal le niveau AA demande-t-il pour un texte normal ?
2. Pourquoi ne faut-il pas indiquer un état uniquement par la couleur ?
3. Quelle taille minimale recommander pour une zone tactile sur Android ?

> **Réponses** : 1. 4,5 pour 1. 2. Parce que les personnes daltoniennes ou malvoyantes risquent de ne pas percevoir la différence. 3. 48 × 48 dp.

## En résumé

- L'accessibilité permet à **tous** d'utiliser l'application, y compris dans des situations temporaires.
- Les **WCAG** reposent sur quatre principes : perceptible, utilisable, compréhensible, robuste.
- Contraste d'au moins **4,5:1**, jamais d'information par la couleur seule.
- Zones tactiles d'au moins **48 px**, formulaires avec étiquettes visibles et erreurs explicites.
- Penser aux **lecteurs d'écran** et utiliser un **langage clair**.

## Pour aller plus loin

- [Les règles WCAG présentées par le W3C, en français](https://www.w3.org/WAI/standards-guidelines/wcag/fr)
- Demande au mentor IA : « Fais-moi une checklist d'accessibilité en 15 points pour une application mobile. »
