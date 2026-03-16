# 04 — Supervision, journalisation et maintenance corrective

---

## 1. Objectif

Mettre en place des mécanismes permettant d'assurer la **surveillance, la traçabilité et la maintenance corrective** de l'application en production.

L'objectif est de garantir :

* La **détection rapide des incidents**
* La **traçabilité des événements techniques**
* La **sécurisation des accès à l'API**
* La **correction d'un bug applicatif identifié**

Ces mécanismes sont essentiels pour assurer la **continuité de service et la fiabilité du système**.

---

## 2. Journalisation de l'application

### 2.1 Logs applicatifs Laravel

Laravel génère automatiquement des journaux dans le fichier :

```
storage/logs/laravel.log
```

Ces logs permettent d'enregistrer :

* les erreurs applicatives
* les exceptions
* les événements critiques

Exemple de consultation :

```bash
tail -f storage/logs/laravel.log
```

Ces informations facilitent le **diagnostic des incidents en production**.

---

### 2.2 Logs serveur Nginx

Le serveur web Nginx enregistre également les requêtes et erreurs :

```
/var/log/nginx/access.log
/var/log/nginx/error.log
```

Les logs Nginx permettent notamment :

* d'identifier les erreurs HTTP
* de détecter des requêtes suspectes
* d'analyser le trafic de l'application

Exemple de consultation :

```bash
tail -f /var/log/nginx/error.log
```

---

## 3. Endpoint de supervision

L'application expose un endpoint de santé :

```
GET /api/health
```

Test de l'endpoint :

```bash
curl https://eval-dfs-p-tpl-20261-04.it-students.fr/api/health
```

Réponse attendue :

```json
{
  "status": "ok",
  "service": "OpsTrack"
}
```

Cet endpoint peut être utilisé par un **outil de supervision** pour vérifier automatiquement la disponibilité du service.

Exemples d'outils compatibles :

* Uptime Kuma
* Prometheus
* Grafana
* services de monitoring cloud

Une sonde HTTP peut ainsi vérifier l'application à intervalles réguliers.

---

## 4. Sécurisation de l'API

L'accès aux routes API est protégé par un **token d'authentification**.

Le middleware `EnsureApiTokenIsValid` vérifie la présence et la validité du token.

Extrait du middleware :

```php
$tokenValue = $request->bearerToken() ?: $request->header('X-Api-Token');
```

Le token est ensuite vérifié dans la base de données :

```php
$token = ApiToken::query()
    ->where('token', $tokenValue)
    ->where('is_active', true)
    ->first();
```

Chaque requête doit inclure l'en-tête :

```
Authorization: Bearer <token>
```

Exemple de requête valide :

```bash
curl -H "Authorization: Bearer opstrack-token-securise-2026" \
https://eval-dfs-p-tpl-20261-04.it-students.fr/api/v1/tickets
```

Si le token est valide, l'API retourne les données demandées.

Ce mécanisme permet :

* de **restreindre l'accès aux clients autorisés**
* de **désactiver un token compromis**
* de **tracer l'utilisation via le champ `last_used_at`**

---

## 5. Identification d'une faille de sécurité

Une faille de sécurité a été identifiée dans l'implémentation du webhook.

Le fichier :

```
public/hooks.php
```

charge directement l'application Laravel et appelle le contrôleur :

```php
$response = $app->make(WebhookController::class)->handle($request);
```

Ce mécanisme **bypass le système de routing et les middlewares Laravel**.

Conséquences :

* absence de contrôle global de sécurité
* absence de limitation de requêtes
* absence de journalisation automatique

### Correction proposée

Déplacer le webhook dans le système de routes Laravel :

```php
Route::post('/webhook', [WebhookController::class, 'handle']);
```

Cela permet de bénéficier des protections standards de Laravel.

---

## 6. Identification d'un bug applicatif

Un bug a été identifié dans le traitement du webhook.

Dans le contrôleur :

```
app/Http/Controllers/WebhookController.php
```

Le statut du ticket était systématiquement défini à :

```php
$ticket->update(['status' => 'scheduled']);
```

Cela ignore le statut réellement reçu dans le payload du webhook.

Conséquence :

* mauvaise synchronisation avec les systèmes externes
* statut incorrect dans l'application

### Correction

La correction consiste à utiliser la valeur reçue dans la requête :

```php
$ticket->update(['status' => $payload['status']]);
```

Le statut du ticket reflète désormais correctement l'état transmis par le système externe.

---

## 7. Résultat

Après mise en place des mécanismes de supervision et correction du bug :

| Élément                   | Statut          |
| ------------------------- | --------------- |
| Logs applicatifs          | ✅ opérationnels |
| Logs serveur Nginx        | ✅ disponibles   |
| Endpoint de supervision   | ✅ fonctionnel   |
| Authentification API      | ✅ sécurisée     |
| Faille webhook identifiée | ✅ documentée    |
| Bug applicatif corrigé    | ✅ résolu        |

L'application dispose désormais d'une **base solide de supervision et de maintenance corrective** pour un environnement de production.

---

## 8. Améliorations possibles

Plusieurs améliorations pourraient être ajoutées dans une architecture cible :

* Centralisation des logs (ELK Stack)
* Monitoring avancé via Prometheus + Grafana
* Alertes automatiques (email / Slack)
* Mise en place d'un rate limiting sur l'API
* Sauvegarde automatique de la base de données

Ces améliorations permettraient d'augmenter le **niveau de résilience et d'observabilité du système**.
