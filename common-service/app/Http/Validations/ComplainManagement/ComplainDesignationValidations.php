<?php
namespace App\Http\Validations\ComplainManagement;

use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class ComplainDesignationValidations
{
    /**
     * Complain Designation Validations;
    */
    public static function validate($request, $id = 0)
    {
        $org_id = $request->org_id;        
        $designation_id = $request->designation_id;
        $validator = Validator::make($request->all(), [
            'org_id' => 'required',
            'designation_id' => [
                'required',
                Rule::unique('master_complain_designations')->where(function ($query) use ($org_id, $designation_id, $id) {
                    $query->where('org_id', $org_id);
                    $query->where('designation_id', $designation_id);
                    if ($id) {
                        $query =$query->where('id', '!=' ,$id);
                    }
                    return $query;             
                }),
            ]
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

