Un client de l'entreprise d'Abdelkerim appelle : « Internet ne marche plus ! » Est-ce le câble, le Wi-Fi, l'adresse IP, le DNS, ou le site lui-même qui est en panne ? Pour répondre vite, un technicien raisonne **par couches**, en s'appuyant sur le **modèle TCP/IP**. Ce chapitre te donne les notions réseau dont tu auras besoin tous les jours.

> **Objectifs de ce chapitre**
> - Comprendre les quatre couches du modèle TCP/IP
> - Lire une adresse IPv4 et un masque de sous-réseau
> - Connaître le rôle de la passerelle, du DHCP et du DNS
> - Distinguer TCP et UDP
> - Diagnostiquer une panne avec les bonnes commandes

## Le modèle en couches

Pour envoyer un message à travers le réseau, chaque couche ajoute ses informations, comme on glisse une lettre dans une enveloppe, puis dans un colis, puis dans un camion :

| Couche TCP/IP | Rôle | Exemples |
| --- | --- | --- |
| 4. Application | Les services utilisés par les programmes | HTTP, DNS, SMTP, SSH |
| 3. Transport | Le dialogue entre deux programmes, avec les **ports** | TCP, UDP |
| 2. Internet | L'acheminement entre réseaux, avec les **adresses IP** | IP, ICMP (ping) |
| 1. Accès réseau | La transmission physique sur le support | Ethernet, Wi-Fi, fibre, 4G |

> **Info** : tu entendras aussi parler du **modèle OSI** à 7 couches. Il découpe plus finement les mêmes idées ; le modèle TCP/IP est celui qui décrit réellement Internet.

## Les adresses IP

Une **adresse IPv4** identifie un appareil sur un réseau. Elle s'écrit en quatre nombres de 0 à 255 : `192.168.1.25`.

Le **masque de sous-réseau** indique quelle partie de l'adresse désigne le **réseau** et quelle partie désigne l'**appareil**. On l'écrit souvent en notation CIDR :

```text
192.168.1.25/24
masque : 255.255.255.0
réseau : 192.168.1.0   →   appareils possibles : 192.168.1.1 à 192.168.1.254
```

Le `/24` signifie que les 24 premiers bits (les trois premiers nombres) désignent le réseau. Deux appareils sur le même réseau communiquent directement ; sinon, ils passent par un routeur.

### Adresses privées et publiques

Certaines plages sont réservées aux réseaux **privés** (maison, entreprise) et ne circulent pas sur Internet : `10.0.0.0/8`, `172.16.0.0/12` et `192.168.0.0/16`. Le routeur de la box ou de l'entreprise traduit ces adresses privées en une adresse **publique** pour sortir sur Internet : c'est la **NAT**.

> **Info** : les adresses IPv4 sont épuisées dans le monde. Leur successeur, **IPv6**, utilise des adresses beaucoup plus longues comme `2001:db8::1`. Les deux coexistent aujourd'hui.

## Les services indispensables

- La **passerelle par défaut** : le routeur vers lequel l'appareil envoie tout ce qui ne concerne pas son réseau local. Sans elle, pas d'Internet.
- Le **DHCP** : le service qui attribue automatiquement une adresse IP, un masque, une passerelle et des serveurs DNS aux appareils qui se connectent.
- Le **DNS** : l'annuaire qui traduit les noms (`google.com`) en adresses IP.

## TCP ou UDP ?

| | TCP | UDP |
| --- | --- | --- |
| Fiabilité | Vérifie que chaque paquet arrive, renvoie les paquets perdus | Envoie sans vérifier |
| Ordre | Remet les données dans l'ordre | Pas de garantie d'ordre |
| Rapidité | Plus lent | Plus rapide |
| Usages | Web, e-mail, transfert de fichiers, SSH | Appels vocaux et vidéo, jeux en ligne, DNS |

Pour un appel WhatsApp, mieux vaut perdre un fragment de voix que d'attendre qu'il soit renvoyé : on utilise UDP. Pour télécharger un fichier, chaque octet compte : on utilise TCP.

## Diagnostiquer une panne, couche par couche

On part du bas et on remonte. Les commandes ci-dessous fonctionnent sous Linux ; sous Windows, `ipconfig` remplace `ip a` et `tracert` remplace `traceroute`.

```bash
ip a                        # 1. L'appareil a-t-il une adresse IP ? (une adresse en 169.254.x.x = DHCP en échec)
ip route                    # 2. Quelle est la passerelle par défaut ?
ping -c 4 192.168.1.1       # 3. La passerelle répond-elle ?
ping -c 4 8.8.8.8           # 4. Internet est-il joignable par adresse IP ?
nslookup google.com         # 5. Le DNS fonctionne-t-il ?
traceroute google.com       # 6. Par où passent les paquets, et où ça bloque ?
```

L'interprétation est logique :

- pas d'adresse IP → problème de câble, de Wi-Fi ou de DHCP ;
- la passerelle ne répond pas → problème sur le réseau local ;
- `8.8.8.8` ne répond pas mais la passerelle oui → problème côté routeur ou fournisseur d'accès ;
- `8.8.8.8` répond mais `google.com` non → problème de **DNS**.

> **Astuce** : beaucoup de « pannes d'Internet » sont en fait des pannes de DNS. Si `ping 8.8.8.8` fonctionne et pas les sites web, essaie de configurer un autre serveur DNS.

## À toi de jouer

1. Sur ta machine, relève ton adresse IP, ton masque, ta passerelle et tes serveurs DNS.
2. Calcule la plage d'adresses utilisables du réseau `192.168.10.0/24`, puis celle de `10.20.0.0/16`.
3. Un client a l'adresse `169.254.12.40`. Quel est le problème probable ?
4. Un autre client peut faire `ping 8.8.8.8` mais aucun site ne s'ouvre. Quelle couche ou quel service est en cause, et que lui proposes-tu ?
5. Rédige une fiche de diagnostic en 6 étapes que les techniciens du support pourront suivre au téléphone avec un client.

> **Réponses des étapes 2 à 4** : `192.168.10.1` à `192.168.10.254` ; `10.20.0.1` à `10.20.255.254`. Une adresse en 169.254 signifie que l'appareil n'a pas obtenu d'adresse du serveur DHCP. Le DNS est en cause : vérifier les serveurs DNS configurés ou en essayer d'autres.

## Vérifie tes acquis

1. À quelle couche se situent les ports ?
2. Quel service attribue automatiquement les adresses IP ?
3. Pourquoi un appel vidéo utilise-t-il plutôt UDP ?

> **Réponses** : 1. À la couche transport. 2. Le DHCP. 3. Parce qu'il vaut mieux perdre un petit fragment que d'attendre sa retransmission : la rapidité prime.

## En résumé

- Le modèle **TCP/IP** a quatre couches : accès réseau, Internet (IP), transport (TCP/UDP), application.
- Une adresse IP et son **masque** définissent le réseau et l'appareil ; les plages privées passent par la **NAT**.
- La **passerelle** mène vers les autres réseaux, le **DHCP** distribue les adresses, le **DNS** traduit les noms.
- **TCP** est fiable, **UDP** est rapide.
- On diagnostique de bas en haut : adresse, passerelle, Internet par IP, DNS.

## Pour aller plus loin

- Demande au mentor IA : « Fais-moi pratiquer le calcul de sous-réseaux avec 5 exercices corrigés. »
