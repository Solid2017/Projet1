Au Tchad, un ordinateur est un investissement important. On le répare plutôt que de le remplacer, et un bon technicien de maintenance est toujours recherché, dans une boutique, une administration, une ONG ou à son compte. Pour réparer, il faut d'abord savoir comment l'ordinateur est construit et comment trouver méthodiquement d'où vient une panne.

Dans ce parcours, tu suis **Djibrine**, qui vient d'ouvrir un petit atelier de réparation informatique près du grand marché de N'Djamena.

> **Objectifs de ce chapitre**
> - Identifier les composants d'un ordinateur et leur rôle
> - Respecter les règles de sécurité avant d'ouvrir une machine
> - Assembler les éléments d'un ordinateur de bureau
> - Comprendre la séquence de démarrage
> - Appliquer une méthode de diagnostic

## Les composants essentiels

| Composant | Rôle | Analogie |
| --- | --- | --- |
| **Carte mère** | Relie tous les composants entre eux | Le squelette et le système nerveux |
| **Processeur** (CPU) | Exécute les calculs et les instructions | Le cerveau |
| **Mémoire vive** (RAM) | Stocke temporairement les programmes ouverts ; s'efface à l'extinction | Le plan de travail |
| **Stockage** (disque dur HDD ou SSD) | Conserve le système, les programmes et les fichiers | L'armoire |
| **Alimentation** | Transforme le courant du secteur pour les composants | Le cœur |
| **Carte graphique** (GPU) | Calcule l'affichage ; souvent intégrée au processeur | Les yeux |
| **Ventilateurs et radiateurs** | Évacuent la chaleur | Le système de refroidissement |

> **Info** : remplacer un vieux disque dur (HDD) par un **SSD** est souvent la réparation la plus rentable : l'ordinateur démarre en quelques secondes au lieu de plusieurs minutes. C'est un service très apprécié des clients.

## La sécurité avant tout

Avant d'ouvrir un ordinateur :

1. **Éteins** l'ordinateur et **débranche** le câble d'alimentation. Pour un portable, retire aussi la batterie si elle est amovible.
2. Appuie quelques secondes sur le bouton marche pour décharger le courant résiduel.
3. Décharge l'**électricité statique** de ton corps en touchant une partie métallique non peinte du boîtier, ou porte un **bracelet antistatique**. Une décharge invisible suffit à détruire une barrette de mémoire.
4. Travaille sur une surface propre, non métallique, bien éclairée, et range les vis dans des petites boîtes séparées.

> **Attention** : n'ouvre **jamais** un bloc d'alimentation ni un écran ancien à tube : ils contiennent des condensateurs qui peuvent rester chargés à des tensions dangereuses longtemps après le débranchement. Un bloc d'alimentation défectueux se remplace, il ne se répare pas.

## Assembler un ordinateur de bureau

L'ordre de montage habituel :

1. Installer le **processeur** sur la carte mère en respectant le repère (un petit triangle doré), sans jamais forcer.
2. Appliquer une fine couche de **pâte thermique** et fixer le **radiateur** avec son ventilateur.
3. Insérer les barrettes de **RAM** dans les bons emplacements, jusqu'au clic des loquets.
4. Fixer la **carte mère** dans le boîtier sur ses entretoises.
5. Installer l'**alimentation**, puis le **disque** ou le SSD.
6. Brancher les câbles : alimentation 24 broches de la carte mère, 4 ou 8 broches du processeur, câbles des disques, boutons de la façade.
7. Ajouter la carte graphique si besoin.
8. **Avant de refermer**, faire un premier démarrage de test.

## La séquence de démarrage

Quand on appuie sur le bouton :

1. L'alimentation fournit le courant aux composants.
2. Le micrologiciel de la carte mère (**BIOS** ou **UEFI**) lance l'autotest de démarrage, le **POST** : il vérifie le processeur, la mémoire, la carte graphique.
3. Si tout va bien, il cherche un support de démarrage (SSD, disque, clé USB) dans l'ordre configuré.
4. Il lance le **système d'exploitation** (Windows, Linux).

En cas de problème pendant le POST, beaucoup de cartes mères émettent des **bips** ou allument des **voyants** selon un code qui indique le composant en cause. Le code exact dépend du fabricant : consulte le manuel de la carte mère ou le site du constructeur.

## La méthode de diagnostic

Un bon technicien ne change pas des pièces au hasard. Il suit une méthode :

1. **Écouter le client** : que se passe-t-il exactement ? Depuis quand ? Qu'est-ce qui a changé (chute, orage, coupure de courant, nouvelle installation) ?
2. **Reproduire** la panne soi-même.
3. **Commencer par le plus simple** : le câble est-il branché ? la prise fonctionne-t-elle ? l'écran est-il allumé sur la bonne entrée ?
4. **Isoler** : ne garder que le minimum (carte mère, processeur, une barrette de RAM, alimentation) et ajouter les éléments un par un.
5. **Tester par substitution** : remplacer un composant suspect par un composant qu'on sait fonctionnel.
6. **Noter** chaque test et son résultat.

| Symptôme | Pistes à vérifier en premier |
| --- | --- |
| Rien ne se passe, aucun voyant | Prise, câble, interrupteur de l'alimentation, alimentation défectueuse |
| Les ventilateurs tournent, écran noir | Câble vidéo, RAM mal enfoncée (la retirer et la réinsérer), carte graphique |
| Bips au démarrage | Code de bips du fabricant : souvent la RAM ou la carte graphique |
| L'ordinateur s'éteint tout seul | Surchauffe : poussière, ventilateur bloqué, pâte thermique sèche |
| « Aucun périphérique de démarrage » | Disque débranché ou en panne, ordre de démarrage dans le BIOS |

> **Astuce** : au Tchad, la **poussière** et la **chaleur** sont responsables d'une grande partie des pannes. Un nettoyage à la bombe d'air sec (ou à la soufflette), ventilateurs bloqués pour ne pas qu'ils s'emballent, règle de nombreux arrêts inexpliqués. Propose-le systématiquement à tes clients.

## À toi de jouer

1. Si tu as accès à un vieil ordinateur de bureau, ouvre-le en respectant les règles de sécurité et identifie chaque composant. Prends des photos et légende-les.
2. Dresse la fiche technique de ton ordinateur avec l'outil gratuit **CPU-Z** (Windows) ou la commande `lshw -short` (Linux) : processeur, quantité de RAM, type de stockage.
3. Pour chacun des cas suivants, écris les trois premières vérifications que tu ferais :
   - un client dit que son ordinateur « ne s'allume plus depuis l'orage d'hier » ;
   - un ordinateur portable s'éteint après 20 minutes d'utilisation ;
   - au démarrage, l'écran affiche « No bootable device ».
4. Rédige un modèle de **fiche d'intervention** pour l'atelier de Djibrine : client, appareil, symptômes, tests réalisés, diagnostic, réparation, prix, garantie.

> **Éléments de correction pour l'étape 3** : après l'orage, vérifier la prise et la multiprise, tester avec un autre câble ou une autre alimentation, puis la carte mère. Pour le portable, nettoyer les aérations et le ventilateur, vérifier les températures, puis la pâte thermique. Pour « No bootable device », vérifier l'ordre de démarrage dans le BIOS, la détection du disque, puis l'état du disque.

## Vérifie tes acquis

1. Quelle est la différence entre la RAM et le stockage ?
2. Que vérifie le POST ?
3. Pourquoi faut-il toucher une partie métallique avant de manipuler des composants ?

> **Réponses** : 1. La RAM conserve temporairement les programmes en cours et s'efface à l'extinction ; le stockage conserve durablement les fichiers. 2. Le bon fonctionnement des composants essentiels au démarrage (processeur, mémoire, carte graphique). 3. Pour décharger l'électricité statique, qui peut détruire les composants.

## En résumé

- Carte mère, processeur, RAM, stockage, alimentation, carte graphique et refroidissement forment un ordinateur.
- **Débrancher**, décharger l'électricité statique, ne jamais ouvrir une alimentation.
- Le démarrage passe par le **BIOS/UEFI**, le **POST**, puis le système d'exploitation.
- Le diagnostic suit une méthode : écouter, reproduire, commencer simple, isoler, substituer, noter.
- Poussière et chaleur causent de nombreuses pannes : le nettoyage est un service essentiel.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi comment choisir un SSD compatible avec un ordinateur portable donné. »
