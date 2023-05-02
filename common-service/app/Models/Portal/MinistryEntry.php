<?php

namespace App\Models\Portal;

use Illuminate\Database\Eloquent\Model;

class MinistryEntry extends Model
{
    protected $table = "portal_ministry_entries";

    protected $fillable = [
        'ministry_name', 'ministry_name_bn', 'logo', 'created_by', 'updated_by', 'status'
    ];
}
