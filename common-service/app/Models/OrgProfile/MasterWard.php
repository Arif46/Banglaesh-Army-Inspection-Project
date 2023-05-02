<?php

namespace App\Models\OrgProfile;

use Illuminate\Database\Eloquent\Model;
use App\Models\OrgProfile\MasterWardDetails;

class MasterWard extends Model
{
    protected $table = "master_wards";

    protected $fillable = [
        'type', 'city_corporation_id', 'division_id', 'district_id', 'upazila_id', 'union_id', 'pauroshoba_id', 'municipality_id'
    ];

    public function ward_details()
    {
        return $this->hasMany(MasterWardDetails::class, 'master_ward_id');
    }
    
    public static function getWardCode()
    {
        $wardCode = 6666;

        $model = Self::latest()->first(['id', 'ward_code']);

        if ($model) {
            $wardCode = (int) $model->ward_code + 1;
        }

        return $wardCode;
    }


    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            $model->ward_code = Self::getWardCode();
        });
    }

}
