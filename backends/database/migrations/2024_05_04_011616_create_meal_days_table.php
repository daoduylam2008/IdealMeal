<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('meal_days', function (Blueprint $table) {
            $table->string("student_id");
            $table->string("Monday#1")->nullable();
            $table->string("Tuesday#1")->nullable();
            $table->string("Wednesday#1")->nullable();
            $table->string("Thursday#1")->nullable();
            $table->string("Friday#1")->nullable();
            $table->string("Monday#2")->nullable();
            $table->string("Tuesday#2")->nullable();
            $table->string("Wednesday#2")->nullable();
            $table->string("Thursday#2")->nullable();
            $table->string("Friday#2")->nullable();
            $table->string("Monday#3")->nullable();
            $table->string("Tuesday#3")->nullable();
            $table->string("Wednesday#3")->nullable();
            $table->string("Thursday#3")->nullable();
            $table->string("Friday#3")->nullable();
            $table->string("Monday#4")->nullable();
            $table->string("Tuesday#4")->nullable();
            $table->string("Wednesday#4")->nullable();
            $table->string("Thursday#4")->nullable();
            $table->string("Friday#4")->nullable();
            $table->timestamps();
            $table->foreign("student_id")->references("student_id")->on("users");
            
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('meal_days');
    }
};
