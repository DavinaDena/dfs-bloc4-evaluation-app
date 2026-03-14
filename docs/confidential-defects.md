# Defauts volontaires confidentiels

Ce document ne doit pas etre diffuse aux candidats. Il sert au parametrage de l'evaluation.

## Bugs fonctionnels volontaires

- `TicketController@index` contient une requete de recherche mal groupee avec `orWhereRaw`, ce qui produit des resultats incoherents sur certaines combinaisons de filtres.
- `DashboardController` met les KPI en cache pendant 30 minutes sans invalidation lors des mises a jour de tickets. Le tableau de bord peut donc afficher des compteurs obsoletes.
- `WebhookController` cree une intervention pour chaque appel sans deduplication sur `external_event_id`.
- `WebhookController` accuse reception du statut externe mais force ensuite le ticket sur `scheduled`, ce qui cree un ecart entre le webhook et l'etat reel en base.
- Le microservice Next.js lit `payload.items` au lieu de `payload.data`, ce qui provoque un tableau de bord vide malgre une API Laravel fonctionnelle.

## Defauts de securite volontaires

- `TicketController@index` utilise `orWhereRaw` avec interpolation directe du terme de recherche, introduisant une faiblesse de type injection SQL.
- L'API par token est minimale et ne verifie pas finement les permissions par ressource.
- `hooks.php` verifie seulement l'authentification HTTP BASIC, sans signature complementaire ni restriction stricte sur l'origine.
- Le fichier `.env.example` contient les identifiants de demonstration utilises en environnement de qualification.

## Defauts d'exploitation possibles a preparer

- variable `MONGODB_*` absente en production
- token API invalide cote microservice Next.js
- tache cron du webhook active mais sans supervision
