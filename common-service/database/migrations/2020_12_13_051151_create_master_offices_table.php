<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMasterOfficesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('master_offices', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('org_id')->nullable();
            $table->tinyInteger('office_cat_id')->nullable();
            $table->unsignedBigInteger('office_type_id')->nullable();
            $table->integer('area_type_id')->comment('1=City Corpoation,2=Pauroshoba,3=Union');
            $table->integer('city_corporation_id')->nullable();
            $table->integer('pauroshoba_id')->nullable();
            $table->integer('ward_id')->nullable();
            $table->unsignedBigInteger('country_id')->nullable();
            $table->unsignedBigInteger('division_id')->nullable();
            $table->unsignedBigInteger('district_id')->nullable();
            $table->unsignedBigInteger('upazila_id')->nullable();
            $table->unsignedBigInteger('union_id')->nullable();
            $table->string('office_name',100)->index();
            $table->string('office_name_bn',100)->index();
            $table->string('address',100)->nullable();
            $table->string('address_bn',100)->nullable();
            $table->string('office_code',100)->nullable();
            $table->unsignedBigInteger('parent_office_type_id')->nullable();
            $table->unsignedBigInteger('parent_office_id')->nullable();
            $table->integer('is_regional_office')->default(0)->comment('0=not Regional, 1=Regional');
            $table->unsignedBigInteger('regional_office_id')->nullable();
            $table->unsignedBigInteger('created_by')->nullable();
            $table->unsignedBigInteger('updated_by')->nullable();
            $table->integer('status')->default(1)->comment('1=active, 2=inactive');
            $table->timestamps();

            $table->foreign('org_id')
                ->references('id')
                ->on('master_org_profiles')
                ->onDelete('cascade');

            $table->foreign('office_type_id')
                ->references('id')
                ->on('master_office_types')
                ->onDelete('cascade');

            $table->foreign('country_id')
                ->references('id')
                ->on('master_countries')
                ->onDelete('cascade');

            $table->foreign('division_id')
                ->references('id')
                ->on('master_divisions')
                ->onDelete('cascade');

            $table->foreign('district_id')
                ->references('id')
                ->on('master_districts')
                ->onDelete('cascade');

            // $table->foreign('upazila_id')
            //     ->references('id')
            //     ->on('master_upazilas')
            //     ->onDelete('cascade');

            // $table->foreign('union_id')
            //     ->references('id')
            //     ->on('master_unions')
            //     ->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('master_offices');
    }
}
