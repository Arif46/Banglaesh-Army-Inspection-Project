<?php
namespace App\Http\Validations\OrgProfile;

use Illuminate\Support\Facades\Validator;

class MasterFiscalYearValidation
{
    /**
     * MasterFiscalYearValidation;
    */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'year'          =>'required',
            'start_date'    =>'required|date',
            'end_date'      =>'required|date',
            'sorting_order' =>'required'
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

