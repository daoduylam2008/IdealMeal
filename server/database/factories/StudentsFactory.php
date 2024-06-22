<?php

namespace Database\Factories;

use App\Models\RoomIds;
use App\Models\Students;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Students>
 */
class StudentsFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    protected $model = Students::class;

    public function definition(): array
    {
        $student_id = RoomIds::pluck("student_id")->toArray();
        return [
            "student_id" => fake()->unique()->randomElement($student_id),
            "name"=> fake()->name(),
            "birth"=> fake()->dateTimeThisDecade(),
            "ethnic"=> "Kinh",
            "address"=> fake()->address(),
            "phone"=> fake()->phoneNumber(),
        ];
    }
}
