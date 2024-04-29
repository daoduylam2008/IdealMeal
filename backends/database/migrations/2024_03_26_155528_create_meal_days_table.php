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
            $table->integer('student_id');
            $table->string('Monday#1');
            $table->string('Tuesday#1');
            $table->string('Wednesday#1');
            $table->string('Thursday#1');
            $table->string('Friday#1');
            $table->string("Monday#2");
            $table->string("Tuesday#2");
            $table->string("Wednesday#2");
            $table->string("Thursday#2");
            $table->string("Friday#2");
            $table->string("Monday#3");
            $table->string("Tuesday#3");
            $table->string("Wednesday#3");
            $table->string("Thursday#3");
            $table->string("Friday#3");
            $table->string("Monday#4");
            $table->string("Tuesday#4");
            $table->string("Wednesday#4");
            $table->string("Thursday#4");
            $table->string("Friday#4");
            
            
            $table->foreign('student_id')->references('student_id')->on('students')->onDelete('cascade')->onUpdate('cascade');
            
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
