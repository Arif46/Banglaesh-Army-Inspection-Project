<?php
namespace App\Http\Validations\Committee;

use Validator;

class CreateCommitteeValidation
{
    /**
     *Create Committee Validation
    */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'committee_name'     => 'required|unique:cmt_committees,committee_name,'.$id,
            'committee_name_bn'  => 'required|unique:cmt_committees,committee_name_bn,'.$id,
            'org_id'             => 'required',
            'formation_date'     => 'required',
            'purpose'            => 'required',
            'purpose_bn'         => 'required',
            'duration'           => 'required',
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