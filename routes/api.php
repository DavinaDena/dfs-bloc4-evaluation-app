<?php

use App\Http\Controllers\Api\ExternalContextController;
use App\Http\Controllers\Api\TechnicianController;
use App\Http\Controllers\Api\TicketController;
use Illuminate\Support\Facades\Route;

Route::get('/health', fn () => response()->json([
    'status' => 'ok',
    'service' => config('app.name'),
    'timestamp' => now()->toIso8601String(),
]));

Route::prefix('v1')
    ->middleware('api.token')
    ->group(function (): void {
        Route::apiResource('tickets', TicketController::class)->only([
            'index',
            'store',
            'show',
            'update',
        ]);
        Route::get('technicians', [TechnicianController::class, 'index']);
        Route::get('external/weather', [ExternalContextController::class, 'weather']);
    });
