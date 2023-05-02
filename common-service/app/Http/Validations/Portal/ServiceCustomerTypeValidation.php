<?php

namespace App\Http\Validations\Portal;

use Validator;

class ServiceCustomerTypeValidation
{
    /**
   * service customer types Validation
   */
 /**
     * service customer types Validation
     */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|unique:portal_service_customer_types,name,'.$id,
            'name_bn'  => 'required'
        ]);

        if ($validator->fails()) {
            return ([
                'success' => false,
                'errors' => $validator->errors()
            ]);
        }

        return ['success'=>true];
    }
}
