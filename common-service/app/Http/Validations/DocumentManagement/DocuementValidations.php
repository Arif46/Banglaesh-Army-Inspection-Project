<?php
namespace App\Http\Validations\DocumentManagement;

use Illuminate\Support\Facades\Validator;

class DocuementValidations
{
    /**
     * Document Validations;
    */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'doc_title'     => 'required|unique:doc_doc_infos,doc_title,'.$id,
            'doc_title_bn'  => 'required|unique:doc_doc_infos,doc_title_bn,'.$id,
            'org_id'        => 'required',
            'category_id'   => 'required',
            'attachment'    => 'required'
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

