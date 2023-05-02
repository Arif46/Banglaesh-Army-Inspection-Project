<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateComCommitteesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('com_committees', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('complain_id');
            $table->unsignedBigInteger('role_id');
            $table->unsignedBigInteger('user_id');
            $table->unsignedBigInteger('designation_id');
            $table->unsignedBigInteger('created_by')->nullable();
            $table->unsignedBigInteger('updated_by')->nullable();
            $table->integer('status')->default(1)->comment('1=active, 2=inactive');
            $table->timestamps();

            $table->foreign('complain_id')
                ->references('id')
                ->on('com_complain_infos')
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
        Schema::dropIfExists('com_committees');
    }
}
