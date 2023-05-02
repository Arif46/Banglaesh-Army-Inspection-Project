<?php

namespace App\Models\Menu;

use Illuminate\Database\Eloquent\Model;
use App\Traits\ModelSetup;

class MasterOrgComponent extends Model
{
    // use ModelSetup;

    protected $table ='master_org_components';

    protected $fillable = [
         'org_id','component_id'
    ];
    
    public function component()
    {
        return $this->belongsTo('App\Models\Menu\MasterComponent', 'component_id', 'id');
    }
}
