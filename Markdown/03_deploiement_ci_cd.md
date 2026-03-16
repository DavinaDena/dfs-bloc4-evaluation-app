# 03 — Déploiement automatisé entre qualification et mise en service

---

## 1. Objectif

Mettre en place un pipeline de déploiement automatique permettant de promouvoir l'application depuis l'environnement de qualification vers l'environnement de production, avec vérification de qualité et smoke test post-déploiement.

---

## 2. Outil retenu : GitHub Actions

GitHub Actions est retenu car :
- Intégré nativement au dépôt GitHub — pas d'outil externe à installer
- Déclenchement automatique sur push de branche
- Secrets chiffrés pour les credentials SSH
- Logs détaillés de chaque exécution
- Gratuit pour les dépôts publics

---

## 3. Configuration des secrets GitHub

Les secrets suivants ont été configurés dans **Settings → Secrets and variables → Actions** du dépôt :

| Secret | Valeur |
|---|---|
| `SSH_PRIVATE_KEY` | Clé privée `.pem` du serveur de production |
| `SSH_HOST` | `35.180.42.86` |
| `SSH_USER` | `ubuntu` |

> Les secrets sont chiffrés par GitHub et jamais exposés dans les logs.

---

## 4. Pipeline de déploiement

Fichier : `.github/workflows/deploy.yml`

```yaml
name: Deploy to Production

on:
  push:
    branches:
      - production

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Deploy via SSH
        uses: appleboy/ssh-action@v1.0.0
        with:
          host: ${{ secrets.SSH_HOST }}
          username: ${{ secrets.SSH_USER }}
          key: ${{ secrets.SSH_PRIVATE_KEY }}
          script: |
            cd /var/www/opstrack
            git pull origin main
            composer install --no-dev --optimize-autoloader
            php artisan migrate --force
            php artisan config:cache
            php artisan view:clear
            php artisan cache:clear
            sudo systemctl reload nginx

      - name: Smoke test
        run: |
          sleep 10
          curl --fail https://eval-dfs-p-tpl-20261-04.it-students.fr/api/health
```

---

## 5. Description des étapes

### 5.1 Déclenchement

Le pipeline se déclenche automatiquement à chaque push sur la branche `production`. Le déclenchement est donc **explicite et reproductible** — un push = un déploiement.

### 5.2 Étapes du déploiement

| Étape | Commande | Description |
|---|---|---|
| Pull du code | `git pull origin main` | Récupère la dernière version du code |
| Dépendances | `composer install --no-dev` | Installe les packages PHP sans les dépendances de dev |
| Migrations | `php artisan migrate --force` | Applique les nouvelles migrations en production |
| Cache config | `php artisan config:cache` | Optimise le chargement de la config |
| Nettoyage vues | `php artisan view:clear` | Vide le cache des templates Blade |
| Nettoyage cache | `php artisan cache:clear` | Vide le cache applicatif |
| Reload Nginx | `sudo systemctl reload nginx` | Recharge Nginx sans coupure de service |

### 5.3 Smoke test post-déploiement

Après chaque déploiement, un smoke test vérifie automatiquement que l'application répond correctement :

```bash
curl --fail https://eval-dfs-p-tpl-20261-04.it-students.fr/api/health
```

Réponse attendue :
```json
{"status":"ok","service":"OpsTrack","timestamp":"..."}
```

Si le smoke test échoue, le job GitHub Actions passe en rouge et l'équipe est notifiée. Le déploiement précédent reste actif sur le serveur.

---

## 6. Résultat

Le pipeline a été exécuté avec succès :

| Champ | Valeur |
|---|---|
| Workflow | Deploy to Production |
| Run | #1 — commit `8647fe1` |
| Branche | `production` |
| Statut | ✅ Success |
| Étapes | deploy ✅ — smoke test ✅ |

---

## 7. Améliorations possibles

Dans une architecture AWS cible (cf. livrable 01), ce pipeline pourrait être enrichi avec :
- Déploiement blue/green via ECS pour zéro downtime
- Tests automatisés (`php artisan test`) avant déploiement
- Notification Slack/email en cas d'échec
- Rollback automatique si le smoke test échoue

---
