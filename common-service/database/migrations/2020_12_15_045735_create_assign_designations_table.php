<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAssignDesignationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('assign_designations', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('org_id');
            $table->unsignedBigInteger('office_type_id');
            $table->unsignedBigInteger('office_id');
            $table->unsignedBigInteger('designation_id');
            $table->Integer('approved_post')->nullable();
            $table->Integer('sorting_order')->nullable();
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

            $table->foreign('office_id')
                ->references('id')
                ->on('master_offices')
                ->onDelete('cascade');

            $table->foreign('designation_id')
                ->references('id')
                ->on('master_designations')
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
        Schema::dropIfExists('assign_designations');
    }
}
