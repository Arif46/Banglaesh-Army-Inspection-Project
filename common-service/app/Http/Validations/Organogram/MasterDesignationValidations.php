<?php
namespace App\Http\Validations\Organogram;

use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;



class MasterDesignationValidations
{
  /**
   * Master Designation Validator
   */
  public static function validate($request, $id = 0)
  {
    $validator = Validator::make($request->all(), [
      'org_id'           =>'required',
      'designation'      =>'required|unique:master_designations,designation,'.$id. ',id,org_id,' . $request->org_id,
      'designation_bn'   =>'required|unique:master_designations,designation_bn,'.$id. ',id,org_id,' . $request->org_id,
      'direct_post'      =>'required',
      'promotional_post' =>'required',
      'total_post'       =>'required',
      'grade_id'         =>'required',
      'sorting_order'    =>'required'
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