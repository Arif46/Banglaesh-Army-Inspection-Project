<?php

namespace App\Models\Portal;

use Illuminate\Database\Eloquent\Model;

class AboutServicePortal extends Model
{
    protected $table ="portal_abouts";

    protected $fillable = [
        'description_bn', 'description'
    ];
}
