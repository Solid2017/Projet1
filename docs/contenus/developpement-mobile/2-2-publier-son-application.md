MarchéTchad fonctionne sur le téléphone d'Achta. Pour qu'il arrive dans les poches des commerçants de Moundou, Sarh ou Abéché, il faut le **publier**. Sur Android, la voie principale est le **Google Play Store**, mais ce n'est pas la seule. Ce chapitre te guide de la préparation de l'application jusqu'aux premières mises à jour.

> **Objectifs de ce chapitre**
> - Préparer une application pour la production
> - Signer et construire le paquet de publication
> - Créer une fiche Play Store convaincante
> - Connaître les autres canaux de distribution
> - Suivre et mettre à jour l'application après le lancement

## Préparer l'application

Avant de publier, vérifie ces points :

- **Identifiant unique** : chaque application a un identifiant, comme `td.marchetchad.app`. Il ne pourra plus jamais changer après la publication.
- **Nom et icône** : une icône lisible même en petit, sans texte.
- **Numéro de version** : dans `pubspec.yaml` en Flutter, par exemple `version: 1.0.0+1`. Le premier nombre (`1.0.0`) est la version affichée aux utilisateurs ; le second (`+1`) est un compteur qui doit **augmenter à chaque publication**.
- **Taille** : vise le plus léger possible ; compresse les images et retire les ressources inutilisées.
- **Politique de confidentialité** : obligatoire sur le Play Store dès que l'application collecte des données. Une simple page web qui explique quelles données sont collectées et pourquoi suffit pour commencer.

## Signer l'application

Android exige que chaque application soit **signée** avec une clé numérique : c'est ce qui prouve que les mises à jour viennent bien du même développeur.

```bash
keytool -genkey -v -keystore marchetchad-upload.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

On indique ensuite le chemin de cette clé dans la configuration du projet (fichier `android/key.properties` en Flutter), puis on construit le paquet de publication :

```bash
flutter build appbundle --release
```

Le fichier produit, au format **AAB** (*Android App Bundle*), est celui qu'on envoie sur le Play Store. Google génère ensuite des APK optimisés pour chaque type de téléphone, ce qui réduit la taille téléchargée par les utilisateurs.

> **Attention** : sauvegarde la clé de signature et son mot de passe à deux endroits sûrs, et **jamais** dans le dépôt Git. Avec la signature d'application par Google Play, une clé d'envoi perdue peut être réinitialisée, mais au prix de démarches pénibles.

## Publier sur le Google Play Store

1. Crée un compte **Google Play Console**. Des frais d'inscription uniques sont demandés (25 dollars au moment de la rédaction de ce cours ; vérifie le montant actuel).
2. Crée l'application et remplis la **fiche** : titre, description courte et longue, captures d'écran, icône, catégorie.
3. Remplis les questionnaires obligatoires : classification du contenu, public cible, sécurité des données.
4. Envoie l'AAB dans une piste de **test** d'abord. Pour les nouveaux comptes personnels, Google impose une période de test fermé avec un nombre minimal de testeurs avant de pouvoir publier pour tous : lis attentivement les conditions affichées dans la console.
5. Soumets pour examen. La validation prend de quelques heures à quelques jours.

## Une fiche qui donne envie

La fiche du Play Store est ta vitrine. Quelques conseils :

- un **titre** clair qui contient le mot que les gens tapent : « MarchéTchad : prix des marchés » ;
- une **description courte** qui dit le bénéfice en une phrase : « Les prix du mil, du sucre et de l'huile dans 10 marchés du Tchad, même sans connexion » ;
- des **captures d'écran** réelles, avec une courte légende sur chacune ;
- une mention de la **taille légère** et du **mode hors ligne**, de vrais arguments au Tchad.

## Les autres canaux de distribution

- **Fichier APK direct** : partagé par lien de téléchargement ou par WhatsApp. Pratique pour un test rapide avec quelques utilisateurs, mais l'utilisateur doit autoriser les « sources inconnues », ce qui est une mauvaise habitude de sécurité, et les mises à jour ne sont pas automatiques.
- **Autres boutiques** : certains fabricants de téléphones très présents en Afrique, comme Transsion (Tecno, Infinix, itel), Huawei ou Samsung, ont leurs propres boutiques d'applications.
- **Apple App Store** : pour iPhone, avec un compte développeur payant chaque année et un examen plus strict.

> **Info** : au lancement, le bouche-à-oreille et les groupes WhatsApp de commerçants seront probablement tes meilleurs canaux de promotion. Prépare un message court avec le lien direct vers la fiche Play Store.

## Après la publication

Publier n'est que le début :

- **Suis les plantages** (*crashes*) dans la Play Console ou avec un outil comme Firebase Crashlytics, et corrige-les en priorité.
- **Lis et réponds aux avis** : un utilisateur dont le problème est réglé change souvent sa note.
- **Mets à jour régulièrement** : augmente le numéro de version, construis un nouvel AAB, publie-le d'abord pour un petit pourcentage d'utilisateurs (déploiement progressif), puis pour tous si tout va bien.
- **Mesure l'usage** : combien d'installations, combien d'utilisateurs actifs, quels écrans sont les plus consultés.

## À toi de jouer

Prépare le **kit de lancement** de MarchéTchad :

1. Choisis l'identifiant de l'application et le numéro de la première version.
2. Rédige le titre (30 caractères maximum), la description courte (80 caractères maximum) et la description longue (10 lignes) de la fiche Play Store.
3. Liste les cinq captures d'écran à réaliser, avec leur légende.
4. Écris la politique de confidentialité en langage simple (données collectées, pourquoi, avec qui elles sont partagées, comment les supprimer).
5. Rédige le message WhatsApp d'annonce du lancement pour les groupes de commerçants.
6. Bonus : construis réellement l'AAB signé de ton projet Flutter.

> **Pour t'auto-évaluer** : demande à une personne non informaticienne de lire ta fiche Play Store. Si elle comprend en dix secondes à quoi sert l'application et pourquoi elle en aurait besoin, c'est réussi.

## Vérifie tes acquis

1. Quelle partie du numéro de version doit obligatoirement augmenter à chaque publication ?
2. Pourquoi faut-il sauvegarder soigneusement la clé de signature ?
3. Quel est l'inconvénient principal de la distribution d'un APK par WhatsApp ?

> **Réponses** : 1. Le numéro de build (le nombre après le `+` dans `pubspec.yaml`). 2. Parce qu'elle prouve que les mises à jour viennent du même développeur ; sa perte complique fortement la publication des mises à jour. 3. L'utilisateur doit autoriser les sources inconnues et les mises à jour ne sont pas automatiques.

## En résumé

- Avant publication : identifiant définitif, icône, version, taille réduite, politique de confidentialité.
- L'application est **signée** et construite au format **AAB** pour le Play Store.
- La Play Console demande une fiche complète, des questionnaires et souvent une phase de test.
- D'autres canaux existent : APK direct, boutiques des fabricants, App Store.
- Après le lancement : suivi des plantages, réponses aux avis, mises à jour progressives.

## Pour aller plus loin

- [Le guide de publication Android de Flutter](https://docs.flutter.dev/deployment/android)
- Demande au mentor IA : « Rédige-moi une description Play Store optimisée pour une application de prix des marchés au Tchad. »
