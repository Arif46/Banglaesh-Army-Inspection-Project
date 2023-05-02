<?php

namespace App\Models\OrgProfile;

use Illuminate\Database\Eloquent\Model;

class MasterBank extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

     protected $table = "master_banks";

     protected $fillable = [
         'bank_name', 'bank_name_bn', 'org_id', 'component_id'
     ];


}
