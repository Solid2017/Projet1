Une école privée de N'Djamena veut permettre aux parents de payer les frais de scolarité par mobile money. Aujourd'hui, les parents envoient l'argent sur un numéro, puis le comptable vérifie chaque paiement à la main en comparant les SMS : des heures de travail et beaucoup d'erreurs. La solution passe par deux technologies : l'**USSD**, que les parents utilisent sur n'importe quel téléphone, et les **API**, qui permettent au logiciel de l'école de dialoguer automatiquement avec la plateforme de paiement.

> **Objectifs de ce chapitre**
> - Comprendre le fonctionnement de l'USSD et de ses menus
> - Comprendre ce qu'est une API de paiement
> - Connaître les grandes étapes d'une intégration : collecte, confirmation, réconciliation
> - Comprendre le rôle des notifications (callbacks)
> - Connaître les règles de sécurité d'une intégration de paiement

## L'USSD

L'**USSD** (*Unstructured Supplementary Service Data*) est le service qui s'ouvre quand on compose un code commençant par `*` et finissant par `#`. Il présente des menus textuels interactifs :

```text
1. Transfert d'argent
2. Retrait
3. Paiement marchand
4. Factures
5. Mon compte
```

Ses avantages, décisifs au Tchad :

- il fonctionne sur **tous les téléphones**, même les plus simples, sans smartphone ;
- il ne consomme **pas de data** internet ;
- il fonctionne avec une couverture réseau minimale (2G).

Ses limites : une **session courte** (si l'utilisateur tarde à répondre, la session se ferme), des écrans de quelques lignes seulement, et une expérience peu adaptée aux opérations complexes.

### Comment fonctionne une session USSD

1. L'utilisateur compose le code ; le réseau ouvre une **session** et la transmet au serveur du service.
2. Le serveur renvoie un **menu** ; l'utilisateur répond par un chiffre.
3. Les échanges continuent jusqu'à ce que le serveur termine la session (« Opération réussie ») ou que le délai expire.

Une entreprise peut obtenir son propre **code USSD** auprès d'un opérateur ou d'un agrégateur, pour proposer ses services (consultation de solde scolaire, paiement de facture) directement depuis le menu du téléphone.

> **Astuce** : en concevant un menu USSD, garde au maximum 5 ou 6 choix par écran, des libellés très courts, et le moins d'étapes possible : chaque étape supplémentaire augmente le risque d'expiration de la session.

## Les API de paiement

Une **API** (*Application Programming Interface*) est une porte d'entrée qu'un système ouvre pour que d'autres programmes puissent communiquer avec lui, selon des règles précises. Une API de paiement permet par exemple au logiciel de l'école de :

- **demander un paiement** à un parent (on parle de **collecte**) ;
- **vérifier le statut** d'un paiement ;
- **envoyer de l'argent** (rembourser, payer un fournisseur : on parle de **décaissement**) ;
- **recevoir des notifications** quand un paiement est confirmé.

Les API modernes fonctionnent sur HTTPS et échangent des données au format **JSON**. L'accès se fait avec des **identifiants** fournis par l'opérateur ou l'agrégateur après signature d'un contrat marchand, et un environnement de **test** (*sandbox*) permet d'essayer sans argent réel.

## Le parcours d'un paiement par API

1. Le parent choisit sur le site ou l'application de l'école « Payer les frais du 1er trimestre : 45 000 FCFA » et saisit son numéro.
2. Le serveur de l'école envoie une **demande de collecte** à l'API, avec le montant, le numéro et une **référence unique** de commande.
3. La plateforme envoie au parent une demande de confirmation sur son téléphone (souvent une fenêtre USSD) ; il valide avec son **code PIN**. L'école ne voit jamais ce code.
4. La plateforme traite le paiement, puis envoie une **notification** au serveur de l'école (**callback** ou *webhook*) : « Paiement de la référence ECOLE-2026-0412 réussi ».
5. Le serveur de l'école **vérifie** le statut auprès de l'API, puis marque les frais comme payés et envoie un reçu au parent.

Exemple simplifié de demande, au format JSON (chaque fournisseur a son propre format, décrit dans sa documentation) :

```json
{
  "reference": "ECOLE-2026-0412",
  "montant": 45000,
  "devise": "XAF",
  "telephone": "23566123456",
  "description": "Frais de scolarité T1 - Achta Mahamat",
  "url_notification": "https://ecole-exemple.td/paiements/notification"
}
```

> **Info** : comme vu avec les intégrations de paiement de la plateforme IgoTech IA, certaines entreprises passent par un **agrégateur** qui donne accès à plusieurs opérateurs avec une seule API, d'autres signent directement avec chaque opérateur. Vérifie toujours que le service couvre bien le Tchad et les opérateurs souhaités avant de signer.

## Les règles de sécurité

- **Ne jamais faire confiance au navigateur** : un parent pourrait modifier le montant dans la page. Le montant se calcule et se vérifie toujours côté serveur.
- **Toujours vérifier la notification** : une notification reçue peut être falsifiée. On vérifie sa signature si le fournisseur en propose une, et on interroge l'API pour confirmer le statut réel avant de valider.
- **Une référence unique par paiement** et un traitement **idempotent** : si la même notification arrive deux fois, le paiement ne doit être enregistré qu'une seule fois.
- **Protéger les identifiants d'API** : jamais dans le code publié ni dans un dépôt Git, mais dans un fichier de configuration protégé.
- **Journaliser** chaque échange pour pouvoir analyser une réclamation.

## La réconciliation

Même avec une API, il faut **réconcilier** : comparer régulièrement les paiements enregistrés dans le logiciel de l'école avec le relevé de la plateforme de paiement. Les écarts révèlent les notifications perdues, les paiements en attente ou les erreurs. Une réconciliation automatique quotidienne, avec un rapport des écarts, est une bonne pratique.

## À toi de jouer

1. Conçois le **menu USSD** de l'école pour les parents : consultation du montant restant à payer, paiement d'un trimestre, réception du dernier reçu. Écris chaque écran (5 lignes maximum).
2. Dessine le **schéma** du parcours d'un paiement par API, avec les acteurs (parent, téléphone, serveur de l'école, plateforme de paiement) et les messages échangés.
3. Écris, en français structuré (pseudo-code), ce que doit faire le serveur de l'école quand il reçoit une notification de paiement, en intégrant les règles de sécurité.
4. Liste les colonnes d'un rapport de réconciliation quotidien et les types d'écarts à rechercher.

> **Correction possible pour l'étape 3** : recevoir la notification ; vérifier sa signature ; retrouver le paiement par sa référence (s'il n'existe pas, journaliser et ignorer) ; s'il est déjà marqué payé, ne rien faire (idempotence) ; interroger l'API pour confirmer le statut ; si le statut est « réussi » et le montant correct, marquer comme payé et envoyer le reçu ; dans tous les cas, journaliser et répondre au fournisseur que la notification est reçue.

## Vérifie tes acquis

1. Pourquoi l'USSD est-il si utilisé au Tchad ?
2. Qu'est-ce qu'un callback dans une intégration de paiement ?
3. Pourquoi faut-il vérifier le statut auprès de l'API même après avoir reçu une notification ?

> **Réponses** : 1. Parce qu'il fonctionne sur tous les téléphones, sans data internet et avec une couverture minimale. 2. Une notification envoyée par la plateforme de paiement au serveur du marchand pour l'informer du résultat d'un paiement. 3. Parce qu'une notification peut être falsifiée ou erronée : seule la confirmation par l'API fait foi.

## En résumé

- L'**USSD** offre des menus interactifs sur tous les téléphones, sans internet, avec des sessions courtes.
- Une **API de paiement** permet de collecter, vérifier, décaisser et recevoir des notifications, en JSON sur HTTPS.
- Le parcours : demande de collecte, validation par PIN sur le téléphone, notification, vérification, reçu.
- Sécurité : montant calculé côté serveur, notifications vérifiées, traitement idempotent, identifiants protégés.
- La **réconciliation** quotidienne détecte les écarts.

## Pour aller plus loin

- Demande au mentor IA : « Explique-moi l'idempotence avec un exemple de double notification de paiement. »
