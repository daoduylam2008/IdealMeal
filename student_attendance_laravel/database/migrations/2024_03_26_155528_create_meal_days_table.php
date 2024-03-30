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
            $table->string('Monday');
            $table->string('Tuesday');
            $table->string('Wednesday');
            $table->string('Thursday');
            $table->string('Friday');
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
