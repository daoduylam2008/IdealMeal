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
            $table->string("student_id",6)->unique();
            $table->string("dex");
            $table->foreign("student_id")->references("student_id")->on("room_ids")->onDelete("CASCADE")->onUpdate("CASCADE");
            
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
