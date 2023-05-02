<?php
namespace app\Http\Validations;

use Validator, DB;

use function PHPUnit\Framework\isEmpty;

class ExternalUserValidations 
{

    /**
     * external user sign up validation
     */
    public static function validate($request)
    {  
        $getRequestEmail = strlen($request->email) > 0 ? 'unique:users|email' : 'nullable';

        $validator = Validator::make($request->all(), [
            'name'              => 'required',
            'name_bn'           => 'required',
            'email'             => $getRequestEmail,
            'password'          => 'required|string|min:6',
            'confirm_password'  => 'required|min:6|same:password',
            'mobile'            => 'required|unique:users'
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