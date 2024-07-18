<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class StudentsResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            "student_id" => $this->student_id,
            // "birth"=>$this->birth,
            "name"=>$this->name,
            "ethnic"=>$this->ethnic,
            "class"=>$this->class,
            // "address"=>$this->address,
            // "phone"=>$this->phone
        ];
    }
}
