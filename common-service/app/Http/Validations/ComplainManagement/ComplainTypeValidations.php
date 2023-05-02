<?php
namespace App\Http\Validations\ComplainManagement;

use Illuminate\Support\Facades\Validator;

class ComplainTypeValidations
{
    /**
     * Complain Type Validations;
    */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'com_type_name'     => 'required|unique:master_complain_types,com_type_name,'.$id,
            'com_type_name_bn'  => 'required|unique:master_complain_types,com_type_name_bn,'.$id
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

