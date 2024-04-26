<?php

namespace App\Http\Resources\V1;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class MealDayResource extends JsonResource
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
            "Monday" => $this->Monday,
            "Tuesday" => $this->Tuesday,
            "Wednesday" => $this->Wednesday,
            "Thursday" => $this->Thursday,
            "Friday" => $this->Friday
        ];
    }
}
