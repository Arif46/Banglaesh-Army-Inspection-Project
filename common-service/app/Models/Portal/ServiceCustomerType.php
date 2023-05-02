<?php

namespace App\Models\Portal;

use Illuminate\Database\Eloquent\Model;

class ServiceCustomerType extends Model
{
    protected $table = "portal_service_customer_types";

    protected $fillable = [
        'name', 'name_bn', 'image', 'created_by', 'updated_by', 'status'
    ];

    public function service()
    {
        return $this->belongsToMany(Service::class, 'portal_service_customers',  'customer_type_id', 'service_id')->withTimestamps();
    }
}
