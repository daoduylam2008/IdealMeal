<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class MealDayResources extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $arrayDex = explode(" ", $this->dex);
        foreach ($arrayDex as $some){
            $dex = explode(":", $some);
            $keys[] = $dex[0];
            $vals[] = $dex[1];
        }
        $result = array_combine($keys, $vals);

        return [
            "student_id" => $this->student_id,
            "dex" => $result,
        ];
    }
}
