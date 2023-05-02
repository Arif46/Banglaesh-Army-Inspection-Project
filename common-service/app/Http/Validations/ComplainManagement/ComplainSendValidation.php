<?php
namespace App\Http\Validations\ComplainManagement;

use Illuminate\Support\Facades\Validator;

class ComplainSendValidation
{
    /**
     * Complain Send Validations
    */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'complain_id'   => 'required',
            'sender_id'     => 'required',
            'receiver_id'   => 'required',
            'note'          => 'required',
            'note_bn'       => 'required',
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
