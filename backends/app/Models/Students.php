<?php

namespace App\Models;

use App\Models\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Students extends Model
{
    use HasFactory;

    protected $fillable = [
        "student_id",
        "name",
        "birth",
        "ethnic",
        "address",
        "phone",
        "room_id"
    ];

    
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class,"student_id","student_id");
    }
   
}
