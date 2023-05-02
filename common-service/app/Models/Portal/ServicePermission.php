<?php

namespace App\Models\Portal;

use Illuminate\Database\Eloquent\Model;

class ServicePermission extends Model
{
    protected $table ="portal_service_permissions";

    protected $fillable = [
        'service_id',
        'pr_apply_btn',
        'pr_attachment_form',
        'pr_service_applied',
        'pr_service_time',
        'pr_target_customer',
        'pr_fees',
        'pr_service_process',
        'pr_rating',
        'pr_policy'
    ];
}
