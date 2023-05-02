<?php

namespace App\Http\Validations\UserManagement;

use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class MasterRoleValidations
{
    /**
     * Master Role Validation
     */
    public static function validate($request, $id = 0) {

        $org_id         = $request->org_id;
        $designation_id = $request->designation_id;
        $role_name      = $request->role_name;
        $role_name_bn   = $request->role_name_bn;

        $validator = Validator::make($request->all(), [
            'org_id'          => 'required',
            'designation_id'  =>'required',
            'role_name' => [
                'required',
                Rule::unique('roles')->where(function ($query) use($org_id, $designation_id ,$role_name, $id) {
                    $query->where('role_name', $role_name)
                                // ->where('org_id', $org_id)
                                ->where('designation_id', $designation_id);
                    if ($id) {
                        $query =$query->where('id', '!=' ,$id);
                    }
                    return $query;
                }),
            ],
            'role_name_bn' => [
                'required',
                Rule::unique('roles')->where(function ($query) use($org_id, $designation_id ,$role_name_bn, $id) {
                    $query->where('role_name_bn', $role_name_bn)
                                // ->where('org_id', $org_id)
                                ->where('designation_id', $designation_id);
                    if ($id) {
                        $query = $query->where('id', '!=' ,$id);
                    }
                    return $query;
                }),
            ],
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

