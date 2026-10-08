« Internet ne marche pas ! » C'est l'appel que Djibrine reçoit le plus souvent de ses clients professionnels. Derrière cette phrase se cachent des causes très différentes : un câble débranché, un Wi-Fi saturé, une adresse IP mal configurée, un forfait épuisé, une panne de l'opérateur. Avec une méthode simple et quelques commandes, on trouve la cause en quelques minutes.

> **Objectifs de ce chapitre**
> - Comprendre le chemin d'une connexion, de l'ordinateur à Internet
> - Lire la configuration réseau d'un ordinateur
> - Diagnostiquer pas à pas avec ping, ipconfig et nslookup
> - Résoudre les problèmes Wi-Fi les plus courants
> - Expliquer le problème simplement au client

## Le chemin d'une connexion

Pour accéder à un site, la connexion traverse plusieurs maillons :

```text
Ordinateur → câble ou Wi-Fi → box ou routeur → opérateur (fibre, 4G, satellite) → Internet → site web
```

Si un maillon est cassé, tout ce qui est après lui est inaccessible. Le diagnostic consiste à tester les maillons **un par un, du plus proche au plus lointain**.

## Lire la configuration réseau

Sous Windows, ouvre l'invite de commandes et tape :

```text
ipconfig /all
```

Les lignes importantes :

| Information | Exemple | Signification |
| --- | --- | --- |
| Adresse IPv4 | 192.168.1.34 | L'adresse de l'ordinateur sur le réseau local |
| Masque de sous-réseau | 255.255.255.0 | La taille du réseau local |
| Passerelle par défaut | 192.168.1.1 | L'adresse de la box ou du routeur |
| Serveurs DNS | 192.168.1.1 | Le service qui traduit les noms de sites en adresses |
| DHCP activé | Oui | L'adresse est attribuée automatiquement par la box |

> **Info** : une adresse qui commence par **169.254** signifie que l'ordinateur n'a reçu aucune adresse de la box : le problème est entre l'ordinateur et la box (câble, Wi-Fi, ou box qui ne distribue plus d'adresses).

## Le diagnostic pas à pas

### Étape 1 : le physique

- Le câble réseau est-il bien branché ? Les voyants de la prise réseau clignotent-ils ?
- Le Wi-Fi est-il activé sur l'ordinateur (pas de mode avion) ?
- La box est-elle allumée ? Ses voyants indiquent-ils une connexion à Internet ?

### Étape 2 : la box répond-elle ?

```text
ping 192.168.1.1
```

Remplace l'adresse par la passerelle relevée avec `ipconfig`. Si tu obtiens des réponses (« Réponse de 192.168.1.1 : octets=32 temps=2 ms »), la liaison avec la box fonctionne. Sinon, le problème est local : câble, Wi-Fi, carte réseau, pilote.

### Étape 3 : Internet répond-il ?

```text
ping 8.8.8.8
```

`8.8.8.8` est un serveur public de Google qui répond presque toujours. S'il ne répond pas alors que la box répond, le problème est **entre la box et Internet** : forfait épuisé, panne de l'opérateur, câble de la fibre, problème de la box.

### Étape 4 : le DNS fonctionne-t-il ?

```text
nslookup google.com
```

Si `ping 8.8.8.8` répond mais que les sites ne s'ouvrent pas et que `nslookup` échoue, c'est un problème de **DNS**. Solution rapide : configurer des serveurs DNS publics (par exemple `1.1.1.1` et `8.8.8.8`) dans les paramètres de la carte réseau.

### Étape 5 : le problème vient-il d'un seul site ou d'un seul appareil ?

- Un seul site ne fonctionne pas : le problème vient sûrement du site lui-même.
- Un seul ordinateur ne se connecte pas, alors que les téléphones marchent : le problème est sur cet ordinateur (pilote, configuration, antivirus, proxy).

> **Astuce** : sous Windows, la commande `ipconfig /release` puis `ipconfig /renew` redemande une adresse à la box, et `ipconfig /flushdns` vide le cache DNS. Avec un redémarrage de la box, ces trois gestes règlent une bonne partie des problèmes courants.

## Les problèmes Wi-Fi courants

| Symptôme | Causes possibles | Solutions |
| --- | --- | --- |
| Signal faible | Distance, murs épais en béton ou en banco, box posée au sol | Placer la box en hauteur et au centre, ajouter un répéteur |
| Connexion lente aux heures de pointe | Trop d'appareils, voisins sur le même canal | Changer de canal dans l'interface de la box, préférer la bande 5 GHz près de la box |
| « Connecté, pas d'Internet » | Problème entre la box et l'opérateur, forfait épuisé | Vérifier les voyants et le solde du forfait, redémarrer la box |
| Mot de passe refusé | Erreur de saisie, mot de passe changé | Vérifier sur l'étiquette de la box ou dans son interface |
| Coupures fréquentes | Surchauffe de la box, coupures électriques | Ventiler la box, l'alimenter avec un petit onduleur |

## Expliquer au client

Un bon technicien sait expliquer sans jargon. Plutôt que « votre serveur DNS ne résout plus les requêtes », dis : « Votre connexion fonctionne, mais l'annuaire qui permet de trouver les sites ne répondait plus. J'en ai configuré un autre, plus fiable. » Le client comprend, te fait confiance, et revient.

## À toi de jouer

1. Sur ton ordinateur, relève avec `ipconfig /all` ton adresse IP, ta passerelle et tes serveurs DNS.
2. Teste successivement `ping` vers ta passerelle, vers `8.8.8.8`, puis `nslookup google.com`, et note les résultats.
3. Pour chaque situation, indique le maillon en cause et ta solution :
   - l'ordinateur a l'adresse 169.254.20.5 ;
   - la passerelle répond, mais pas 8.8.8.8 ;
   - 8.8.8.8 répond, mais aucun site ne s'ouvre ;
   - seul l'ordinateur de la comptable n'a pas Internet, tous les autres oui.
4. Rédige une **fiche de dépannage** d'une page, illustrée par un schéma des maillons, à afficher dans les bureaux d'un client pour que les employés fassent les premières vérifications eux-mêmes.

> **Réponses de l'étape 3** : pas d'adresse reçue de la box (câble, Wi-Fi ou DHCP de la box) ; problème entre la box et l'opérateur (forfait, panne, box) ; problème de DNS (changer de serveurs DNS) ; problème propre à cet ordinateur (configuration, pilote, câble, antivirus).

## Vérifie tes acquis

1. Que signifie une adresse IP commençant par 169.254 ?
2. Pourquoi tester `ping 8.8.8.8` avant d'ouvrir un site web ?
3. Quelle commande vide le cache DNS sous Windows ?

> **Réponses** : 1. Que l'ordinateur n'a pas reçu d'adresse de la box ou du serveur DHCP. 2. Pour savoir si l'accès à Internet fonctionne indépendamment du DNS. 3. `ipconfig /flushdns`.

## En résumé

- La connexion traverse plusieurs maillons : ordinateur, câble ou Wi-Fi, box, opérateur, Internet.
- `ipconfig /all` montre l'adresse IP, la passerelle et les DNS.
- On teste dans l'ordre : physique, passerelle (`ping`), Internet (`ping 8.8.8.8`), DNS (`nslookup`).
- Les problèmes Wi-Fi se règlent souvent par le placement de la box, le canal ou un répéteur.
- On explique le problème au client avec des mots simples.

## Pour aller plus loin

- Demande au mentor IA : « Comment changer le canal Wi-Fi et le mot de passe dans l'interface d'une box 4G ? »
