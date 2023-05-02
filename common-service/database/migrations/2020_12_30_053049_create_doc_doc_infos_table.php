<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDocDocInfosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('doc_doc_infos', function (Blueprint $table) {
            $table->id();
            $table->string('doc_title',100)->index();
            $table->string('doc_title_bn',100)->index();
            $table->string('attachment');
            $table->unsignedBigInteger('org_id');
            $table->unsignedBigInteger('category_id');
            $table->unsignedBigInteger('created_by')->nullable();
            $table->unsignedBigInteger('updated_by')->nullable();
            $table->integer('status')->default(1)->comment('1=active, 2=inactive, 3=archive');
            $table->timestamps();

            $table->foreign('org_id')
                ->references('id')
                ->on('master_org_profiles')
                ->onDelete('cascade');

            $table->foreign('category_id')
                ->references('id')
                ->on('master_document_categories')
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
        Schema::dropIfExists('doc_doc_infos');
    }
}
