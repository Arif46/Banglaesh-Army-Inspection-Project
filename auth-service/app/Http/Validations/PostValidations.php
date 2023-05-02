<?php
namespace App\Http\Validations;

use Validator;

class PostValidations
{
    /**
     * MasterCityCorporationsValidations;
    */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'title'     		   =>'required'
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

