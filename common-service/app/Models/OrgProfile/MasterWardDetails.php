<?php

namespace App\Models\OrgProfile;

use Illuminate\Database\Eloquent\Model;

class MasterWardDetails extends Model
{
    protected $table = "master_ward_details";

    protected $fillable = [
        'master_ward_id', 'ward_name', 'ward_name_bn'
    ];
}
