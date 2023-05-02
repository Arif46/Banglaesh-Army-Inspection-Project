<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMasterModuleTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('master_module', function (Blueprint $table) {
            $table->id();
            $table->string('module_name',100);
            $table->string('module_name_bn',100);
            $table->unsignedBigInteger('component_id');
            $table->unsignedBigInteger('created_by')->nullable();
            $table->unsignedBigInteger('updated_by')->nullable();
            $table->unsignedBigInteger('sorting_order')->default(0);
            $table->integer('status')->default(0)->comment('1=active, 2=inactive');
            $table->timestamps();
            $table->foreign('component_id')->references('id')->on('master_components');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('master_module');
    }
}
