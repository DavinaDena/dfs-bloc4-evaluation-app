# Documentation API — OpsTrack Field Service

---

## 1. Présentation générale

L’API OpsTrack Field Service permet au dashboard Next.js et aux intégrations externes (webhook) d’accéder aux données métier de l’application.  

Elle est exposée uniquement en production et protégée par :

- **Token Bearer** pour la plupart des endpoints API  
- **Basic Auth** pour le webhook externe (`hooks.php`)  

> Cette documentation couvre les endpoints principaux et leur utilisation. Une documentation Swagger/OpenAPI complète n’est pas jugée nécessaire pour ce projet, car l’API est simple et le code source est accessible.

---

## 2. Endpoints principaux

| Endpoint | Méthode | Description | Authentification |
|----------|---------|-------------|----------------|
| `/api/health` | GET | Vérifie l’état de santé du service | Aucune |
| `/api/v1/tickets` | GET | Récupère la liste des tickets | Token Bearer |
| `/api/v1/tickets` | POST | Crée un ticket | Token Bearer |
| `/api/v1/tickets/{id}` | PUT | Met à jour un ticket | Token Bearer |
| `/api/v1/tickets/{id}` | DELETE | Supprime un ticket | Token Bearer |
| `/api/v1/technicians` | GET | Liste des techniciens | Token Bearer |
| `/api/v1/external/weather?site_id={id}` | GET | Météo Open-Meteo pour un site | Token Bearer |
| `/hooks.php` | POST | Webhook externe pour mise à jour des tickets | Basic Auth |

---

## 3. Exemples de requêtes

### 3.1 Vérification de l’état de santé

```bash
curl https://eval-dfs-p-tpl-20261-04.it-students.fr/api/health
```
Réponse attendue :

```bash
{
  "status": "ok",
  "service": "OpsTrack",
  "timestamp": "2026-03-16T12:51:33+00:00"
}
```

###  3.2 Récupération des tickets (Token Bearer)
curl -H "Authorization: Bearer opstrack-token-securise-2026" \
https://eval-dfs-p-tpl-20261-04.it-students.fr/api/v1/tickets

Réponse typique :
```bash
[
  {
    "id": 1,
    "title": "Problème électrique",
    "status": "scheduled",
    "site_id": 2,
    "assigned_technician_id": 3
  },
  {
    "id": 2,
    "title": "Maintenance climatiseur",
    "status": "in_progress",
    "site_id": 1,
    "assigned_technician_id": 2
  }
]
```
### 3.3 Webhook externe (Basic Auth)
```bash
curl -u webhook_user:[motdepasse] \
-X POST https://eval-dfs-p-tpl-20261-04.it-students.fr/hooks.php \
-H "Content-Type: application/json" \
-d '{
  "ticket_id": 1,
  "status": "completed"
}'
```
Le webhook met à jour le statut d’un ticket dans la base MySQL.

Vérifie la présence et la validité du Basic Auth.

## 4. Authentification et sécurité
###  4.1 Token Bearer

Chaque requête API côté dashboard ou intégration doit inclure l’en-tête :

Authorization: Bearer <token>

Les tokens sont stockés dans la base de données avec le champ is_active.

Chaque utilisation met à jour le champ last_used_at.

###  4.2 Basic Auth pour le webhook

Utilisé uniquement pour hooks.php

Empêche l’accès non autorisé et protège les modifications sur les tickets.

## 5. Bonnes pratiques et maintenance

Superviser les logs Laravel (storage/logs/laravel.log) pour détecter les erreurs API

Superviser les logs Nginx (/var/log/nginx/access.log et /var/log/nginx/error.log)

Tester les endpoints régulièrement, notamment /api/health

Ajouter de nouveaux endpoints en suivant la convention existante et en utilisant le middleware de sécurité EnsureApiTokenIsValid

## 6. Conclusion

Cette documentation permet au mainteneur de :

Comprendre les endpoints API existants

Tester et vérifier la sécurité des requêtes

Garantir la traçabilité et la bonne utilisation des API

Pour toute extension de l’API ou intégration d’un nouveau microservice, respecter les mêmes conventions d’authentification et de sécurité.