<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateNotificationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('notifications', function (Blueprint $table) {
            $table->id();
            $table->text('message_id');
            $table->unsignedBigInteger('recipient_id')->default(0)->index();
            $table->unsignedBigInteger('sender_id')->default(0)->index();
            $table->text('url')->nullable();
            $table->tinyInteger('read_status')->default(1)->comment('1 = unread, 2 = read');
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
        Schema::dropIfExists('notifications');
    }
}
