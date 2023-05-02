<?php

namespace App\Models\ComplainManagement;

use Illuminate\Database\Eloquent\Model;

class ComplainType extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table = 'master_complain_types';
    protected $guarded = ['id', 'created_at', 'updated_at'];
}
