<?php

namespace App\Models\UserManagement;

use Illuminate\Database\Eloquent\Model;

class SecretQuestion extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table = 'secret_questions';

    protected $guarded = [
        'id', 'created_at', 'updated_at'
    ];
}
