« Bonjour, ici le service client Airtel Money. Votre compte va être suspendu. Pour le réactiver, donnez-nous le code que vous venez de recevoir par SMS. » Ce type d'appel, tout le monde au Tchad en a déjà reçu. Les pirates ont compris qu'il est souvent plus facile de **tromper une personne** que de casser un système. C'est l'**ingénierie sociale**, et sa forme la plus répandue s'appelle l'**hameçonnage** (*phishing*).

> **Objectifs de ce chapitre**
> - Comprendre les ressorts psychologiques de l'ingénierie sociale
> - Reconnaître un e-mail, un SMS ou un appel frauduleux
> - Vérifier un lien avant de cliquer
> - Savoir réagir après un clic ou une erreur
> - Organiser une sensibilisation dans une équipe

## Les leviers de la manipulation

L'attaquant joue sur des émotions qui court-circuitent la réflexion :

- **L'urgence** : « Votre compte sera bloqué dans 2 heures. »
- **La peur** : « Une transaction suspecte de 450 000 FCFA a été détectée. »
- **L'autorité** : « Ici le directeur général, j'ai besoin d'un virement urgent et confidentiel. »
- **L'appât du gain** : « Félicitations, vous avez gagné 1 000 000 FCFA à la tombola. »
- **La serviabilité** : « Je suis le technicien, pouvez-vous me donner votre mot de passe pour la maintenance ? »

> **Info** : la règle d'or à transmettre à tout le monde : **aucun opérateur, aucune banque et aucun service informatique sérieux ne te demandera jamais ton code secret, ton code PIN ou un code reçu par SMS.**

## Les formes de l'hameçonnage

| Forme | Canal | Exemple |
| --- | --- | --- |
| Phishing | E-mail | Faux message de « Microsoft » demandant de reconfirmer son mot de passe |
| Smishing | SMS | Faux SMS de colis en attente avec un lien de paiement |
| Vishing | Appel vocal | Faux agent Mobile Money qui demande un code |
| Fraude au président | E-mail ou WhatsApp | Faux dirigeant qui exige un virement urgent |
| Spear phishing | Tous | Message très personnalisé, préparé à partir des réseaux sociaux de la victime |

## Repérer un e-mail frauduleux

Avant de cliquer, passe le message au crible :

1. **L'expéditeur** : regarde l'adresse complète, pas seulement le nom affiché. « Service Ecobank » peut cacher `support@ecobank-securite-verif.com`.
2. **Le ton** : urgence, menace ou promesse trop belle ?
3. **La demande** : on te demande un mot de passe, un code, un paiement ou d'ouvrir une pièce jointe inattendue ?
4. **Les liens** : survole le lien avec la souris (ou appui long sur mobile) pour voir la vraie adresse.
5. **La forme** : fautes, logo flou, formule générique comme « Cher client ».

## Lire une adresse web

La partie importante d'une adresse est le **nom de domaine**, juste avant le premier `/` :

```text
https://www.airtel.td/airtelmoney          → domaine : airtel.td      (légitime)
https://airtel.td.verification-compte.com  → domaine : verification-compte.com (piège !)
https://airteI-money.com                   → un « I » majuscule à la place du « l » (piège !)
```

Le domaine se lit **de droite à gauche** à partir du premier `/` : dans le deuxième exemple, le vrai propriétaire est `verification-compte.com` ; « airtel.td » n'est qu'un sous-domaine trompeur.

> **Attention** : le cadenas HTTPS prouve seulement que la connexion est chiffrée, **pas** que le site est honnête. Les sites de phishing ont presque tous un cadenas aujourd'hui.

## Réagir en cas d'erreur

Tout le monde peut se faire piéger un jour. Ce qui compte, c'est de réagir vite :

1. **Ne pas avoir honte et prévenir immédiatement** le responsable informatique : chaque minute compte.
2. **Changer le mot de passe** du compte concerné depuis un appareil sûr, puis ceux des comptes qui utilisaient le même.
3. **Déconnecter l'ordinateur du réseau** si une pièce jointe a été ouverte.
4. Pour un code Mobile Money ou bancaire communiqué, **appeler tout de suite** le service client officiel (numéro au dos de la carte ou sur le site officiel) pour bloquer le compte.
5. **Signaler** la tentative pour protéger les collègues.

## Sensibiliser une équipe

La technique ne suffit pas : la meilleure défense est une équipe vigilante. Quelques actions simples :

- une séance de 30 minutes avec des exemples réels de messages frauduleux ;
- une affiche près des postes : « Code demandé = arnaque » ;
- un canal clair pour signaler un message douteux, sans reproche ;
- des exercices de faux phishing, annoncés à la direction, pour mesurer les progrès.

## À toi de jouer

Analyse ce SMS reçu par un agent de la microfinance :

```text
MICROFINANCE-INFO : Votre accès au logiciel expire aujourd'hui.
Reconnectez-vous ici sous 1h pour éviter le blocage :
http://microfinance-td.acces-renouvellement.net/login
```

1. Relève au moins quatre indices de fraude.
2. Rédige la réponse que l'agent doit apporter (à qui le signaler, quoi faire).
3. Prépare trois diapositives (titre + 3 points chacune) pour une sensibilisation de 15 minutes destinée aux agents de guichet.

> **Correction** : indices : urgence (« sous 1h »), menace (« blocage »), lien en HTTP non sécurisé, domaine réel `acces-renouvellement.net` sans rapport avec la microfinance, un logiciel interne qui n'envoie pas de SMS de ce type. L'agent ne clique pas, transfère une capture au responsable informatique et supprime le message.

## Vérifie tes acquis

1. Dans `https://ecobank.com.securite-client.info/login`, quel est le vrai nom de domaine ?
2. Le cadenas HTTPS garantit-il qu'un site est fiable ?
3. Quelle est la première chose à faire après avoir saisi son mot de passe sur un faux site ?

> **Réponses** : 1. `securite-client.info`. 2. Non, il garantit seulement que la connexion est chiffrée. 3. Prévenir le responsable informatique et changer immédiatement le mot de passe depuis un appareil sûr.

## En résumé

- L'**ingénierie sociale** manipule les personnes par l'urgence, la peur, l'autorité ou l'appât du gain.
- Le phishing existe par e-mail, SMS, appel et messagerie.
- Vérifie l'expéditeur, la demande et surtout le **nom de domaine** des liens.
- Personne de sérieux ne demande un code secret.
- En cas d'erreur : prévenir, changer les mots de passe, isoler, signaler, sans honte.

## Pour aller plus loin

- Demande au mentor IA : « Crée-moi cinq exemples de SMS frauduleux réalistes au Tchad et cinq messages légitimes, pour un quiz de sensibilisation. »
