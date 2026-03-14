# OpsTrack Field Service

Application support pour l'evaluation RNCP38606 bloc 4.

## Stack

- Laravel 12 / PHP 8.4
- MySQL
- MongoDB
- Redis
- API REST
- Webhook `public/hooks.php`
- Microservice Next.js dans `microservices/dispatch-dashboard`
- API publique Open-Meteo consommee depuis Laravel

## Installation

```bash
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate --seed
php artisan serve
```

## Variables importantes

- `DB_*` pour MySQL
- `MONGODB_*` pour la journalisation technique
- `REDIS_*` pour cache/session
- `OPSTRACK_API_TOKEN` pour les clients API et le microservice Next.js
- `WEBHOOK_BASIC_USER` et `WEBHOOK_BASIC_PASSWORD` pour `hooks.php`

## Endpoints utiles

- `/` tableau de bord Laravel
- `/api/health`
- `/api/v1/tickets`
- `/api/v1/technicians`
- `/api/v1/external/weather?site_id=1`
- `/hooks.php`

## Notes d'exploitation

- Le package MongoDB Laravel est installe, mais l'extension PHP `ext-mongodb` doit etre presente sur la machine d'execution.
- Le microservice Next.js est fourni comme squelette applicatif et doit etre installe avec Node.js sur l'environnement cible.
