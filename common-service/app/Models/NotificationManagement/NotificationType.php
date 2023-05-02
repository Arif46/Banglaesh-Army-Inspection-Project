<?php

namespace App\Models\NotificationManagement;

use Illuminate\Database\Eloquent\Model;

class NotificationType extends Model
{
    protected $table = "master_notification_types";

    protected $fillable = [
        'not_type_name', 'not_type_name_bn', 'status'
    ];
}
