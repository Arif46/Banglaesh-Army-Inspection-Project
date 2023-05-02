<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateNotCirculateNoticesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('not_circulate_notices', function (Blueprint $table) {
            $table->id();
            $table->string('notice_title')->index();
            $table->string('notice_title_bn')->index();;
            $table->text('description');
            $table->text('description_bn')->nullable();;
            $table->integer('notice_for');
            $table->unsignedBigInteger('office_id')->nullable();;
            $table->unsignedBigInteger('designation_id')->nullable();;
            $table->date('notice_date')->index();
            $table->time('notice_time')->nullable();;
            $table->unsignedBigInteger('org_id');
            $table->unsignedBigInteger('notification_type_id');
            $table->unsignedBigInteger('created_by')->nullable();
            $table->unsignedBigInteger('updated_by')->nullable();
            $table->integer('status')->default(1)->comment('1=active, 2=inactive');
            $table->timestamps();

            $table->foreign('org_id')
                ->references('id')
                ->on('master_org_profiles')
                ->onDelete('cascade');

            $table->foreign('office_id')
                ->references('id')
                ->on('master_offices')
                ->onDelete('cascade');

            $table->foreign('designation_id')
                ->references('id')
                ->on('master_designations')
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
        Schema::dropIfExists('not_circulate_notices');
    }
}
