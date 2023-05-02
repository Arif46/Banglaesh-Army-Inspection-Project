<?php

namespace App\Models\Organogram;

use Illuminate\Database\Eloquent\Model;

class MasterOffice extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

     protected $table = "master_offices";

     protected $fillable = [
        'org_id',
        'office_cat_id',
        'office_type_id',
        'area_type_id',
        'city_corporation_id',
        'pauroshoba_id',
        'ward_id',
        'country_id',
        'division_id',
        'district_id',
        'upazila_id',
        'union_id',
        'office_name',
        'office_name_bn',
        'address',
        'address_bn',
        'office_code',
        'parent_office_type_id',
        'parent_office_id',
        'is_regional_office',
        'regional_office_id',
         'created_by',
         'updated_by'
     ];

     public function assign_designations()
    {
        return $this->hasMany('App\Models\Organogram\AssignDesignation', 'office_id', 'id')->select(
            'org_id',
            'office_id',
            'designation_id'
        );
    }
    public function childrenOffice()
    {
        return $this->hasMany(MasterOffice::class, 'parent_office_id', 'id')->select(
            'id',
            'office_name',
            'office_name_bn',
            'org_id',
            'parent_office_id',
            'parent_office_type_id'
        );
    }
    public function allChildrenOffice()
    {
        return $this->childrenOffice()->with('allChildrenOffice');
    }

}
