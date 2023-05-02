<?php

namespace App\Models\Organogram;

use Illuminate\Database\Eloquent\Model;

class MasterAssignDesignation extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table = "assign_designations";

    protected $fillable = [
        'org_id', 'office_type_id', 'office_id', 'designation_id', 'approved_post', 'sorting_order'
    ];
}
