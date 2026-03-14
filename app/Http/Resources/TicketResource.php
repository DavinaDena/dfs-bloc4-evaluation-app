<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TicketResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'reference' => $this->reference,
            'title' => $this->title,
            'description' => $this->description,
            'priority' => $this->priority,
            'status' => $this->status,
            'sla_due_at' => $this->sla_due_at?->toIso8601String(),
            'closed_at' => $this->closed_at?->toIso8601String(),
            'site' => [
                'id' => $this->site?->id,
                'name' => $this->site?->name,
                'city' => $this->site?->city,
            ],
            'opened_by' => [
                'id' => $this->openedBy?->id,
                'name' => $this->openedBy?->name,
            ],
            'assigned_to' => [
                'id' => $this->assignedTo?->id,
                'name' => $this->assignedTo?->name,
            ],
            'interventions' => $this->interventions->map(fn ($intervention) => [
                'id' => $intervention->id,
                'status' => $intervention->status,
                'scheduled_for' => $intervention->scheduled_for?->toIso8601String(),
                'started_at' => $intervention->started_at?->toIso8601String(),
                'ended_at' => $intervention->ended_at?->toIso8601String(),
            ]),
            'updated_at' => $this->updated_at?->toIso8601String(),
        ];
    }
}
