<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePortalServicesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('portal_services', function (Blueprint $table) {
            $table->id();
            $table->tinyInteger('service_type_id')->index()->comment('1=IDSDP, 2=API, 3=Link');
            $table->unsignedBigInteger('component_id')->nullable();
            $table->unsignedBigInteger('ministry_id')->nullable();
            $table->unsignedBigInteger('ex_org_id')->nullable();
            $table->unsignedBigInteger('service_category_id');
            $table->string('api_manager')->nullable();
            $table->string('name')->index();
            $table->string('name_bn')->index();
            $table->text('description');
            $table->text('description_bn');
            $table->string('image')->nullable();
            $table->string('process')->nullable();
            $table->string('form_attachment')->nullable();
            $table->string('operating_procedure')->nullable();
            $table->integer('days_of_disposal')->default(0);
            $table->integer('applied_service')->default(0);
            $table->integer('target_customer')->default(0);
            $table->string('service_url')->nullable();
            $table->tinyInteger('status')->default(1)->comment('1=active, 2=inactive');
            $table->tinyInteger('is_featured')->default(1)->comment('1=yes, 0=no');
            $table->unsignedBigInteger('created_by')->nullable();
            $table->unsignedBigInteger('updated_by')->nullable();
            $table->timestamps();
            
            $table->foreign('component_id')
            ->references('id')
            ->on('master_components')
            ->onDelete('cascade');
            
            $table->foreign('service_category_id')
            ->references('id')
            ->on('portal_service_categories')
            ->onDelete('cascade');

            $table->foreign('ministry_id')
            ->references('id')
            ->on('portal_ministry_entries')
            ->onDelete('cascade');

            $table->foreign('ex_org_id')
            ->references('id')
            ->on('portal_ex_organizations')
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
        Schema::dropIfExists('portal_services');
    }
}
