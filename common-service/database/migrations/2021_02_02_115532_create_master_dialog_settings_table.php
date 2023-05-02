<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMasterDialogSettingsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('master_dialogue_settings', function (Blueprint $table) {
            $table->id();
            $table->string('dialogue')->index();
            $table->string('dialogue_bn')->index();
            $table->tinyInteger('position')->default(1)->comment('1 = left bottom, 2 = left top');
            $table->tinyInteger('status')->default(1)->comment('1 = active, 2 = inactive');
            $table->unsignedBigInteger('created_by');
            $table->unsignedBigInteger('updated_by');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('master_dialogue_settings');
    }
}
