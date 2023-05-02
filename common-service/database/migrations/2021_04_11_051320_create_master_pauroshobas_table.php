<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMasterPauroshobasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('master_pauroshobas', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('division_id');
            $table->unsignedBigInteger('district_id');
            $table->unsignedBigInteger('upazila_id');
            $table->string('pauroshoba_name')->index();
            $table->string('pauroshoba_name_bn')->index();
            $table->unsignedInteger('pauroshoba_code')->unique();
            $table->unsignedBigInteger('created_by')->nullable();
            $table->unsignedBigInteger('updated_by')->nullable();
            $table->integer('status')->default(1)->comment('1=active, 2=inactive');
            $table->timestamps();

            $table->foreign('division_id')
                ->references('id')
                ->on('master_divisions')
                ->onDelete('cascade');

            $table->foreign('district_id')
                ->references('id')
                ->on('master_districts')
                ->onDelete('cascade');

            $table->foreign('upazila_id')
                ->references('id')
                ->on('master_upazilas')
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
        Schema::dropIfExists('master_pauroshobas');
    }
}
