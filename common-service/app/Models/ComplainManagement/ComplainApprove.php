<?php

namespace App\Models\ComplainManagement;

use Illuminate\Database\Eloquent\Model;

class ComplainApprove extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table = 'com_approve';
    protected $guarded = ['complain_id', 'approve_note', 'approve_note_bn'];
}
