Chaque jour, tu ouvres Facebook, WhatsApp Web ou le site de ta banque sans y penser. Pourtant, entre le moment où tu tapes une adresse et celui où la page s'affiche, une dizaine d'étapes se déroulent en moins d'une seconde. Comprendre ces étapes, c'est la base de tout le métier de développeur web : tu sauras ensuite exactement où agit chaque ligne de code que tu écriras.

> **Objectifs de ce chapitre**
> - Comprendre la différence entre Internet et le web
> - Savoir ce que font le client, le serveur et le DNS
> - Lire une requête et une réponse HTTP
> - Connaître le rôle de HTML, CSS et JavaScript

## Internet et le web, ce n'est pas la même chose

**Internet** est le réseau physique : des fibres optiques (qui relient le Tchad aux grands câbles sous-marins de l'océan Atlantique), des antennes 4G, des routeurs. C'est la route.

**Le web** est un service qui circule sur cette route, comme les voitures. WhatsApp, les e-mails ou les jeux en ligne sont d'autres services qui utilisent la même route.

Le web a été inventé en 1989 par Tim Berners-Lee avec trois idées : des pages écrites en **HTML**, des adresses pour les retrouver (les **URL**) et un langage pour les demander (le protocole **HTTP**).

## Le client et le serveur

Sur le web, deux ordinateurs discutent :

- **Le client** : c'est ton navigateur (Chrome, Firefox, Opera Mini…). Il *demande* une page.
- **Le serveur** : c'est un ordinateur allumé en permanence dans un centre de données. Il *répond* en envoyant la page.

Pense à un restaurant à N'Djamena : tu es le client, tu passes commande au serveur, qui va en cuisine et te rapporte ton plat. Le navigateur passe commande, le serveur web prépare la page et la renvoie.

## Ce qui se passe quand tu tapes une adresse

Prenons l'adresse `https://ia.igotech.com/parcours`.

1. **Lecture de l'URL** : le navigateur repère le protocole (`https`), le nom de domaine (`ia.igotech.com`) et le chemin (`/parcours`).
2. **Résolution DNS** : un ordinateur ne connaît que des adresses IP (par exemple `203.0.113.10`). Le **DNS** est l'annuaire d'Internet : il traduit le nom de domaine en adresse IP.
3. **Connexion sécurisée** : avec HTTPS, le navigateur et le serveur se mettent d'accord sur une clé de chiffrement. Plus personne ne peut lire ce qui circule entre eux.
4. **Requête HTTP** : le navigateur envoie sa commande au serveur.
5. **Réponse HTTP** : le serveur renvoie un code de statut et le contenu de la page.
6. **Rendu** : le navigateur lit le HTML, télécharge le CSS, les images et le JavaScript, puis dessine la page à l'écran.

> **Info** : le cadenas à côté de l'adresse signifie que la connexion est en HTTPS. Ne saisis jamais un mot de passe ou un code Mobile Money sur un site sans cadenas.

## À quoi ressemble une requête HTTP ?

Une requête est un simple texte. Voici celle que ton navigateur envoie pour la page des parcours :

```http
GET /parcours HTTP/1.1
Host: ia.igotech.com
User-Agent: Mozilla/5.0 (Android 13)
Accept-Language: fr-FR
```

La première ligne contient l'essentiel : la **méthode** (`GET`, « donne-moi »), le **chemin** demandé et la version du protocole. Les lignes suivantes sont des **en-têtes** qui donnent des détails (le site visé, le type de téléphone, la langue préférée).

Les deux méthodes que tu utiliseras tout le temps :

| Méthode | Sert à | Exemple |
| --- | --- | --- |
| `GET` | Lire une page ou une donnée | Afficher la liste des parcours |
| `POST` | Envoyer des données au serveur | Valider un formulaire d'inscription |

## Et la réponse ?

```http
HTTP/1.1 200 OK
Content-Type: text/html; charset=UTF-8

<!DOCTYPE html>
<html lang="fr">
  ...
</html>
```

Le nombre `200` est le **code de statut**. Il indique au navigateur comment s'est passée la commande :

| Code | Signification | Quand tu le verras |
| --- | --- | --- |
| `200` | Tout va bien | La page s'affiche normalement |
| `301` | Déplacé définitivement | Une ancienne adresse redirige vers la nouvelle |
| `404` | Introuvable | Lien cassé ou faute de frappe dans l'URL |
| `403` | Accès interdit | Fichier protégé, comme un fichier de configuration |
| `500` | Erreur du serveur | Le code PHP du site a planté |

> **Astuce** : retiens que les codes en 4xx sont des erreurs du côté client (mauvaise demande) et les codes en 5xx des erreurs du côté serveur (le site a un problème).

## Les trois langages du navigateur

Une page web est presque toujours faite de trois couches. Imagine une maison :

- **HTML** est la structure : les murs, les pièces, les portes. Il dit « ceci est un titre, ceci est un paragraphe, ceci est un bouton ».
- **CSS** est la décoration : la peinture, les rideaux. Il dit « ce titre est bleu, ce bouton est arrondi ».
- **JavaScript** est l'électricité : il rend la maison vivante. Il dit « quand on clique sur ce bouton, affiche un message ».

Côté serveur, d'autres langages comme **PHP** préparent la page avant de l'envoyer : par exemple, aller chercher dans une base de données la liste de tes leçons terminées. Tu les découvriras dans le module 3.

## Front-end, back-end, full-stack

- Le **développeur front-end** travaille sur ce que l'utilisateur voit : HTML, CSS, JavaScript.
- Le **développeur back-end** travaille sur le serveur : PHP, bases de données, sécurité.
- Le **développeur full-stack** sait faire les deux. C'est l'objectif de ce parcours.

## À toi de jouer

Tu vas observer de vrais échanges HTTP avec les outils de développement de ton navigateur. Fais l'exercice sur un ordinateur, ou sur Chrome pour Android en mode « Version pour ordinateur ».

1. Ouvre un site que tu connais, par exemple `https://ia.igotech.com`.
2. Appuie sur **F12** (ou clic droit, puis **Inspecter**) et ouvre l'onglet **Réseau** (*Network*).
3. Recharge la page avec **F5**.
4. Clique sur la toute première ligne de la liste : c'est la page HTML elle-même.
5. Note la **méthode**, le **code de statut** et la valeur de l'en-tête `Content-Type`.
6. Maintenant, tape une adresse qui n'existe pas, par exemple `https://ia.igotech.com/page-imaginaire`. Quel code de statut obtiens-tu ?

> **Correction** : la première requête est un `GET` qui renvoie `200` avec `Content-Type: text/html`. La page imaginaire renvoie `404`. Tu remarqueras aussi des dizaines d'autres requêtes : une pour chaque image, feuille CSS et fichier JavaScript de la page.

## Vérifie tes acquis

1. Quel service traduit `ia.igotech.com` en adresse IP ?
2. Quelle méthode HTTP utilise un formulaire d'inscription ?
3. Un site affiche une erreur 500. Le problème vient-il de ton téléphone ou du site ?

> **Réponses** : 1. Le DNS. 2. `POST`, car on envoie des données au serveur. 3. Du site : les codes 5xx sont des erreurs du serveur.

## En résumé

- Internet est le réseau ; le web est un service qui l'utilise.
- Le navigateur (client) envoie une **requête HTTP** ; le serveur renvoie une **réponse** avec un **code de statut**.
- Le **DNS** traduit les noms de domaine en adresses IP.
- **HTTPS** chiffre l'échange : c'est le cadenas dans la barre d'adresse.
- Une page = **HTML** (structure) + **CSS** (style) + **JavaScript** (comportement).

## Pour aller plus loin

- [La documentation HTTP de MDN, en français](https://developer.mozilla.org/fr/docs/Web/HTTP) : méthodes, en-têtes et codes de statut expliqués en détail.
- Demande au mentor IA : « Explique-moi le rôle du DNS avec un exemple tchadien. »
