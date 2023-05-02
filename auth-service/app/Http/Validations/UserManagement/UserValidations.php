<?php 
namespace App\Http\Validations\UserManagement;

use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class UserValidations {
    /**
     * Master Role Validation
     */
    public static function validate($request, $id = 0) 
    {
        $validator = Validator::make($request->all(), [
            'name'                      => 'required',
            'name_bn'                   => 'required',
            'username'                  => 'required|unique:users,username,'.$id,
            'email'                     => 'required|unique:users,email,'.$id,
            'password'                  => 'required_if:'. $id .',==,0|min:6',
            'password_confirmation'     => 'required_if:'. $id .',==,0|required_with:password|same:password|min:6',
            'mobile'                    => 'required|unique:users,mobile,'.$id,

            'details'                   => 'required|array',
            'details.org_id'            => 'required',
            'details.office_id'         => 'required',
            'details.office_type_id'    => 'required',
            'details.designation_id'    => 'required',
        ]);

        if ($validator->fails()) {
            return ([
                'success' => false,
                'errors'  => $validator->errors()
            ]);
        }

        return ['success'=> 'true'];
   }
}