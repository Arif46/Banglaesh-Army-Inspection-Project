<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCmtMeetingMinutesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('cmt_meeting_minutes', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('org_id');
            $table->unsignedBigInteger('cmt_committee_id');
            $table->unsignedBigInteger('cmt_agenda_id');
            $table->text('decision');
            $table->text('decision_bn');
            $table->string('attendance_attachment');
            $table->string('document_attachment');
            $table->integer('status')->default(1)->comment('1=active, 2=inactive');
            $table->unsignedBigInteger('created_by')->nullable();
            $table->unsignedBigInteger('updated_by')->nullable();
            $table->timestamps();

            $table->foreign('org_id')
                ->references('id')
                ->on('master_org_profiles')
                ->onDelete('cascade');

            $table->foreign('cmt_committee_id')
                ->references('id')
                ->on('cmt_committees')
                ->onDelete('cascade');

            $table->foreign('cmt_agenda_id')
                ->references('id')
                ->on('cmt_agenda')
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
        Schema::dropIfExists('meeting_minutes');
    }
}
