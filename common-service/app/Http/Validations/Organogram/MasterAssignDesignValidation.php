<?php
namespace App\Http\Validations\Organogram;

use Illuminate\Validation\Rule;
use Validator;


class MasterAssignDesignValidation
{
  /**
   * Master Union Validator
   */
  public static function validate($request, $id = 0)
  {
    $org_id     = $request->org_id;
    $office_id  = $request->office_id;
    $validator = Validator::make($request->all(), [
      'designation_id' => [
          'required',
          Rule::unique('assign_designations')->where(function ($query) use($office_id, $org_id , $id) {
              $subQuery = $query->where('office_id', $office_id)
                           ->where('org_id', $org_id);
              if ($id) {
                $subQuery = $subQuery->where('id','!=',$id);
              }

              return $subQuery;
          }),
      ],
      'org_id'    => 'required',
      'office_id' => 'required',
      'office_type_id' => 'required',
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