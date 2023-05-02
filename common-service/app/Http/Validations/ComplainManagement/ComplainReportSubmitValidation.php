<?php
namespace App\Http\Validations\ComplainManagement;

use Illuminate\Support\Facades\Validator;

class ComplainReportSubmitValidation
{
    /**
     * Complain Report Submit Validations
    */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'complain_id'   => 'required',
            'report_note'   => 'required'
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
