<?php

namespace App\Http\Validations\OrgProfile;

use Validator;

class MasterDivisionValidations
{
    /**
     * Master Division Validation
     */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'division_name'     => 'required|unique:master_divisions,division_name,'.$id,
            'division_name_bn'  => 'required|unique:master_divisions,division_name_bn,'.$id,
            'division_code'     => 'nullable|integer'
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
