<?php

namespace App\Http\Validations\OrgProfile;

use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class MasterBranchValidations
{
    /**
     * Master Branch Validation
     */
    public static function validate($request, $id = 0) {

        $org_id         = $request->org_id;
        $bank_id        = $request->bank_id;
        $branch_name    = $request->branch_name;
        $branch_name_bn = $request->branch_name_bn;

        $validator = Validator::make($request->all(), [
            'org_id'          => 'required',
            'bank_id'         =>'required',
            'branch_name' => [
                'required',
                Rule::unique('master_branchs')->where(function ($query) use($org_id, $bank_id ,$branch_name, $id) {
                    $query->where('branch_name', $branch_name)
                                // ->where('org_id', $org_id)
                                ->where('bank_id', $bank_id);
                    if ($id) {
                        $query =$query->where('id', '!=' ,$id);
                    }
                    return $query;
                }),
            ],
            'branch_name_bn' => [
                'required',
                Rule::unique('master_branchs')->where(function ($query) use($org_id, $bank_id ,$branch_name_bn, $id) {
                    $query->where('branch_name_bn', $branch_name_bn)
                                // ->where('org_id', $org_id)
                                ->where('bank_id', $bank_id);
                    if ($id) {
                        $query = $query->where('id', '!=' ,$id);
                    }
                    return $query;
                }),
            ],
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

