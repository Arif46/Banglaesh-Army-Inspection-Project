<?php

namespace App\Models\OrgProfile;

use Illuminate\Database\Eloquent\Model;

class MasterCountry extends Model
{
     /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table = 'master_countries';
    protected $guarded = ['id', 'created_at', 'updated_at'];

     /**
      * country code auth generation...
      */
    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            $model->country_code = Self::getCountryCode();
        });
    }

    public static function getCountryCode()
    {
        $countryCode = 999;

        $model = Self::latest()->first(['id', 'country_code']);

        if ($model) {
            $countryCode = (int) $model->country_code + 1;
        }

        return $countryCode;
    }
}
