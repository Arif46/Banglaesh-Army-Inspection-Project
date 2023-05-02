<?php
namespace App\Http\Validations\External;

use Illuminate\Support\Facades\Validator;

class MasterExternalMenuValidation
{
    /**
     * MasterExternalMenuValidation;
    */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'name'          =>'required|unique:external_menus,name,'.$id. ',id,external_panel_id,' . $request->external_panel_id,
            'name_bn'       =>'required|unique:external_menus,name_bn,'.$id. ',id,external_panel_id,' . $request->external_panel_id,
            'external_panel_id'  =>'required',
            'url' =>'required',
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

