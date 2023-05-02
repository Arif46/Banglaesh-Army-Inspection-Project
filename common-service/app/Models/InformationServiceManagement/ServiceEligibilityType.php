<?php

namespace App\Models\InformationServiceManagement;

use Illuminate\Database\Eloquent\Model;

class ServiceEligibilityType extends Model
{
    protected $table ="service_eligibility_types";

    protected $fillable = [
    	'type_name',	
		'type_name_bn',	
		'status',	
		'created_by',	
		'updated_by',	
		'created_at',	
		'updated_at'
    ];
}
