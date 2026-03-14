<?php

namespace App\Http\Controllers;

use App\Models\Ticket;
use App\Models\User;
use Illuminate\Contracts\View\View;
use Illuminate\Support\Facades\Cache;

class DashboardController extends Controller
{
    public function __invoke(): View
    {
        $tickets = Ticket::query()
            ->with(['site.customer', 'assignedTo'])
            ->latest()
            ->limit(8)
            ->get();

        return view('dashboard.index', [
            // Intentional defect for the assessment: this cache is not invalidated
            // when tickets are updated, which makes dashboard KPIs drift.
            'kpis' => Cache::remember('dashboard.kpis', now()->addMinutes(30), function (): array {
                return [
                    'openTickets' => Ticket::query()->whereNotIn('status', ['resolved', 'closed'])->count(),
                    'criticalTickets' => Ticket::query()->where('priority', 'critical')->count(),
                    'scheduledToday' => Ticket::query()->whereDate('created_at', today())->count(),
                    'technicians' => User::query()->where('role', 'technician')->count(),
                ];
            }),
            'tickets' => $tickets,
        ]);
    }
}
