<?php

namespace App\Models\Organogram;

use Illuminate\Database\Eloquent\Model;

class MasterDesignation extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table = 'master_designations';
    
    protected $guarded = ['id', 'created_at', 'updated_at'];
}
