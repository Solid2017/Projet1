La grande majorité des piratages de comptes ne viennent pas d'attaques sophistiquées, mais de mots de passe faibles, réutilisés ou volés. Halimé découvre que la moitié des agents de la microfinance utilisent le même mot de passe pour leur session Windows, leur messagerie et le logiciel de gestion. Il est temps d'agir.

> **Objectifs de ce chapitre**
> - Comprendre comment les mots de passe sont attaqués
> - Créer des mots de passe robustes et faciles à retenir
> - Utiliser un gestionnaire de mots de passe
> - Mettre en place l'authentification à deux facteurs
> - Rédiger une politique de mots de passe pour une organisation

## Comment un mot de passe est-il volé ?

- **Le devinement** : l'attaquant essaie les mots de passe les plus courants (`123456`, `password`, `azerty`, le prénom de l'enfant, l'année de naissance).
- **La force brute** : un programme essaie toutes les combinaisons possibles. Un mot de passe de 6 caractères tombe en quelques secondes ; un de 16 caractères variés résiste des siècles.
- **Les fuites de données** : un site mal protégé se fait voler sa base. Si tu utilises le même mot de passe ailleurs, l'attaquant essaie la même combinaison e-mail + mot de passe sur tous tes comptes. C'est le **bourrage d'identifiants**.
- **L'hameçonnage** (*phishing*) : un faux site ou un faux message te pousse à saisir toi-même ton mot de passe. Tu l'étudieras en détail dans un prochain chapitre.
- **L'observation** : un post-it collé sous le clavier, un mot de passe tapé devant un collègue.

> **Info** : le site [Have I Been Pwned](https://haveibeenpwned.com) permet de vérifier si ton adresse e-mail apparaît dans une fuite de données connue. Fais le test : le résultat surprend souvent.

## Créer un mot de passe robuste

La **longueur** compte plus que la complexité. Un bon mot de passe en 2026 :

- fait au moins **12 caractères**, idéalement 16 ou plus ;
- est **unique** : un mot de passe différent pour chaque compte important ;
- n'est pas lié à toi (pas de nom, de date de naissance, de numéro de téléphone).

La méthode la plus simple est la **phrase de passe** : plusieurs mots sans rapport entre eux, faciles à retenir pour toi, impossibles à deviner pour les autres.

```text
Mauvais : Halime1995
Mauvais : P@ssw0rd!
Bon     : chameau-Bleu-radio-Sorgho-42
```

## Le gestionnaire de mots de passe

Retenir 30 mots de passe uniques est impossible. La solution : un **gestionnaire de mots de passe** (Bitwarden, KeePassXC, ou celui intégré à Google Chrome ou Firefox). Il génère et retient des mots de passe aléatoires pour chaque site. Tu n'as plus qu'**un seul** mot de passe maître à retenir : une longue phrase de passe.

> **Attention** : le mot de passe maître ne doit jamais être perdu ni réutilisé ailleurs. Note-le sur papier et range ce papier dans un endroit sûr, pas dans ton téléphone.

## L'authentification à deux facteurs

Même un excellent mot de passe peut être volé. L'**authentification à deux facteurs** (2FA) exige une deuxième preuve, d'une autre nature :

| Facteur | Exemples |
| --- | --- |
| Ce que je **sais** | Mot de passe, code PIN |
| Ce que je **possède** | Téléphone (code SMS, application d'authentification), clé de sécurité USB |
| Ce que je **suis** | Empreinte digitale, reconnaissance faciale |

Combiner deux facteurs différents rend le piratage beaucoup plus difficile : l'attaquant qui a volé ton mot de passe n'a pas ton téléphone.

Les applications d'authentification (Google Authenticator, Microsoft Authenticator, Aegis) sont plus sûres que les codes SMS, qui peuvent être interceptés lors d'une fraude au changement de carte SIM.

> **Astuce** : active la 2FA en priorité sur ta messagerie e-mail (elle permet de réinitialiser tous tes autres comptes), sur WhatsApp (la « vérification en deux étapes » dans les réglages) et sur les comptes d'administration.

## Côté développeur : stocker les mots de passe

Si tu développes une application, ne stocke **jamais** les mots de passe en clair dans la base de données. On stocke une **empreinte** (un *hash*) calculée avec un algorithme lent et salé, conçu pour cela : bcrypt ou Argon2. En PHP, c'est très simple :

```php
$empreinte = password_hash($motDePasse, PASSWORD_DEFAULT);   // à l'inscription
if (password_verify($saisie, $empreinte)) { /* connexion OK */ } // à la connexion
```

Même en cas de vol de la base, les mots de passe ne sont pas directement lisibles.

## À toi de jouer

Halimé te demande de rédiger la **politique de mots de passe** de la microfinance, en une page maximum. Elle doit couvrir :

1. La longueur minimale et les règles de création (avec un exemple de phrase de passe).
2. L'interdiction de réutiliser un mot de passe professionnel ailleurs.
3. L'outil de gestion de mots de passe recommandé.
4. Les comptes sur lesquels la 2FA est obligatoire.
5. La conduite à tenir si un employé pense que son mot de passe a été découvert.
6. La procédure lors du départ d'un employé.

> **Pour t'auto-évaluer** : ta politique est réussie si un agent sans formation technique peut la lire en trois minutes et l'appliquer seul. Évite le jargon ; explique le « pourquoi » de chaque règle en une phrase.

## Vérifie tes acquis

1. Pourquoi est-il dangereux de réutiliser le même mot de passe sur plusieurs sites ?
2. Qu'est-ce qui rend un mot de passe robuste avant tout : la longueur ou les caractères spéciaux ?
3. Pourquoi une application d'authentification est-elle plus sûre qu'un code SMS ?

> **Réponses** : 1. Si un site subit une fuite, l'attaquant peut utiliser la même combinaison sur tous tes autres comptes. 2. La longueur. 3. Parce que les SMS peuvent être détournés, notamment par une fraude au changement de carte SIM.

## En résumé

- Les mots de passe sont surtout volés par devinement, fuites de données et hameçonnage.
- Un bon mot de passe est **long**, **unique** et sans lien avec toi ; la phrase de passe est la méthode la plus simple.
- Un **gestionnaire de mots de passe** retient tout à ta place.
- La **2FA** ajoute une deuxième preuve d'une autre nature ; active-la sur les comptes critiques.
- Un développeur stocke des empreintes (`password_hash`), jamais des mots de passe en clair.

## Pour aller plus loin

- Demande au mentor IA : « Comment activer la vérification en deux étapes sur WhatsApp et Gmail ? Donne-moi les étapes. »
