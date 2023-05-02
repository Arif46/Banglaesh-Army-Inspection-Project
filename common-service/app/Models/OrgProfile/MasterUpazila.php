<?php

namespace App\Models\OrgProfile;

use App\Traits\ModelSetup;
use Illuminate\Database\Eloquent\Model;

class MasterUpazila extends Model
{
    use ModelSetup;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table = 'master_upazilas';

    protected $guarded = ['id', 'created_at', 'updated_at'];

    /**
     * upazila code model generation...
     */
    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            $model->upazila_code = Self::getUpazilaCode();
        });
    }

    public static function getUpazilaCode()
    {
        $code = 4444;

        $model = Self::latest()->first(['id', 'upazila_code']);

        if ($model) {
            $code = (int) $model->division_code + 1;
        }

        return $code;
    }
}
