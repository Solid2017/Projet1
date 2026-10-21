#!/usr/bin/env bash
# Construit et signe l'APK IgoTech IA, sans Android Studio.
#
# Prérequis (Ubuntu / Debian) :
#   sudo apt install openjdk-17-jdk-headless aapt dalvik-exchange zipalign apksigner android-sdk-platform-23
#
# Usage :
#   KEYSTORE_PASS='mot-de-passe' ./build.sh
#
# La clé de signature (igotech-release.jks) est créée au premier lancement.
# GARDE-LA PRÉCIEUSEMENT avec son mot de passe : sans elle, impossible de
# publier une mise à jour installable par-dessus l'application existante.
set -euo pipefail
cd "$(dirname "$0")"

SDK_JAR="${ANDROID_JAR:-/usr/lib/android-sdk/platforms/android-23/android.jar}"
KEYSTORE="${KEYSTORE:-igotech-release.jks}"
KEYSTORE_PASS="${KEYSTORE_PASS:?Définis KEYSTORE_PASS (mot de passe de la clé de signature)}"
OUT="${OUT:-../../assets/app/igotech-ia.apk}"
BUILD=build

VERSION_NAME=$(sed -n 's/.*android:versionName="\([^"]*\)".*/\1/p' AndroidManifest.xml)

rm -rf "$BUILD" && mkdir -p "$BUILD"/{gen,classes,dex}

# 1. Ressources -> R.java
aapt package -f -m -J "$BUILD/gen" -M AndroidManifest.xml -S res -I "$SDK_JAR"
mkdir -p "$BUILD/gen/tech/igotech/ia"
cat > "$BUILD/gen/tech/igotech/ia/BuildInfo.java" <<JAVA
package tech.igotech.ia;
final class BuildInfo { static final String VERSION_NAME = "$VERSION_NAME"; }
JAVA

# 2. Compilation Java (bytecode Java 8, compatible avec dx)
javac -nowarn -Xlint:-options -source 8 -target 8 -encoding UTF-8 \
  -bootclasspath "$SDK_JAR" -d "$BUILD/classes" \
  $(find src "$BUILD/gen" -name '*.java')

# 3. Bytecode Java -> classes.dex
dalvik-exchange --dex --min-sdk-version=23 --output="$BUILD/dex/classes.dex" "$BUILD/classes"

# 4. APK non signé (resources.arsc non compressé, exigé depuis Android 11)
aapt package -f -M AndroidManifest.xml -S res -I "$SDK_JAR" -0 arsc -F "$BUILD/unsigned.apk"
(cd "$BUILD/dex" && aapt add ../unsigned.apk classes.dex >/dev/null)

# 5. Alignement et signature (schémas v1, v2 et v3)
zipalign -f -p 4 "$BUILD/unsigned.apk" "$BUILD/aligned.apk"
if [ ! -f "$KEYSTORE" ]; then
  keytool -genkeypair -keystore "$KEYSTORE" -alias igotech -keyalg RSA -keysize 2048 \
    -validity 10000 -storepass "$KEYSTORE_PASS" -keypass "$KEYSTORE_PASS" \
    -dname "CN=IgoTech IA, O=IgoTech, L=N'Djamena, C=TD"
fi
apksigner sign --ks "$KEYSTORE" --ks-key-alias igotech --ks-pass "pass:$KEYSTORE_PASS" \
  --key-pass "pass:$KEYSTORE_PASS" --min-sdk-version 23 --v4-signing-enabled false --out "$OUT" "$BUILD/aligned.apk"
apksigner verify --print-certs "$OUT" | head -n 3
echo "APK prêt : $OUT (version $VERSION_NAME)"
