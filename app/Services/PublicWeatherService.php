<?php

namespace App\Services;

use App\Models\Site;
use Illuminate\Support\Facades\Http;

class PublicWeatherService
{
    public function currentForSite(Site $site): array
    {
        $response = Http::baseUrl(config('services.public_weather.base_url'))
            ->timeout(8)
            ->acceptJson()
            ->get('', [
                'latitude' => $site->latitude,
                'longitude' => $site->longitude,
                'current' => 'temperature_2m,weather_code,wind_speed_10m',
            ])
            ->throw()
            ->json();

        return [
            'provider' => 'open-meteo',
            'site' => $site->name,
            'city' => $site->city,
            'current' => $response['current'] ?? [],
            'fetched_at' => now()->toIso8601String(),
        ];
    }
}
