<?php

namespace App\Models\OrgProfile;

// use App\Traits\ModelSetup;
use Illuminate\Database\Eloquent\Model;

class MasterDivision extends Model
{
    // use ModelSetup;

     /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table = 'master_divisions';

    protected $fillable = [
        'division_name', 'division_name_bn', 'country_id', 'division_code'
    ];

     /**
      * division code auth generation...
      */
    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            $model->division_code = Self::getDivisionCode();
        });
    }

    public static function getDivisionCode()
    {
        $divisionCode = 4444;

        $model = Self::latest()->first(['id', 'division_code']);

        if ($model) {
            $divisionCode = (int) $model->division_code + 1;
        }

        return $divisionCode;
    }
}
