<?php
namespace App\Http\Validations\ComplainManagement;

use Illuminate\Support\Facades\Validator;

class ComplainCommitteeValidation
{
    /**
     * Complain Committee Validations
    */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'complain_id.*'   => 'required',
            'role_id.*'       => 'required',
            'user_id.*'       => 'required',
            'designation_id.*'=> 'required'
        ]);

        if ($validator->fails()) {
            return ([
                'success' => false,
                'errors' => $validator->errors()
            ]);
        }

        return ['success'=> 'true'];
    }
}
