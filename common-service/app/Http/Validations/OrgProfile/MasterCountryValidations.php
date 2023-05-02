<?php

namespace App\Http\Validations\OrgProfile;

use Validator;

class MasterCountryValidations
{
    /**
     * Master Country Validation
     */
    public static function validate($request, $id = 0)
    {

        $validator = Validator::make($request->all(), [
            'country_name'     => 'required|unique:master_countries,country_name,'.$id,
            'country_name_bn'  => 'required|unique:master_countries,country_name_bn,'.$id,
            'nationality'     => 'required|unique:master_countries,nationality,'.$id,
            'nationality_bn'  => 'required|unique:master_countries,nationality_bn,'.$id,
            'country_code'     => 'nullable|integer'
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
