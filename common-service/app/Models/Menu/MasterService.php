<?php

namespace App\Models\Menu;

use Illuminate\Database\Eloquent\Model;
use App\Models\Menu\MasterMenu;

class MasterService extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table = 'master_services';
    protected $guarded = ['id', 'created_at', 'updated_at'];


    public function master_menus()
    {
        return $this->hasMany(MasterMenu::class,'service_id')->oldest('sorting_order');
    }
}
