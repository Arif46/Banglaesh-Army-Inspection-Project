<?php

namespace App\Http\Validations\OrgProfile;

use Illuminate\Validation\Rule;
use Validator;

class MasterBankValidations
{
    /**
     * Master District Validation
     */
    public static function validate($request, $id = 0)
   {

    
    $validator = Validator::make($request->all(), [
      'bank_name'     =>'required|unique:master_banks,bank_name,'.$id,
      'bank_name_bn'  => 'required',
      'org_id'    => 'required',
      'component_id'    =>'required',
    ]);

    if ($validator->fails()) {
        return [
            'success' => false,
            'errors' => $validator->errors()
        ];
    }
    return ['success' => true];
   }
}

