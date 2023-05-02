<?php

namespace App\Http\Validations\UserManagement;

use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class MasterSectetQuestionValidations
{
    /**
     * Master Sectet Question Validation
     */
    public static function validate($request, $id = 0) {

        $validator = Validator::make($request->all(), [
            'question_name'       =>'required|unique:secret_questions,question_name,'.$id,
            'question_name_bn'    =>'required|unique:secret_questions,question_name_bn,'.$id,
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

