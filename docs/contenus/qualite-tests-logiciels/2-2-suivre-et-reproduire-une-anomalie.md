Rokia a trouvé un problème : en payant une facture d'eau, le reçu affiche parfois un montant de frais erroné. Si elle écrit simplement « Les frais sont faux » dans le groupe WhatsApp de l'équipe, le développeur va perdre une heure à chercher dans quel cas cela arrive, ou pire, conclure « chez moi ça marche » et passer à autre chose. Une anomalie mal décrite est une anomalie qui ne sera pas corrigée. Ce chapitre t'apprend à **reproduire**, **décrire** et **suivre** un défaut comme un professionnel.

> **Objectifs de ce chapitre**
> - Reproduire une anomalie de façon fiable
> - Rédiger une fiche d'anomalie complète et claire
> - Distinguer gravité et priorité
> - Connaître le cycle de vie d'une anomalie
> - Rassembler les bonnes preuves (captures, journaux)

## Reproduire avant de signaler

Avant d'écrire quoi que ce soit, Rokia cherche les conditions **exactes** dans lesquelles le problème apparaît. Elle fait varier un paramètre à la fois :

- Est-ce sur toutes les factures d'eau, ou seulement certaines ? → Seulement celles dont le montant se termine par 50.
- Sur tous les téléphones ? → Oui, Android comme navigateur web.
- Depuis quand ? → Depuis la version 2.4 livrée mardi.

Elle arrive à une description précise : « Les frais sont mal arrondis quand le montant de la facture se termine par 50 FCFA. » Le développeur saura immédiatement où chercher : dans la fonction d'arrondi.

> **Astuce** : si une anomalie n'apparaît qu'une fois sur dix, note-le explicitement (« fréquence : environ 1 fois sur 10 ») et décris tout ce qui était particulier à ce moment-là : connexion lente, application restée longtemps en arrière-plan, plusieurs onglets ouverts.

## La fiche d'anomalie

| Champ | Exemple |
| --- | --- |
| Titre | Frais mal arrondis pour les factures d'eau dont le montant se termine par 50 FCFA |
| Environnement | Préproduction, version 2.4.0, Android 11 (Tecno Spark) et Chrome 129 sur Windows |
| Préconditions | Compte de test 66000001 avec 50 000 FCFA, facture d'eau E-7731 de 12 550 FCFA |
| Étapes pour reproduire | 1. Se connecter. 2. Factures, puis Eau. 3. Saisir E-7731. 4. Payer avec le PIN 0000. |
| Résultat obtenu | Frais affichés : 125 FCFA ; total débité : 12 675 FCFA |
| Résultat attendu | Frais de 1 % de 12 550 = 125,5, arrondi à 126 FCFA selon la règle métier ; total : 12 676 FCFA |
| Fréquence | Systématique pour les montants se terminant par 50 |
| Gravité | Majeure |
| Priorité | Haute |
| Pièces jointes | Capture du reçu, extrait du journal de l'API |

Les qualités d'une bonne fiche :

- un **titre** qui permet de comprendre le problème sans ouvrir la fiche ;
- **une seule anomalie** par fiche ;
- des **étapes** que n'importe qui peut rejouer ;
- les résultats **obtenu** et **attendu**, factuels et chiffrés ;
- un ton **neutre** : on décrit le logiciel, jamais la personne qui l'a développé.

> **Attention** : n'écris jamais « le module de paiement ne marche pas » ou « encore un bug de Mahamat ». Un titre vague fait perdre du temps et un ton accusateur abîme la collaboration dans l'équipe.

## Gravité et priorité

Ces deux notions sont souvent confondues :

- La **gravité** mesure l'**impact** technique ou métier du défaut. Elle est évaluée par le testeur.
- La **priorité** indique l'**ordre** dans lequel le corriger. Elle est décidée avec le Product Owner, selon le contexte.

| Gravité | Exemple |
| --- | --- |
| Bloquante | Impossible de payer une facture : la fonctionnalité principale est inutilisable |
| Majeure | Montant de frais erroné, double débit dans certains cas |
| Mineure | Message d'erreur peu clair, mais l'utilisateur peut continuer |
| Cosmétique | Faute d'orthographe, icône mal alignée |

Les deux ne vont pas toujours ensemble : une faute d'orthographe dans le nom de l'entreprise sur la page d'accueil est **cosmétique** mais peut être **hautement prioritaire** juste avant un lancement très médiatisé.

## Le cycle de vie d'une anomalie

Dans l'outil de suivi (Jira, GitLab, GitHub Issues, Mantis…), une anomalie passe par plusieurs états :

1. **Nouvelle** : créée par le testeur.
2. **Analysée** ou **confirmée** : l'équipe la reproduit et la priorise.
3. **En cours** : un développeur la corrige.
4. **Corrigée** : la correction est livrée dans un environnement de test.
5. **Vérifiée** puis **Fermée** : le testeur rejoue le scénario et confirme la correction.
6. **Rouverte** : si le problème est toujours là.

D'autres issues sont possibles : **en double** (déjà signalée), **non reproductible**, ou **ne sera pas corrigée** (décision assumée et justifiée).

> **Info** : après une correction, rejoue toujours le scénario de l'anomalie, **et** quelques tests autour : une correction peut provoquer une régression ailleurs.

## Les preuves utiles

- une **capture d'écran** annotée (entoure la zone qui pose problème) ;
- une **vidéo courte** de l'écran pour les problèmes de parcours ou d'animation ;
- les **journaux** : console du navigateur (F12), journaux de l'application, réponse de l'API ;
- l'**heure exacte** du test, pour retrouver les traces côté serveur ;
- les **données** utilisées (numéro de compte de test, référence de facture).

Ne joins jamais de vraies données personnelles de clients : utilise des comptes de test.

## À toi de jouer

Lors de tes tests du transfert d'argent, tu constates ceci : si tu appuies deux fois rapidement sur « Confirmer », deux transferts de 10 000 FCFA sont effectués et le solde est débité deux fois. Cela arrive environ 3 fois sur 5 sur un téléphone Android avec une connexion 3G, jamais en Wi-Fi.

1. Rédige la fiche d'anomalie complète.
2. Évalue sa gravité et propose une priorité, en justifiant.
3. Propose deux pistes de correction possibles, l'une dans l'interface et l'autre côté serveur.
4. Décris comment tu vérifieras la correction, y compris les tests autour.

> **Éléments de correction** : gravité majeure, voire bloquante (perte d'argent pour le client), priorité très haute. Pistes : désactiver le bouton dès le premier appui ; côté serveur, refuser une seconde opération identique grâce à un identifiant unique de transaction (idempotence), la vraie protection. Vérification : rejouer le double appui en 3G, puis tester les transferts normaux et les erreurs.

## Vérifie tes acquis

1. Pourquoi faut-il une seule anomalie par fiche ?
2. Quelle est la différence entre gravité et priorité ?
3. Que fait le testeur quand une anomalie passe à l'état « Corrigée » ?

> **Réponses** : 1. Pour pouvoir suivre, corriger et vérifier chaque problème indépendamment. 2. La gravité mesure l'impact du défaut ; la priorité fixe l'ordre de correction selon le contexte. 3. Il rejoue le scénario pour vérifier la correction, teste autour, puis ferme ou rouvre l'anomalie.

## En résumé

- On **reproduit** et isole les conditions exactes avant de signaler.
- Une **fiche d'anomalie** : titre précis, environnement, étapes, résultats obtenu et attendu, fréquence, preuves.
- **Gravité** (impact) et **priorité** (ordre de correction) sont deux notions distinctes.
- Une anomalie suit un **cycle de vie** jusqu'à sa vérification et sa fermeture.
- Un ton neutre et des données de test, jamais de vraies données clients.

## Pour aller plus loin

- Demande au mentor IA : « Relis ma fiche d'anomalie et dis-moi ce qui manque pour qu'un développeur la reproduise du premier coup. »
