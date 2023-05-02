<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMasterUnionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('master_unions', function (Blueprint $table) {
            $table->id();
            $table->string('union_name',100)->index();
            $table->string('union_name_bn',100)->index();
            $table->unsignedBigInteger('division_id');
            $table->unsignedBigInteger('district_id');
            $table->unsignedBigInteger('upazila_id');
            $table->unsignedInteger('union_code')->unique();
            $table->unsignedBigInteger('created_by')->nullable();
            $table->unsignedBigInteger('updated_by')->nullable();
            $table->integer('status')->default(1)->comment('1=active, 2=inactive');
            $table->timestamps();

            $table->foreign('division_id')
                ->references('id')
                ->on('master_divisions')
                ->onDelete('cascade');
            $table->foreign('district_id')
                ->references('id')
                ->on('master_districts')
                ->onDelete('cascade');
            $table->foreign('upazila_id')
                ->references('id')
                ->on('master_upazilas')
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
        Schema::dropIfExists('master_unions');
    }
}
