<?php

namespace App\Http\Validations\OrgProfile;

use Validator;

class MasterUpazilaValidations
{
    /**
     * Master Division Validation
     */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'upazila_name'     => 'required|unique:master_upazilas,upazila_name,'.$id,
            'upazila_name_bn'  => 'required|unique:master_upazilas,upazila_name_bn,'.$id,
            'district_id'     => 'required|integer|exists:master_districts,id'
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
