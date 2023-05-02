<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSupplierItemsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('supplier_items', function (Blueprint $table) {
            $table->id();
            $table->integer('demand_no')->index();
            $table->integer('item_id');
            $table->string('supplier_name');
            $table->integer('total_fully_comply')->nullable();
            $table->integer('total_partially_comply')->nullable();
            $table->integer('total_reject')->nullable();
            $table->integer('result_id')->nullable();
            $table->string('attachement')->nullable();
            $table->date('offer_date')->nullable();
            $table->unsignedBigInteger('created_by')->nullable();
            $table->unsignedBigInteger('updated_by')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('supplier_items');
    }
}
