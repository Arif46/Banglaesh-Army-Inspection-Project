<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUserProfilesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('user_profiles', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id');
            $table->string('nid_no', 100)>index()->nullable();
            $table->string('father_name_en', 100)->index()->nullable();
            $table->string('father_name_bn', 100)->index()->nullable();
            $table->string('mother_name_en', 100)->index()->nullable();
            $table->string('mother_name_bn', 100)->index()->nullable();
            $table->date('dob')->nullable();
            $table->string('birth_place_en', 100)->nullable();
            $table->string('birth_place_bn', 100)->nullable();
            $table->string('nationality_en', 50)->nullable();
            $table->string('nationality_bn', 50)->nullable();
            $table->unsignedTinyInteger('gender')->default(1)->comment('1=Male, 2=Female, 3=Others');
            $table->string('occupation_en', 50)->nullable();
            $table->string('occupation_bn', 50)->nullable();
            $table->unsignedTinyInteger('pr_area_type_id')->default(3)->comment('1=City Corpoation,2=Pauroshoba,3=Union');
            $table->unsignedInteger('pr_division_id')->index()->nullable();
            $table->unsignedInteger('pr_district_id')->index()->nullable();
            $table->unsignedInteger('pr_city_corporation_id')->index()->nullable();
            $table->unsignedInteger('pr_pauroshoba_id')->index()->nullable();
            $table->unsignedInteger('pr_upazila_id')->index()->nullable();
            $table->unsignedInteger('pr_union_id')->nullable();
            $table->unsignedInteger('pr_ward_id')->nullable();
            $table->string('pr_address_details_en')->nullable();
            $table->string('pr_address_details_bn')->nullable();
            $table->unsignedTinyInteger('pm_area_type_id')->default(3)->comment('1=City Corpoation,2=Pauroshoba,3=Union');
            $table->unsignedInteger('pm_division_id')->nullable();
            $table->unsignedInteger('pm_district_id')->nullable();
            $table->unsignedInteger('pm_city_corporation_id')->nullable();
            $table->unsignedInteger('pm_pauroshoba_id')->nullable();
            $table->unsignedInteger('pm_upazila_id')->nullable();
            $table->unsignedInteger('pm_union_id')->nullable();
            $table->unsignedInteger('pm_ward_id')->nullable();
            $table->string('pm_address_details_en')->nullable();
            $table->string('pm_address_details_bn')->nullable();
            $table->timestamps();

            $table->foreign('user_id')->references('id')->on('users');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('user_profiles');
    }
}
