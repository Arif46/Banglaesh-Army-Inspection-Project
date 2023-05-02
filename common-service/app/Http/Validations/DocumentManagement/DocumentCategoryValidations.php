<?php
namespace App\Http\Validations\DocumentManagement;

use Illuminate\Support\Facades\Validator;

class DocumentCategoryValidations
{
    /**
     * Document Category Validations;
    */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'category_name'     => 'required|unique:master_document_categories,category_name,'.$id,
            'category_name_bn'  => 'required|unique:master_document_categories,category_name_bn,'.$id,
            'sorting_order'     => 'required'
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

