<?php

namespace App\Models\Portal;

use Illuminate\Database\Eloquent\Model;

class ServiceFee extends Model
{
    protected $table ="portal_service_fees";

    protected $fillable = [
        'service_id',
        'name',
        'name_bn',
        'amount'
    ];
}
