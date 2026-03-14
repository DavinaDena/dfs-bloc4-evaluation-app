<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class StoreTicketRequest extends FormRequest
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
            'site_id' => ['required', 'integer', 'exists:sites,id'],
            'opened_by_user_id' => ['required', 'integer', 'exists:users,id'],
            'assigned_to_user_id' => ['nullable', 'integer', 'exists:users,id'],
            'title' => ['required', 'string', 'max:120'],
            'description' => ['required', 'string'],
            'priority' => ['required', 'in:low,medium,high,critical'],
            'status' => ['nullable', 'in:new,scheduled,in_progress,resolved,closed'],
            'sla_due_at' => ['nullable', 'date'],
        ];
    }
}
