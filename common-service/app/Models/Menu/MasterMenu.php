<?php

namespace App\Models\Menu;

use Illuminate\Database\Eloquent\Model;

class MasterMenu extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table = 'master_menus';
    protected $guarded = ['id', 'created_at', 'updated_at'];
}
