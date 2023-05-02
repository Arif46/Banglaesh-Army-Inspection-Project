<?php

namespace App\Models\OrgProfile;

use Illuminate\Database\Eloquent\Model;

class MasterCityCorporation extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

     protected $table = "master_city_corporations";

     protected $fillable = [
         'city_corporation_name', 'city_corporation_name_bn', 'division_id', 'district_id', 'city_corporation_code'
     ];

     protected static function boot()
     {
         parent::boot();
 
         static::creating(function ($model) {
             $model->city_corporation_code = Self::getCityCorporationCode();
         });
     }
 
     public static function getCityCorporationCode()
     {
         $corporationCode = 1111;
 
         $model = Self::latest()->first(['id', 'city_corporation_code']);
 
         if ($model) {
             $corporationCode = (int) $model->city_corporation_code + 1;
         }
 
         return $corporationCode;
     }


}
