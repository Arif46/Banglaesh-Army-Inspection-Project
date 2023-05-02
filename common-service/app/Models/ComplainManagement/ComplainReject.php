<?php

namespace App\Models\ComplainManagement;

use Illuminate\Database\Eloquent\Model;

class ComplainReject extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table = 'com_reject';
    protected $guarded = ['id', 'reject_note', 'complain_id', 'reject_note_bn', 'attachment', 'status'];
}
