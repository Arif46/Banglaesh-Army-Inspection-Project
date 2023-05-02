<?php

namespace App\Http\Validations\NotificationManagement;

use Validator;

class NotificationTemplateValidation
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
            'template'     =>'required|unique:message_template,template,'.$id,
            'mobile_text'  => 'required',
            'email_web_text'  => 'required'
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
