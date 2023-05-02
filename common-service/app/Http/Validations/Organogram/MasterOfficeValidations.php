<?php
namespace App\Http\Validations\Organogram;

use Illuminate\Validation\Rule;
use Validator;


class MasterOfficeValidations
{
  /**
     * Master office validate
     */
    public static function validate ($request ,$id=0)
    { 
        $office_name    = $request->office_name;
        $org_id         = $request->org_id;
        $office_type_id = $request->office_type_id;
        $division_id = $request->division_id;
        $district_id = $request->district_id;
        $upazila_id = $request->upazila_id;
        $union_id = $request->union_id;
        $validator = Validator::make($request->all(), [
            'office_name' => [
                'required',
                Rule::unique('master_offices')->where(function ($query) use($office_name, $org_id, $office_type_id, $division_id, $district_id, $upazila_id, $union_id, $id) {
                    $query->where('office_name', $office_name)
                                 ->where('org_id', $org_id)
                                 ->where('office_type_id', $office_type_id)
                                 ->where('division_id', $division_id)
                                 ->where('district_id', $district_id)
                                 ->where('upazila_id', $upazila_id)
                                 ->where('union_id', $union_id);
                    if ($id) {
                        $query =$query->where('id', '!=' ,$id);
                    }

                    return $query;
                }),
            ],
            'office_name_bn'  => 'required',
            'org_id'       => 'required',
            'office_type_id'       => 'required',
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