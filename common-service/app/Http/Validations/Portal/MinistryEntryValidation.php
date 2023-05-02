<?php

namespace App\Http\Validations\Portal;

use Validator;

class MinistryEntryValidation
{
    /**
   * Portal Ministry Entry Validation
   */
 /**
     * Service Category Validation
     */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'ministry_name' => 'required|unique:portal_ministry_entries,ministry_name,'.$id,
            'ministry_name_bn'  => 'required'
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
