<?php

namespace App\Models\Portal;

use Illuminate\Database\Eloquent\Model;

class ServiceAttachment extends Model
{
    protected $table ="portal_service_attachments";

    protected $fillable = [
        'service_id',
        'name',
        'name_bn'
    ];
}
