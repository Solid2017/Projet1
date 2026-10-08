La grande majorité des serveurs qui font tourner Internet fonctionnent sous **Linux**, et on les administre presque toujours sans interface graphique, depuis un **terminal**. Savoir se déplacer, manipuler des fichiers et diagnostiquer un problème en ligne de commande est la compétence de base de tout administrateur système.

Dans ce parcours, tu suis **Abdelkerim**, technicien récemment embauché dans un fournisseur d'accès Internet de N'Djamena, qui découvre les serveurs Linux de l'entreprise.

> **Objectifs de ce chapitre**
> - Comprendre l'arborescence des fichiers Linux
> - Se déplacer et manipuler fichiers et dossiers
> - Lire et rechercher dans des fichiers texte
> - Surveiller les processus et l'espace disque
> - Installer des logiciels avec le gestionnaire de paquets

## Où pratiquer ?

Plusieurs options gratuites :

- une **machine virtuelle** Ubuntu avec VirtualBox sur ton ordinateur ;
- **WSL** (Windows Subsystem for Linux) sous Windows 10 ou 11 : `wsl --install` dans PowerShell ;
- sur Android, l'application **Termux**, qui offre un vrai terminal Linux sur ton téléphone.

## L'arborescence Linux

Sous Linux, tout part d'une seule racine, notée `/`. Pas de lecteur `C:` ou `D:` : les disques sont rattachés à des dossiers.

| Dossier | Contenu |
| --- | --- |
| `/home` | Les dossiers personnels des utilisateurs (`/home/abdelkerim`) |
| `/etc` | Les fichiers de configuration du système et des services |
| `/var/log` | Les journaux (logs) du système et des applications |
| `/var/www` | Souvent, les fichiers des sites web |
| `/tmp` | Les fichiers temporaires, effacés au redémarrage |
| `/root` | Le dossier personnel de l'administrateur (root) |

Le symbole `~` désigne ton dossier personnel. Un chemin **absolu** commence par `/` (`/etc/nginx`), un chemin **relatif** part du dossier où tu te trouves (`documents/rapport.txt`).

## Se déplacer

```bash
pwd                 # où suis-je ?
ls                  # que contient ce dossier ?
ls -la              # liste détaillée, fichiers cachés compris
cd /var/log         # aller dans un dossier
cd ..               # remonter d'un niveau
cd ~                # revenir dans mon dossier personnel
```

> **Astuce** : la touche **Tab** complète automatiquement les noms de fichiers et de commandes, et la flèche du haut rappelle les commandes précédentes. Ces deux réflexes te feront gagner un temps énorme.

## Manipuler fichiers et dossiers

```bash
mkdir sauvegardes                  # créer un dossier
touch notes.txt                    # créer un fichier vide
cp notes.txt notes-copie.txt       # copier
mv notes-copie.txt sauvegardes/    # déplacer (ou renommer)
rm sauvegardes/notes-copie.txt     # supprimer un fichier
rm -r sauvegardes                  # supprimer un dossier et son contenu
```

> **Attention** : sous Linux, il n'y a **pas de corbeille** en ligne de commande. Un fichier supprimé avec `rm` est perdu. Relis toujours une commande `rm -r` avant d'appuyer sur Entrée, surtout si tu es connecté en root.

## Lire et chercher dans des fichiers

```bash
cat /etc/hostname                 # afficher un petit fichier
less /var/log/syslog              # parcourir un gros fichier (q pour quitter)
head -n 20 fichier.log            # les 20 premières lignes
tail -n 50 /var/log/syslog        # les 50 dernières lignes
tail -f /var/log/nginx/error.log  # suivre un journal en direct (Ctrl+C pour arrêter)
grep "error" /var/log/syslog      # les lignes qui contiennent "error"
grep -ri "timeout" /etc/nginx     # recherche récursive, sans tenir compte des majuscules
```

Pour modifier un fichier de configuration, l'éditeur le plus simple est **nano** : `nano /etc/hosts`. On enregistre avec **Ctrl+O**, on quitte avec **Ctrl+X**.

## Enchaîner les commandes

Le caractère `|` (*pipe*) envoie le résultat d'une commande à la suivante. C'est l'une des grandes forces du terminal :

```bash
grep "Failed password" /var/log/auth.log | wc -l      # combien de tentatives de connexion échouées ?
ls -l /var/log | sort -k5 -n | tail -n 5               # les 5 plus gros fichiers de logs
```

Le symbole `>` enregistre le résultat dans un fichier (en l'écrasant), `>>` l'ajoute à la fin.

## Surveiller le système

```bash
df -h          # espace disque libre, en unités lisibles
du -sh /var/*  # taille de chaque dossier de /var
free -h        # mémoire vive utilisée et disponible
top            # processus en temps réel (q pour quitter) ; htop est plus lisible s'il est installé
ps aux | grep nginx   # le processus nginx tourne-t-il ?
uptime         # depuis quand le serveur tourne, et sa charge
```

## Installer des logiciels

Sur Debian et Ubuntu, le gestionnaire de paquets s'appelle **apt**. Les commandes d'administration nécessitent les droits d'administrateur, obtenus avec `sudo` :

```bash
sudo apt update            # mettre à jour la liste des paquets disponibles
sudo apt upgrade           # installer les mises à jour
sudo apt install htop      # installer un logiciel
sudo apt remove htop       # le désinstaller
```

> **Info** : `man` affiche le manuel de n'importe quelle commande (`man ls`). Et la plupart des commandes acceptent l'option `--help` pour un résumé rapide.

## À toi de jouer

Sur ta machine Linux :

1. Crée dans ton dossier personnel l'arborescence `formation/jour1/notes` en une seule commande (indice : cherche l'option `-p` de `mkdir`).
2. Crée un fichier `serveurs.txt` contenant cinq lignes de noms de serveurs, dont deux contenant le mot « web ».
3. Affiche uniquement les lignes contenant « web », puis compte-les avec un pipe.
4. Affiche l'espace disque disponible et la mémoire libre.
5. Installe `htop`, lance-le et repère le processus qui consomme le plus de mémoire.
6. Affiche les 10 dernières lignes du journal système (`/var/log/syslog` ou `journalctl -n 10`).

> **Correction de l'étape 3** : `grep "web" serveurs.txt` puis `grep "web" serveurs.txt | wc -l`, qui doit afficher 2.

## Vérifie tes acquis

1. Dans quel dossier trouve-t-on généralement les fichiers de configuration ?
2. Quelle commande permet de suivre un fichier de log en temps réel ?
3. Que fait le caractère `|` entre deux commandes ?

> **Réponses** : 1. `/etc`. 2. `tail -f`. 3. Il envoie le résultat de la première commande en entrée de la seconde.

## En résumé

- Linux organise tout à partir de la racine `/` : `/etc` pour la configuration, `/var/log` pour les journaux, `/home` pour les utilisateurs.
- `pwd`, `ls`, `cd` pour se déplacer ; `cp`, `mv`, `rm`, `mkdir` pour manipuler (sans corbeille !).
- `cat`, `less`, `tail -f` et `grep` pour lire et chercher ; `|` pour enchaîner.
- `df`, `free`, `top` et `ps` pour surveiller ; `apt` avec `sudo` pour installer.

## Pour aller plus loin

- Demande au mentor IA : « Donne-moi 10 défis en ligne de commande Linux de difficulté croissante, sans les solutions. »
