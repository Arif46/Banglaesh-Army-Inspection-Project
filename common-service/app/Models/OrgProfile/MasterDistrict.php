<?php

namespace App\Models\OrgProfile;

use Illuminate\Database\Eloquent\Model;

class MasterDistrict extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

     protected $table = "master_districts";

     protected $fillable = [
         'district_name', 'district_name_bn', 'division_id', 'district_code'
     ];

     protected static function boot()
     {
         parent::boot();
 
         static::creating(function ($model) {
             $model->district_code = Self::getDistrictCode();
         });
     }
 
     public static function getDistrictCode()
     {
         $districtCode = 1111;
 
         $model = Self::latest()->first(['id', 'district_code']);
 
         if ($model) {
             $districtCode = (int) $model->district_code + 1;
         }
 
         return $districtCode;
     }


}
