<?php

namespace App\Models\OrgProfile;

use Illuminate\Database\Eloquent\Model;

class MasterMunicipality extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

     protected $table = "master_pauroshobas";

     protected $fillable = [
         'pauroshoba_name', 'pauroshoba_name_bn', 'division_id', 'district_id', 'upazila_id', 'pauroshoba_code'
     ];

     protected static function boot()
     {
         parent::boot();
 
         static::creating(function ($model) {
             $model->pauroshoba_code = Self::getPauroshobaCode();
         });
     }
 
     public static function getPauroshobaCode()
     {
         $PauroshobaCode = 1111;
 
         $model = Self::latest()->first(['id', 'pauroshoba_code']);
 
         if ($model) {
             $PauroshobaCode = (int) $model->pauroshoba_code + 1;
         }
 
         return $PauroshobaCode;
     }


}
