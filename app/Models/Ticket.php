<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Ticket extends Model
{
    use HasFactory;

    protected $fillable = [
        'site_id',
        'opened_by_user_id',
        'assigned_to_user_id',
        'reference',
        'title',
        'description',
        'priority',
        'status',
        'sla_due_at',
        'closed_at',
        'last_synced_weather_at',
    ];

    protected function casts(): array
    {
        return [
            'sla_due_at' => 'datetime',
            'closed_at' => 'datetime',
            'last_synced_weather_at' => 'datetime',
        ];
    }

    public function site()
    {
        return $this->belongsTo(Site::class);
    }

    public function openedBy()
    {
        return $this->belongsTo(User::class, 'opened_by_user_id');
    }

    public function assignedTo()
    {
        return $this->belongsTo(User::class, 'assigned_to_user_id');
    }

    public function interventions()
    {
        return $this->hasMany(Intervention::class);
    }
}
