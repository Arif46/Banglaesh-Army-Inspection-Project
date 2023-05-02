<?php

namespace App\Models\Portal;

use Illuminate\Database\Eloquent\Model;

class OrganizationEntry extends Model
{
    protected $table = "portal_ex_organizations";

    protected $fillable = [
        'ministry_id', 'ex_org_name', 'ex_org_name_bn', 'logo', 'created_by', 'updated_by', 'status'
    ];
}
