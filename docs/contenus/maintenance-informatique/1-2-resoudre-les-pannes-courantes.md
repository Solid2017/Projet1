Dans l'atelier de Djibrine, la plupart des clients n'arrivent pas avec un composant grillé, mais avec un ordinateur « devenu très lent », « plein de publicités », « qui ne s'allume plus correctement » ou une imprimante qui refuse d'imprimer. Ces pannes logicielles et courantes représentent l'essentiel du travail quotidien d'un technicien. Savoir les résoudre vite et proprement fait la réputation d'un atelier.

> **Objectifs de ce chapitre**
> - Diagnostiquer et accélérer un ordinateur lent
> - Supprimer virus et logiciels indésirables
> - Réparer un Windows qui démarre mal
> - Récupérer les données d'un client avant toute intervention
> - Résoudre les problèmes d'impression les plus fréquents

## La règle d'or : protéger les données du client

Avant toute intervention importante (réinstallation, réparation du disque), pose la question : « Y a-t-il des documents importants sur cet ordinateur ? » Puis **sauvegarde** les dossiers essentiels (Documents, Bureau, Images, Téléchargements, fichiers de comptabilité) sur un disque externe.

> **Attention** : une réinstallation qui efface les photos de famille ou la comptabilité d'une boutique, et ta réputation en souffre durablement. Fais signer au client une fiche indiquant si une sauvegarde a été faite et qui en porte la responsabilité.

## L'ordinateur lent

C'est la plainte numéro un. Les causes les plus fréquentes et leurs solutions :

| Cause | Vérification | Solution |
| --- | --- | --- |
| Trop de programmes au démarrage | Gestionnaire des tâches (**Ctrl+Maj+Échap**), onglet Démarrage | Désactiver les programmes inutiles au démarrage |
| Disque presque plein | Explorateur, propriétés du disque C: | Nettoyage de disque, suppression des fichiers inutiles |
| Disque dur mécanique fatigué | Gestionnaire des tâches : disque à 100 % en permanence | Remplacer par un SSD |
| Mémoire insuffisante | Gestionnaire des tâches, onglet Performance | Fermer des programmes, ajouter de la RAM |
| Logiciels malveillants | Analyse antivirus | Voir la section suivante |
| Surchauffe | Ventilateur bruyant, ordinateur brûlant | Nettoyage de la poussière |

Le **Gestionnaire des tâches** est ton premier outil : il montre en direct ce qui consomme le processeur, la mémoire et le disque.

> **Info** : l'outil intégré **Nettoyage de disque** (tape `cleanmgr` dans la recherche Windows), avec l'option « Nettoyer les fichiers système », libère souvent plusieurs gigaoctets d'anciennes mises à jour.

## Virus et logiciels indésirables

Symptômes typiques : publicités qui s'ouvrent seules, page d'accueil du navigateur modifiée, nouveaux programmes inconnus, fichiers dont l'extension a changé, clés USB dont les dossiers sont devenus des raccourcis.

La démarche :

1. **Déconnecter** l'ordinateur d'Internet pour limiter les dégâts.
2. Lancer une **analyse complète** avec **Microsoft Defender**, intégré à Windows 10 et 11 et efficace s'il est à jour.
3. Compléter avec un outil de seconde opinion gratuit comme **Malwarebytes** (version gratuite) pour les logiciels publicitaires.
4. Désinstaller les programmes inconnus (**Paramètres → Applications**) et réinitialiser les navigateurs.
5. Si l'infection est profonde ou s'il s'agit d'un **rançongiciel** (fichiers chiffrés, demande de rançon) : sauvegarder ce qui peut l'être, puis réinstaller complètement le système.

> **Astuce** : beaucoup d'infections au Tchad passent par les **clés USB** échangées entre cybercafés, bureaux et écoles. Conseille à tes clients d'analyser toute clé avant de l'ouvrir et de ne jamais exécuter un fichier inconnu qui s'y trouve.

## Windows démarre mal

### L'écran bleu

Note le **code d'arrêt** affiché (par exemple `MEMORY_MANAGEMENT` ou `CRITICAL_PROCESS_DIED`) et recherche-le : il oriente le diagnostic. La mémoire défectueuse se teste avec l'outil intégré **Diagnostic de mémoire Windows** (`mdsched`).

### Les outils de réparation

Si Windows échoue au démarrage plusieurs fois de suite, il propose l'**environnement de récupération**, avec :

- **Outil de redémarrage système** : répare automatiquement les problèmes de démarrage ;
- **Restauration du système** : revient à un point de restauration antérieur, sans toucher aux documents ;
- **Désinstaller les mises à jour** : utile si le problème est apparu juste après une mise à jour ;
- **Invite de commandes** : pour les réparations avancées.

Depuis une invite de commandes en administrateur, deux commandes réparent les fichiers système endommagés :

```text
sfc /scannow
DISM /Online /Cleanup-Image /RestoreHealth
```

Et pour vérifier les erreurs du disque : `chkdsk C: /f` (l'analyse se fera au prochain redémarrage).

## Les pannes d'impression

| Problème | Vérifications |
| --- | --- |
| L'imprimante n'imprime rien | Allumée, papier, câble ou Wi-Fi, bonne imprimante par défaut |
| Documents bloqués dans la file d'attente | Annuler tous les documents ; si besoin, redémarrer le service « Spouleur d'impression » |
| Impression pâle ou avec des traits | Niveau d'encre ou de toner, nettoyage des têtes (menu de l'imprimante) |
| Bourrage papier | Retirer le papier délicatement dans le sens de passage, vérifier qu'aucun morceau ne reste |
| Imprimante « hors ligne » | Réinstaller le pilote depuis le site du fabricant, vérifier l'adresse IP pour une imprimante réseau |

## À toi de jouer

1. Sur ton ordinateur, ouvre le Gestionnaire des tâches et relève les trois programmes qui consomment le plus de mémoire, puis la liste des programmes au démarrage. Lesquels pourraient être désactivés ?
2. Lance le Nettoyage de disque avec les fichiers système et note l'espace libéré.
3. Rédige une **procédure en 10 étapes** pour la prise en charge d'un « ordinateur lent » à l'atelier, de l'accueil du client à la remise de l'appareil.
4. Un client arrive : sa clé USB montre des raccourcis à la place de ses dossiers. Explique-lui en termes simples ce qui s'est passé et comment tu vas récupérer ses fichiers.
5. Crée une **grille de tarifs** indicative pour les interventions courantes de l'atelier (nettoyage, désinfection, réinstallation avec sauvegarde, remplacement par un SSD).

> **Pour l'étape 4** : un virus a caché les vrais dossiers et créé des raccourcis qui lancent le virus. Il ne faut surtout pas cliquer dessus. Les vrais fichiers sont généralement toujours sur la clé, simplement masqués : on analyse la clé, on supprime les raccourcis malveillants, puis on rend les dossiers à nouveau visibles.

## Vérifie tes acquis

1. Que faut-il toujours faire avant une réinstallation de Windows ?
2. Quel outil intégré permet de voir ce qui ralentit un ordinateur ?
3. Que fait la commande `sfc /scannow` ?

> **Réponses** : 1. Sauvegarder les données du client. 2. Le Gestionnaire des tâches. 3. Elle vérifie et répare les fichiers système de Windows endommagés.

## En résumé

- **Sauvegarder les données du client** avant toute intervention importante.
- Un ordinateur lent : programmes au démarrage, disque plein, disque mécanique, manque de RAM, virus, poussière.
- Contre les virus : déconnecter, analyser avec Defender et un outil complémentaire, réinstaller si nécessaire.
- L'**environnement de récupération**, `sfc` et `DISM` réparent un Windows qui démarre mal.
- Les pannes d'impression se résolvent souvent avec la file d'attente, l'encre ou le pilote.

## Pour aller plus loin

- Demande au mentor IA : « Comment récupérer les fichiers d'une clé USB infectée par un virus qui transforme les dossiers en raccourcis ? »
