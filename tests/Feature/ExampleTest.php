<?php

namespace Tests\Feature;

use App\Models\ApiToken;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ExampleTest extends TestCase
{
    use RefreshDatabase;

    public function test_the_application_returns_a_successful_response(): void
    {
        $this->seed();

        $response = $this->get('/');

        $response->assertStatus(200);
    }

    public function test_the_health_endpoint_returns_ok(): void
    {
        $response = $this->getJson('/api/health');

        $response->assertOk()->assertJsonPath('status', 'ok');
    }

    public function test_the_ticket_api_requires_a_valid_token(): void
    {
        $this->seed();

        $token = ApiToken::query()->firstOrFail();

        $response = $this->withHeader('Authorization', 'Bearer '.$token->token)
            ->getJson('/api/v1/tickets');

        $response->assertOk()->assertJsonStructure(['data']);
    }
}
