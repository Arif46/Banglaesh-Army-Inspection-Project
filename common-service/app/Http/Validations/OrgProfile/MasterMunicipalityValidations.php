<?php

namespace App\Http\Validations\OrgProfile;

use Illuminate\Validation\Rule;
use Validator;

class MasterMunicipalityValidations
{
    /**
     * Master District Validation
     */
    public static function validate($request, $id = 0)
   {

    $pauroshoba_name = $request->pauroshoba_name;
    $upazila_id   = $request->upazila_id;
    
    $validator = Validator::make($request->all(), [
      'pauroshoba_name' => [
          'required',
          Rule::unique('master_pauroshobas')->where(function ($query) use($pauroshoba_name, $upazila_id , $id) {
              $subQuery = $query->where('pauroshoba_name', $pauroshoba_name)
                           ->where('upazila_id', $upazila_id);
              if ($id) {
                $subQuery = $subQuery->where('id','!=',$id);
              }

              return $subQuery;
          }),
      ],
      'pauroshoba_name_bn'  => 'required',
      'division_id'    => 'required',
      'district_id'    => 'required',
      'upazila_id'    =>'required',
    ]);

    if ($validator->fails()) {
        return [
            'success' => false,
            'errors' => $validator->errors()
        ];
    }
    return ['success' => true];
   }
}

