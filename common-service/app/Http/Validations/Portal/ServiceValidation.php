<?php

namespace App\Http\Validations\Portal;

use Validator;

class ServiceValidation
{
    /**
     * Service Category Validation
    */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'service_type_id' => 'required|integer',
            'service_category_id' => 'required|integer',
            'description' => 'required',
            'description_bn' => 'required',
            'name' => 'required',
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
