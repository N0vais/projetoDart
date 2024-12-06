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
        //criando class tabela barbeiros extends down users
        Schema::create('barbeiros', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('barbeiro_id')->unique();
            $table->string('category')->nullable();
            $table->unsignedInteger('clientes')->nullable();
            $table->unsignedInteger('experiencia')->nullable();
            $table->longText('narrativas')->nullable();
            $table->string('status')->nullable();
            //referencia da tabela clientes
            $table->foreign('barbers_id')->references('id')->on('users')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('barbeiros');
    }
};
