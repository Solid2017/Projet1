Un vendredi soir, le serveur de messagerie de l'entreprise s'est arrêté : son disque était plein. Personne ne s'en est rendu compte avant lundi matin, quand les clients ont commencé à se plaindre. Avec une **supervision**, Abdelkerim aurait reçu une alerte dès que le disque dépassait 85 %, des jours avant la panne. Superviser, c'est passer d'une administration qui **subit** les pannes à une administration qui les **anticipe**.

> **Objectifs de ce chapitre**
> - Identifier les indicateurs clés d'un serveur
> - Lire les journaux système
> - Vérifier l'état des services
> - Écrire un script de contrôle simple et le planifier avec cron
> - Connaître les outils de supervision professionnels

## Quoi surveiller ?

| Indicateur | Commande | Seuil d'alerte courant |
| --- | --- | --- |
| Espace disque | `df -h` | Plus de 85 % utilisé |
| Mémoire vive | `free -h` | Mémoire disponible très faible, swap très utilisé |
| Charge processeur | `uptime`, `top` | Charge durablement supérieure au nombre de cœurs |
| Services | `systemctl status nginx` | Service arrêté ou en échec |
| Disponibilité externe | Test HTTP depuis l'extérieur | Le site ne répond pas |
| Sécurité | `/var/log/auth.log` | Nombreuses connexions échouées |
| Sauvegardes | Date du dernier fichier de sauvegarde | Plus de 24 h |

> **Info** : la **charge** affichée par `uptime` donne trois nombres : la moyenne sur 1, 5 et 15 minutes. Sur un serveur à 4 cœurs, une charge de 4 signifie qu'il est occupé à 100 %.

## Les services avec systemd

Sur la plupart des distributions modernes, les services sont gérés par **systemd** :

```bash
systemctl status nginx          # état du service, avec les dernières lignes de log
sudo systemctl restart nginx    # redémarrer
sudo systemctl enable nginx     # démarrer automatiquement au démarrage du serveur
systemctl --failed              # lister les services en échec
```

## Les journaux

Les journaux racontent tout ce qui se passe sur le serveur. Deux sources principales :

```bash
journalctl -u nginx --since "1 hour ago"    # journal d'un service sur la dernière heure
journalctl -p err -b                        # toutes les erreurs depuis le dernier démarrage
tail -f /var/log/nginx/error.log            # erreurs du serveur web en direct
grep "Failed password" /var/log/auth.log | tail -n 20   # dernières tentatives de connexion échouées
```

> **Attention** : les journaux eux-mêmes peuvent remplir le disque. Vérifie que **logrotate** est actif : il compresse et supprime automatiquement les anciens journaux.

## Un script de contrôle maison

Même sans outil sophistiqué, un petit script peut vérifier l'essentiel et prévenir l'administrateur. Crée `/usr/local/bin/controle-serveur.sh` :

```bash
#!/bin/bash
SEUIL=85
ALERTES=""

# 1. Espace disque de la partition principale
UTILISE=$(df / --output=pcent | tail -n 1 | tr -dc '0-9')
if [ "$UTILISE" -ge "$SEUIL" ]; then
  ALERTES="$ALERTES Disque plein à ${UTILISE}%."
fi

# 2. Services indispensables
for SERVICE in nginx mysql; do
  if ! systemctl is-active --quiet "$SERVICE"; then
    ALERTES="$ALERTES Service $SERVICE arrêté."
  fi
done

# 3. Résultat
if [ -n "$ALERTES" ]; then
  echo "$(date '+%F %T') ALERTE :$ALERTES" >> /var/log/controle-serveur.log
fi
```

Rends-le exécutable avec `sudo chmod 750 /usr/local/bin/controle-serveur.sh`. Pour être prévenu sur ton téléphone, on peut remplacer l'écriture dans le fichier par l'envoi d'un e-mail ou d'un message via l'API d'un service de messagerie comme Telegram.

## Planifier avec cron

**cron** exécute des tâches à intervalles réguliers. On édite la liste des tâches avec `sudo crontab -e`, puis on ajoute une ligne :

```text
*/5 * * * * /usr/local/bin/controle-serveur.sh
```

Les cinq champs sont : minute, heure, jour du mois, mois, jour de la semaine. `*/5` signifie « toutes les 5 minutes ». Autres exemples :

| Ligne cron | Signification |
| --- | --- |
| `0 2 * * *` | Tous les jours à 2 h 00 |
| `30 7 * * 1-5` | Du lundi au vendredi à 7 h 30 |
| `0 */6 * * *` | Toutes les 6 heures |

## Les outils professionnels

Au-delà de quelques serveurs, on utilise des outils dédiés, souvent libres et gratuits :

- **Uptime Kuma** ou **UptimeRobot** : vérifient depuis l'extérieur que tes sites et services répondent, et alertent par e-mail, Telegram ou SMS.
- **Zabbix** : supervision complète d'un parc de serveurs et d'équipements réseau, très utilisée par les opérateurs et les grandes entreprises.
- **Prometheus** et **Grafana** : collecte de métriques et beaux tableaux de bord, populaires dans les environnements cloud et Docker.
- **Netdata** : tableau de bord en temps réel, installable en une commande sur un serveur.

> **Astuce** : une alerte doit être **utile**. Si tu reçois 50 alertes par jour pour rien, tu finiras par les ignorer toutes, y compris la vraie. Ajuste les seuils pour n'être prévenu que de ce qui demande une action.

## À toi de jouer

1. Sur ta machine Linux, relève l'espace disque, la mémoire, la charge et la liste des services en échec.
2. Crée le script `controle-serveur.sh` ci-dessus et teste-le en mettant volontairement le seuil à 1 % : une alerte doit apparaître dans le journal.
3. Planifie-le toutes les 5 minutes avec cron, et vérifie après 10 minutes que le journal se remplit.
4. Ajoute une vérification : alerte si le dernier fichier du dossier `/srv/sauvegardes` date de plus de 24 heures (indice : `find /srv/sauvegardes -mtime -1`).
5. Rédige la **fiche de supervision** du serveur : indicateurs, seuils, fréquence de contrôle, qui est prévenu et comment.

> **Pour t'auto-évaluer** : arrête volontairement le service nginx (`sudo systemctl stop nginx`). Dans les 5 minutes, ton script doit avoir enregistré l'alerte. Pense à redémarrer le service ensuite !

## Vérifie tes acquis

1. Quelle commande liste les services en échec ?
2. Que signifie la ligne cron `0 2 * * *` ?
3. Pourquoi faut-il éviter les alertes trop nombreuses ?

> **Réponses** : 1. `systemctl --failed`. 2. Tous les jours à 2 h du matin. 3. Parce que l'équipe finit par les ignorer et risque de manquer une alerte importante.

## En résumé

- On surveille au minimum le disque, la mémoire, la charge, les services, la disponibilité externe et les sauvegardes.
- `systemctl` gère les services, `journalctl` et `/var/log` contiennent les journaux.
- Un script simple planifié avec **cron** suffit pour commencer.
- Uptime Kuma, Zabbix, Prometheus et Grafana prennent le relais pour un parc plus important.
- Des alertes peu nombreuses mais pertinentes.

## Pour aller plus loin

- Demande au mentor IA : « Comment installer Uptime Kuma avec Docker et recevoir les alertes sur Telegram ? »
