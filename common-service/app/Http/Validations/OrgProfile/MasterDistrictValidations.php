<?php

namespace App\Http\Validations\OrgProfile;

use Illuminate\Validation\Rule;
use Validator;

class MasterDistrictValidations
{
    /**
     * Master District Validation
     */
    public static function validate($request, $id = 0)
    {
        $division_id   = $request->division_id;
        $district_name = $request->district_name;
        $validator = Validator::make($request->all(), [
            'district_name' => [
                'required',
                Rule::unique('master_districts')->where(function ($query) use($district_name, $division_id ,$id) {
                    $query->where('district_name', $district_name)
                                 ->where('division_id', $division_id);
                    if ($id) {
                        $query =$query->where('id', '!=' ,$id);
                    }
                    return $query;             
                }),
            ],
            'district_name_bn'  => 'required',
            'division_id'       => 'required',
        ]);

        if ($validator->fails()) {
            return ([
                'success' => false,
                'errors' => $validator->errors()
            ]);
        }
        
        return ['success'=>true]; 
    }
}

