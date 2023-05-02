<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePortalServicePermissionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('portal_service_permissions', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('service_id');
            $table->tinyInteger('pr_apply_btn')->default(1);
            $table->tinyInteger('pr_attachment_form')->default(1);
            $table->tinyInteger('pr_service_applied')->default(1);
            $table->tinyInteger('pr_service_time')->default(1);
            $table->tinyInteger('pr_target_customer')->default(1);
            $table->tinyInteger('pr_fees')->default(1);
            $table->tinyInteger('pr_service_process')->default(1);
            $table->tinyInteger('pr_rating')->default(1);
            $table->timestamps();

            $table->foreign('service_id')
                ->references('id')
                ->on('portal_services')
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
        Schema::dropIfExists('portal_service_permissions');
    }
}
