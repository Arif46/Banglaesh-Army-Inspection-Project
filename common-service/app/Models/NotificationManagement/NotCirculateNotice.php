<?php

namespace App\Models\NotificationManagement;

use Illuminate\Database\Eloquent\Model;

class NotCirculateNotice extends Model
{
    protected $table = "not_circulate_notices";

    protected $fillable = [
        'notice_title',    
		'notice_title_bn', 
		'description', 
		'description_bn',  
		'notice_for',  
		'office_id',   
		'designation_id',  
		'notice_date', 
		'notice_time', 
		'org_id',  
		'notification_type_id',
		'status'
    ];
}
