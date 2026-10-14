Le jour du lancement de son application de transfert d'argent, une fintech découvre qu'un envoi de 100 000 FCFA est débité deux fois quand la connexion coupe au mauvais moment. Les clients sont furieux, la réputation est abîmée. Un bug trouvé en production coûte beaucoup plus cher qu'un bug trouvé pendant le développement. Le métier de **testeur** (ou ingénieur qualité, *QA*) consiste justement à trouver ces problèmes **avant** les utilisateurs.

Dans ce parcours, tu accompagnes **Rokia**, testeuse dans une fintech de N'Djamena qui développe **TchadPay**, une application de paiement de factures (eau, électricité, abonnements TV).

> **Objectifs de ce chapitre**
> - Comprendre à quoi servent les tests et leurs limites
> - Connaître les niveaux de test : unitaire, intégration, système, acceptation
> - Distinguer tests fonctionnels et non fonctionnels
> - Comprendre la pyramide des tests
> - Connaître le rôle des tests de régression

## Pourquoi tester ?

Tester, c'est **comparer** le comportement réel d'un logiciel à son comportement attendu, pour trouver des écarts. Les tests permettent :

- de **trouver des défauts** avant qu'ils n'atteignent les utilisateurs ;
- de **donner confiance** avant une mise en production ;
- de **réduire les risques** financiers, juridiques et d'image ;
- de vérifier qu'une correction n'a rien **cassé ailleurs**.

> **Info** : un principe fondamental : **les tests montrent la présence de défauts, jamais leur absence**. On ne peut pas tout tester ; on teste en priorité ce qui présente le plus de risques.

## Les niveaux de test

| Niveau | Ce qu'on teste | Qui | Exemple TchadPay |
| --- | --- | --- | --- |
| **Unitaire** | Une petite unité de code isolée (une fonction) | Développeur | La fonction qui calcule les frais : 1 % avec un minimum de 100 FCFA |
| **Intégration** | La communication entre plusieurs composants | Développeur, testeur | L'application et l'API de la société d'électricité échangent correctement les références de facture |
| **Système** | L'application complète, de bout en bout | Testeur | Un utilisateur se connecte, choisit sa facture, paie et reçoit son reçu |
| **Acceptation** | La conformité aux besoins réels | Client, utilisateurs | Les agents d'une agence vérifient que le parcours correspond à leurs attentes |

## Tests fonctionnels et non fonctionnels

- Les tests **fonctionnels** vérifient **ce que fait** le logiciel : le paiement est-il enregistré ? le reçu contient-il les bonnes informations ?
- Les tests **non fonctionnels** vérifient **comment** il le fait :

| Type | Question posée |
| --- | --- |
| Performance | L'application répond-elle en moins de 3 secondes, même à 2 000 paiements par heure en fin de mois ? |
| Sécurité | Peut-on voir les factures d'un autre client en modifiant un numéro dans l'adresse ? |
| Utilisabilité | Un nouvel utilisateur paie-t-il sa facture sans aide ? |
| Compatibilité | Fonctionne-t-elle sur Android 9 avec 2 Go de mémoire ? |
| Fiabilité | Que se passe-t-il si la connexion coupe pendant le paiement ? |

> **Attention** : au Tchad, les tests de **fiabilité en conditions réelles** sont essentiels : connexion lente, coupures, téléphones modestes. Une application parfaite en Wi-Fi au bureau peut être inutilisable sur le terrain.

## Tests en boîte noire et en boîte blanche

- En **boîte noire**, on teste sans regarder le code, à partir des spécifications : on donne des entrées et on vérifie les sorties. C'est l'approche la plus courante pour un testeur.
- En **boîte blanche**, on s'appuie sur la structure du code, par exemple pour vérifier que chaque condition `if` a été testée dans ses deux cas.

## La pyramide des tests

Les tests n'ont pas tous le même coût. La **pyramide des tests** recommande :

- une **large base de tests unitaires** : très rapides (des milliers en quelques secondes), peu coûteux, faciles à maintenir ;
- un **étage intermédiaire de tests d'intégration** ;
- une **petite pointe de tests de bout en bout** (interface complète) : lents, fragiles, mais indispensables pour les parcours critiques.

Une équipe qui ne fait que des tests manuels de bout en bout se retrouve avec une pyramide inversée : chaque vérification est longue et coûteuse, donc on teste moins, et les bugs passent.

## Les tests de régression

Une **régression** est un défaut qui apparaît dans une fonctionnalité qui marchait auparavant, à cause d'une modification ailleurs. Exemple : en ajoutant le paiement des abonnements TV, un développeur casse le calcul des frais des factures d'eau.

Les **tests de régression** consistent à rejouer régulièrement les tests des fonctionnalités existantes après chaque modification. C'est là que l'**automatisation** devient indispensable : on ne peut pas tout retester à la main à chaque livraison.

## À toi de jouer

Voici des vérifications prévues sur TchadPay. Pour chacune, indique le niveau de test (unitaire, intégration, système, acceptation) et s'il s'agit d'un test fonctionnel ou non fonctionnel :

1. La fonction `calculerFrais(5000)` renvoie 100.
2. L'application affiche les factures retournées par l'API de la société d'eau.
3. Un utilisateur paie sa facture d'électricité de bout en bout et reçoit un SMS de confirmation.
4. Le paiement de 500 utilisateurs simultanés reste sous 3 secondes.
5. Des commerçants de Moundou valident que le parcours est compréhensible.
6. Un utilisateur connecté ne peut pas afficher le reçu d'un autre client.

> **Réponses** : 1. Unitaire, fonctionnel (1 % de 5 000 donne 50, donc le minimum de 100 s'applique). 2. Intégration, fonctionnel. 3. Système, fonctionnel. 4. Système, non fonctionnel (performance). 5. Acceptation, non fonctionnel (utilisabilité). 6. Système, non fonctionnel (sécurité).

## Vérifie tes acquis

1. Les tests peuvent-ils prouver qu'un logiciel n'a aucun défaut ?
2. Quel niveau de test vérifie une seule fonction isolée ?
3. Qu'est-ce qu'une régression ?

> **Réponses** : 1. Non, ils montrent la présence de défauts, jamais leur absence. 2. Le test unitaire. 3. Un défaut qui apparaît dans une fonctionnalité qui fonctionnait auparavant, à la suite d'une modification.

## En résumé

- Tester, c'est comparer le comportement réel au comportement attendu pour **réduire les risques**.
- Quatre niveaux : **unitaire**, **intégration**, **système**, **acceptation**.
- Tests **fonctionnels** (ce que fait le logiciel) et **non fonctionnels** (performance, sécurité, utilisabilité…).
- La **pyramide** : beaucoup de tests unitaires, moins de tests de bout en bout.
- Les tests de **régression** vérifient que rien ne s'est cassé ; ils gagnent à être automatisés.

## Pour aller plus loin

- Demande au mentor IA : « Liste-moi 10 risques à tester en priorité sur une application de paiement mobile. »
