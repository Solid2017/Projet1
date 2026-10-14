« Chez moi, ça marche ! » C'est la phrase la plus célèbre des développeurs. L'application tourne sur l'ordinateur d'Ibrahim avec PHP 8.2, mais le serveur a PHP 7.4 ; une bibliothèque manque ; une configuration diffère. **Docker** règle ce problème en emballant l'application avec **tout** ce dont elle a besoin dans un **conteneur**, qui fonctionne de la même façon partout.

> **Objectifs de ce chapitre**
> - Comprendre la différence entre conteneur et machine virtuelle
> - Distinguer image et conteneur
> - Lancer et gérer des conteneurs avec les commandes de base
> - Écrire un Dockerfile
> - Assembler plusieurs services avec Docker Compose

## Conteneur ou machine virtuelle ?

Une **machine virtuelle** simule un ordinateur complet, avec son propre système d'exploitation : elle est lourde (plusieurs Go) et lente à démarrer.

Un **conteneur** partage le noyau du système hôte et n'embarque que l'application et ses dépendances : il pèse souvent quelques dizaines de Mo et démarre en une seconde. Sur un même serveur, on peut faire tourner des dizaines de conteneurs.

Pense aux **conteneurs maritimes** qui arrivent au port de Douala puis par camion jusqu'à N'Djamena : quel que soit le contenu, ils ont une taille standard et se chargent de la même façon sur n'importe quel bateau ou camion. Docker applique ce principe au logiciel.

## Image et conteneur

- Une **image** est un modèle en lecture seule : le système de fichiers et la configuration de l'application. C'est la recette.
- Un **conteneur** est une instance en cours d'exécution d'une image. C'est le plat préparé à partir de la recette.

À partir d'une même image, on peut lancer plusieurs conteneurs. Les images publiques (PHP, MySQL, Nginx…) se trouvent sur **Docker Hub**.

## Les commandes essentielles

```bash
docker run -d --name web -p 8080:80 nginx   # lance un serveur web Nginx
docker ps                                   # liste les conteneurs en cours
docker logs web                             # affiche les journaux du conteneur
docker exec -it web sh                      # ouvre un terminal dans le conteneur
docker stop web && docker rm web            # arrête puis supprime le conteneur
docker images                               # liste les images téléchargées
```

L'option `-p 8080:80` relie le port 8080 de ta machine au port 80 du conteneur : ouvre `http://localhost:8080` pour voir la page d'accueil de Nginx. `-d` lance le conteneur en arrière-plan.

> **Info** : un conteneur est **éphémère** : si tu le supprimes, les fichiers créés dedans disparaissent. Pour garder des données (une base de données par exemple), on utilise un **volume**, un espace de stockage géré par Docker qui survit au conteneur.

## Écrire un Dockerfile

Pour emballer ta propre application, tu écris un **Dockerfile** à la racine du projet :

```dockerfile
FROM php:8.2-apache

RUN docker-php-ext-install pdo_mysql

COPY . /var/www/html/

EXPOSE 80
```

- `FROM` : l'image de départ (ici PHP 8.2 avec le serveur Apache).
- `RUN` : une commande exécutée pendant la construction (ici, installer l'extension PDO MySQL).
- `COPY` : copie le code du projet dans l'image.
- `EXPOSE` : documente le port utilisé.

On construit l'image puis on la lance :

```bash
docker build -t reservation-bus:1.0 .
docker run -d -p 8080:80 reservation-bus:1.0
```

## Plusieurs services avec Docker Compose

Une vraie application a besoin de plusieurs conteneurs : le site PHP et la base MySQL. **Docker Compose** les décrit dans un fichier `compose.yaml` :

```yaml
services:
  web:
    build: .
    ports:
      - "8080:80"
    depends_on:
      - db
  db:
    image: mysql:8.0
    environment:
      MYSQL_DATABASE: reservation
      MYSQL_ROOT_PASSWORD: change-moi
    volumes:
      - donnees-mysql:/var/lib/mysql

volumes:
  donnees-mysql:
```

Une seule commande lance tout : `docker compose up -d`. Et `docker compose down` arrête tout. Dans le code PHP, le serveur de base de données s'appelle simplement `db` : Compose crée un réseau où les services se trouvent par leur nom.

> **Attention** : le mot de passe écrit en clair dans `compose.yaml` convient pour apprendre en local. En production, on utilise un fichier `.env` exclu de Git, ou un gestionnaire de secrets.

## À toi de jouer

1. Installe Docker Desktop (Windows, Mac) ou Docker Engine (Linux).
2. Lance un conteneur Nginx sur le port 8080 et vérifie qu'il répond dans le navigateur.
3. Crée un dossier avec un fichier `index.php` qui affiche `phpversion()`, et un Dockerfile basé sur `php:8.2-apache`. Construis l'image et lance-la.
4. Ajoute un fichier `compose.yaml` avec un service `db` MySQL et un volume. Lance l'ensemble avec `docker compose up -d`.
5. Modifie `index.php` pour te connecter à la base avec PDO (hôte `db`) et afficher « Connexion réussie ».
6. Supprime les conteneurs avec `docker compose down`, relance-les, et vérifie que les données de la base sont toujours là grâce au volume.

> **Pour t'auto-évaluer** : un camarade doit pouvoir lancer ton projet complet sur sa machine avec seulement `git clone` puis `docker compose up -d`, sans rien installer d'autre que Docker.

## Vérifie tes acquis

1. Quelle est la différence entre une image et un conteneur ?
2. Que fait l'option `-p 8080:80` ?
3. Pourquoi utiliser un volume pour une base de données ?

> **Réponses** : 1. L'image est le modèle (la recette), le conteneur est une instance en cours d'exécution de cette image. 2. Elle relie le port 8080 de la machine hôte au port 80 du conteneur. 3. Pour que les données survivent à la suppression du conteneur.

## En résumé

- Un **conteneur** embarque une application et ses dépendances ; il est léger et identique partout.
- Une **image** est le modèle, un **conteneur** son exécution.
- `docker run`, `ps`, `logs`, `exec`, `stop` sont les commandes de base.
- Le **Dockerfile** décrit comment construire l'image de ton application.
- **Docker Compose** orchestre plusieurs services ; les **volumes** conservent les données.

## Pour aller plus loin

- [La documentation officielle de Docker](https://docs.docker.com/get-started/)
- Demande au mentor IA : « Comment réduire la taille de mon image Docker PHP ? »
