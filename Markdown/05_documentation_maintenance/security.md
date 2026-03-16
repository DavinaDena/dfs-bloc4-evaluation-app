# Journal de sécurité — OpsTrack Field Service

---

## 1. Présentation

Ce document recense toutes les actions de sécurité appliquées à l’application et à l’environnement de production, ainsi que les vulnérabilités identifiées et les corrections apportées.

Il sert de référence pour le mainteneur afin d’assurer la **continuité sécurisée** du service.

---

## 2. Mesures de sécurité générales

| Mesure | Description |
|--------|-------------|
| `APP_DEBUG=false` | Empêche l’affichage de stacktrace en production |
| `APP_ENV=production` | Active le mode production de Laravel |
| Variables sensibles hors dépôt | `.env` exclu de git pour protéger mots de passe et tokens |
| Permissions fichiers | `storage` et `bootstrap/cache` accessibles uniquement par `www-data` et `ubuntu` |
| Firewall UFW | Ouverture uniquement des ports 22, 80, 443 |
| HTTPS obligatoire | Redirection HTTP → HTTPS via Certbot/Nginx |
| Fichiers `.ht` bloqués | `location ~ /\.ht { deny all; }` dans Nginx |
| Apache2 désactivé | Service arrêté et désactivé pour éviter conflit |

---

## 3. Vulnérabilités identifiées et corrections

| Date | Faille | Description | Correction |
|------|--------|-------------|------------|
| 2026-03-16 | Webhook non sécurisé | `hooks.php` chargeait directement le contrôleur, bypassant les middlewares Laravel | Déplacement dans les routes Laravel : `Route::post('/webhook', [WebhookController::class, 'handle']);` |
| 2026-03-16 | Statut ticket incorrect | Le webhook mettait systématiquement `scheduled` au lieu du statut du payload | Mise à jour : `$ticket->update(['status' => $payload['status']]);` |
| 2026-03-16 | Tokens API non tracés | Aucun suivi de l’utilisation des tokens | Ajout du champ `last_used_at` et vérification `is_active` pour chaque requête |

---

## 4. Recommandations pour le mainteneur

- Surveiller régulièrement les logs Laravel (`storage/logs/laravel.log`) et Nginx (`/var/log/nginx/error.log`) pour détecter des anomalies.
- Vérifier que tous les tokens API sont actifs et non compromis.
- Ajouter tout nouveau webhook ou endpoint via le système de routes Laravel pour bénéficier des protections standards.
- Appliquer immédiatement les mises à jour de sécurité de Laravel, PHP et des dépendances.
- Envisager la mise en place de rate limiting et d’alertes automatiques pour détecter des usages suspects.

---

## 5. Conclusion

Le journal de sécurité constitue un historique clair des vulnérabilités, corrections et bonnes pratiques.  
Il doit être mis à jour à chaque intervention de maintenance ou ajout de fonctionnalité pour assurer un environnement **robuste et sécurisé**.