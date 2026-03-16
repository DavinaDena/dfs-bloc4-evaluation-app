# Documentation technique — OpsTrack Field Service

---

## 1. Présentation générale

OpsTrack Field Service est une application composée de plusieurs composants :

- **Backend Laravel 12 / PHP 8.4** : API REST et webhook (`hooks.php`)  
- **Base MySQL** : données métier relationnelles  
- **Base MongoDB / DocumentDB** : stockage des journaux techniques  
- **Redis** : cache et sessions  
- **Microservice Next.js** : dashboard de dispatch  
- **Appels API externes** : Open-Meteo pour la météo  

Cette documentation résume le code source propre au projet, hors dépendances tierces, pour faciliter la maintenance et la compréhension globale.

---

## 2. Arborescence du projet (simplifiée)


app/ # Code Laravel : controllers, models, services
bootstrap/ # Configuration bootstrap
config/ # Fichiers de configuration (database, cache, app)
database/ # Migrations et seeders
microservices/ # Dashboard Next.js
public/ # Entrée web : index.php, hooks.php
resources/ # Templates Blade, assets (CSS, JS)
routes/ # Définition des routes Web et API
storage/ # Logs, cache, fichiers uploadés
vendor/ # Dépendances Laravel (non incluses dans la doc technique)


---

## 3. Description des composants clés

### 3.1 Backend Laravel

- **app/Http/Controllers** : contrôleurs exposant les endpoints API et gérant les webhooks  
- **app/Models** : modèles Eloquent pour MySQL et DocumentDB  
- **routes/api.php** : routes API principales (`tickets`, `technicians`, `weather`)  
- **public/hooks.php** : webhook externe sécurisé par Basic Auth  
- **database/migrations** : fichiers de migration pour créer la structure de la base MySQL  
- **database/seeders** : seeders pour remplir les tables initiales  

### 3.2 Microservice Next.js

- **microservices/dispatch-dashboard** : interface pour dispatcher les tickets  
- Communique avec le backend Laravel via les endpoints API sécurisés  
- Frontend statique construit et servi via Next.js  

### 3.3 Autres dossiers importants

- **config/** : configuration de l’application (DB, cache, mail, queue, etc.)  
- **resources/** : templates Blade, fichiers CSS/JS  
- **storage/** : logs Laravel, cache des vues, fichiers temporaires  
- **bootstrap/cache/** : fichiers de configuration compilée pour l’optimisation  

---

## 4. Dépendances

- **Laravel** : géré via `composer.json`  
- **Next.js / Node.js** : géré via `package.json`  
- **Redis** : utilisé pour les sessions et le cache  
- **DocumentDB** : stockage des logs techniques (MongoDB-compatible)  

> Les dépendances tierces ne sont pas incluses dans la documentation technique, seules les parties propres au projet sont documentées.

---

## 5. Remarques importantes

- Les variables sensibles sont stockées dans `.env` et **ne sont pas versionnées**  
- Le webhook doit passer par la route Laravel pour bénéficier des middlewares de sécurité  
- L’API est sécurisée via **token Bearer**  
- Endpoint `/api/health` disponible pour la supervision et le monitoring  
- Le projet est conçu pour être déployé sur un serveur Ubuntu 24.04 avec Nginx, PHP-FPM, Redis et MySQL  

---

## 6. Objectif de la documentation

Cette documentation technique permet à un futur mainteneur de :

1. Comprendre l’architecture générale de l’application  
2. Localiser rapidement les composants clés (controllers, models, routes)  
3. Identifier les fichiers importants pour la maintenance et les mises à jour  
4. Préparer la documentation API et le changelog  
5. Garantir la sécurité et la continuité de service  

---

## 7. Points de repère pour le mainteneur

- **Webhook** : `public/hooks.php` → vérifier Basic Auth, logs, intégrité des payloads  
- **Endpoints API** : `routes/api.php` → token Bearer obligatoire, test avec `/api/health`  
- **Migrations et seeders** : `database/migrations` et `database/seeders`  
- **Logs Laravel** : `storage/logs/laravel.log`  
- **Logs Nginx** : `/var/log/nginx/access.log` et `/var/log/nginx/error.log`  
- **Cache et sessions** : Redis, vérifier configuration dans `config/cache.php` et `config/database.php`  

---

## 8. Conclusion

Ce résumé technique fournit une **vue globale et structurée du projet*