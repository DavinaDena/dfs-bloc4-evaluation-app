<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Site extends Model
{
    use HasFactory;

    protected $fillable = [
        'customer_id',
        'name',
        'address',
        'postal_code',
        'city',
        'latitude',
        'longitude',
        'timezone',
    ];

    protected function casts(): array
    {
        return [
            'latitude' => 'float',
            'longitude' => 'float',
        ];
    }

    public function customer()
    {
        return $this->belongsTo(Customer::class);
    }

    public function tickets()
    {
        return $this->hasMany(Ticket::class);
    }
}
