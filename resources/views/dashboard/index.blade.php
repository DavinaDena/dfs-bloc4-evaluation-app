<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{{ config('app.name') }} - Dispatch Desk</title>
    <style>
        :root {
            --bg: #f4efe8;
            --ink: #1f2933;
            --muted: #64748b;
            --panel: #fffdf8;
            --accent: #0f766e;
            --accent-soft: #d7f3ef;
            --critical: #b91c1c;
            --border: #d8d0c5;
        }
        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: Georgia, "Times New Roman", serif;
            color: var(--ink);
            background:
                radial-gradient(circle at top left, #efe4d5 0, transparent 28%),
                linear-gradient(180deg, #f7f1e9 0%, var(--bg) 100%);
        }
        header, main { max-width: 1120px; margin: 0 auto; padding: 24px; }
        header { padding-top: 40px; }
        .eyebrow {
            letter-spacing: .12em;
            text-transform: uppercase;
            color: var(--muted);
            font-size: 12px;
            margin-bottom: 10px;
        }
        h1 { margin: 0 0 8px; font-size: 44px; }
        p.lead { max-width: 760px; color: var(--muted); line-height: 1.6; margin: 0; }
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 16px;
            margin: 28px 0 36px;
        }
        .card, .table-card {
            background: var(--panel);
            border: 1px solid var(--border);
            border-radius: 18px;
            box-shadow: 0 12px 30px rgba(31, 41, 51, 0.05);
        }
        .card { padding: 20px; }
        .card small { display: block; color: var(--muted); text-transform: uppercase; letter-spacing: .08em; margin-bottom: 10px; }
        .card strong { font-size: 36px; }
        .table-card { overflow: hidden; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 16px 18px; text-align: left; border-bottom: 1px solid var(--border); }
        th { font-size: 13px; text-transform: uppercase; letter-spacing: .08em; color: var(--muted); background: #fcfaf6; }
        tr:last-child td { border-bottom: none; }
        .pill {
            display: inline-block;
            border-radius: 999px;
            padding: 6px 10px;
            font-size: 12px;
            background: var(--accent-soft);
            color: var(--accent);
        }
        .pill.critical {
            background: #fee2e2;
            color: var(--critical);
        }
    </style>
</head>
<body>
    <header>
        <div class="eyebrow">OpsTrack field service</div>
        <h1>Centre de supervision des interventions</h1>
        <p class="lead">
            Ce tableau de bord centralise l’activite des tickets, les techniciens planifies et les incidents prioritaires pour les equipes support et exploitation.
        </p>
    </header>
    <main>
        <section class="grid">
            <article class="card">
                <small>Tickets ouverts</small>
                <strong>{{ $kpis['openTickets'] }}</strong>
            </article>
            <article class="card">
                <small>Critiques</small>
                <strong>{{ $kpis['criticalTickets'] }}</strong>
            </article>
            <article class="card">
                <small>Crees aujourd’hui</small>
                <strong>{{ $kpis['scheduledToday'] }}</strong>
            </article>
            <article class="card">
                <small>Techniciens</small>
                <strong>{{ $kpis['technicians'] }}</strong>
            </article>
        </section>

        <section class="table-card">
            <table>
                <thead>
                    <tr>
                        <th>Reference</th>
                        <th>Ticket</th>
                        <th>Site</th>
                        <th>Technicien</th>
                        <th>Priorite</th>
                        <th>Statut</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($tickets as $ticket)
                        <tr>
                            <td>{{ $ticket->reference }}</td>
                            <td>
                                <strong>{{ $ticket->title }}</strong><br>
                                <span style="color: var(--muted);">{{ $ticket->site->customer->name }}</span>
                            </td>
                            <td>{{ $ticket->site->name }}<br><span style="color: var(--muted);">{{ $ticket->site->city }}</span></td>
                            <td>{{ $ticket->assignedTo?->name ?? 'Non affecte' }}</td>
                            <td>
                                <span class="pill {{ $ticket->priority === 'critical' ? 'critical' : '' }}">{{ $ticket->priority }}</span>
                            </td>
                            <td>{{ $ticket->status }}</td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </section>
    </main>
</body>
</html>
