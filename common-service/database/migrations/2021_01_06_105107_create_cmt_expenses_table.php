<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCmtExpensesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('cmt_expenses', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('org_id');
            $table->unsignedBigInteger('cmt_committee_id');
            $table->unsignedBigInteger('cmt_agenda_id');
            $table->integer('fiscal_year')->index();
            $table->date('date')->index();
            $table->double('amount');
            $table->text('description');
            $table->text('description_bn');
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
        Schema::dropIfExists('cmt_expenses');
    }
}
