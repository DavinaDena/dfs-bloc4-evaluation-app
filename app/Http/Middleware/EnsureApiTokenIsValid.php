<?php

namespace App\Http\Middleware;

use App\Models\ApiToken;
use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class EnsureApiTokenIsValid
{
    /**
     * Handle an incoming request.
     *
     * @param  Closure(Request): (Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        $tokenValue = $request->bearerToken() ?: $request->header('X-Api-Token');

        if (! $tokenValue) {
            return response()->json(['message' => 'Missing API token.'], Response::HTTP_UNAUTHORIZED);
        }

        $token = ApiToken::query()
            ->where('token', $tokenValue)
            ->where('is_active', true)
            ->first();

        if (! $token) {
            return response()->json(['message' => 'Invalid API token.'], Response::HTTP_UNAUTHORIZED);
        }

        $token->forceFill(['last_used_at' => now()])->save();

        return $next($request);
    }
}
