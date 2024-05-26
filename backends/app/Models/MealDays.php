<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MealDays extends Model
{
    use HasFactory;

    protected $fillable = [
        "student_id",
        "Monday#1",
        "Tuesday#1",
        "Wednesday#1",
        "Thursday#1",
        "Friday#1",
        "Monday#2",
        "Tuesday#2",
        "Wednesday#2",
        "Thursday#2",
        "Friday#2",
        "Monday#3",
        "Tuesday#3",
        "Wednesday#3",
        "Thursday#3",
        "Friday#3",
        "Monday#4",
        "Tuesday#4",
        "Wednesday#4",
        "Thursday#4",
        "Friday#4",
    ];
}
