<?php

namespace App\Models\Mongo;

use MongoDB\Laravel\Eloquent\Model;

class EventLog extends Model
{
    protected $connection = 'mongodb';

    protected $collection = 'app_events';

    protected $fillable = [
        'channel',
        'event_type',
        'severity',
        'payload',
        'recorded_at',
    ];

    protected function casts(): array
    {
        return [
            'payload' => 'array',
            'recorded_at' => 'datetime',
        ];
    }
}
