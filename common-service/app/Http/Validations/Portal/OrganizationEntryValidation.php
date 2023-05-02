<?php

namespace App\Http\Validations\Portal;

use Validator;

class OrganizationEntryValidation
{
    /**
    * Portal External Organization Entry Validation
    */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'ex_org_name' => 'required|unique:portal_ex_organizations,ex_org_name,'.$id,
            'ex_org_name_bn'  => 'required',
            'ministry_id'  => 'required|integer'
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
