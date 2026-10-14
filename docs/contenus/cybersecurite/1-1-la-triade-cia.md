Une banque de N'Djamena dont le site est piraté, une ONG qui perd les fichiers de ses bénéficiaires, un compte Facebook d'entreprise volé : derrière chaque incident de sécurité, il y a une information qui a perdu l'une de ses trois protections fondamentales. Ces trois protections forment la **triade CIA**, le point de départ de toute réflexion en cybersécurité.

Dans ce parcours, tu accompagnes **Halimé**, qui vient d'être recrutée comme responsable informatique dans une microfinance de N'Djamena. Elle doit sécuriser les systèmes de l'agence.

> **Objectifs de ce chapitre**
> - Définir la confidentialité, l'intégrité et la disponibilité
> - Associer chaque menace à la propriété qu'elle attaque
> - Comprendre les notions de risque, menace et vulnérabilité
> - Proposer des mesures de protection adaptées

## C, I, A : trois propriétés à protéger

Le sigle vient de l'anglais *Confidentiality, Integrity, Availability*.

### La confidentialité

Seules les personnes autorisées peuvent **lire** l'information. Le solde d'un client de la microfinance ne doit être visible que par lui et par les agents habilités.

Elle est menacée par : le vol de mot de passe, un ordinateur perdu non chiffré, un employé curieux, une base de données exposée sur Internet.

### L'intégrité

L'information est **exacte et n'a pas été modifiée** sans autorisation. Si quelqu'un change le montant d'un prêt dans la base, de 150 000 à 1 500 000 FCFA, l'intégrité est violée, même si personne d'autre n'a lu la donnée.

Elle est menacée par : un pirate qui modifie des données, un virus, mais aussi une simple erreur de saisie ou un bug.

### La disponibilité

L'information et les systèmes sont **accessibles quand on en a besoin**. Si le serveur de l'agence tombe en panne un jour de remboursement, les clients ne peuvent plus payer : la disponibilité est perdue.

Elle est menacée par : une panne électrique (sujet très concret au Tchad), un rançongiciel qui chiffre tous les fichiers, une attaque par saturation, un disque dur qui lâche sans sauvegarde.

> **Info** : on ajoute souvent deux propriétés complémentaires : la **traçabilité** (savoir qui a fait quoi et quand) et l'**authenticité** (être sûr de l'identité de son interlocuteur).

## Associer une mesure à chaque propriété

| Propriété | Mesures de protection typiques |
| --- | --- |
| Confidentialité | Mots de passe solides, droits d'accès limités, chiffrement des disques et des connexions (HTTPS) |
| Intégrité | Droits en écriture limités, journalisation des modifications, contrôles de cohérence, signatures numériques |
| Disponibilité | Sauvegardes, onduleur et groupe électrogène, matériel redondant, plan de reprise après incident |

> **Attention** : renforcer une propriété peut en affaiblir une autre. Un système trop verrouillé (confidentialité maximale) peut devenir inutilisable pour les employés (disponibilité dégradée). La sécurité est toujours une question d'équilibre.

## Menace, vulnérabilité, risque

Trois mots que tu entendras partout :

- Une **vulnérabilité** est une faiblesse : un logiciel non mis à jour, un mot de passe « 123456 », une salle serveur sans serrure.
- Une **menace** est ce qui peut exploiter cette faiblesse : un pirate, un employé malveillant, une inondation, une coupure de courant.
- Le **risque** combine les deux avec l'impact : quelle est la probabilité que la menace exploite la vulnérabilité, et quelles seraient les conséquences ?

On peut retenir : **risque = probabilité × impact**. Une coupure de courant a une forte probabilité à N'Djamena ; si le serveur n'a pas d'onduleur et que chaque coupure corrompt la base, l'impact est fort : le risque est élevé et doit être traité en priorité.

## À toi de jouer

Voici cinq incidents survenus dans des organisations. Pour chacun, indique la ou les propriétés touchées (C, I, A) et propose une mesure de prévention.

1. Un agent envoie par erreur la liste des clients et de leurs soldes dans un groupe WhatsApp public.
2. Un rançongiciel chiffre tous les fichiers du serveur de comptabilité.
3. Un stagiaire modifie par erreur les taux d'intérêt dans le logiciel de gestion.
4. Le serveur s'éteint à chaque coupure d'électricité et met une heure à redémarrer.
5. Un ancien employé se connecte encore à la messagerie de l'entreprise trois mois après son départ.

> **Réponses** : 1. Confidentialité : sensibiliser le personnel et interdire le partage de données clients sur les messageries personnelles. 2. Disponibilité (et intégrité) : sauvegardes régulières hors ligne et mises à jour des logiciels. 3. Intégrité : limiter les droits de modification et journaliser les changements. 4. Disponibilité : onduleur et arrêt automatique propre du serveur. 5. Confidentialité : procédure de départ qui désactive tous les comptes le jour même.

## Vérifie tes acquis

1. Un pirate modifie le montant d'un virement sans le lire. Quelle propriété est touchée ?
2. Quelle mesure protège avant tout la disponibilité ?
3. Quelle est la différence entre une menace et une vulnérabilité ?

> **Réponses** : 1. L'intégrité. 2. Les sauvegardes (et l'alimentation de secours). 3. La vulnérabilité est une faiblesse du système ; la menace est ce qui peut l'exploiter.

## En résumé

- La **triade CIA** : confidentialité (qui peut lire), intégrité (l'exactitude), disponibilité (l'accès quand on en a besoin).
- Chaque incident touche au moins une de ces trois propriétés.
- Le **risque** dépend de la probabilité qu'une **menace** exploite une **vulnérabilité** et de l'impact.
- Les mesures de sécurité sont un équilibre entre protection et facilité d'usage.

## Pour aller plus loin

- [Le guide d'hygiène informatique de l'ANSSI](https://cyber.gouv.fr/publications/guide-dhygiene-informatique) : 42 mesures concrètes pour sécuriser une organisation.
- Demande au mentor IA : « Aide-moi à faire la liste des 5 plus grands risques informatiques d'une petite microfinance au Tchad. »
