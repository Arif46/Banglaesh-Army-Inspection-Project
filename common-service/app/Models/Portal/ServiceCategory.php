<?php

namespace App\Models\Portal;

use Illuminate\Database\Eloquent\Model;

class ServiceCategory extends Model
{
    protected $table = "portal_service_categories";

    protected $fillable = [
        'name','name_bn', 'logo','created_by', 'updated_by', 'status'
    ];

    public function service()
    {
        return $this->hasMany(Service::class, 'service_category_id');
    }
}
