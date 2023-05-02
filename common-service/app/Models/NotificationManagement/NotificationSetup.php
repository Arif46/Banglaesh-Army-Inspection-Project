<?php

namespace App\Models\NotificationManagement;

use Illuminate\Database\Eloquent\Model;

class NotificationSetup extends Model
{
    protected $table = "notification_settings";
    
    protected $guarded = ['id', 'created_at', 'updated_at'];

    protected $casts = [
        'recipient_id' => 'array',
        'media_id' => 'array',
    ];

    public function setRecipientIdAttribute($value)
    {
        $properties = [];

        foreach ($value as $array_item) {
            if ($array_item) {
                $properties[] = $array_item;
            }
        }

        $this->attributes['recipient_id'] = json_encode($properties);
    }

    public function setMediaIdAttribute($value)
    {
        $properties = [];

        foreach ($value as $array_item) {
            if ($array_item) {
                $properties[] = $array_item;
            }
        }

        $this->attributes['media_id'] = json_encode($properties);
    }
}
