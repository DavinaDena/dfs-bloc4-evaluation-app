<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class UpdateTicketRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'assigned_to_user_id' => ['nullable', 'integer', 'exists:users,id'],
            'title' => ['sometimes', 'string', 'max:120'],
            'description' => ['sometimes', 'string'],
            'priority' => ['sometimes', 'in:low,medium,high,critical'],
            'status' => ['sometimes', 'in:new,scheduled,in_progress,resolved,closed'],
            'sla_due_at' => ['nullable', 'date'],
            'closed_at' => ['nullable', 'date'],
        ];
    }
}
