Pendant des années, les enquêtes humanitaires se faisaient sur papier : des milliers de questionnaires remplis à la main, transportés jusqu'au bureau, puis ressaisis dans Excel pendant des semaines, avec des erreurs à chaque étape. Aujourd'hui, les enquêteurs utilisent des **formulaires numériques** sur téléphone ou tablette, qui fonctionnent même sans connexion et envoient les données dès qu'un réseau est disponible. Le technicien IT d'une ONG conçoit, déploie et maintient ces outils.

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

> **Info** : ces outils fonctionnent **hors ligne** : l'enquêteur télécharge le formulaire au bureau, remplit des dizaines de questionnaires dans les villages sans réseau, puis envoie tout au serveur dès qu'il retrouve une connexion.

## Concevoir un formulaire avec XLSForm

Un formulaire XLSForm est un simple **fichier Excel** avec deux feuilles principales.

### La feuille survey

| type | name | label | required | constraint | relevant |
| --- | --- | --- | --- | --- | --- |
| text | nom_village | Nom du village | yes | | |
| integer | taille_menage | Nombre de personnes dans le ménage | yes | . > 0 and . < 40 | |
| select_one oui_non | enfants_moins5 | Y a-t-il des enfants de moins de 5 ans ? | yes | | |
| integer | nb_enfants_moins5 | Combien d'enfants de moins de 5 ans ? | yes | . <= ${taille_menage} | ${enfants_moins5} = 'oui' |
| select_multiple sources_eau | source_eau | Quelles sources d'eau utilisez-vous ? | | | |
| geopoint | gps | Position GPS du ménage | | | |
| date | date_enquete | Date de l'enquête | yes | | |

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
- **label** : la question affichée à l'enquêteur ;
- **required** : réponse obligatoire ;
- **constraint** : une règle de validité (le point `.` désigne la réponse) ;
- **relevant** : la condition d'affichage de la question.

## Des données fiables dès la saisie

Les contraintes et conditions évitent la plupart des erreurs :

- `. > 0 and . < 40` refuse une taille de ménage aberrante ;
- `. <= ${taille_menage}` empêche d'avoir plus d'enfants que de personnes dans le ménage ;
- la condition `relevant` n'affiche la question sur le nombre d'enfants que si la réponse précédente est « oui » ;
- les **listes de choix** remplacent les réponses libres, ce qui évite les variantes d'écriture.

> **Astuce** : ajoute un **message de contrainte** (colonne `constraint_message`) clair pour l'enquêteur : « La taille du ménage doit être comprise entre 1 et 39 personnes. » Sans message, l'enquêteur bloque sans comprendre.

## Les langues

Les enquêtes se font souvent en arabe tchadien, en sara ou dans d'autres langues locales, même si le formulaire est rédigé en français. XLSForm permet plusieurs colonnes de libellés (`label::Français`, `label::Arabe`) : l'enquêteur choisit la langue dans l'application. Il faut aussi **former** les enquêteurs à traduire oralement les questions de façon cohérente.

## Tester avant de déployer

1. **Prévisualiser** le formulaire dans le navigateur (KoboToolbox le propose).
2. Le **tester sur un téléphone** comme le feront les enquêteurs.
3. Faire un **pilote** avec quelques vrais ménages, puis corriger les questions mal comprises.
4. **Télécharger les données du test** et vérifier qu'elles sont exploitables dans Excel.

> **Attention** : modifier un formulaire **en cours de collecte** peut créer des incohérences dans les données. Fais tous les tests avant le déploiement et, si une modification est vraiment nécessaire, crée une nouvelle version clairement identifiée.

## Préparer le terrain

- **Téléphones** : chargés, avec batteries externes ; écran lisible au soleil ; application installée et formulaire téléchargé au bureau.
- **Formation** des enquêteurs : utilisation de l'application, signification de chaque question, consentement des personnes interrogées.
- **Synchronisation** : définir quand et où les enquêteurs envoient leurs données (chaque soir, au retour à la base).
- **Supervision** : vérifier chaque jour les données reçues pour détecter rapidement les problèmes (enquêteur qui va trop vite, GPS absent, valeurs étranges).

## À toi de jouer

Ton ONG prépare une évaluation rapide de l'accès à l'eau dans 20 villages.

1. Crée un compte gratuit sur KoboToolbox.
2. Construis un formulaire XLSForm d'au moins 12 questions : identification du village et du ménage, sources d'eau, distance et temps de trajet, coût de l'eau, problèmes de santé liés à l'eau, position GPS.
3. Ajoute au moins 3 contraintes avec message, et 2 questions conditionnelles.
4. Ajoute une version en arabe des libellés d'au moins 5 questions.
5. Importe le formulaire dans KoboToolbox, déploie-le, remplis-le trois fois depuis l'application KoboCollect, puis télécharge les données en Excel.
6. Rédige une fiche de formation d'une page pour les enquêteurs.

> **Pour t'auto-évaluer** : essaie volontairement de saisir des réponses absurdes (ménage de 0 personne, 10 enfants dans un ménage de 5). Si ton formulaire les refuse avec un message clair, tes contraintes sont bien conçues.

## Vérifie tes acquis

1. Pourquoi les outils comme KoboToolbox sont-ils adaptés aux zones sans réseau ?
2. À quoi sert la colonne `relevant` dans un XLSForm ?
3. Pourquoi éviter de modifier un formulaire en cours de collecte ?

> **Réponses** : 1. Parce que le formulaire se remplit hors ligne et que les données sont envoyées plus tard, dès qu'une connexion est disponible. 2. À n'afficher une question que si une condition est remplie. 3. Parce que cela peut créer des données incohérentes entre les questionnaires remplis avant et après la modification.

## En résumé

- **KoboToolbox**, **ODK** et **CommCare** remplacent les questionnaires papier, avec un fonctionnement **hors ligne**.
- Un formulaire **XLSForm** est un fichier Excel : feuilles `survey` et `choices`.
- Les **contraintes**, les **conditions** et les **listes de choix** garantissent des données fiables dès la saisie.
- On **teste** et on fait un **pilote** avant de déployer.
- Matériel prêt, enquêteurs formés, synchronisation organisée et supervision quotidienne.

## Pour aller plus loin

- [La documentation de KoboToolbox](https://support.kobotoolbox.org/)
- Demande au mentor IA : « Aide-moi à écrire la contrainte XLSForm qui vérifie qu'un numéro de téléphone tchadien a bien 8 chiffres. »
