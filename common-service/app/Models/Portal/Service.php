<?php

namespace App\Models\Portal;

use App\Models\Portal\ServiceFee;
use Illuminate\Database\Eloquent\Model;
use App\Models\Portal\ServiceAttachment;
use App\Models\Portal\ServiceCustomerType;
use App\Models\OrgProfile\MasterOrgProfile;

class Service extends Model
{
    protected $table ="portal_services";

    protected $fillable = [
        'service_type_id',
        'component_id',
        'ministry_id',
        'ex_org_id',
        'service_category_id',
        'api_manager',
        'name',
        'name_bn',
        'description',
        'description_bn',
        'image',
        'process',
        'form_attachment',
        'policy_attachment',
        'operating_procedure',
        'days_of_disposal',
        'applied_service',
        'target_customer',
        'service_url',
        'status',
        'is_featured',
        'created_by',
        'updated_by',
        'status'
    ];


    public function attachment()
    {
        return $this->hasMany(ServiceAttachment::class, 'service_id', 'id');
    }

    public function fees()
    {
        return $this->hasMany(ServiceFee::class, 'service_id', 'id');
    }

    public function permission()
    {
        return $this->hasOne(ServicePermission::class, 'service_id');
    }

    public function customerTypes()
    {
        return $this->belongsToMany(ServiceCustomerType::class, 'portal_service_customers',  'service_id', 'customer_type_id')->withTimestamps();
    }

    public function customers()
    {
        return $this->belongsToMany(ServiceCustomerType::class, 'portal_service_customers',  'service_id', 'customer_type_id')->withTimestamps();
    }

    public function orgList()
    {
        return $this->belongsToMany(MasterOrgProfile::class, 'portal_service_org',  'service_id', 'org_id')->withTimestamps();
    }
}
