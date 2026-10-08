Au Tchad, l'immense majorité des internautes se connectent depuis un **smartphone Android**, souvent d'entrée de gamme, avec une connexion 3G ou 4G variable. Créer une application mobile, c'est donc toucher directement ces utilisateurs. Mais avant d'écrire la moindre ligne de code, il faut faire un choix technique important : développer en **natif** ou en **multiplateforme** ?

Dans ce parcours, tu accompagnes **Achta**, qui veut créer **MarchéTchad**, une application pour consulter les prix des produits de base (mil, sorgho, sucre, huile) dans les principaux marchés du pays.

> **Objectifs de ce chapitre**
> - Connaître les trois grandes approches du développement mobile
> - Comparer leurs avantages et leurs inconvénients
> - Choisir une approche selon le projet, le budget et le public
> - Tenir compte des réalités du marché tchadien

## Approche 1 : le natif

On développe une application **différente pour chaque système**, avec les outils officiels :

- **Android** : langage **Kotlin** (ou Java), avec Android Studio.
- **iOS** (iPhone) : langage **Swift**, avec Xcode, qui ne fonctionne que sur un Mac.

Avantages : les meilleures performances, l'accès immédiat à toutes les fonctionnalités du téléphone, une interface parfaitement conforme à chaque système.

Inconvénients : deux applications à écrire et à maintenir, donc deux fois plus de temps et souvent deux équipes.

## Approche 2 : le multiplateforme

On écrit **un seul code** qui produit une application Android **et** une application iOS. Les deux outils les plus utilisés :

| Outil | Langage | Porté par | Points forts |
| --- | --- | --- | --- |
| **Flutter** | Dart | Google | Interface identique partout, très bonnes performances, rechargement à chaud |
| **React Native** | JavaScript / TypeScript | Meta | Idéal pour les développeurs web qui connaissent déjà JavaScript et React |

Avantages : un seul code, une seule équipe, un développement nettement plus rapide.

Inconvénients : une couche supplémentaire entre ton code et le téléphone, parfois besoin d'écrire un peu de code natif pour des fonctions très spécifiques, et une application un peu plus lourde.

## Approche 3 : l'application web progressive (PWA)

Une **PWA** est un site web qui se comporte comme une application : on peut l'installer sur l'écran d'accueil, elle fonctionne en partie hors ligne et peut envoyer des notifications.

Avantages : pas de passage par le Play Store, une seule base de code web, mises à jour instantanées.

Inconvénients : accès plus limité aux fonctions du téléphone, moins visible qu'une application du Play Store, et une prise en charge plus restreinte sur iPhone.

> **Info** : beaucoup de projets commencent par une PWA ou un site mobile bien conçu pour tester l'idée à moindre coût, puis passent à une application quand le besoin est confirmé.

## Les critères de choix

| Critère | Questions à se poser |
| --- | --- |
| Public | Android seulement, ou aussi iPhone ? |
| Budget et délai | Combien de développeurs, combien de mois ? |
| Fonctionnalités | Besoin du GPS, de la caméra, du Bluetooth, du mode hors ligne ? |
| Performances | Jeu, vidéo, cartes complexes, ou simples formulaires et listes ? |
| Compétences | L'équipe connaît-elle JavaScript, Dart, Kotlin ? |
| Maintenance | Qui fera évoluer l'application dans deux ans ? |

## Les réalités du terrain au Tchad

Quelle que soit l'approche, quelques contraintes locales doivent guider la conception :

- **Téléphones modestes** : peu de mémoire et de stockage. Une application de 150 Mo sera désinstallée au premier manque de place.
- **Connexion instable et data coûteuse** : prévois un **mode hors ligne** (afficher les dernières données enregistrées) et limite la taille des images.
- **Langues** : français et arabe, avec l'écriture de droite à gauche pour l'arabe ; pense aussi aux utilisateurs peu à l'aise avec l'écrit (icônes claires, messages vocaux).
- **Batterie** : coupures d'électricité fréquentes, donc pas de tâches inutiles en arrière-plan.

> **Attention** : teste toujours ton application sur un téléphone d'entrée de gamme réel, pas seulement sur l'émulateur de ton ordinateur ou sur le smartphone haut de gamme d'un collègue.

## À toi de jouer

Achta te donne le cahier des charges de MarchéTchad :

- consulter les prix du jour dans 10 marchés (N'Djamena, Moundou, Sarh, Abéché…) ;
- consulter les derniers prix même sans connexion ;
- recevoir une notification quand le prix d'un produit suivi change ;
- public : commerçants et ménages, surtout sur Android d'entrée de gamme ;
- équipe : un seul développeur, qui connaît un peu JavaScript ; budget limité ; lancement dans 4 mois.

1. Compare les trois approches dans un tableau de critères.
2. Recommande une approche et justifie ce choix en cinq lignes.
3. Liste trois décisions de conception liées aux réalités du terrain.

> **Exemple de réponse** : Flutter (ou React Native, plus proche des compétences JavaScript du développeur) est un bon choix : une seule base de code, un bon mode hors ligne grâce au stockage local, des notifications, et un éventuel passage sur iPhone plus tard sans réécriture. Une PWA serait aussi défendable pour un premier test à très faible coût. Décisions terrain : cache local des prix, images très légères, interface en français et en arabe.

## Vérifie tes acquis

1. Quel langage utilise-t-on pour une application Android native moderne ?
2. Quel est le principal avantage d'un outil multiplateforme comme Flutter ?
3. Cite deux contraintes du terrain tchadien à prendre en compte dans la conception.

> **Réponses** : 1. Kotlin. 2. Un seul code pour Android et iOS, donc moins de temps et de coûts. 3. Par exemple : téléphones peu puissants, connexion instable et data coûteuse, langues française et arabe.

## En résumé

- **Natif** : performances maximales, mais une application par système.
- **Multiplateforme** (Flutter, React Native) : un seul code pour Android et iOS.
- **PWA** : un site installable, sans Play Store, plus limité.
- Le choix dépend du public, du budget, des fonctionnalités et des compétences de l'équipe.
- Au Tchad : applications légères, mode hors ligne et tests sur de vrais téléphones d'entrée de gamme.

## Pour aller plus loin

- Demande au mentor IA : « Quels sont les avantages et inconvénients de Flutter par rapport à React Native pour un développeur qui connaît JavaScript ? »
