<?php

namespace App\Models\Organogram;

use Illuminate\Database\Eloquent\Model;

class MasterOfficeType extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

     protected $table = "master_office_types";

     protected $fillable = [
        'office_type_name', 'office_type_name_bn', 'org_id'
     ];

}
