<?php

namespace App\Models\NotificationManagement;

use Illuminate\Database\Eloquent\Model;

class NotificationTemplate extends Model
{
    protected $table = "message_template";

    protected $fillable = [
        'template', 'mobile_text', 'email_web_text', 'status'
    ];
}
