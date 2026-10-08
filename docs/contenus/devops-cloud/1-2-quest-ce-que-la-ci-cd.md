Dans la startup d'Ibrahim, la mise en ligne d'une nouvelle version se fait à la main : un développeur copie les fichiers par FTP le vendredi soir… et passe parfois le week-end à réparer ce qui a cassé. La **CI/CD** automatise ce processus : chaque modification est testée automatiquement, puis déployée de façon fiable et répétable.

> **Objectifs de ce chapitre**
> - Comprendre l'intégration continue (CI) et le déploiement continu (CD)
> - Connaître les étapes d'un pipeline
> - Lire et écrire un workflow GitHub Actions simple
> - Savoir où ranger les secrets d'un pipeline

## Le problème à résoudre

Sans automatisation, chaque mise en production comporte des risques : un test oublié, un fichier mal copié, une étape sautée par fatigue. Plus les mises en ligne sont rares, plus elles regroupent de changements, et plus elles sont risquées. C'est un cercle vicieux.

L'idée de la CI/CD est inverse : livrer **souvent**, par **petits** changements, avec des étapes **automatisées** et donc identiques à chaque fois.

## Intégration continue (CI)

À chaque `git push`, un serveur récupère le code et exécute automatiquement une série de vérifications :

- installation des dépendances ;
- vérification du style de code (*lint*) ;
- exécution des tests automatisés ;
- construction de l'application (*build*).

Si une étape échoue, le développeur est prévenu en quelques minutes, pendant que le changement est encore frais dans sa tête. On ne fusionne dans `main` que du code qui passe la CI.

## Livraison et déploiement continus (CD)

- **Livraison continue** (*Continuous Delivery*) : après la CI, l'application est prête à être déployée ; une personne valide la mise en production d'un clic.
- **Déploiement continu** (*Continuous Deployment*) : la mise en production est entièrement automatique dès que la CI réussit.

La plupart des équipes commencent par la livraison continue, en gardant une validation humaine.

## Le pipeline

L'enchaînement des étapes s'appelle un **pipeline** :

```text
push → installation → lint → tests → build → déploiement en préproduction → validation → production
```

L'environnement de **préproduction** (*staging*) est une copie de la production où l'on vérifie la nouvelle version avant de l'exposer aux vrais utilisateurs.

## Un exemple avec GitHub Actions

**GitHub Actions** permet de définir un pipeline dans un fichier YAML placé dans le dépôt, sous `.github/workflows/ci.yml` :

```yaml
name: CI

on:
  push:
    branches: [main]
  pull_request:

jobs:
  tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: shivammathur/setup-php@v2
        with:
          php-version: '8.2'
      - run: composer install --no-progress
      - run: php -l index.php
      - run: vendor/bin/phpunit
```

Ligne par ligne :

- `on` : le pipeline se déclenche à chaque push sur `main` et à chaque demande de fusion.
- `runs-on` : il s'exécute sur une machine Linux fournie par GitHub.
- `steps` : les étapes, dans l'ordre. `checkout` récupère le code, `setup-php` installe PHP, puis on installe les dépendances, on vérifie la syntaxe et on lance les tests.

> **Info** : GitLab propose l'équivalent avec GitLab CI (fichier `.gitlab-ci.yml`). Les concepts sont les mêmes ; seule la syntaxe change.

## Les secrets

Pour déployer, le pipeline a besoin d'informations sensibles : mot de passe FTP, clé SSH, clé d'API. Elles ne doivent **jamais** être écrites dans le fichier YAML. On les enregistre dans les **secrets** du dépôt (sur GitHub : *Settings → Secrets and variables → Actions*), puis on les utilise ainsi :

```yaml
      - run: ./deployer.sh
        env:
          CLE_SSH: ${{ secrets.CLE_SSH_SERVEUR }}
```

> **Attention** : un secret affiché par erreur dans les journaux d'exécution doit être considéré comme compromis. GitHub masque les secrets connus, mais pas leurs transformations : n'affiche jamais une variable sensible avec `echo`.

## Les bonnes pratiques

- Un pipeline **rapide** (moins de 10 minutes) : sinon les développeurs le contournent.
- Un pipeline **rouge** (en échec) se répare en priorité, avant toute nouvelle fonctionnalité.
- Les mêmes étapes pour tout le monde : personne ne déploie « à la main en vitesse ».
- Un moyen simple de **revenir en arrière** (*rollback*) si la nouvelle version pose problème.

## À toi de jouer

1. Sur GitHub, crée un dépôt public contenant un simple fichier `index.php`.
2. Ajoute le fichier `.github/workflows/ci.yml` qui vérifie la syntaxe PHP avec `php -l` à chaque push (sans Composer ni PHPUnit pour commencer).
3. Pousse un commit et observe l'exécution dans l'onglet **Actions**.
4. Introduis volontairement une erreur de syntaxe (un point-virgule manquant), pousse, et constate que le pipeline passe au rouge.
5. Corrige l'erreur et vérifie que le pipeline repasse au vert.

> **Pour t'auto-évaluer** : explique en trois phrases à un responsable non technique ce que le pipeline apporte à l'entreprise. Si ton explication parle de risques et de temps gagné plutôt que d'outils, c'est réussi.

## Vérifie tes acquis

1. Quelle est la différence entre livraison continue et déploiement continu ?
2. Où doit-on stocker le mot de passe du serveur utilisé par le pipeline ?
3. Que faire en priorité quand le pipeline de `main` est en échec ?

> **Réponses** : 1. En livraison continue, une personne valide la mise en production ; en déploiement continu, elle est automatique. 2. Dans les secrets du dépôt, jamais dans le fichier du pipeline. 3. Le réparer avant toute autre tâche.

## En résumé

- La **CI** vérifie automatiquement chaque modification (lint, tests, build).
- La **CD** prépare (livraison) ou réalise (déploiement) la mise en production automatiquement.
- Un **pipeline** enchaîne ces étapes ; GitHub Actions le décrit dans un fichier YAML.
- Les **secrets** se rangent dans le coffre-fort du dépôt, jamais dans le code.
- Livrer souvent par petits changements réduit les risques.

## Pour aller plus loin

- [La documentation de GitHub Actions](https://docs.github.com/fr/actions)
- Demande au mentor IA : « Comment ajouter à mon workflow GitHub Actions un déploiement automatique par SSH sur mon serveur ? »
