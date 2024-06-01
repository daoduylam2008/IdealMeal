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
        Schema::create('room_ids', function (Blueprint $table) {
            $table->string("student_id");
            $table->string('room_id');
            $table->foreign("room_id")->references("room_id")->on("teachers");
            $table->foreign("student_id")->references("student_id")->on("students");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Schema::enableForeignKeyConstraints();
        Schema::dropIfExists('room_ids');
    }
};
