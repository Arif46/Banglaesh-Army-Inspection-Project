<?php

namespace App\Models\ComplainManagement;

use Illuminate\Database\Eloquent\Model;

class ComplainCommittee extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table = 'com_committees';
    protected $guarded = ['complain_id', 'role_id', 'user_id', 'designation_id', 'status'];
}
