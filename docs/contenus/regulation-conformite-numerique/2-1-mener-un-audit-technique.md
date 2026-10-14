Le régulateur a reçu de nombreuses plaintes d'abonnés d'une ville secondaire : appels coupés, Internet très lent, forfaits qui disparaissent plus vite que prévu. Hawa est chargée de mener un **audit technique** pour établir les faits. Un audit n'est ni une impression, ni une accusation : c'est une démarche **méthodique**, fondée sur des **preuves**, qui compare la réalité à un **référentiel** et aboutit à des constats et des recommandations. La même méthode s'applique à un audit de sécurité informatique dans une entreprise ou un audit de conformité dans une banque.

> **Objectifs de ce chapitre**
> - Connaître les étapes d'un audit technique
> - Définir le périmètre, le référentiel et les critères
> - Collecter des preuves fiables
> - Formuler des constats et des recommandations utiles
> - Rédiger un rapport d'audit et assurer le suivi

## Les principes de l'audit

- **Indépendance** : l'auditeur n'audite pas son propre travail et n'a pas d'intérêt dans le résultat.
- **Approche fondée sur les preuves** : chaque constat s'appuie sur des éléments vérifiables.
- **Objectivité** : on décrit les faits, sans jugement sur les personnes.
- **Confidentialité** : les informations recueillies sont protégées.
- **Contradictoire** : l'audité peut répondre aux constats avant la version finale.

## Étape 1 : préparer

### Le périmètre et les objectifs

On précise **ce qui est audité** et **ce qui ne l'est pas** : pour Hawa, la qualité des services voix et data de l'opérateur X dans la ville Y, sur les trois derniers mois, ainsi que l'exactitude du décompte des forfaits data.

### Le référentiel

C'est la **norme de comparaison** : le cahier des charges de l'opérateur, les décisions du régulateur sur la qualité de service, les conditions des offres publiées. Pour un audit de sécurité en entreprise, ce sera par exemple la politique de sécurité interne ou une norme comme l'**ISO/IEC 27001**.

### Le plan d'audit

Il liste les **points de contrôle**, les **méthodes** (mesures, entretiens, analyse de documents, tests), les **données à demander**, le **calendrier** et l'**équipe**. On envoie à l'audité une **lettre de mission** et une **demande de documents** à l'avance.

> **Astuce** : une analyse des données disponibles **avant** la visite (plaintes reçues, indicateurs transmis, résultats de mesures précédentes) permet de cibler les points de contrôle et de gagner beaucoup de temps sur place.

## Étape 2 : collecter les preuves

Les principales techniques :

| Technique | Exemple dans l'audit d'Hawa |
| --- | --- |
| **Mesures** | Campagne de drive tests dans la ville : appels de test, téléchargements, mesures de couverture |
| **Analyse de données** | Indicateurs du NOC de l'opérateur, statistiques de trafic des sites de la ville |
| **Revue documentaire** | Liste des sites et de leur état, tickets d'incidents, rapports de maintenance |
| **Entretiens** | Responsable régional, ingénieurs radio, équipe du NOC |
| **Observation et visite** | Visite de sites : énergie, batteries, état des équipements |
| **Tests** | Achat de forfaits data avec des cartes SIM de test et comparaison entre volume consommé et volume décompté |

Une **preuve fiable** est :

- **pertinente** : elle concerne bien le point de contrôle ;
- **suffisante** : en quantité assez grande pour conclure (un échantillon représentatif, pas un cas isolé) ;
- **traçable** : on sait d'où elle vient, quand et comment elle a été obtenue ;
- **conservée** de façon sécurisée.

> **Attention** : quand tu travailles sur des données d'abonnés (relevés de consommation, tickets de réclamation), respecte strictement la confidentialité et la protection des données personnelles : n'extrais que ce qui est nécessaire, et anonymise autant que possible.

### L'échantillonnage

Impossible de tout vérifier. On choisit un **échantillon** : 30 sites sur 120, 50 réclamations sur 2 000, 20 achats de forfait de test. L'échantillon doit être **représentatif** (différents quartiers, différentes heures) et sa méthode de sélection **documentée**.

## Étape 3 : analyser et formuler les constats

Un **constat** compare ce qui est observé au référentiel. Il se rédige en quatre parties :

| Élément | Exemple |
| --- | --- |
| **Critère** (ce qui est attendu) | Le cahier des charges impose un taux de coupure des appels inférieur à un seuil fixé |
| **Fait constaté** | Les mesures montrent un taux de coupure deux fois supérieur à ce seuil dans quatre quartiers, aux heures de pointe |
| **Cause** | Huit sites de ces quartiers sont saturés le soir ; trois sites subissent des coupures d'énergie répétées faute de batteries fonctionnelles |
| **Conséquence** | Dégradation du service pour les abonnés, manquement aux obligations du cahier des charges |

Les constats sont classés par **niveau de gravité** (majeur, modéré, mineur) pour aider à prioriser.

## Étape 4 : recommander

Une bonne **recommandation** est **précise**, **réaliste**, **mesurable** et **assortie d'un délai** :

- vague : « Améliorer la qualité de service » ;
- utile : « Remplacer les batteries des trois sites identifiés sous 30 jours et ajouter de la capacité sur les huit sites saturés sous 90 jours, avec un rapport mensuel des indicateurs de ces sites au régulateur. »

## Étape 5 : le rapport et le contradictoire

Le **rapport d'audit** contient :

1. une **synthèse** d'une page pour les décideurs : contexte, conclusion générale, constats majeurs ;
2. le **périmètre**, le **référentiel** et la **méthodologie** (y compris l'échantillonnage et ses limites) ;
3. les **constats** détaillés avec leurs preuves ;
4. les **recommandations** priorisées ;
5. les **réponses de l'audité** ;
6. les **annexes** : données, résultats de mesures, liste des documents.

Le projet de rapport est transmis à l'audité, qui peut apporter des précisions ou contester des constats avec des éléments. L'auditeur en tient compte, puis finalise.

## Étape 6 : le suivi

Un audit n'a de valeur que si les recommandations sont **mises en œuvre**. On tient un **tableau de suivi** : recommandation, responsable, délai, état d'avancement, preuves de réalisation. Une **mesure de contrôle** après les délais vérifie l'amélioration réelle.

## À toi de jouer

Tu es chargé de l'audit du décompte des forfaits data d'un opérateur, à la suite de plaintes d'abonnés.

1. Rédige le périmètre, les objectifs et le référentiel de l'audit.
2. Construis le plan d'audit : 6 points de contrôle, avec pour chacun la technique et les données demandées.
3. Conçois le protocole de test : nombre de cartes SIM de test, forfaits achetés, usages réalisés, mesure indépendante de la consommation (application de mesure, journal d'un serveur de test), critère d'écart acceptable.
4. Rédige un constat fictif complet (critère, fait, cause, conséquence) et la recommandation associée.
5. Rédige la synthèse d'une page du rapport.

> **Pour t'auto-évaluer** : relis chacun de tes constats. Un lecteur extérieur doit pouvoir retrouver la preuve qui le fonde, et comprendre ce qui est attendu de l'audité, sans avoir besoin de t'appeler.

## Vérifie tes acquis

1. Qu'est-ce qu'un référentiel d'audit ?
2. Quelles sont les quatre parties d'un constat ?
3. Pourquoi la phase contradictoire est-elle importante ?

> **Réponses** : 1. La norme de comparaison (loi, cahier des charges, politique, norme) à laquelle on confronte la réalité observée. 2. Le critère, le fait constaté, la cause et la conséquence. 3. Elle permet à l'audité d'apporter des éléments, corrige d'éventuelles erreurs et renforce la solidité et l'acceptation du rapport.

## En résumé

- Un audit compare la réalité à un **référentiel**, avec **indépendance**, **objectivité** et **preuves**.
- Étapes : préparer, collecter, analyser, recommander, rapporter (avec contradictoire), suivre.
- Les preuves doivent être **pertinentes**, **suffisantes**, **traçables** et **conservées** ; l'échantillon est représentatif et documenté.
- Un constat = **critère, fait, cause, conséquence** ; une recommandation est précise, mesurable et datée.
- Le **suivi** des recommandations donne sa valeur à l'audit.

## Pour aller plus loin

- Demande au mentor IA : « Aide-moi à transformer ces observations en constats d'audit structurés : [tes observations]. »
