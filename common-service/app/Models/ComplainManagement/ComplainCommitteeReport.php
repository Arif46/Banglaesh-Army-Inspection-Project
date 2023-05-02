<?php

namespace App\Models\ComplainManagement;

use Illuminate\Database\Eloquent\Model;

class ComplainCommitteeReport extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table = 'com_committee_reports';
    protected $guarded = ['report_note', 'complain_id', 'report_note_bn', 'attachment', 'status'];
}
