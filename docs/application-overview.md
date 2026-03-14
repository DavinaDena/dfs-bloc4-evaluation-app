# OpsTrack Field Service

OpsTrack est une application de gestion d'interventions terrain utilisee comme support d'evaluation RNCP38606 bloc 4.

## Composants

- `Laravel 12` pour l'application coeur metier, l'API REST et le webhook `hooks.php`
- `MySQL` pour les donnees transactionnelles
- `MongoDB` pour les journaux techniques et les evenements
- `Redis` pour le cache et les sessions
- `Next.js` pour le microservice `dispatch-dashboard`
- `Open-Meteo` comme API publique consommee

## Capacites exposees

- tableau de bord web professionnel
- API REST versionnee `/api/v1`
- webhook entrant via `public/hooks.php`
- journalisation vers MongoDB
- enrichissement externe via API publique
- jeu de donnees de demonstration pour qualification
