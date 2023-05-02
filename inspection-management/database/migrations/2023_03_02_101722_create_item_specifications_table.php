<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateItemSpecificationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('item_specifications', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('item_id');
            $table->unsignedBigInteger('parent_id')->nullable();
            $table->text('s_description');
            $table->text('s_specified');
            $table->unsignedTinyInteger('has_child')->default(0)->comment('0=No, 1=Yes');
            $table->unsignedTinyInteger('has_blank_row')->default(0);
            $table->string('blank_row_text')->nullable();
            $table->timestamps();

            $table->foreign('item_id')
                ->references('id')
                ->on('items')
                ->onDelete('cascade');
                
            $table->foreign('parent_id')
                ->references('id')
                ->on('item_specifications')
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
        Schema::dropIfExists('item_specifications');
    }
}
