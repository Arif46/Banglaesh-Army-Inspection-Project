<?php
namespace App\Http\Validations\ComplainManagement;

use Illuminate\Support\Facades\Validator;

class ComplainInfoValidation
{
    /**
     * Complain Send Validations
    */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'com_title'     => 'required',
            'description'   => 'required',
            'org_id'        => 'required',
            'service_id'    => 'required',
            'division_id'   => 'required',
            'district_id'   => 'required',
            'upazilla_id'   => 'required',
            'union_id'      => 'required',
            'mobile_no'     => 'required|min:11|max:11',
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
