<?php

namespace App\Models;

use App\Models\User;
use Illuminate\Database\Eloquent\Model;

use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class RoomIds extends Model
{
    use HasFactory;

    protected $fillable = [
        "room_id",
        "student_id",
    ];

    
}
