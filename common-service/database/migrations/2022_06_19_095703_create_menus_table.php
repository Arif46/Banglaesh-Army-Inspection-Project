<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMenusTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('external_menus', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('external_panel_id');
            $table->string('name', 100)->index();
            $table->string('name_bn', 100)->index();
            $table->string('url');
            $table->unsignedInteger('sorting_order');
            $table->string('icon', 100)->nullable();
            $table->integer('status')->default(1)->comment('1=active, 2=inactive');
            $table->timestamps();

            $table->foreign('external_panel_id')
                ->references('id')
                ->on('external_panels')
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
        Schema::dropIfExists('external_menus');
    }
}
