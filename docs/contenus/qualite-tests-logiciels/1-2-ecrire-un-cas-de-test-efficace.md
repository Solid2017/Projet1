Rokia doit tester la fonctionnalité « Payer une facture d'électricité » de TchadPay. Si elle se contente de « cliquer un peu partout », elle oubliera des cas importants et ne pourra pas refaire exactement les mêmes vérifications à la prochaine version. Elle va donc écrire des **cas de test** : des scénarios précis, reproductibles, que n'importe quel testeur pourra exécuter.

> **Objectifs de ce chapitre**
> - Connaître la structure d'un cas de test
> - Tester les cas nominaux, alternatifs et d'erreur
> - Appliquer les partitions d'équivalence et l'analyse des valeurs limites
> - Organiser les cas de test en campagne

## La structure d'un cas de test

| Champ | Exemple |
| --- | --- |
| Identifiant | CT-PAIE-001 |
| Titre | Paiement d'une facture d'électricité avec un solde suffisant |
| Préconditions | Utilisateur connecté, compte Mobile Money test avec 50 000 FCFA, facture n°F-2026-1042 de 12 500 FCFA impayée |
| Étapes | 1. Ouvrir « Factures ». 2. Choisir « Électricité ». 3. Saisir la référence F-2026-1042. 4. Valider. 5. Confirmer le paiement avec le code PIN de test. |
| Données | Référence F-2026-1042, PIN de test 0000 |
| Résultat attendu | Message « Paiement réussi », facture marquée payée, frais de 125 FCFA affichés, solde réduit de 12 625 FCFA, SMS de reçu envoyé |
| Priorité | Haute |

> **Attention** : le **résultat attendu** doit être précis et vérifiable. « Le paiement fonctionne » n'est pas un résultat attendu ; « le solde passe de 50 000 à 37 375 FCFA » en est un.

Une bonne règle : un autre testeur, qui ne connaît pas l'application, doit pouvoir exécuter ton cas de test et arriver à la même conclusion que toi.

## Couvrir les différents scénarios

Pour chaque fonctionnalité, on écrit des cas de test pour trois familles de scénarios :

- **Cas nominal** : tout se passe comme prévu (solde suffisant, référence valide, connexion stable).
- **Cas alternatifs** : chemins différents mais valides (paiement partiel autorisé, paiement de la facture d'un proche).
- **Cas d'erreur** : ce qui doit être refusé ou bien géré (solde insuffisant, référence inexistante, facture déjà payée, mauvais code PIN, perte de connexion pendant le paiement).

Les cas d'erreur sont souvent les plus révélateurs : c'est là que se cachent les bugs les plus graves, comme le double débit en cas de coupure réseau.

## Les partitions d'équivalence

On ne peut pas tester toutes les valeurs possibles. On regroupe les valeurs qui doivent se comporter de la même façon en **classes d'équivalence**, et on teste **une valeur par classe**.

Exemple : le montant d'un paiement doit être compris entre 500 et 500 000 FCFA.

| Classe | Exemple de valeur | Résultat attendu |
| --- | --- | --- |
| Trop petit | 200 | Refusé avec message d'erreur |
| Valide | 25 000 | Accepté |
| Trop grand | 800 000 | Refusé avec message d'erreur |
| Non numérique | « abc » | Refusé, saisie impossible ou message d'erreur |
| Vide | (rien) | Refusé |

## L'analyse des valeurs limites

Les erreurs se cachent très souvent **aux frontières**, à cause d'un `<` écrit à la place d'un `<=`. On teste donc précisément les limites et leurs voisines immédiates :

| Valeur | Résultat attendu |
| --- | --- |
| 499 | Refusé |
| 500 | Accepté |
| 501 | Accepté |
| 499 999 | Accepté |
| 500 000 | Accepté |
| 500 001 | Refusé |

> **Info** : ces deux techniques se combinent : les partitions d'équivalence choisissent une valeur représentative dans chaque classe, l'analyse des valeurs limites vérifie les frontières entre les classes.

## Organiser une campagne de test

Avant une mise en production, Rokia prépare une **campagne de test** :

1. Elle sélectionne les cas de test concernés par la nouvelle version, plus les tests de régression des fonctions critiques.
2. Elle les exécute et note le résultat de chacun : **réussi**, **échoué** ou **bloqué** (impossible à exécuter, par exemple parce que l'environnement de test est indisponible).
3. Pour chaque échec, elle crée une **fiche d'anomalie** (sujet du prochain chapitre).
4. Elle produit une **synthèse** : nombre de tests exécutés, réussis, échoués, anomalies bloquantes restantes, et sa recommandation pour la mise en production.

On utilise un tableur pour démarrer, puis un outil dédié (TestRail, Xray dans Jira, ou Qase) quand le nombre de cas de test augmente.

## À toi de jouer

La fonctionnalité « Transfert d'argent entre utilisateurs TchadPay » a les règles suivantes :

- montant entre 100 et 200 000 FCFA par transfert ;
- le numéro du destinataire doit être un numéro tchadien à 8 chiffres inscrit sur TchadPay ;
- frais de 1 % avec un minimum de 50 FCFA ;
- confirmation par code PIN, bloqué après 3 erreurs.

1. Identifie les classes d'équivalence pour le montant et pour le numéro du destinataire.
2. Liste les valeurs limites à tester pour le montant.
3. Rédige **6 cas de test complets** (avec la structure vue dans ce chapitre) : 2 nominaux et 4 d'erreur.
4. Calcule le résultat attendu des frais pour un transfert de 3 000 FCFA et pour un transfert de 50 000 FCFA.

> **Réponses de l'étape 4** : 1 % de 3 000 donne 30 FCFA, inférieur au minimum, donc 50 FCFA de frais. 1 % de 50 000 donne 500 FCFA de frais.

## Vérifie tes acquis

1. Quelles informations doit absolument contenir un cas de test ?
2. Pour un champ acceptant 1 à 10 articles, quelles valeurs limites tester ?
3. Que signifie un test au statut « bloqué » ?

> **Réponses** : 1. Au minimum un identifiant, des préconditions, des étapes, des données et un résultat attendu précis. 2. 0, 1, 2, 9, 10 et 11. 3. Qu'il n'a pas pu être exécuté, par exemple à cause d'un environnement indisponible ou d'une anomalie qui empêche d'atteindre l'étape.

## En résumé

- Un **cas de test** contient préconditions, étapes, données et un **résultat attendu précis**.
- On couvre les cas **nominaux**, **alternatifs** et **d'erreur**.
- Les **partitions d'équivalence** réduisent le nombre de tests : une valeur par classe.
- L'**analyse des valeurs limites** cible les frontières, où se cachent beaucoup de bugs.
- Une **campagne** regroupe l'exécution des tests et se termine par une synthèse.

## Pour aller plus loin

- Demande au mentor IA : « Voici une règle métier : [ta règle]. Aide-moi à trouver les classes d'équivalence et les valeurs limites. »
