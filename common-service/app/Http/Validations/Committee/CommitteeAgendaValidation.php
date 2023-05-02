<?php
namespace App\Http\Validations\Committee;

use Validator;

class CommitteeAgendaValidation
{
    /**
     * Committee agenda Validation
     */

    public static function validate($request)
    {
       $validator = Validator::make($request->all(), [
            'org_id'              => 'required',
            'cmt_committee_id'    => 'required',
            'meeting_number'      => 'required',
            'memo_number'         => 'required',
            'agenda_name'         => 'required',
            'agenda_name_bn'      => 'required',
            'meeting_date'        => 'required',
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