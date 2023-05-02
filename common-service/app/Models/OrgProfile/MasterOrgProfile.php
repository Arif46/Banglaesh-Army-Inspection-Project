<?php

namespace App\Models\OrgProfile;

use App\Models\Portal\Service;
use Illuminate\Database\Eloquent\Model;

class MasterOrgProfile extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
    */
    
    protected $table = "master_org_profiles";

    protected $fillable = [
        'org_name', 
        'org_name_bn', 
        'abbreviation', 
        'abbreviation_bn', 
        'establishment_year', 
        'about_org_bn',
        'about_org',
        'mission',
        'mission_bn',
        'vision',
        'vision_bn',
        'logo',
        'hierarchy',
        'website_url',
        'address',
        'address_bn',
        'status'
    ];

    public function service()
    {
        return $this->belongsToMany(Service::class, 'portal_service_org',  'org_id', 'service_id')->withTimestamps();
    }

}
