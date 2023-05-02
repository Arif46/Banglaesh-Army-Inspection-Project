<?php
namespace App\Http\Validations\OrgProfile;

use Illuminate\Validation\Rule;
use Validator;


class MasterUnionValidations
{
  /**
   * Master Union Validator
   */
  public static function validate($request, $id = 0)
  {
    $union_name = $request->union_name;
    $upazila_id   = $request->upazila_id;
    
    $validator = Validator::make($request->all(), [
      'union_name' => [
          'required',
          Rule::unique('master_unions')->where(function ($query) use($union_name, $upazila_id , $id) {
              $subQuery = $query->where('union_name', $union_name)
                           ->where('upazila_id', $upazila_id);
              if ($id) {
                $subQuery = $subQuery->where('id','!=',$id);
              }

              return $subQuery;
          }),
      ],
      'union_name_bn'  => 'required',
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