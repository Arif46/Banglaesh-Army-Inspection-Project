<?php 
namespace App\Http\Validations;

use Illuminate\Support\Facades\Validator;

class CommonProfileValidation {
    /**
     * Master Role Validation
     */
    public static function validate($request, $id = 0) 
    {
        $validator = Validator::make($request->all(), [
            'dob'                => 'required',
            'father_name_en'     => 'required',
            'father_name_bn'     => 'required',
            'mother_name_en'     => 'required',
            'mother_name_bn'     => 'required',
            'gender'             => 'required',
            'nid_no'                => 'required|unique:user_profiles,nid_no,'.$id,
            'user_id'                => 'required|unique:user_profiles,user_id,'.$id,
            'pr_address.pr_area_type_id' => 'required|integer',
            'pr_address.pr_division_id' => 'required|integer',
            'pr_address.pr_district_id' => 'required|integer',
            'pr_address.pr_city_corporation_id' => 'required_if:'. $request['pr_address']['pr_area_type_id'] .',==,1',
            'pr_address.pr_pauroshoba_id' => 'required_if:'. $request['pr_address']['pr_area_type_id'] .',==,2',
            'pr_address.pr_union_id' => 'required_if:'. $request['pr_address']['pr_area_type_id'] .',==,3',
            'pm_address.pm_area_type_id' => 'required|integer',
            'pm_address.pm_division_id' => 'required|integer',
            'pm_address.pm_district_id' => 'required|integer',
            'pm_address.pm_city_corporation_id' => 'required_if:'. $request['pm_address']['pm_area_type_id'] .',==,1',
            'pm_address.pm_pauroshoba_id' => 'required_if:'. $request['pm_address']['pm_area_type_id'] .',==,2',
            'pm_address.pm_union_id' => 'required_if:'. $request['pm_address']['pm_area_type_id'] .',==,3'
        ]);

        if ($validator->fails()) {
            return ([
                'success' => false,
                'errors'  => $validator->errors()
            ]);
        }

        return ['success'=> 'true'];
   }
}