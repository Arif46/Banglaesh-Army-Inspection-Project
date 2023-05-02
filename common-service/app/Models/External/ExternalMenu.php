<?php

namespace App\Models\External;

use Illuminate\Database\Eloquent\Model;

class ExternalMenu extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
    */
    protected $table = 'external_menus';
    protected $guarded = ['id', 'created_at', 'updated_at'];
}
