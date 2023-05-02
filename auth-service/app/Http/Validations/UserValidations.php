<?php
namespace app\Http\Validations;

use Validator, DB;

class UserValidations 
{

    /**
     * user account validation
     */
    public static function validate($request, $id=0)
    {
        $validator = Validator::make($request->all(), [
            'name'              => 'required',
            'name_bn'           => 'required',
            'email'             => 'nullable|unique:users,email,'.$id,
            'password'          => 'required|string|min:6',
            'confirm_password'  => 'required|min:6|same:password',
            'mobile'            => 'required|unique:users,mobile,'.$id,
        ],
        [ 
            'password.required' => 'Password is required',
            'password.min'      => 'Password at least 6 digit'
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