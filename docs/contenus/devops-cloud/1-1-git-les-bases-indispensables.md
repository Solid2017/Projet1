« Le site marchait hier, quelqu'un a modifié un fichier et tout est cassé… mais personne ne sait quoi. » Ce scénario, toutes les équipes l'ont vécu avant d'adopter **Git**. Git est un **système de gestion de versions** : il enregistre l'historique complet de ton code, permet de revenir en arrière et de travailler à plusieurs sans s'écraser mutuellement. C'est la compétence numéro un demandée à tout développeur et à tout profil DevOps.

Dans ce parcours, tu suis **Ibrahim**, développeur dans une startup de N'Djamena qui édite une application de réservation de bus entre N'Djamena, Moundou et Abéché.

> **Objectifs de ce chapitre**
> - Comprendre le fonctionnement de Git : dépôt, commit, historique
> - Utiliser les commandes essentielles au quotidien
> - Travailler avec des branches
> - Collaborer via un dépôt distant (GitHub, GitLab)
> - Résoudre un conflit simple

## Les notions clés

- Un **dépôt** (*repository*) est un dossier suivi par Git, avec tout son historique.
- Un **commit** est une photo de l'état des fichiers à un instant donné, accompagnée d'un message qui explique le changement.
- L'**historique** est la suite de tous les commits.
- Une **branche** est une ligne de travail parallèle : on y développe une fonctionnalité sans toucher à la version stable.

## Les trois zones de Git

Avant d'être enregistré dans l'historique, un changement passe par trois étapes :

1. Le **répertoire de travail** : tes fichiers tels que tu les modifies.
2. La **zone de préparation** (*staging area*) : les changements que tu as choisis d'inclure dans le prochain commit, avec `git add`.
3. Le **dépôt** : l'historique, une fois le commit créé avec `git commit`.

Cette étape intermédiaire permet de faire des commits propres, qui ne regroupent que des changements liés entre eux.

## Démarrer

```bash
git config --global user.name "Ibrahim Abakar"
git config --global user.email "ibrahim@exemple.td"

mkdir reservation-bus && cd reservation-bus
git init
```

## Le cycle quotidien

```bash
git status                       # que s'est-il passé depuis le dernier commit ?
git add index.php                # préparer un fichier
git add .                        # ou tous les fichiers modifiés
git commit -m "Ajoute la page de recherche de trajets"
git log --oneline                # voir l'historique résumé
git diff                         # voir les modifications pas encore préparées
```

> **Astuce** : un bon message de commit décrit **ce que fait** le changement, à l'impératif : « Corrige le calcul du prix des billets » plutôt que « modif » ou « correction ». Dans six mois, tu remercieras ton toi d'aujourd'hui.

## Le fichier .gitignore

Certains fichiers ne doivent jamais entrer dans Git : mots de passe, fichiers de configuration locaux, dossiers de dépendances, fichiers temporaires. On les liste dans un fichier `.gitignore` :

```text
config/config.php
.env
vendor/
node_modules/
*.log
```

> **Attention** : un mot de passe commité reste dans l'historique même si tu supprimes le fichier ensuite. Si cela arrive sur un dépôt public, considère le mot de passe comme compromis et change-le immédiatement.

## Les branches

```bash
git switch -c paiement-mobile-money   # créer une branche et s'y placer
# ... modifications et commits ...
git switch main                       # revenir sur la branche principale
git merge paiement-mobile-money       # intégrer le travail de la branche
git branch -d paiement-mobile-money   # supprimer la branche fusionnée
```

La branche `main` contient la version stable, celle qui est en production. Chaque nouvelle fonctionnalité se développe sur sa propre branche, puis on la fusionne quand elle est prête et testée.

## Travailler avec un dépôt distant

Pour collaborer, l'équipe partage un dépôt en ligne sur **GitHub**, **GitLab** ou **Bitbucket** :

```bash
git clone https://github.com/startup-td/reservation-bus.git   # récupérer un projet existant
git pull                                                     # récupérer les nouveautés des collègues
git push                                                     # envoyer tes commits
```

Le flux classique en équipe : créer une branche, pousser la branche, ouvrir une **demande de fusion** (*pull request* sur GitHub, *merge request* sur GitLab), faire relire le code par un collègue, puis fusionner.

## Résoudre un conflit

Si deux personnes modifient la même ligne, Git ne peut pas choisir à leur place : c'est un **conflit**. Il l'indique dans le fichier :

```text
<<<<<<< HEAD
$prixBillet = 15000;
=======
$prixBillet = 17500;
>>>>>>> nouveaux-tarifs
```

Tu choisis la bonne version (ou tu combines les deux), tu supprimes les marqueurs `<<<<<<<`, `=======` et `>>>>>>>`, puis :

```bash
git add tarifs.php
git commit -m "Résout le conflit sur le prix des billets"
```

## À toi de jouer

1. Crée un dossier `reservation-bus`, initialise un dépôt Git et ajoute un fichier `README.md` décrivant le projet. Fais un premier commit.
2. Crée un fichier `.gitignore` qui exclut `config.php` et les fichiers `.log`.
3. Crée une branche `page-tarifs`, ajoute un fichier `tarifs.txt` avec trois trajets et leurs prix, et commite.
4. Reviens sur `main`, modifie le `README.md`, commite, puis fusionne `page-tarifs`.
5. Provoque volontairement un conflit : modifie la même ligne de `tarifs.txt` sur deux branches différentes, puis fusionne et résous le conflit.
6. Affiche l'historique avec `git log --oneline --graph`.

> **Pour t'auto-évaluer** : si tu peux expliquer à un camarade, en regardant le graphe de `git log --graph`, à quel moment chaque branche a été créée et fusionnée, tu as compris l'essentiel de Git.

## Vérifie tes acquis

1. Quelle commande prépare un fichier pour le prochain commit ?
2. À quoi sert le fichier `.gitignore` ?
3. Que dois-tu faire si Git signale un conflit ?

> **Réponses** : 1. `git add`. 2. À indiquer les fichiers que Git doit ignorer (secrets, dépendances, fichiers temporaires). 3. Ouvrir le fichier, choisir le bon contenu, supprimer les marqueurs de conflit, puis faire `git add` et `git commit`.

## En résumé

- Git enregistre l'**historique** du code sous forme de **commits**.
- Cycle quotidien : `git status`, `git add`, `git commit`, `git log`.
- Les **branches** isolent chaque fonctionnalité ; `git merge` les intègre.
- `git clone`, `git pull` et `git push` synchronisent avec un dépôt distant.
- Jamais de secrets dans Git : utilise `.gitignore`.

## Pour aller plus loin

- [Le livre Pro Git, gratuit et en français](https://git-scm.com/book/fr/v2)
- Demande au mentor IA : « Quelle est la différence entre git merge et git rebase ? Quand utiliser l'un ou l'autre ? »
