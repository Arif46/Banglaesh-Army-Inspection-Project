<?php

namespace App\Models\OrgProfile;

use Illuminate\Database\Eloquent\Model;

class MasterUnion extends Model
{
    protected $table = "master_unions";

    protected $fillable = [
        'union_name', 'union_name_bn', 'division_id', 'district_id','upazila_id', 'union_code'   
    ];

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            $model->union_code = Self::getUnionCode();
        });
    }

    public static function getUnionCode()
    {
        $unionCode = 3333;

        $model = Self::latest()->first(['id', 'union_code']);

        if ($model) {
            $unionCode = (int) $model->union_code + 1;
        }

        return $unionCode;
    }
}
