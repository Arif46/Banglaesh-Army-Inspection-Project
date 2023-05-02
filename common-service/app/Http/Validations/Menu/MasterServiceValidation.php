<?php
namespace App\Http\Validations\Menu;

use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class MasterServiceValidation
{
    /**
     * MasterServiceValidation;
    */
    public static function validate($request, $id = 0)
    {
        $validator = Validator::make($request->all(), [
            // 'service_name'      =>'required|unique:master_services,service_name,'.$id,
            'component_id'      =>'required',
            'module_id'         =>'required',
            'service_name' => ['required', Rule::unique('master_services')->where(function ($q) use($request, $id) {
                    $q->where('service_name', $request->service_name)
                                 ->where('component_id', $request->component_id)
                                 ->where('module_id', $request->module_id);
                    if ($id) {
                        $q = $q->where('id', '!=' ,$id);
                    }
                    return $q;
                }),
            ],
            'service_name_bn'   =>'required',
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

