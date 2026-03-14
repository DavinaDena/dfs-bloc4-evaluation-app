<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\JsonResponse;

class TechnicianController extends Controller
{
    public function index(): JsonResponse
    {
        $technicians = User::query()
            ->where('role', 'technician')
            ->orderBy('name')
            ->get(['id', 'name', 'email', 'phone']);

        return response()->json([
            'data' => $technicians,
        ]);
    }
}
