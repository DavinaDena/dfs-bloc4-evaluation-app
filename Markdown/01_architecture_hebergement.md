# 01 — Architecture cible et choix d'hébergement


---

## 1. Contexte

L'application OpsTrack Field Service est composée de plusieurs services qui tournent ensemble :

- Un backend Laravel 12 / PHP 8.4 avec une API REST et un webhook (`hooks.php`)
- Une base MySQL pour les données métier
- Une base MongoDB pour stocker les journaux techniques
- Redis pour le cache et les sessions
- Un microservice Next.js pour le dashboard de dispatch
- Des appels vers des APIs externes (Open-Meteo)

L'objectif est de trouver une architecture d'hébergement qui soit **stable, sécurisée, et qui ne coûte pas une fortune dès le départ**, mais qui peut monter en charge si besoin.

---

## 2. Plateforme choisie : AWS — région eu-west-3 (Paris)

J'ai choisi AWS pour plusieurs raisons :

- La région Paris (eu-west-3) permet de garder les données en Europe, ce qui est important pour respecter le RGPD
- AWS propose des services managés pour chaque composant de la stack (pas besoin de tout gérer à la main)
- Le modèle de facturation est à l'usage, donc le coût de base reste faible si l'application ne reçoit pas beaucoup de trafic
- C'est une plateforme très utilisée en entreprise, donc bien documentée et fiable

---

## 3. Architecture cible

### Diagramme

```
                        ┌──────────────────────────────────────────────┐
                        │           AWS — eu-west-3 (Paris)             │
                        │                                               │
  Utilisateurs          │  ┌─────────────┐    ┌──────────────────┐    │
  (web, API)  ────────► │  │  CloudFront │    │    Route 53      │    │
                        │  │  (front     │    │    (DNS)         │    │
                        │  │  statique)  │    └────────┬─────────┘    │
                        │  └─────────────┘             │              │
                        │                              ▼              │
                        │                 ┌────────────────────────┐  │
                        │                 │  Application Load      │  │
                        │                 │  Balancer (ALB)        │  │
                        │                 │  + certificat HTTPS    │  │
                        │                 │    via ACM             │  │
                        │                 └───────────┬────────────┘  │
                        │                             │               │
                        │              ┌──────────────┴────────────┐  │
                        │              │         VPC privé         │  │
                        │              │                           │  │
                        │        ┌─────▼──────┐  ┌───────────────┐│  │
                        │        │ ECS Fargate│  │  ECS Fargate  ││  │
                        │        │  Laravel   │  │   Next.js     ││  │
                        │        │ (API+hooks)│  │  microservice ││  │
                        │        └─────┬──────┘  └───────────────┘│  │
                        │              │                           │  │
                        │        ┌─────▼───────────────────────┐  │  │
                        │        │        Couche données        │  │  │
                        │        │                             │  │  │
                        │        │  RDS Aurora MySQL  Redis    │  │  │
                        │        │  Serverless v2     Serverless│  │  │
                        │        │                             │  │  │
                        │        │  DocumentDB (MongoDB-compat)│  │  │
                        │        └─────────────────────────────┘  │  │
                        │              │                           │  │
                        │        ┌─────▼───────────────────────┐  │  │
                        │        │       AWS Backup             │  │  │
                        │        │  (snapshots RDS + DocDB)     │  │  │
                        │        └─────────────────────────────┘  │  │
                        │              └───────────────────────────┘  │
                        └──────────────────────────────────────────────┘
```

### Description des composants

**Route 53 (DNS)**  
C'est le service DNS d'AWS. Il fait pointer le domaine `it-students.fr` vers l'ALB. Il gère aussi les sous-domaines si besoin (ex: `api.`, `eval-dfs-s-p-tpl-20261-04.`).

**ALB — Application Load Balancer**  
C'est lui qui reçoit les requêtes HTTPS en entrée. Il gère la terminaison TLS grâce au certificat émis par ACM (gratuit et renouvelé automatiquement). Il distribue ensuite le trafic vers les conteneurs ECS selon les routes (`/api`, `/hooks.php`, etc.).

**CloudFront + S3**  
Le frontend Next.js (build statique) est hébergé sur S3 et distribué via CloudFront, le CDN d'AWS. Ça permet d'avoir des temps de chargement rapides et un coût quasi nul à faible trafic.

**ECS Fargate**  
C'est du Docker managé par AWS. On définit les conteneurs dans un fichier de config (Task Definition), et AWS s'occupe de les lancer et de les redémarrer si besoin. Il y a un conteneur pour Laravel et un pour le microservice Next.js. L'avantage c'est que ça scale automatiquement avec le trafic et qu'on ne gère pas de serveurs.

**RDS Aurora MySQL Serverless v2**  
La base MySQL de l'application. Le mode Serverless v2 veut dire qu'elle démarre avec une capacité minimale (0.5 ACU) et monte automatiquement si il y a plus de requêtes. C'est le plus économique pour une app qui ne tourne pas à fond 24h/24.

**ElastiCache Serverless (Redis)**  
Pareil que RDS mais pour Redis. Gère le cache Laravel et les sessions. Pas de cluster à configurer.

**DocumentDB (compatible MongoDB)**  
AWS ne propose pas MongoDB directement, mais DocumentDB est compatible avec le driver MongoDB de Laravel. Il stocke les journaux techniques de l'application. C'est le composant le plus cher de l'archi car il n'a pas de mode serverless.

**AWS Secrets Manager**  
Toutes les variables sensibles (mots de passe BDD, tokens API, clés) sont stockées ici et injectées dans les conteneurs ECS. Ça évite de mettre des secrets dans le code ou dans les images Docker.

**AWS Backup**  
Politique de sauvegarde centralisée pour RDS et DocumentDB. Snapshots quotidiens avec rétention de 7 jours par exemple.

---

## 4. Estimation du coût mensuel

> Estimation pour une utilisation faible à modérée (contexte de démo / évaluation), région eu-west-3.

| Service | Hypothèse | Coût estimé / mois |
|---|---|---|
| ECS Fargate (Laravel) | 0.25 vCPU, 0.5 GB RAM | ~5–10 € |
| ECS Fargate (Next.js) | 0.25 vCPU, 0.5 GB RAM | ~3–6 € |
| ALB | 1 load balancer, faible trafic | ~18 € |
| RDS Aurora Serverless v2 | 0.5 ACU minimum | ~15–25 € |
| ElastiCache Serverless | Usage minimal | ~5–10 € |
| DocumentDB | Instance t3.medium | ~50–60 € |
| CloudFront + S3 | < 1 Go/mois | ~1–2 € |
| Route 53 | 1 zone DNS | ~0.50 € |
| AWS Backup | Snapshots 7j | ~2–5 € |
| Secrets Manager | < 10 secrets | ~1 € |
| **Total** | | **~100–140 € / mois** |

Le poste le plus cher est DocumentDB. Une alternative moins chère serait de faire tourner MongoDB dans un conteneur ECS avec un volume EFS persistant (~20€/mois), mais ça demande plus de maintenance.

---

## 5. Élasticité

L'architecture est pensée pour absorber les variations de charge sans intervention manuelle :

- ECS Fargate scale le nombre de conteneurs selon le CPU/mémoire (auto-scaling)
- RDS Aurora Serverless v2 augmente sa capacité en quelques secondes si les requêtes augmentent
- ElastiCache Serverless s'adapte automatiquement
- CloudFront absorbe les pics côté front sans toucher au backend

En dehors des heures de pointe, tout redescend au minimum, ce qui limite la facture.

---

## 6. Sécurité

- HTTPS obligatoire sur l'ALB, HTTP redirigé automatiquement
- Les bases de données ne sont pas accessibles depuis internet (Security Groups VPC)
- Les secrets sont dans AWS Secrets Manager, pas dans le code
- Les rôles IAM des tâches ECS ont uniquement les permissions nécessaires
- Toutes les données restent en région eu-west-3 (Paris) → conformité RGPD

---

## 7. Note sur l'environnement d'examen

Pour l'épreuve du jour, le déploiement se fait sur **une seule machine EC2** fournie par le centre (contrainte économique et temporelle). L'architecture AWS décrite dans ce document représente la **cible de production recommandée** pour un déploiement réel de cette application.

---
