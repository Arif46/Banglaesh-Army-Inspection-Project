<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUserLogsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('user_logs', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id');
            $table->string('username');
            $table->string('menu_name');
            $table->string('table_name');
            $table->unsignedBigInteger('data_id');
            $table->string('ip');
            $table->integer('execution_type')->comment('0=insert, 1=update,2=delete');
            $table->timestamps();
            $table->index('username','username_index');
            $table->index('user_id','uid_index');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('user_logs');
    }
}
