<?php

namespace App\Http\Validations\OrgProfile;

use Validator;
use Illuminate\Validation\Rule;

class MasterThanaValidations
{
    /**
     * Master Division Validation
     */
    public static function validate($request, $id = 0)
    {
        $district_id   = $request->district_id;
        $thana_name = $request->thana_name;
        $thana_name_bn = $request->thana_name_bn;
        $validator = Validator::make($request->all(), [
            'thana_name' => [
                'required',
                Rule::unique('master_thanas')->where(function ($query) use($thana_name, $district_id ,$id) {
                    $query->where('thana_name', $thana_name)
                                 ->where('district_id', $district_id);
                    if ($id) {
                        $query =$query->where('id', '!=' ,$id);
                    }
                    return $query;             
                }),
            ],
            'thana_name_bn' => [
                'required',
                Rule::unique('master_thanas')->where(function ($query) use($thana_name_bn, $district_id ,$id) {
                    $query->where('thana_name_bn', $thana_name_bn)
                                 ->where('district_id', $district_id);
                    if ($id) {
                        $query =$query->where('id', '!=' ,$id);
                    }
                    return $query;             
                }),
            ],
            'district_id'     => 'required|integer|exists:master_districts,id'
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
