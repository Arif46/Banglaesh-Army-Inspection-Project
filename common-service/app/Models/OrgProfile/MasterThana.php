<?php

namespace App\Models\OrgProfile;

use App\Traits\ModelSetup;
use Illuminate\Database\Eloquent\Model;

class MasterThana extends Model
{
    use ModelSetup;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table = 'master_thanas';

    protected $guarded = ['id', 'created_at', 'updated_at'];

    /**
     * upazila code model generation...
     */
    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            $model->thana_code = Self::getThanaCode();
        });
    }

    public static function getThanaCode()
    {
        $code = 4444;

        $model = Self::latest()->first(['id', 'thana_code']);

        if ($model) {
            $code = (int) $model->thana_code + 1;
        }

        return $code;
    }
}
