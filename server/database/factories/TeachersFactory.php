<?php

namespace Database\Factories;

use App\Models\Teachers;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Teachers>
 */
class TeachersFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */

    protected $model = Teachers::class;

    public function definition(): array
    {
        return [
            "name" => fake()->name(),
            "room_id"=> fake()->unique()->randomElement(["D101","D102","D103","D104","D105","D106","D107","D108","D109","D110","D111","D112","D113","D114","D115","D116","D117","D118","D119","D120","D121","D122","D123","D124","D125"]),
        ];
    }
}
