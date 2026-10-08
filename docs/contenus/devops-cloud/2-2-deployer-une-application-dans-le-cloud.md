L'application de réservation de bus fonctionne en local dans Docker. Il est temps de la rendre accessible aux voyageurs de tout le Tchad. Où l'héberger ? Sur un serveur au bureau, chez un hébergeur mutualisé, ou dans le **cloud** ? Ce chapitre t'aide à choisir et te guide pour un premier déploiement sur un serveur virtuel.

> **Objectifs de ce chapitre**
> - Comprendre ce qu'est le cloud et ses modèles (IaaS, PaaS, SaaS)
> - Choisir un type d'hébergement selon le projet et le budget
> - Déployer une application Docker sur un VPS
> - Configurer un nom de domaine et HTTPS
> - Mettre en place sauvegardes et supervision de base

## Le cloud, c'est quoi ?

Le **cloud** consiste à louer des ressources informatiques (serveurs, stockage, bases de données) à un fournisseur, à la demande, au lieu de les acheter et de les gérer soi-même. Tu payes ce que tu utilises, tu peux augmenter la puissance en quelques minutes, et le fournisseur s'occupe du matériel, de l'électricité et de la climatisation.

## Les trois modèles

| Modèle | Tu gères | Le fournisseur gère | Exemples |
| --- | --- | --- | --- |
| **IaaS** (infrastructure) | Système, logiciels, application | Matériel, réseau | VPS chez OVHcloud, Hetzner, DigitalOcean ; machines virtuelles AWS, Azure |
| **PaaS** (plateforme) | Ton code et sa configuration | Serveur, système, mises à jour | Render, Heroku, Google App Engine |
| **SaaS** (logiciel) | Tes données et paramètres | Tout le reste | Gmail, Google Drive, Microsoft 365 |

Plus on monte vers le SaaS, moins il y a de travail technique, mais moins on a de contrôle.

> **Info** : pour un public au Tchad, la **latence** compte : un serveur en Europe répond généralement plus vite qu'un serveur aux États-Unis. Le choix de la région du centre de données a un vrai impact sur la rapidité perçue.

## Choisir son hébergement

- **Hébergement mutualisé** (comme LWS) : idéal pour un site PHP classique, peu cher, sans administration système. Mais pas de Docker et peu de liberté.
- **VPS** (serveur privé virtuel) : un serveur Linux à toi, à partir de quelques milliers de FCFA par mois. Tu installes ce que tu veux, Docker compris, mais tu es responsable de la sécurité et des mises à jour.
- **PaaS** : tu pousses ton code, la plateforme s'occupe du reste. Très confortable, plus cher à grande échelle.

Pour l'application d'Ibrahim, packagée en Docker et sans budget pour une équipe système, un petit VPS est un bon compromis.

## Déployer sur un VPS, étape par étape

### 1. Se connecter et sécuriser le serveur

```bash
ssh root@203.0.113.25
adduser ibrahim && usermod -aG sudo ibrahim
apt update && apt upgrade -y
ufw allow OpenSSH && ufw allow 80 && ufw allow 443 && ufw enable
```

On crée un utilisateur personnel, on met le système à jour et on active le pare-feu en n'ouvrant que SSH et le web. Ensuite, on configure la connexion par **clé SSH** et on désactive la connexion par mot de passe.

### 2. Installer Docker et récupérer le projet

```bash
curl -fsSL https://get.docker.com | sh
git clone https://github.com/startup-td/reservation-bus.git
cd reservation-bus
cp .env.exemple .env      # puis renseigner les vrais mots de passe
docker compose up -d
```

### 3. Nom de domaine et HTTPS

Chez ton registraire de domaine, crée un **enregistrement DNS de type A** qui pointe `bus.exemple.td` vers l'adresse IP du VPS. Ensuite, place devant l'application un **reverse proxy** qui gère le certificat HTTPS gratuit de Let's Encrypt. **Caddy** le fait automatiquement avec une configuration de deux lignes :

```text
bus.exemple.td {
    reverse_proxy localhost:8080
}
```

> **Attention** : ne publie jamais une application qui gère des comptes ou des paiements sans HTTPS. Sans chiffrement, les mots de passe circulent en clair sur le réseau.

## Après le déploiement

Mettre en ligne n'est que le début. Trois réflexes indispensables :

- **Sauvegardes** automatiques et quotidiennes de la base de données, stockées **ailleurs** que sur le serveur (et testées : une sauvegarde jamais restaurée n'est pas une sauvegarde).
- **Supervision** : un service gratuit comme UptimeRobot vérifie toutes les 5 minutes que le site répond et t'alerte sinon.
- **Mises à jour** régulières du système et des images Docker, pour corriger les failles de sécurité.

Exemple de sauvegarde planifiée chaque nuit avec `cron` :

```bash
0 2 * * * docker compose -f /home/ibrahim/reservation-bus/compose.yaml exec -T db mysqldump -uroot -p"$MDP" reservation | gzip > /home/ibrahim/sauvegardes/reservation-$(date +\%F).sql.gz
```

## À toi de jouer

Sans forcément louer de serveur, prépare le **dossier de déploiement** de l'application d'Ibrahim :

1. Choisis un type d'hébergement et justifie ce choix en cinq lignes (budget, compétences de l'équipe, besoins techniques).
2. Écris la liste ordonnée des commandes pour préparer et sécuriser le serveur.
3. Décris la configuration DNS et HTTPS.
4. Rédige la stratégie de sauvegarde : quoi, quand, où, combien de temps on garde les copies, et comment on teste la restauration.
5. Bonus : si tu as accès à un VPS (beaucoup de fournisseurs offrent un crédit d'essai), réalise le déploiement complet.

> **Pour t'auto-évaluer** : ton dossier est complet si un autre développeur peut redéployer l'application de zéro, seul, en suivant uniquement tes instructions.

## Vérifie tes acquis

1. Quelle est la différence entre IaaS et PaaS ?
2. Quel enregistrement DNS relie un nom de domaine à l'adresse IP d'un serveur ?
3. Pourquoi stocker les sauvegardes ailleurs que sur le serveur ?

> **Réponses** : 1. En IaaS, tu gères le système et les logiciels ; en PaaS, la plateforme s'en charge et tu ne gères que ton code. 2. Un enregistrement de type A. 3. Pour pouvoir restaurer les données même si le serveur est détruit, piraté ou inaccessible.

## En résumé

- Le **cloud** loue des ressources à la demande ; trois modèles : IaaS, PaaS, SaaS.
- Le choix dépend du budget, des compétences et des besoins (mutualisé, VPS, PaaS).
- Un déploiement sur VPS : sécuriser, installer Docker, lancer l'application, configurer DNS et HTTPS.
- Après la mise en ligne : **sauvegardes testées**, **supervision**, **mises à jour**.

## Pour aller plus loin

- [La documentation de Caddy](https://caddyserver.com/docs/) pour le HTTPS automatique
- Demande au mentor IA : « Comment déployer automatiquement sur mon VPS à chaque push grâce à GitHub Actions ? »
