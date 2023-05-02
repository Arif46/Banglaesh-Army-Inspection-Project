<?php

namespace App\Models\Portal;

use Illuminate\Database\Eloquent\Model;

class PortalNotice extends Model
{
    protected $table = "portal_notices";

    protected $fillable = [
        'title', 'title_bn', 'description','description_bn','attachment','user_id', 'status'
    ];
}
