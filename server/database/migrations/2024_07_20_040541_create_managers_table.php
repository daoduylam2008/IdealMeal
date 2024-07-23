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
        Schema::create('managers', function (Blueprint $table) {
            $table->string("student_id",6);
            $table->string("Mongday",1);
            $table->string("Tuesday",1);
            $table->string("Wednesday",1);
            $table->string("Thursday",1);
            $table->string("Friday",1);
            $table->foreign("student_id")->references("student_id")->on("room_ids")->onDelete("CASCADE")->onUpdate("CASCADE");
            $table->index("student_id");

        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('managers');
    }
};
