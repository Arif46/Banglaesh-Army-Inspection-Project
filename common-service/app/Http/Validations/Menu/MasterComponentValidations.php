<?php
namespace App\Http\Validations\Menu;

use Validator;

class MasterComponentValidations
{
    /**
     * MasterComponentValidations;
    */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'component_name'           =>'required|unique:master_components,component_name,'.$id,
            'component_name_bn'        =>'required|unique:master_components,component_name_bn,'.$id,
            'description'     		   =>'required',
            'description_bn'           =>'required',
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

