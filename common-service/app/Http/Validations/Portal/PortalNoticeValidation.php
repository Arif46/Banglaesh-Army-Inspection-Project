<?php

namespace App\Http\Validations\Portal;

use Validator;

class PortalNoticeValidation
{
    /**
   * Notice Validation
   */
 /**
     * Notice Validation
     */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'required',
            'title_bn'  => 'required',
            'description'  => 'required',
            'description_bn'  => 'required'
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
