<?php
namespace App\Http\Validations\Organogram;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class ComponentDesignationValidations
{
    /**
   * Component Designation Validationsator
   */
  public static function validate($request, $id = 0)
  {
    $validator = Validator::make($request->all(), [
      'designation_id' => 'required|array',
      'org_id'         => 'required',
      'component_id'   => 'required'
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