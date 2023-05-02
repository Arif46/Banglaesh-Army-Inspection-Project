<?php

namespace App\Models\Committee;

use Illuminate\Database\Eloquent\Model;

class CommitteeExpenses extends Model
{
    /**
     * The attributes that aren't mass assignable.
     *
     * @var array
    */
    protected $table = 'cmt_expenses';

    protected $guarded = ['id', 'created_at', 'updated_at'];
}
