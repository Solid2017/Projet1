Avant de coder MarchéTchad, Achta veut comprendre de quoi est faite une application mobile. Derrière l'icône sur l'écran d'accueil se cachent des écrans, une navigation, des données stockées dans le téléphone, des échanges avec un serveur et un cycle de vie particulier. Ce chapitre te donne cette vue d'ensemble indispensable.

> **Objectifs de ce chapitre**
> - Identifier les composants d'une application mobile
> - Comprendre la navigation entre écrans
> - Connaître le cycle de vie d'une application
> - Savoir où et comment stocker des données
> - Comprendre la communication avec un serveur par API
> - Connaître le rôle des permissions

## Les écrans et la navigation

Une application est une suite d'**écrans** (on dit aussi pages ou vues). Pour MarchéTchad :

1. un écran **d'accueil** avec la liste des marchés ;
2. un écran **marché** avec les produits et leurs prix ;
3. un écran **détail produit** avec l'historique des prix ;
4. un écran **paramètres** (langue, produits suivis).

La **navigation** fonctionne comme une pile d'assiettes : quand on ouvre un écran, il est posé sur le dessus ; le bouton retour retire l'assiette du dessus et revient à l'écran précédent. On trouve aussi souvent une **barre d'onglets** en bas de l'écran pour passer d'une section principale à l'autre.

> **Astuce** : dessine toujours le parcours de l'utilisateur sur papier avant de coder : quels écrans, quels boutons, où mène chaque bouton. Tu gagneras des heures.

## Le cycle de vie

Contrairement à un site web, une application mobile peut être interrompue à tout moment : un appel entrant, un passage à WhatsApp, l'écran qui se verrouille. Elle passe par plusieurs états :

| État | Situation | Ce que l'application doit faire |
| --- | --- | --- |
| Au premier plan | L'utilisateur s'en sert | Fonctionner normalement |
| En arrière-plan | L'utilisateur est passé à une autre application | Sauvegarder ce qui est en cours, arrêter les tâches inutiles |
| Arrêtée | Le système l'a fermée pour libérer de la mémoire | Pouvoir reprendre proprement au prochain lancement |

> **Attention** : sur les téléphones avec peu de mémoire, Android ferme souvent les applications en arrière-plan. Si l'utilisateur remplissait un formulaire, enregistre son brouillon, sinon il perdra tout.

## Stocker des données dans le téléphone

Selon le besoin, plusieurs solutions :

- **Préférences clé-valeur** (SharedPreferences sur Android, `shared_preferences` en Flutter) : pour de petites informations comme la langue choisie ou le dernier marché consulté.
- **Base de données locale** (SQLite, Hive, Isar) : pour des listes structurées, comme tous les prix téléchargés, consultables hors ligne.
- **Fichiers** : pour les images ou documents téléchargés.
- **Stockage sécurisé** (Keystore, `flutter_secure_storage`) : pour les informations sensibles comme un jeton de connexion. Jamais de mot de passe en clair !

## Communiquer avec un serveur : les API

Les prix du jour ne sont pas dans l'application : ils sont sur un **serveur**, mis à jour par les agents de collecte. L'application les récupère par une **API** (interface de programmation), le plus souvent une API **REST** qui répond en **JSON** :

```text
GET https://api.marchetchad.td/marches/ndjamena/prix
```

```json
{
  "marche": "N'Djamena - Marché central",
  "date": "2026-10-08",
  "prix": [
    { "produit": "Mil", "unite": "coro", "prix": 1000 },
    { "produit": "Sucre", "unite": "kg", "prix": 900 }
  ]
}
```

Le schéma typique : l'application affiche d'abord les **données en cache** (déjà enregistrées), puis tente de récupérer les nouvelles données ; si elle y parvient, elle met à jour l'écran et le cache. L'utilisateur voit toujours quelque chose, même sans réseau.

> **Info** : le format JSON est le même que celui que tu as peut-être déjà manipulé en JavaScript. C'est le langage commun entre presque toutes les applications et leurs serveurs.

## Les permissions

Pour accéder à certaines fonctions sensibles, l'application doit demander l'accord de l'utilisateur : localisation, caméra, micro, contacts, notifications. Bonnes pratiques :

- ne demander que les permissions **vraiment nécessaires** ;
- les demander **au moment où on en a besoin**, avec une explication (« Pour afficher les marchés proches de vous ») ;
- prévoir le cas où l'utilisateur refuse : l'application doit continuer à fonctionner autrement.

## Le paquet de l'application

Une application Android est distribuée sous forme de fichier **APK** ou, pour le Play Store, **AAB**. Elle contient le code compilé, les ressources (images, traductions, icônes) et un fichier **manifeste** qui déclare son nom, sa version et ses permissions.

## À toi de jouer

Prépare la fiche d'architecture de MarchéTchad :

1. Dessine les écrans et les flèches de navigation entre eux.
2. Pour chaque donnée (langue choisie, produits suivis, prix téléchargés, jeton de connexion d'un agent de collecte), indique où la stocker et pourquoi.
3. Écris l'exemple de réponse JSON de l'API pour l'historique des prix d'un produit sur 7 jours.
4. Liste les permissions nécessaires et le message d'explication montré à l'utilisateur pour chacune.

> **Éléments de correction** : langue et produits suivis dans les préférences ; prix dans une base locale pour le hors ligne ; jeton dans le stockage sécurisé. Permissions : notifications (« pour vous prévenir quand un prix change ») et éventuellement localisation (« pour afficher les marchés proches »), facultative.

## Vérifie tes acquis

1. Pourquoi une application doit-elle sauvegarder les données en cours quand elle passe en arrière-plan ?
2. Où stocker un jeton de connexion sur le téléphone ?
3. Quel format de données utilisent la plupart des API REST ?

> **Réponses** : 1. Parce que le système peut la fermer à tout moment pour libérer de la mémoire. 2. Dans le stockage sécurisé du système. 3. Le JSON.

## En résumé

- Une application est faite d'**écrans** reliés par une **navigation** en pile.
- Son **cycle de vie** impose de sauvegarder les données quand elle passe en arrière-plan.
- Préférences, base locale, fichiers et stockage sécurisé répondent à des besoins différents.
- Les données viennent d'un serveur par une **API REST** en **JSON** ; le cache permet le hors ligne.
- Les **permissions** se demandent au bon moment, avec une explication.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi la stratégie cache d'abord puis réseau pour une application mobile hors ligne. »
