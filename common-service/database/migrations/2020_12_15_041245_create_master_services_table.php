<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMasterServicesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('master_services', function (Blueprint $table) {
            $table->id();
            $table->string('service_name')->index();
            $table->string('service_name_bn')->index();
            $table->unsignedBigInteger('component_id')->nullable();
            $table->unsignedBigInteger('module_id')->nullable();
            $table->integer('sorting_order')->nullable();
            $table->unsignedBigInteger('created_by')->nullable();
            $table->unsignedBigInteger('updated_by')->nullable();
            $table->integer('status')->default(1)->comment('1=active, 2=inactive');
            $table->timestamps();

            $table->foreign('module_id')
                ->references('id')
                ->on('master_modules')
                ->onDelete('cascade');

            $table->foreign('component_id')
                ->references('id')
                ->on('master_components')
                ->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('master_services');
    }
}
