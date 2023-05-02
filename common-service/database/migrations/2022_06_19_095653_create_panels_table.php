<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePanelsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('external_panels', function (Blueprint $table) {
            $table->id();
            $table->string('name', 100)->index();
            $table->string('name_bn', 100)->index();
            $table->unsignedBigInteger('component_id');
            $table->unsignedInteger('sorting_order');
            $table->string('description')->nullable();
            $table->string('description_bn')->nullable();
            $table->string('icon', 100)->nullable();
            $table->integer('status')->default(1)->comment('1=active, 2=inactive');
            $table->timestamps();

            $table->foreign('component_id')
                ->references('id')
                ->on('master_components');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('external_panels');
    }
}
