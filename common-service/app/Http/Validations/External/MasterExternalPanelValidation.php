<?php
namespace App\Http\Validations\External;

use Illuminate\Support\Facades\Validator;

class MasterExternalPanelValidation
{
    /**
     * MasterExternalPanelValidation;
    */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'name'          =>'required|unique:external_panels,name,'.$id. ',id,component_id,' . $request->component_id,
            'name_bn'       =>'required|unique:external_panels,name_bn,'.$id. ',id,component_id,' . $request->component_id,
            'component_id'  =>'required',
            'sorting_order' =>'required'
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

