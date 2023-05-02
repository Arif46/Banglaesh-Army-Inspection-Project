<?php

namespace App\Models\ComplainManagement;

use Illuminate\Database\Eloquent\Model;

class ComplainSubmit extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table = 'com_complain_infos';
    protected $guarded = ['id', 'created_at', 'updated_at'];
}
