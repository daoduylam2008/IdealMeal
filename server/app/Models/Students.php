<?php

namespace App\Models;

use App\Models\RoomIds;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Students extends Model
{
    use HasFactory;

    protected $fillable = [
        "student_id",
        "name",
        "ethnic",
        "birth",
        "address",
        "phone",
    ];

    public function roomids(): BelongsTo
    {
        return $this->belongsTo(RoomIds::class);
    }
}
