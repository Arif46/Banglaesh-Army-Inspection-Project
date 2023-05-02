<?php

namespace App\Http\Validations\OrgProfile;

use Validator;

class MasterDialogueInfoValidations
{
    /**
   * Master Dialogue Info Validation
   */
 /**
     * Master Division Validation
     */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'dialogue'     => 'required',
            'dialogue_bn'  => 'required',
            'position'     => 'required'
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
