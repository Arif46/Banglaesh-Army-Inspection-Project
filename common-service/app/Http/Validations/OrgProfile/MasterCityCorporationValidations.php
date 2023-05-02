<?php

namespace App\Http\Validations\OrgProfile;

use Validator;

class MasterCityCorporationValidations
{
    /**
     * Master District Validation
     */
    public static function validate($request, $id = 0)
   {

    $city_corporation_name = $request->city_corporation_name;
    $district_id    = $request->district_id;

    $validator = Validator::make($request->all(), [
        // 'city_corporation_name' => [
        //     'required',
        //     Rule::unique('master_city_corporations')->where(function ($query) use($city_corporation_name, $district_id ,$id) {
        //         $query->where('city_corporation_name', $city_corporation_name)
        //                      ->where('district_id', $district_id);
        //         if ($id) {
        //         $query = $query->where('id','!=',$id);
        //         }
        //         return $query;             
        //     }),
        // ],
        'city_corporation_name'  => 'required',
        'city_corporation_name_bn'  => 'required',
        'city_corporation_code'  => 'nullable|integer',
        'division_id'        => 'required',
        'district_id'        => 'required',
    ]);

    if ($validator->fails()) {
        return [
            'success' => false,
            'errors'  => $validator->errors()
        ];
    }
    return ['success' => true];
   }
}

