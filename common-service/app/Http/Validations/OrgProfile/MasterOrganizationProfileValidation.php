<?php
namespace app\Http\Validations\OrgProfile;

use Validator;

class MasterOrganizationProfileValidation
{
    /**
     * master organization validation
     */
    public static function validate ($request, $id=0)
    {
        $validator = Validator::make($request->all(), [
            'org_name' => 'required|unique:master_org_profiles,org_name,'.$id,
            'hierarchy' => 'integer|sometimes|nullable',
        ]);

        if ($validator->fails()) {
            return([
                'success' => false,
                'errors'  => $validator->errors()
            ]);
        } 
        return ['success'=>true]; 
    }
}