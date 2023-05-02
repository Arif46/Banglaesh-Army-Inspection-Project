<?php

namespace App\Models\ComplainManagement;

use Illuminate\Database\Eloquent\Model;

class ComplainInfo extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table = 'com_complain_infos';
    protected $guarded = [ 'com_title', 'com_title_bn', 'description', 'description_bn', 'org_id', 'component_id', 'module_id', 'service_id', 'division_id', 'district_id', 'upazilla_id' ,'union_id', 'mobile_no', 'email', 'status'];
}
