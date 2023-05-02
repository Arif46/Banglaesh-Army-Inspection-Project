<?php

namespace App\Models\Portal;

use Illuminate\Database\Eloquent\Model;

class PortalHeader extends Model
{
    protected $table = "portal_headers";

    protected $fillable = [
        'title', 'title_bn', 'description','description_bn','logo','helpline', 'status'
    ];
}
