<?php

namespace Database\Factories;

use App\Models\User;
use App\Models\RoomIds;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Hash;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\User>
 */
class UserFactory extends Factory
{
    // /**
    //  * The current password being used by the factory.
    //  */
    // protected static ?string $password;


    protected $model = User::class;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $student_id = RoomIds::pluck("student_id")->toArray();
        $email  = fake()->bothify('???????-#######') . "@gmail.com";

        return [
            'name' => fake()->userName(),
            'email' => $email,
            'password' => Hash::make("123456789"),
            "student_id" => fake()->unique()->randomElement($student_id),
        ];
    }

    // /**
    //  * Indicate that the model's email address should be unverified.
    //  */
    // public function unverified(): static
    // {
    //     return $this->state(fn (array $attributes) => [
    //         'email_verified_at' => null,
    //     ]);
    // }
}
