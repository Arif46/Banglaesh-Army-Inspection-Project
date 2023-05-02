<?php
namespace App\Http\Validations\Organogram;

use Illuminate\Validation\Rule;
use Validator;


class MasterOfficeTypeValidations
{
  /**
   * Master Office Type Validator
   */
  public static function validate($request, $id = 0)
  {
    $office_type_name = $request->office_type_name;
    $org_id   = $request->org_id;
    
    $validator = Validator::make($request->all(), [
      'office_type_name' => [
          'required',
          Rule::unique('master_office_types')->where(function ($query) use($office_type_name, $org_id , $id) {
              $subQuery = $query->where('office_type_name', $office_type_name)
                           ->where('org_id', $org_id);
              if ($id) {
                $subQuery = $subQuery->where('id','!=',$id);
              }

              return $subQuery;
          }),
      ],
      'office_type_name_bn'  => 'required',
      'org_id'    =>'required',
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