<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class PortalNotice extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('portal_notices', function (Blueprint $table) {
            $table->id();
            $table->string('title')->index();
            $table->string('title_bn')->index();
            $table->text('description');
            $table->text('description_bn');
            $table->string('attachment');
            $table->integer('status')->default(1)->comment('1=active, 2=inactive');
            $table->unsignedBigInteger('user_id');
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
        Schema::dropIfExists('portal_notices');
        //
    }
}
