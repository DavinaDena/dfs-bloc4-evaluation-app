<?php

namespace App\Services;

use App\Models\Mongo\EventLog;
use Illuminate\Support\Facades\Log;
use Throwable;

class EventLogService
{
    public function record(string $channel, string $eventType, array $payload = [], string $severity = 'info'): void
    {
        try {
            EventLog::query()->create([
                'channel' => $channel,
                'event_type' => $eventType,
                'severity' => $severity,
                'payload' => $payload,
                'recorded_at' => now(),
            ]);
        } catch (Throwable $exception) {
            Log::warning('MongoDB logging unavailable.', [
                'channel' => $channel,
                'event_type' => $eventType,
                'error' => $exception->getMessage(),
            ]);
        }
    }
}
