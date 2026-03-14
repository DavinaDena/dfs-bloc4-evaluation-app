<?php

use Illuminate\Support\Facades\Artisan;

Artisan::command('ops:seed-demo', function () {
    $this->call('migrate:fresh', ['--seed' => true]);
})->purpose('Rebuild the database with the OpsTrack demo dataset');
