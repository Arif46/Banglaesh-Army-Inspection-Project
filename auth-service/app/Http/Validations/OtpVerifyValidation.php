<?php
namespace app\Http\Validations;

use Validator;

class OtpVerifyValidation
{
    /**
     * user account validation
     */
    public static function validate($request, $id =0)
    {
        $validator = Validator::make($request->all(), [
            'otp_code'     => 'required|digits_between:6,6',
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