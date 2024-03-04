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
            'Sinh nhật'=>$this->birth,
            'Tên học sinh' =>$this->name,
            'Dân tộc'=> $this->ethnic,
            "Địa chỉ" => $this->address,
            'Điện thoại'=> $this->phone
        ];
    }
}

?>