<?php

namespace App\Http\Validations\NotificationManagement;

use Illuminate\Support\Facades\Validator;

class NotificationSetupValidation
{
    /**
   * Notification Setup Validation
   */

    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'component_id'   =>'required',
            'module_id'      =>'required',
            'menu_id'        =>'required',
            'button_id'      =>'required',
            'template_id'    =>'required',
            'button_id'      =>'required',
            'mobile_text'    =>'required',
            'email_web_text' =>'required',
            'media_id'       =>'required',
            'recipient_id'   =>'required'
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
