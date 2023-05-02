<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Model;

class Detail extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table ="details";

    protected $fillable = [
        'post_id', 'attachment'
    ];
}
