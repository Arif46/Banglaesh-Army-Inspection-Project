<?php
namespace App\Http\Validations\Menu;

use Illuminate\Support\Facades\Validator;

class MasterModuleValidation
{
    /**
     * MasterModuleValidation;
    */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            'module_name'      =>'required|unique:master_modules,module_name,'.$id. ',id,component_id,' . $request->component_id,
            'module_name_bn'   =>'required|unique:master_modules,module_name_bn,'.$id. ',id,component_id,' . $request->component_id,
            'component_id'      =>'required',
            'sorting_order'     =>'required'
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

