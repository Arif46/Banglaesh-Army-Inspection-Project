<?php

namespace App\Http\Validations\Portal;

use Validator;

class PortalHeaderValidation
{
    /**
   * Header Validation
   */
 /**
     * Header Validation
     */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'required',
            'title_bn'  => 'required',
            'description'  => 'required',
            'description_bn'  => 'required',
            'helpline' => 'required'
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
