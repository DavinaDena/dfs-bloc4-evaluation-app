<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Intervention extends Model
{
    use HasFactory;

    protected $fillable = [
        'ticket_id',
        'scheduled_for',
        'started_at',
        'ended_at',
        'status',
        'summary',
        'external_event_id',
    ];

    protected function casts(): array
    {
        return [
            'scheduled_for' => 'datetime',
            'started_at' => 'datetime',
            'ended_at' => 'datetime',
        ];
    }

    public function ticket()
    {
        return $this->belongsTo(Ticket::class);
    }
}
