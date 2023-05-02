<?php

namespace App\Http\Validations\NotificationManagement;

use Validator;

class NotCirculateNoticeValidation
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
            'notice_title'     			=>'required',
            'description'               =>'required',
            'notice_for'                =>'required',
            'org_id'                   	=>'required',
            'notification_type_id'      =>'required',                  
            'notice_date'      			=>'required', 
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
