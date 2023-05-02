<?php

namespace App\Models\Menu;


use Illuminate\Database\Eloquent\Model;
use App\Models\OrgProfile\MasterOrgProfile;

class MasterComponent extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table ='master_components';

    protected $fillable = [
        'component_name',
        'component_name_bn',
        'description',
        'description_bn',
        'sorting_order',
        'status',
   ];

    public function org_component()
    {
        return $this->hasMany('App\Models\Menu\MasterOrgComponent', 'component_id', 'id');
    }
    public function org()
    {
        return $this->belongsToMany('App\Models\OrgProfile\MasterOrgProfile','master_org_components','component_id','org_id');
    }

}
