<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateStudentsRequest extends FormRequest
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
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        $method = $this->method();

        if ($method == "PUT"){
            return [
                "name" => ["required"],
                "birth" => ["required"],
                "ethnic"=>["required"],
                "address" => ["required"],
                "phone" => ["required"],
            ];
        }
        else{
            return [
                "name" => ["sometimes","required"],
                "birth" => ["sometimes","required"],
                "ethnic"=>["sometimes","required"],
                "address" => ["sometimes","required"],
                "phone" => ["sometimes","required"],
            ];
        }
        
    }
}
