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
        Schema::create('students', function (Blueprint $table) {
            $table->string("student_id",6)->unique();
            $table->string("name",40)->nullable();
            $table->date("birth",8)->nullable();
            $table->string("ethnic",6)->nullable();
            $table->string("address")->nullable();
            $table->string("phone",20)->nullable();
            // $table->timestamps();
            // $table->primary("student_id");
            $table->foreign("student_id")->references('student_id')->on("room_ids")->onDelete("CASCADE")->onUpdate("CASCADE");
            $table->index("student_id");
            $table->timestamps();
           
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('students');
    }
};
