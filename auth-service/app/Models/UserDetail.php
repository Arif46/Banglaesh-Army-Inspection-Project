<?php

namespace App\Models;
use App\Models\User;

use Illuminate\Database\Eloquent\Model;

class UserDetail extends Model
{
    protected $table = "user_details";

    protected $guarded = ['id', 'created_at', 'updated_at'];

    protected $casts = [
		'sso' => 'array'
	];
}
