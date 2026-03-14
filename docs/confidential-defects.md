# Defauts volontaires confidentiels

Ce document ne doit pas etre diffuse aux candidats. Il sert au parametrage de l'evaluation.

## Bugs fonctionnels volontaires

- `TicketController@index` contient une requete de recherche mal groupee avec `orWhereRaw`, ce qui produit des resultats incoherents sur certaines combinaisons de filtres.
- La cloture d'un ticket ne purge pas explicitement le cache du tableau de bord, ce qui permet de construire un scenario de KPI stale si un mecanisme de cache est active.
- `WebhookController` cree une intervention pour chaque appel sans deduplication sur `external_event_id`.

## Defauts de securite volontaires

- `TicketController@index` utilise `orWhereRaw` avec interpolation directe du terme de recherche, introduisant une faiblesse de type injection SQL.
- L'API par token est minimale et ne verifie pas finement les permissions par ressource.
- `hooks.php` verifie seulement l'authentification HTTP BASIC, sans signature complementaire ni restriction stricte sur l'origine.
- Le fichier `.env.example` contient les identifiants de demonstration utilises en environnement de qualification.

## Defauts d'exploitation possibles a preparer

- variable `MONGODB_*` absente en production
- token API invalide cote microservice Next.js
- tache cron du webhook active mais sans supervision
