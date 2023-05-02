<?php
namespace App\Http\Validations\Menu;

use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class MasterMenuValidation
{
    /**
     * MasterMenuValidation;
    */
    public static function validate($request, $id = 0)
    {
        $menu_name      = $request->menu_name;
        $component_id   = $request->component_id;
        $module_id      = $request->module_id;
        $service_id     = $request->service_id;
        $validator = Validator::make($request->all(), [
            'menu_name' => [
                'required',
                Rule::unique('master_menus')->where(function ($query) use($menu_name, $component_id, $module_id, $service_id, $id) {
                    $query->where('menu_name', $menu_name)
                                 ->where('component_id', $component_id)
                                 ->where('module_id', $module_id)
                                 ->where('service_id', $service_id);
                    if ($id) {
                        $query =$query->where('id', '!=' ,$id);
                    }
                    return $query;
                }),
            ],
            'menu_name_bn'  => 'required',
            'component_id'  => 'required',
            'module_id'     => 'required',
            'url'           => 'required',
            'sorting_order' => 'required'
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

