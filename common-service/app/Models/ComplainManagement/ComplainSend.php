<?php

namespace App\Models\ComplainManagement;

use Illuminate\Database\Eloquent\Model;

class ComplainSend extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table = 'com_complain_cycle';
    protected $guarded = ['complain_id', 'sender_id', 'receiver_id', 'note', 'note_bn', 'status'];
}
