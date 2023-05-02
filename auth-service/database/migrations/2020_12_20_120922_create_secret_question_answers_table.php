<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSecretQuestionAnswersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('secret_question_answers', function (Blueprint $table) {
            $table->id();
            $table->text('answer');
            $table->unsignedBigInteger('user_id');
            $table->unsignedBigInteger('secret_question_id');
            $table->integer('status')->default(1)->comment('1=active, 2=inactive');
            $table->timestamps();
            $table->foreign('user_id')->references('id')->on('users');
            $table->foreign('secret_question_id')->references('id')->on('secret_questions');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('secret_question_answers');
    }
}
