<?php
namespace App\Http\Validations\Committee;

use Validator;

class CommiteeMettingValidation
{
    /**
     * Committee Metting Validation
     */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'org_id'                   => 'required',
            'cmt_committee_id'         => 'required',
            'cmt_agenda_id'            => 'required',
            'decision'                 => 'required',
            'decision_bn'              => 'required',
            'attendance_attachment'    => 'required',
            'document_attachment'      => 'required',
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