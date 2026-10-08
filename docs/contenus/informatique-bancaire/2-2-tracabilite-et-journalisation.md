Un client conteste un retrait de 500 000 FCFA effectué sur son compte il y a trois mois. Qui a saisi l'opération ? Depuis quel poste ? Qui l'a validée ? À quelle heure exacte ? Le plafond a-t-il été modifié juste avant ? Pour répondre, la banque doit pouvoir **retrouver la trace** de chaque action dans ses systèmes. C'est le rôle de la **journalisation** : enregistrer qui fait quoi, quand et d'où, de façon fiable et inaltérable.

> **Objectifs de ce chapitre**
> - Comprendre à quoi servent les journaux dans une banque
> - Savoir quels événements enregistrer et quelles informations y mettre
> - Garantir l'intégrité et la conservation des journaux
> - Centraliser et analyser les journaux
> - Utiliser les journaux lors d'une enquête

## À quoi servent les journaux ?

- **Prouver** : en cas de litige avec un client, de fraude ou de contrôle du régulateur.
- **Détecter** : repérer une attaque ou un comportement anormal, idéalement pendant qu'il se produit.
- **Comprendre** : reconstituer le déroulement d'un incident pour corriger et éviter qu'il se reproduise.
- **Dissuader** : un employé qui sait que ses actions sont tracées hésite davantage à frauder.

## Quels événements enregistrer ?

| Domaine | Événements |
| --- | --- |
| **Authentification** | Connexions réussies et échouées, déconnexions, verrouillages de compte |
| **Habilitations** | Création, modification et suppression de comptes utilisateurs et de profils |
| **Opérations sensibles** | Saisie, validation, annulation des transactions ; dépassements de plafond |
| **Données clients** | Modification des coordonnées, consultation de comptes sensibles (personnalités, employés) |
| **Paramétrage** | Changement des taux, frais, plafonds, règles |
| **Administration technique** | Accès aux serveurs et bases de données, commandes d'administration, modifications de configuration |
| **Sécurité** | Alertes antivirus, blocages du pare-feu, tentatives d'accès refusées |

## Le contenu d'une ligne de journal

Une bonne entrée de journal répond aux questions **qui, quoi, quand, où, sur quoi, avec quel résultat** :

```text
2026-10-08T14:32:07+01:00 | utilisateur=a.mahamat | profil=CAISSIER | poste=AG-MOU-G03 | ip=10.20.3.17
action=RETRAIT | compte=0012****4589 | montant=500000 XAF | reference=TRX-88412 | resultat=EN_ATTENTE_VALIDATION
```

- **L'horodatage** précis, avec le fuseau horaire.
- **L'identité** de l'utilisateur (nominative, jamais un compte partagé).
- **Le poste** ou l'adresse IP d'origine.
- **L'action** et **l'objet** concerné.
- **Le résultat** : réussi, refusé, en attente.

> **Attention** : ne journalise jamais de **mots de passe**, de **codes PIN** ni de numéros de carte complets. Masque les données sensibles (`0012****4589`). Un journal qui contient des secrets devient lui-même une cible.

## La synchronisation des horloges

Pour reconstituer un incident à partir des journaux de plusieurs systèmes (core banking, serveur d'application mobile, pare-feu), il faut que leurs horloges soient **synchronisées**. Tous les serveurs se règlent sur une même source de temps grâce au protocole **NTP**. Un décalage de quelques minutes entre deux serveurs suffit à rendre une enquête très difficile.

## Intégrité et conservation

Un journal n'a de valeur que s'il est **fiable**. Un administrateur malveillant ne doit pas pouvoir effacer la trace de ses propres actions.

- **Envoyer les journaux en temps réel vers un serveur central** dédié, administré par une équipe différente de celle des systèmes surveillés.
- **Protéger contre la modification** : droits d'écriture seulement en ajout, stockage non modifiable, empreintes cryptographiques qui permettent de détecter toute altération.
- **Conserver** les journaux pendant la durée exigée par la réglementation et la politique de l'établissement, avec des **sauvegardes**.
- **Contrôler l'accès** aux journaux eux-mêmes, et journaliser ces accès.

> **Info** : la durée de conservation dépend du type de journal et des exigences applicables. Elle est fixée par la politique de l'établissement, en lien avec la conformité et la réglementation. Les journaux d'opérations doivent souvent être conservés plusieurs années.

## Centraliser et analyser : le SIEM

Avec des millions d'événements par jour, impossible de tout lire. Les banques utilisent un **SIEM** (*Security Information and Event Management*), un outil qui :

- **collecte** et centralise les journaux de tous les systèmes ;
- **corrèle** les événements de sources différentes ;
- déclenche des **alertes** selon des règles ;
- permet des **recherches** rapides lors d'une enquête.

Exemples de règles d'alerte :

- plus de 5 connexions échouées sur un même compte en 10 minutes ;
- connexion d'un utilisateur en dehors de ses horaires habituels, ou depuis deux agences différentes à quelques minutes d'intervalle ;
- consultation d'un grand nombre de comptes clients par un même employé en peu de temps ;
- création d'un compte administrateur en dehors de la procédure ;
- désactivation de la journalisation sur un serveur.

Des solutions commerciales et libres existent (par exemple **Wazuh** ou la suite **Elastic**). L'essentiel est que quelqu'un **traite réellement** les alertes : un SIEM dont personne ne regarde les alertes n'apporte rien.

## Mener une enquête avec les journaux

Reprenons le retrait contesté de 500 000 FCFA :

1. **Identifier** l'opération dans le core banking : référence, date, montant.
2. **Retrouver** dans les journaux qui l'a saisie, depuis quel poste, et qui l'a validée.
3. **Vérifier** les événements autour : modification récente des coordonnées du client ? changement de plafond ? connexions inhabituelles de l'utilisateur ?
4. **Croiser** avec les autres sources : vidéosurveillance de l'agence à l'heure exacte, signature sur le bordereau, journaux de l'application mobile.
5. **Conserver les preuves** : extraire et sécuriser les journaux concernés pour une éventuelle procédure.
6. **Rédiger** un rapport factuel, chronologique, avec les sources de chaque élément.

## À toi de jouer

1. Liste les 15 événements à journaliser en priorité dans le core banking de la banque de Mahamat, avec les informations à enregistrer pour chacun.
2. Écris 3 exemples de lignes de journal (connexion échouée, modification de plafond, consultation d'un compte sensible) en masquant les données sensibles.
3. Propose 5 règles d'alerte pour le SIEM, avec le seuil et l'action attendue de l'équipe de sécurité.
4. Rédige la procédure d'enquête pour une contestation de virement depuis l'application mobile.

> **Pour t'auto-évaluer** : pour chacune de tes règles d'alerte, demande-toi qui la reçoit, en combien de temps elle doit être traitée et quelle est la première action. Une alerte sans responsable ni action définie ne sert à rien.

## Vérifie tes acquis

1. À quelles questions doit répondre une entrée de journal ?
2. Pourquoi faut-il synchroniser les horloges des serveurs ?
3. Pourquoi envoyer les journaux vers un serveur central géré par une autre équipe ?

> **Réponses** : 1. Qui, quoi, quand, où, sur quoi et avec quel résultat. 2. Pour pouvoir reconstituer précisément la chronologie d'un incident à partir de plusieurs systèmes. 3. Pour éviter qu'un administrateur malveillant puisse effacer ou modifier la trace de ses propres actions.

## En résumé

- Les journaux servent à **prouver**, **détecter**, **comprendre** et **dissuader**.
- On trace authentification, habilitations, opérations sensibles, données clients, paramétrage et administration.
- Une entrée de journal dit **qui, quoi, quand, où, sur quoi, avec quel résultat**, sans jamais de secret en clair.
- Horloges synchronisées (**NTP**), journaux **centralisés**, **protégés** contre la modification et **conservés**.
- Un **SIEM** corrèle et alerte ; une enquête croise journaux et autres preuves.

## Pour aller plus loin

- Demande au mentor IA : « Comment installer Wazuh pour centraliser les journaux de quelques serveurs Linux ? »
