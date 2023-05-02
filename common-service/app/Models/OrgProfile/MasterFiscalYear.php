<?php

namespace App\Models\OrgProfile;

use Illuminate\Database\Eloquent\Model;

class MasterFiscalYear extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table = 'master_fiscal_years';
    protected $guarded = ['id', 'created_at', 'updated_at'];
}
