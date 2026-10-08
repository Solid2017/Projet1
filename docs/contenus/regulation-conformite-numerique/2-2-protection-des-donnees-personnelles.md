Un opérateur connaît, pour chacun de ses millions d'abonnés, son identité, ses appels, ses déplacements de cellule en cellule, ses recharges, souvent ses transactions mobile money. Une banque connaît les revenus et les dépenses de ses clients. Une application de santé connaît leurs maladies. Ces **données personnelles** ont une grande valeur, et leur mauvaise utilisation peut causer des torts considérables : fraude, discrimination, surveillance, atteinte à la vie privée. Leur protection est devenue un domaine majeur de la conformité numérique.

> **Objectifs de ce chapitre**
> - Définir les données personnelles et les traitements
> - Connaître les principes de la protection des données
> - Connaître les droits des personnes concernées
> - Connaître les obligations des responsables de traitement
> - Appliquer la protection des données dès la conception et gérer une violation

> **Attention** : le Tchad dispose d'une législation relative à la protection des données à caractère personnel, et des textes régionaux existent également. Les principes présentés ici sont communs à la plupart des cadres modernes (y compris le RGPD européen, souvent appliqué par les entreprises internationales). Pour les obligations exactes (formalités auprès de l'autorité compétente, durées, sanctions), réfère-toi toujours aux textes en vigueur.

## Les notions de base

- Une **donnée personnelle** est toute information relative à une personne identifiée ou identifiable : nom, numéro de téléphone, numéro de carte SIM, adresse IP, localisation, photo, voix, empreinte digitale.
- Un **traitement** est toute opération sur ces données : collecte, enregistrement, consultation, modification, transmission, suppression.
- Le **responsable du traitement** est l'organisme qui décide des finalités et des moyens du traitement (l'opérateur, la banque).
- Le **sous-traitant** traite les données pour le compte du responsable (un prestataire d'hébergement, un centre d'appels externalisé).
- Les **données sensibles** bénéficient d'une protection renforcée : santé, opinions politiques, religieuses ou philosophiques, origine ethnique, données biométriques, et souvent les infractions.

## Les principes

| Principe | En pratique pour un opérateur |
| --- | --- |
| **Licéité, loyauté, transparence** | Informer clairement les abonnés de l'usage de leurs données, sur une base légale (contrat, obligation légale, consentement…) |
| **Finalité déterminée** | Les données de localisation collectées pour faire fonctionner le réseau ne sont pas revendues pour de la publicité sans base légale |
| **Minimisation** | Ne collecter que les données nécessaires à la finalité |
| **Exactitude** | Permettre la mise à jour des informations des abonnés |
| **Durée de conservation limitée** | Supprimer ou anonymiser les données au-delà de la durée nécessaire ou légale |
| **Sécurité et confidentialité** | Protéger contre l'accès non autorisé, la perte et la fuite |
| **Responsabilité** | Pouvoir démontrer la conformité : registre, procédures, preuves |

## Les droits des personnes

Les cadres de protection des données reconnaissent généralement aux personnes :

- le droit d'**information** : savoir qui traite leurs données et pourquoi ;
- le droit d'**accès** : obtenir une copie de leurs données ;
- le droit de **rectification** des données inexactes ;
- le droit d'**opposition**, notamment à la prospection commerciale ;
- le droit à l'**effacement** dans certaines conditions.

L'organisme doit prévoir une **procédure** pour recevoir et traiter ces demandes dans les délais, après avoir vérifié l'identité du demandeur.

> **Info** : pour un opérateur, le droit d'opposition se traduit très concrètement par la possibilité de ne plus recevoir de SMS promotionnels, avec un moyen simple de se désinscrire.

## Les obligations du responsable de traitement

- **Formalités** auprès de l'autorité de protection des données lorsque la loi les prévoit (déclaration ou demande d'autorisation, notamment pour les données sensibles ou certains transferts).
- **Registre des traitements** : la liste des traitements, leurs finalités, les données concernées, les destinataires, les durées de conservation, les mesures de sécurité.
- **Contrats avec les sous-traitants**, qui fixent leurs obligations de sécurité et de confidentialité.
- **Encadrement des transferts hors du pays**, par exemple lorsque des données sont hébergées dans un centre de données à l'étranger.
- **Sécurité** : contrôle des accès, chiffrement, journalisation, sauvegardes, sensibilisation du personnel.
- **Délégué à la protection des données** (DPO), dans les organismes où il est requis ou recommandé, qui conseille et contrôle en interne.

## La protection des données dès la conception

Le principe de **protection des données dès la conception** (*privacy by design*) demande d'intégrer la protection **dès le début** d'un projet, plutôt que de la rajouter à la fin :

- se demander pour chaque champ de formulaire s'il est vraiment nécessaire ;
- prévoir dès le départ les **durées de conservation** et la suppression automatique ;
- **pseudonymiser** les données utilisées pour les statistiques et les tests ;
- limiter les **accès** selon les profils ;
- choisir des **réglages par défaut** protecteurs (par exemple, partage de la localisation désactivé par défaut).

Pour les projets à risque élevé (biométrie, surveillance à grande échelle, données sensibles), on réalise une **analyse d'impact** relative à la protection des données avant le lancement.

> **Astuce** : les environnements de test et de développement sont une source classique de fuites : des copies complètes de la base clients y sont souvent stockées avec une sécurité moindre. Utilise des données **fictives** ou **anonymisées** pour les tests.

## Gérer une violation de données

Une **violation** est un incident qui entraîne la destruction, la perte, l'altération, la divulgation ou l'accès non autorisé à des données personnelles : piratage, ordinateur volé, fichier envoyé au mauvais destinataire, employé qui consulte des données sans raison.

1. **Contenir** l'incident : couper l'accès, changer les mots de passe, isoler les systèmes.
2. **Évaluer** : quelles données, combien de personnes, quels risques pour elles ?
3. **Notifier** l'autorité compétente et, si le risque est élevé, les personnes concernées, lorsque la loi l'exige et dans les délais prévus.
4. **Corriger** la cause et renforcer les mesures.
5. **Documenter** l'incident dans un registre des violations.

## À toi de jouer

Un opérateur veut lancer une application qui propose aux abonnés des offres personnalisées en fonction de leurs habitudes de consommation et de leurs lieux fréquentés.

1. Liste les données personnelles que l'application utiliserait et identifie celles qui sont les plus sensibles.
2. Pour chaque principe de la protection des données, indique une exigence concrète pour ce projet.
3. Rédige le texte d'information présenté à l'abonné à l'ouverture de l'application (8 lignes maximum, langage simple).
4. Propose 5 mesures de protection dès la conception.
5. Rédige la procédure de traitement d'une demande d'accès d'un abonné à ses données.

> **Éléments de correction** : la localisation (lieux fréquentés) est la donnée la plus sensible : elle révèle domicile, lieu de travail, habitudes, voire lieux de culte ou de soins. Exigences : consentement explicite pour la localisation, possibilité de refuser sans perdre le service de base, durée de conservation courte, données agrégées plutôt que précises, aucune revente sans base légale.

## Vérifie tes acquis

1. Une adresse IP ou un numéro de carte SIM est-il une donnée personnelle ?
2. Qu'est-ce que le principe de minimisation ?
3. Que faut-il faire en premier lors d'une violation de données ?

> **Réponses** : 1. Oui, car ils permettent d'identifier indirectement une personne. 2. Ne collecter que les données strictement nécessaires à la finalité poursuivie. 3. Contenir l'incident pour limiter la fuite, puis évaluer, notifier si nécessaire, corriger et documenter.

## En résumé

- Une **donnée personnelle** identifie directement ou indirectement une personne ; certaines sont **sensibles**.
- Principes : licéité, **finalité**, **minimisation**, exactitude, durée limitée, sécurité, responsabilité.
- Les personnes ont des **droits** : information, accès, rectification, opposition, effacement.
- Le responsable de traitement accomplit les **formalités**, tient un **registre**, encadre sous-traitants et transferts, et sécurise.
- **Protection dès la conception**, analyse d'impact pour les projets à risque, procédure en cas de **violation**.

## Pour aller plus loin

- Demande au mentor IA : « Aide-moi à rédiger le registre des traitements d'une petite entreprise : clients, salariés, prospects. »
