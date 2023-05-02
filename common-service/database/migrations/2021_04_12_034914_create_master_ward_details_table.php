<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMasterWardDetailsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('master_ward_details', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('master_ward_id');
            $table->string('ward_name')->index();
            $table->string('ward_name_bn')->index();
            $table->timestamps();

            $table->foreign('master_ward_id')
                ->references('id')
                ->on('master_wards')
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
        Schema::dropIfExists('master_ward_details');
    }
}
