<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMasterOrgProfilessTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('master_org_profiles', function (Blueprint $table) {
            $table->id();
            $table->string('org_name', 100)->index();
            $table->string('org_name_bn', 100)->index();
            $table->string('abbreviation', 20)->nullable();
            $table->string('abbreviation_bn', 100)->nullable();
            $table->integer('establishment_year')->nullable();
            $table->text('about_org')->nullable();
            $table->text('about_org_bn')->nullable();
            $table->text('mission')->nullable();
            $table->text('mission_bn')->nullable();
            $table->text('vision')->nullable();
            $table->text('vision_bn')->nullable();
            $table->string('logo')->nullable();
            $table->integer('hierarchy')->nullable();
            $table->string('website_url')->nullable();
            $table->string('address')->nullable();
            $table->string('address_bn')->nullable();
            $table->unsignedBigInteger('created_by')->nullable();
            $table->unsignedBigInteger('updated_by')->nullable();
            $table->integer('status')->default(1)->comment('1=active, 2=inactive');
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
        Schema::dropIfExists('master_org_profiles');
    }
}
