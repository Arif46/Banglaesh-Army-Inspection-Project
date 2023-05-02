<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCmtAgendaTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('cmt_agenda', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('org_id');
            $table->unsignedBigInteger('cmt_committee_id');
            $table->integer('meeting_number')->index();
            $table->string('memo_number')->index();
            $table->date('memo_issue_date')->index();
            $table->string('agenda_name')->index();
            $table->string('agenda_name_bn')->index();
            $table->date('meeting_date')->index();
            $table->string('attachment')->nullable();
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
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('cmt_agenda');
    }
}
