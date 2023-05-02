<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserProfile extends Model
{
    protected $table = "user_profiles";
    protected $fillable = [
        'user_id',
        'nid_no',
        'image',
        'father_name_en',
        'father_name_bn',
        'mother_name_en',
        'mother_name_bn',
        'dob',
        'birth_place_en',
        'birth_place_bn',
        'nationality_en',
        'nationality_bn',
        'gender',
        'occupation_en',
        'occupation_bn',
        'pr_area_type_id',
        'pr_division_id',
        'pr_district_id',
        'pr_city_corporation_id',
        'pr_pauroshoba_id',
        'pr_upazila_id',
        'pr_union_id',
        'pr_ward_id',
        'pr_address_details_en',
        'pr_address_details_bn',
        'is_same',
        'pm_area_type_id',
        'pm_division_id',
        'pm_district_id',
        'pm_city_corporation_id',
        'pm_pauroshoba_id',
        'pm_upazila_id',
        'pm_union_id',
        'pm_ward_id',
        'pm_address_details_en',
        'pm_address_details_bn'
    ];
}
