<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMasterContentEligibilityTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('master_content_eligibility', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('eligibility_criteria_id');
            $table->unsignedBigInteger('master_content_id');
            $table->timestamps();

            $table->foreign('master_content_id')
                ->references('id')
                ->on('master_contents')
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
        Schema::dropIfExists('master_content_eligibility');
    }
}
