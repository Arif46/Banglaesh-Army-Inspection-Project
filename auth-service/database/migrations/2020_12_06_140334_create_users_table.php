<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('name_bn');
            $table->string('username')->unique()->index("u_index");
            $table->string('email')->unique()->index("email_index");
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->unsignedTinyInteger('user_type')->comment('1=Admin User,2=Public User')->default(1);
            $table->unsignedTinyInteger('org_admin')->comment('1=No,2=Yes')->default(1);
            $table->string('mobile', 50);
            $table->string('last_panel', 100)->nullable();
            $table->string('panels')->nullable();
            $table->bigInteger('nothi_user_id')->nullable();
            $table->bigInteger('nid')->nullable();
            $table->timestamp('last_logged_in')->nullable();
            $table->tinyInteger('status')->default(1)->comment('1=active, 2=inactive');
            $table->rememberToken();
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
        Schema::dropIfExists('users');
    }
}
