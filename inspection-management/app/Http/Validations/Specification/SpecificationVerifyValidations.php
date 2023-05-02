<?php

namespace App\Http\Validations\Specification;

use Validator;

class SpecificationVerifyValidations
{
    /**
     * Specification Verify Validations
     */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'supplier_name'  => 'required|unique:supplier_items,supplier_name,NULL,id,demand_no,'. $request->demand_no. $id,
            // 'demand_no' => 'required|unique:supplier_items,demand_no'
            'demand_no' => 'required'
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
