<?php

namespace App\Http\Validations\OrgProfile;

use Validator;

class MasterWardValidations
{
    /**
     * @queryParam Master Ward Validation
     */
    public static function validate ($request)
    {
        $validator = Validator::make($request->all(), [
            'type'     => 'required',
            'ward_name'     => 'required',
            'ward_name_bn'  => 'required',
        ]);

        if ($request->type == 1) {
            $validator = Validator::make($request->all(), [
                'city_corporation_id'   => 'required',
            ]);
        }

        if ($request->type == 2) {
            $validator = Validator::make($request->all(), [
                'division_id'   => 'required',
                'district_id'   => 'required',
                'upazila_id'   => 'required',
                'pauroshoba_id' => 'required',
            ]);
        }

        if ($request->type == 3) {
            $validator = Validator::make($request->all(), [
                'division_id'   => 'required',
                'district_id'   => 'required',
                'upazila_id'   => 'required',
                'union_id'      => 'required',
            ]);
        }



        if ($validator->fails()) {
            return ([
                'success' => false,
                'errors' => $validator->errors()
            ]);
        }

        return ['success'=> 'true'];
    }
}