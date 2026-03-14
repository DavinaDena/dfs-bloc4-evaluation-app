<?php

namespace App\Http\Controllers;

use App\Models\Ticket;
use App\Models\User;
use Illuminate\Contracts\View\View;

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
            'kpis' => [
                'openTickets' => Ticket::query()->whereNotIn('status', ['resolved', 'closed'])->count(),
                'criticalTickets' => Ticket::query()->where('priority', 'critical')->count(),
                'scheduledToday' => Ticket::query()->whereDate('created_at', today())->count(),
                'technicians' => User::query()->where('role', 'technician')->count(),
            ],
            'tickets' => $tickets,
        ]);
    }
}
