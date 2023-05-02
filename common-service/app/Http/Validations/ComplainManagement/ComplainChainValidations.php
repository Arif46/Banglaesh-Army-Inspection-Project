<?php
namespace App\Http\Validations\ComplainManagement;

use Illuminate\Support\Facades\Validator;

class ComplainChainValidations
{
    /**
     * Complain Chain Validations
    */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'org_id'          => 'required',
            'designation_id'  => 'required'
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

