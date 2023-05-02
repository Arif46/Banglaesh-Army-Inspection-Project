<?php

namespace App\Http\Controllers;

use App\Helpers\Base64FileUpload;
use App\Http\Controllers\Controller;
use App\Http\Validations\CommonProfileValidation;
use App\Models\UserProfile;
use App\Repositories\Repository;
use Illuminate\Http\Request;

class UserCommonProfileController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(UserProfile $profile)
    {
        // set the model
        $this->model = new Repository($profile);
    }

    /**
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data Saved Successfully",
        *  "data": {
            *   id: 1,
            *   "pr_area_type_id": 1 (1 = City Corporation, 2= Pauroshoba, 3=Union),
            *   "pm_area_type_id": 1 (1 = City Corporation, 2= Pauroshoba, 3=Union),
            *   "user_id": 1,
            *   "nid_no": 4545454545444,
            *   "dob": '15-02-1997',
            *   "gender": 1 (1=male, 2=female, 3=others),
            *   "image": 'user-logo.png',
            *   "user_id": 1,
            *   "father_name_en": 'Name of Father',
            *   ............,
            *   ............,
            *   "status": "1"
            *   .........
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to save data"
        *  "errors"  => "....."
        * }
        * @bodyParam user_id bigInteger required The User Id UserProfile.
        * @bodyParam nid_no integer required The NID of the User.
        * @bodyParam pr_area_type_id tinyInteger required The Area Type of the Address.
        *   when pr_area_type_id = 1
        *   pr_pauroshoba_id: 0
        *   pr_union_id: 0
        *   pr_upazila_id: 0
        *   for pr_area_type_id = 2
        *   pr_city_corporation = 0
        *   pr_union_id = 0
        *   for pr_area_type_id = 3
        *   pr_pauroshoba_id: 0
        * ......
    */
    public function store(Request $request)
    {
        $validationResult = CommonProfileValidation::validate($request);
        
        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $allData = $request->all();
        if ($allData['image']) {
            $image = Base64FileUpload::uploadImage($allData, 'image', '/common-profile', null);         
            $allData['image'] = $image['success'] ? $image['data'] : null;
        }

        // for present address
        $allData['pr_area_type_id'] = $request['pr_address']['pr_area_type_id'];
        $allData['pr_division_id'] = $request['pr_address']['pr_division_id'];
        $allData['pr_district_id'] = $request['pr_address']['pr_district_id'];
        $allData['pr_ward_id'] = $request['pr_address']['pr_ward_id'];
        $allData['pr_pauroshoba_id'] = $request['pr_address']['pr_pauroshoba_id'];
        $allData['pr_union_id'] = $request['pr_address']['pr_union_id'];
        $allData['pr_upazila_id'] = $request['pr_address']['pr_upazila_id'];
        $allData['pr_city_corporation_id'] = $request['pr_address']['pr_city_corporation_id'];
        $allData['pr_address_details_en'] = $request['pr_address']['pr_address_details_en'];
        $allData['pr_address_details_bn'] = $request['pr_address']['pr_address_details_bn'];

        // for permanent address
        $allData['pm_area_type_id'] = $request['pm_address']['pm_area_type_id'];
        $allData['pm_division_id'] = $request['pm_address']['pm_division_id'];
        $allData['pm_district_id'] = $request['pm_address']['pm_district_id'];
        $allData['pm_ward_id'] = $request['pm_address']['pm_ward_id'];
        $allData['pm_pauroshoba_id'] = $request['pm_address']['pm_pauroshoba_id'];
        $allData['pm_union_id'] = $request['pm_address']['pm_union_id'];
        $allData['pm_upazila_id'] = $request['pm_address']['pm_upazila_id'];
        $allData['pm_city_corporation_id'] = $request['pm_address']['pm_city_corporation_id'];
        $allData['pm_address_details_en'] = $request['pm_address']['pm_address_details_en'];
        $allData['pm_address_details_bn'] = $request['pm_address']['pm_address_details_bn'];

        // for present Address
        if ($allData['pr_area_type_id'] == 1) {
            $allData['pr_pauroshoba_id'] = 0;
            $allData['pr_union_id'] = 0;
            $allData['pr_upazila_id'] = 0;
        } else if ($allData['pr_area_type_id'] == 2) {
            $allData['pr_city_corporation_id'] = 0;
            $allData['pr_union_id'] = 0;
        } else if ($allData['pr_area_type_id'] == 3) {
            $allData['pr_city_corporation_id'] = 0;
        } else {
            return [
                'success' => false,
                'message' => 'Invalid Area Type'
            ];
        }

        // for permanent address
        if ($allData['pm_area_type_id'] == 1) {
            $allData['pm_pauroshoba_id'] = 0;
            $allData['pm_union_id'] = 0;
            $allData['pm_upazila_id'] = 0;
        } else if ($allData['pm_area_type_id'] == 2) {
            $allData['pm_city_corporation_id'] = 0;
            $allData['pm_union_id'] = 0;
        } else if ($allData['pm_area_type_id'] == 3) {
            $allData['pm_city_corporation_id'] = 0;
            // $allData['pm_union_id'] = 0;
        } else {
            return [
                'success' => false,
                'message' => 'Invalid Area Type'
            ];
        }

        // $allData['updated_by'] = (int) user_id();
        $allData['user_id'] = $allData['user_id'];
        $allData['created_by'] = $allData['user_id'];
        $allData['updated_by'] = $allData['user_id'];

        $data = $this->model->create($allData);
        return $data;
    }


    /**
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data Saved Successfully",
        *  "data": {
            *   id: 1,
            *   "pr_area_type_id": 1 (1 = City Corporation, 2= Pauroshoba, 3=Union),
            *   "pm_area_type_id": 1 (1 = City Corporation, 2= Pauroshoba, 3=Union),
            *   "user_id": 1,
            *   "nid_no": 4545454545444,
            *   "dob": '15-02-1997',
            *   "gender": 1 (1=male, 2=female, 3=others),
            *   "image": 'user-logo.png',
            *   "user_id": 1,
            *   "father_name_en": 'Name of Father',
            *   ............,
            *   ............,
            *   "status": "1"
            *   .........
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to save data"
        *  "errors"  => "....."
        * }
        * @bodyParam user_id bigInteger required The User Id UserProfile.
        * @bodyParam nid_no integer required The NID of the User.
        * @bodyParam pr_area_type_id tinyInteger required The Area Type of the Address.
        *   when pr_area_type_id = 1
        *   pr_pauroshoba_id: 0
        *   pr_union_id: 0
        *   pr_upazila_id: 0
        *   for pr_area_type_id = 2
        *   pr_city_corporation = 0
        *   pr_union_id = 0
        *   for pr_area_type_id = 3
        *   pr_pauroshoba_id: 0
        * ......
    */
    public function update(Request $request, $id)
    {
        $validationResult = CommonProfileValidation::validate($request, $id);
        
        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $allData = $request->all();
        // return $allData;
        if ($allData['image']) {
            $image = Base64FileUpload::uploadImage($allData, 'image', '', $allData['pre_image']);
            $allData['image'] = $image['success'] ? $image['data'] : null;
        } else {
            $allData['image'] = $allData['pre_image'];
        }

        // for present address
        $allData['pr_area_type_id'] = $request['pr_address']['pr_area_type_id'];
        $allData['pr_division_id'] = $request['pr_address']['pr_division_id'];
        $allData['pr_district_id'] = $request['pr_address']['pr_district_id'];
        $allData['pr_ward_id'] = $request['pr_address']['pr_ward_id'];
        $allData['pr_pauroshoba_id'] = $request['pr_address']['pr_pauroshoba_id'];
        $allData['pr_union_id'] = $request['pr_address']['pr_union_id'];
        $allData['pr_upazila_id'] = $request['pr_address']['pr_upazila_id'];
        $allData['pr_city_corporation_id'] = $request['pr_address']['pr_city_corporation_id'];
        $allData['pr_address_details_en'] = $request['pr_address']['pr_address_details_en'];
        $allData['pr_address_details_bn'] = $request['pr_address']['pr_address_details_bn'];

        // for permanent address
        $allData['pm_area_type_id'] = $request['pm_address']['pm_area_type_id'];
        $allData['pm_division_id'] = $request['pm_address']['pm_division_id'];
        $allData['pm_district_id'] = $request['pm_address']['pm_district_id'];
        $allData['pm_ward_id'] = $request['pm_address']['pm_ward_id'];
        $allData['pm_pauroshoba_id'] = $request['pm_address']['pm_pauroshoba_id'];
        $allData['pm_union_id'] = $request['pm_address']['pm_union_id'];
        $allData['pm_upazila_id'] = $request['pm_address']['pm_upazila_id'];
        $allData['pm_city_corporation_id'] = $request['pm_address']['pm_city_corporation_id'];
        $allData['pm_address_details_en'] = $request['pm_address']['pm_address_details_en'];
        $allData['pm_address_details_bn'] = $request['pm_address']['pm_address_details_bn'];

        // for present Address
        if ($allData['pr_area_type_id'] == 1) {
            $allData['pr_pauroshoba_id'] = 0;
            $allData['pr_union_id'] = 0;
            $allData['pr_upazila_id'] = 0;
        } else if ($allData['pr_area_type_id'] == 2) {
            $allData['pr_city_corporation_id'] = 0;
            $allData['pr_union_id'] = 0;
        } else if ($allData['pr_area_type_id'] == 3) {
            $allData['pr_city_corporation_id'] = 0;
        } else {
            return [
                'success' => false,
                'message' => 'Invalid Area Type'
            ];
        }

        // for permanent address
        if ($allData['pm_area_type_id'] == 1) {
            $allData['pm_pauroshoba_id'] = 0;
            $allData['pm_union_id'] = 0;
            $allData['pm_upazila_id'] = 0;
        } else if ($allData['pm_area_type_id'] == 2) {
            $allData['pm_city_corporation_id'] = 0;
            $allData['pm_union_id'] = 0;
        } else if ($allData['pm_area_type_id'] == 3) {
            $allData['pm_city_corporation_id'] = 0;
            // $allData['pm_union_id'] = 0;
        } else {
            return [
                'success' => false,
                'message' => 'Invalid Area Type'
            ];
        }

        // $allData['updated_by'] = (int) user_id();
        $allData['updated_by'] = $allData['user_id'];

        $data = $this->model->update($allData, $id);
        return $data;
    }


    /**
        * @urlParam id integer required The user_id of the UserProfile.
        * @response scenario=success {
        *   id: 4,
        *   "user_id": 2,
        *   "dob": "15-06-1997"
        *   "nid_no": "8555554544",
        *   "father_name_en" : "Name of the father name in english"
        *   ..............
        * }
        * @response scenario="Failed" {
        *  "message": "Data not found"
        * }
    */
    public function show($id)
    {
        $user = UserProfile::where('user_id', $id)->first();

        if ($user) {
            return [
                'success' => true,
                'message' => 'User data found!',
                'data' =>  $user,
            ];
        } else {
            return [
                'success' => false,
                'message' => 'User Not found!'
            ];
        }
    }
}
