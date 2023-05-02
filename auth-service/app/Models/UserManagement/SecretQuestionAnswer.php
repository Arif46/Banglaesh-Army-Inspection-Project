<?php

namespace App\Models\UserManagement;

use Illuminate\Database\Eloquent\Model;

class SecretQuestionAnswer extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table = 'secret_question_answers';

    protected $guarded = [
        'id', 'created_at', 'updated_at'
    ];
}
