<?php

namespace App\Http\Validations\Specification;

use Validator;

class SpecficationInfoValidations
{
    /**
     * Specification Info Validations
     */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'item_name'  => 'required|string',
            'demand_no'  => 'required|unique:items,demand_no,'. $id
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
