<?php

namespace App\Http\Resources\V1;

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
            'id' => $this->id,
            'birth'=>$this->birth,
            'name' =>$this->name,
            'ethnic'=> $this->ethnic,
            "address" => $this->address,
            'phone'=> $this->phone
        ];
    }
}

?>