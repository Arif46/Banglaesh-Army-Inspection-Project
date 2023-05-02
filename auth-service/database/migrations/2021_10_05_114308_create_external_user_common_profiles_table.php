<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateExternalUserCommonProfilesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('external_user_common_profiles', function (Blueprint $table) {
            $table->unsignedBigInteger('user_id');
            $table->string('name')->nullable();
            $table->string('name_bn')->nullable();
            $table->string('mobile_no')->nullable();
            $table->string('email')->nullable();
            $table->string('father_name')->nullable();
            $table->string('father_name_bn')->nullable();
            $table->string('mother_name')->nullable();
            $table->string('mother_name_bn')->nullable();
            $table->tinyInteger('gender')->nullable();
            $table->integer('region_id')->nullable();
            $table->integer('division_id')->nullable();
            $table->integer('district_id')->nullable();
            $table->integer('upazila_id')->nullable();
            $table->integer('city_corporation_id')->nullable();
            $table->integer('union_id')->nullable();
            $table->integer('ward_id')->nullable();
            $table->string('nid')->nullable();
            $table->string('present_address')->nullable()->comment('keep as json');
            $table->string('permanent_address')->nullable()->comment('keep as json');
            $table->integer('image')->nullable();
            $table->string('last_working_panel')->nullable();
            $table->string('working_panels')->nullable();

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
        Schema::dropIfExists('external_user_common_profiles');
    }
}
