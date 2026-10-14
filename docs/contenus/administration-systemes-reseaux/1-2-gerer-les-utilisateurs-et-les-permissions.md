Le serveur de fichiers de l'entreprise d'Abdelkerim est partagé par trois services : comptabilité, technique et commercial. Les techniciens ne doivent pas lire les fiches de paie, et un stagiaire ne doit pas pouvoir effacer la configuration du serveur. Sous Linux, ce contrôle repose sur les **utilisateurs**, les **groupes** et les **permissions**.

> **Objectifs de ce chapitre**
> - Créer et gérer des comptes utilisateurs et des groupes
> - Lire et modifier les permissions d'un fichier
> - Changer le propriétaire d'un fichier
> - Utiliser sudo de façon raisonnée
> - Appliquer le principe du moindre privilège

## Utilisateurs et groupes

Chaque personne (et chaque service, comme le serveur web) dispose d'un **compte utilisateur**. Les utilisateurs sont regroupés en **groupes**, ce qui permet de donner des droits à tout un service d'un coup.

```bash
sudo adduser fatime                    # créer un utilisateur (avec dossier personnel et mot de passe)
sudo groupadd compta                   # créer un groupe
sudo usermod -aG compta fatime         # ajouter fatime au groupe compta
groups fatime                          # voir les groupes de fatime
id fatime                              # identifiants numériques et groupes
sudo passwd -l stagiaire               # verrouiller un compte
sudo deluser --remove-home stagiaire   # supprimer un compte et son dossier
```

> **Attention** : dans `usermod -aG`, l'option `-a` (*append*, ajouter) est essentielle. Sans elle, l'utilisateur est retiré de tous ses autres groupes secondaires.

L'utilisateur **root** a tous les pouvoirs sur le système. On ne travaille jamais directement en root au quotidien.

## Lire les permissions

La commande `ls -l` affiche les permissions :

```text
-rw-r----- 1 fatime compta 2048 oct.  8 09:12 paie-octobre.xlsx
drwxr-x--- 2 root   compta 4096 oct.  8 09:00 comptabilite
```

Décomposons `-rw-r-----` :

| Position | Valeur | Signification |
| --- | --- | --- |
| 1 | `-` ou `d` | Fichier ordinaire ou dossier (*directory*) |
| 2 à 4 | `rw-` | Droits du **propriétaire** (fatime) |
| 5 à 7 | `r--` | Droits du **groupe** (compta) |
| 8 à 10 | `---` | Droits des **autres** utilisateurs |

Les trois droits :

- `r` (*read*) : lire le fichier, ou lister le contenu d'un dossier ;
- `w` (*write*) : modifier le fichier, ou créer et supprimer des fichiers dans un dossier ;
- `x` (*execute*) : exécuter le fichier (un script), ou **entrer** dans un dossier.

Ici, fatime peut lire et modifier la fiche de paie, les membres du groupe compta peuvent seulement la lire, et les autres n'y ont aucun accès.

## Modifier les permissions : chmod

### La notation symbolique

```bash
chmod u+x sauvegarde.sh      # ajouter l'exécution pour le propriétaire (u = user)
chmod g-w rapport.txt        # retirer l'écriture au groupe (g = group)
chmod o-rwx paie.xlsx        # retirer tous les droits aux autres (o = others)
```

### La notation octale

Chaque droit a une valeur : `r = 4`, `w = 2`, `x = 1`. On additionne pour chaque catégorie :

| Chiffre | Droits | Usage courant |
| --- | --- | --- |
| 7 | rwx | Propriétaire d'un script ou d'un dossier |
| 6 | rw- | Propriétaire d'un fichier |
| 5 | r-x | Lecture et accès à un dossier |
| 4 | r-- | Lecture seule |
| 0 | --- | Aucun accès |

```bash
chmod 640 paie-octobre.xlsx   # rw- r-- ---
chmod 750 comptabilite        # rwx r-x ---
chmod 600 ~/.ssh/id_ed25519   # clé privée SSH : lisible par son seul propriétaire
```

> **Attention** : `chmod 777` (tous les droits pour tout le monde) n'est jamais une solution, même quand « ça ne marche pas ». C'est une faille de sécurité ; cherche plutôt quel utilisateur a besoin de quel droit.

## Changer le propriétaire : chown

```bash
sudo chown fatime paie-octobre.xlsx            # nouveau propriétaire
sudo chown fatime:compta paie-octobre.xlsx     # propriétaire et groupe
sudo chown -R www-data:www-data /var/www/site  # récursif : tout le dossier du site web
```

Le serveur web (Apache ou Nginx) tourne souvent sous l'utilisateur `www-data`. Pour que le site puisse écrire dans un dossier d'envoi de fichiers, c'est cet utilisateur qui doit en avoir le droit, et lui seul.

## sudo : des droits d'administration contrôlés

`sudo` permet à un utilisateur autorisé d'exécuter une commande en tant que root, en saisissant **son propre** mot de passe. Chaque utilisation est enregistrée dans les journaux (`/var/log/auth.log`) : on sait qui a fait quoi.

```bash
sudo usermod -aG sudo abdelkerim   # donner les droits sudo (Debian, Ubuntu)
```

On ne donne les droits sudo qu'aux personnes qui administrent réellement le serveur.

## Le principe du moindre privilège

Chaque compte ne doit avoir **que les droits strictement nécessaires** à son travail. Appliqué au serveur de fichiers :

- un dossier par service, appartenant au groupe du service, en `770` ou `750` ;
- aucun accès pour les « autres » sur les dossiers sensibles ;
- les droits sudo réservés aux administrateurs ;
- les comptes des personnes parties désactivés le jour même.

## À toi de jouer

Mets en place le serveur de fichiers de l'entreprise :

1. Crée les groupes `compta`, `technique` et `commercial`.
2. Crée trois utilisateurs (un par service) et ajoute chacun à son groupe.
3. Crée les dossiers `/srv/partage/compta`, `/srv/partage/technique` et `/srv/partage/commercial`.
4. Donne à chaque dossier le bon groupe propriétaire et des permissions qui permettent aux membres du service de lire et écrire, sans aucun accès pour les autres.
5. Crée un dossier `/srv/partage/commun` lisible et modifiable par les trois services.
6. Vérifie en te connectant avec chaque utilisateur (`su - nom`) qu'il ne peut pas lire les dossiers des autres services.

> **Correction de l'étape 4** : par exemple `sudo chown root:compta /srv/partage/compta` puis `sudo chmod 770 /srv/partage/compta`, et de même pour les autres services. Pour `commun`, on peut créer un groupe `tous` contenant tout le monde, avec les mêmes réglages.

## Vérifie tes acquis

1. Que signifient les permissions `750` sur un dossier ?
2. Pourquoi l'option `-a` est-elle importante dans `usermod -aG` ?
3. Quel utilisateur doit souvent posséder les fichiers d'un site web ?

> **Réponses** : 1. Le propriétaire a tous les droits, le groupe peut lire et entrer dans le dossier, les autres n'ont aucun accès. 2. Sans elle, l'utilisateur perd ses autres groupes secondaires. 3. L'utilisateur du serveur web, souvent `www-data`.

## En résumé

- Linux gère les accès avec des **utilisateurs**, des **groupes** et des **permissions** `r`, `w`, `x`.
- Les permissions concernent trois catégories : propriétaire, groupe, autres.
- `chmod` modifie les droits (symbolique ou octal), `chown` change le propriétaire.
- `sudo` donne des droits d'administration temporaires et tracés.
- **Moindre privilège** : chacun n'a que les droits dont il a besoin. Jamais de `777`.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi le rôle du bit setgid sur un dossier partagé et quand l'utiliser. »
