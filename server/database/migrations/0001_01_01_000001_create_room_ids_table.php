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
            $table->string("student_id",6);
            $table->string('room_id',4);
            $table->foreign("room_id")->references("room_id")->on("teachers")->onDelete("CASCADE")->onUpdate("CASCADE");
            $table->primary("student_id");
            $table->index("room_id");
            $table->timestamps();
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
