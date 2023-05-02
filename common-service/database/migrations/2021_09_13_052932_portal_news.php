<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class PortalNews extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('portal_news', function (Blueprint $table) {
            $table->id();
            $table->string('title')->index();
            $table->string('title_bn')->index();
            $table->text('description');
            $table->text('description_bn');
            $table->integer('status')->default(1)->comment('1=active, 2=inactive');
            $table->string('logo');
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
        Schema::dropIfExists('portal_news');
        //
    }
}
