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
            $table->string("student_id");
            $table->string("name")->nullable();
            $table->date("birth")->nullable();
            $table->string("ethnic")->nullable();
            $table->string("address")->nullable();
            $table->string("phone")->nullable();
            // $table->timestamps();
            // $table->primary("student_id");
            $table->foreign("student_id")->references('student_id')->on("users");

           
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
