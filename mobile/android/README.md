# Application Android IgoTech IA

Application Android légère (≈ 55 Ko) qui affiche la plateforme web dans une WebView.
Elle utilise donc **les mêmes comptes et la même base de données** que le site.

- Paquet : `tech.igotech.ia` · Android 6 (API 23) minimum · cible Android 14 (API 34)
- Adresse affichée : `res/values/strings.xml` → `app_url`
- Version : `AndroidManifest.xml` → `android:versionCode` (à augmenter de 1 à chaque mise à jour) et `android:versionName`
- Le user-agent se termine par `IgoTechApp/<version>` : le site s'en sert pour ne pas proposer l'application… dans l'application.

## Fonctionnalités

- Navigation dans le site, bouton Retour du téléphone, barre de chargement
- WhatsApp (`wa.me`), téléphone, e-mail, LinkedIn et autres sites ouverts dans l'application adaptée
- Envoi d'une photo de profil depuis la galerie
- Écran « Pas de connexion » avec bouton Réessayer
- Session conservée entre deux ouvertures (cookies)

## Construire l'APK

Sur Ubuntu ou Debian, sans Android Studio :

```bash
sudo apt install openjdk-17-jdk-headless aapt dalvik-exchange zipalign apksigner android-sdk-platform-23
cd mobile/android
KEYSTORE=/chemin/vers/igotech-release.jks KEYSTORE_PASS='mot-de-passe' ./build.sh
```

L'APK signé est écrit dans `assets/app/igotech-ia.apk`, prêt à être envoyé sur le serveur.

**La clé de signature `igotech-release.jks` et son mot de passe ne sont pas dans le dépôt.**
Conserve-les en lieu sûr (et en double) : Android refuse d'installer une mise à jour signée
avec une autre clé. Si la clé est perdue, chaque utilisateur devra désinstaller l'ancienne
application avant d'installer la nouvelle.
