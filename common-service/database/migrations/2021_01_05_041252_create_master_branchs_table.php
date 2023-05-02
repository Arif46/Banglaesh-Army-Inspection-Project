<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMasterBranchsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('master_branchs', function (Blueprint $table) {
            $table->id();
            $table->string('branch_name',100)->index();
            $table->string('branch_name_bn',100)->index();
            $table->string('address');
            $table->string('address_bn');
            $table->unsignedBigInteger('org_id')->nullable();
            $table->unsignedBigInteger('bank_id')->nullable();
            $table->unsignedBigInteger('created_by')->nullable();
            $table->unsignedBigInteger('updated_by')->nullable();
            $table->integer('status')->default(1)->comment('1=active, 2=inactive');
            $table->timestamps();
            
            $table->foreign('org_id')
            ->references('id')
            ->on('master_org_profiles')
            ->onDelete('cascade');
            
            $table->foreign('bank_id')
                ->references('id')
                ->on('master_banks')
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
        Schema::dropIfExists('master_branchs');
    }
}
