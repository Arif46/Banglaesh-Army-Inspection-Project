<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateComComplainInfosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('com_complain_infos', function (Blueprint $table) {
            $table->id();
            $table->string('com_title',100)->index();
            $table->string('com_title_bn',100)->index();
            $table->text('description',100)->nullable();
            $table->text('description_bn',100)->nullable();
            $table->unsignedBigInteger('org_id');
            $table->unsignedBigInteger('component_id');
            $table->unsignedBigInteger('service_id')->nullable();
            $table->unsignedBigInteger('module_id');
            $table->unsignedBigInteger('division_id');
            $table->unsignedBigInteger('district_id');
            $table->unsignedBigInteger('upazila_id');
            $table->unsignedBigInteger('union_id');
            $table->string('mobile_no',100)->nullable()->index();;
            $table->string('email',100)->nullable()->index();;
            $table->unsignedBigInteger('created_by')->nullable();
            $table->unsignedBigInteger('updated_by')->nullable();
            $table->integer('status')->default(0)->comment('1=pending, 2=processing,3=Presented,4=Rejected,5=Solved,6=Appealed');
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

            $table->foreign('union_id')
                ->references('id')
                ->on('master_unions')
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
        Schema::dropIfExists('com_complain_infos');
    }
}
