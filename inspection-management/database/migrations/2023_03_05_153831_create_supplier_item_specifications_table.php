<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSupplierItemSpecificationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('supplier_item_specifications', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('supplier_item_id');
            $table->unsignedBigInteger('parent_id')->nullable();
            $table->unsignedBigInteger('specification_id');
            $table->text('received_specification')->nullable();
            $table->tinyInteger('verify_status')->default(0);
            $table->text('reason')->nullable();
            $table->timestamps();

        $table->foreign('supplier_item_id')
            ->references('id')
            ->on('supplier_items')
            ->onDelete('cascade');
            
        $table->foreign('parent_id')
            ->references('id')
            ->on('supplier_item_specifications')
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
        Schema::dropIfExists('supplier_item_specifications');
    }
}
