<?php
namespace App\Http\Validations\InformationServiceManagement;

use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class ServiceEligibilityTypeValidation
{
    /**
     * Service Eligibility Type Validations;
    */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'type_name'          =>'required|unique:service_eligibility_types,type_name,'.$id,
            'type_name_bn'       =>'required|unique:service_eligibility_types,type_name_bn,'.$id,
        ]);

        if ($validator->fails()) {
            return ([
                'success' => false,
                'errors' => $validator->errors()
            ]);
        }
        return ['success'=> 'true'];
    }
}

