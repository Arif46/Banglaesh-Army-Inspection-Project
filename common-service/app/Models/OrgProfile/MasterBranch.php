<?php

namespace App\Models\OrgProfile;

use Illuminate\Database\Eloquent\Model;

class MasterBranch extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

    protected $table = "master_branchs";

    protected $guarded = ['id', 'created_at', 'updated_at'];
}
