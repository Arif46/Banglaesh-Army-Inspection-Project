<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMasterNotificationSettingsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('master_notification_settings', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('org_id')->nullable();
            $table->unsignedBigInteger('component_id')->nullable();
            $table->unsignedBigInteger('module_id')->nullable();
            $table->unsignedBigInteger('service_id')->nullable();
            $table->unsignedBigInteger('menu_id')->nullable();
            $table->unsignedBigInteger('notification_type_id')->nullable();
            $table->unsignedBigInteger('created_by')->nullable();
            $table->unsignedBigInteger('updated_by')->nullable();
            $table->integer('status')->default(1)->comment('1=active, 2=inactive');
            $table->timestamps();

            $table->foreign('org_id')
                ->references('id')
                ->on('master_org_profiles')
                ->onDelete('cascade');

            $table->foreign('component_id')
                ->references('id')
                ->on('master_components')
                ->onDelete('cascade');

            $table->foreign('module_id')
                ->references('id')
                ->on('master_modules')
                ->onDelete('cascade');

            $table->foreign('service_id')
                ->references('id')
                ->on('master_services')
                ->onDelete('cascade');

            $table->foreign('menu_id')
                ->references('id')
                ->on('master_menus')
                ->onDelete('cascade');

            $table->foreign('notification_type_id')
                ->references('id')
                ->on('master_notification_types')
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
        Schema::dropIfExists('master_notification_settings');
    }
}
