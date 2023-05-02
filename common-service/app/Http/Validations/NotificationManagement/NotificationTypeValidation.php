<?php

namespace App\Http\Validations\NotificationManagement;

use Validator;

class NotificationTypeValidation
{
    /**
   * Notification Type Validation
   */
 /**
     * Notification Type Validation
     */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'not_type_name'     => 'required',
            'not_type_name_bn'  => 'required'
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
