<?php
namespace App\Http\Validations\Committee;

use Validator;

class CommitteeExpensesValidation
{
   /**
    * Comiitee expense Validation
    */
    public static function validate ($request)
    {
        $validator = Validator::make($request->all(), [
            'org_id'                    => 'required',
            'date'                      => 'required',
            'fiscal_year'               => 'required',
            'cmt_committee_id'          => 'required',
            'cmt_agenda_id'             => 'required',
            'amount'                    => 'required',
            'description'               => 'required',
            'description_bn'            => 'required',
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