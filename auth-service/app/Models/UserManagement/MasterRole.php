<?php

namespace App\Models\UserManagement;

use Illuminate\Database\Eloquent\Model;

class MasterRole extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table = 'roles';

    protected $fillable = [
        'role_name', 'role_name_bn', 'org_id', 'designation_id'
    ];

    public static function activeRole() 
    {
        return MasterRole::Select(['id', 'role_name', 'role_name','role_name_bn','org_id'])->where('status', 1);
    }
}
