# Changelog — OpsTrack Field Service

---

## Version 1.0.0 — 2026-03-16
**Première version de production**

- Déploiement initial de l’application OpsTrack Field Service
- Backend Laravel 12 / PHP 8.4 avec API REST et webhook
- Dashboard Next.js pour le dispatch
- Base MySQL pour les données métier
- Redis pour cache et sessions
- Intégration Open-Meteo pour la météo des sites
- Authentification API via Token Bearer
- Webhook externe protégé par Basic Auth
- Endpoint `/api/health` pour supervision

---

## Version 1.0.1 — 2026-03-16
**Corrections et ajustements post-déploiement**

- Correction du bug dans les migrations : renommage pour respecter l’ordre des dépendances (`customers`, `sites`, `tickets`, `interventions`)
- Permissions fichiers `storage` et `bootstrap/cache` ajustées (`775`, ownership `ubuntu:www-data`)
- Ajout du certificat TLS/HTTPS via Certbot
- Configuration du firewall UFW pour n’ouvrir que les ports 22, 80, 443

---

## Version 1.0.2 — 2026-03-16
**Maintenance corrective et sécurité**

- Correction du bug webhook : statut des tickets désormais mis à jour selon le payload
- Déplacement du webhook dans les routes Laravel pour bénéficier des middlewares et journaux
- Validation des tokens API avec champ `is_active` et mise à jour `last_used_at`
- Ajout des logs serveur Nginx pour surveillance et diagnostic
- Mise en place d’un pipeline GitHub Actions pour déploiement automatique + smoke test

---

## Version 1.1.0 — 2026-03-16
**Améliorations de supervision et documentation**

- Documentation technique et API rédigée
- Endpoint `/api/health` utilisé par outils de monitoring
- Mise en place des bonnes pratiques de maintenance (logs, tests endpoints, suivi des tokens)
- Planification de futures améliorations : centralisation des logs, monitoring avancé, alertes automatiques, rate limiting, sauvegarde automatique de la BDD

---

## Note

Chaque entrée du changelog correspond à un commit ou une intervention sur le serveur.  
Le mainteneur peut se référer à ce document pour suivre l’historique des versions, corrections et améliorations.
