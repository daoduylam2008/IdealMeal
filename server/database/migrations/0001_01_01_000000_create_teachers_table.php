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
        Schema::create('teachers', function (Blueprint $table) {
            $table->string('name',40)->nullable();
            $table->string("room_id",4);
            $table->primary("room_id");
            $table->timestamps();
        });
        Schema::create("teachers_cache",function(Blueprint $table){
            $table->string("room_id");
            $table->string("name");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('teachers');
        Schema::dropIfExists('teachers_cache');
    }
};
