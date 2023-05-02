<?php

namespace App\Http\Controllers\UserManagement;

use App\Helpers\Base64FileUpload;
use App\Http\Controllers\Controller;
use App\Http\Validations\UserManagement\UserValidations;
use App\Models\User;
use App\Models\UserManagement\SecretQuestionAnswer;
use Illuminate\Http\Request;
use DB;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    /**
   * @queryParam name Filter by English or Bangla Name of the Name Example: User Name
   * @queryParam name_bn Filter by English or Bangla Name of the Name Example: ব্যবহারকারীর নাম
   * @queryParam org_id Filter by Office Example: 1
   * @queryParam office_id Filter by Office Example: 1
   * @queryParam org_id Filter by Office Example: 1
   * @queryParam designation_id Filter by Office Example: 1
   * @queryParam office_id Filter by Office Example: 1
  */
    public function list(Request $request)
    {   
        $query = User::with(['details:id,user_id,org_id,designation_id,office_type_id,office_id,role_id,photo',
                            'answer:id,user_id,answer,secret_question_id']);
        
        if ($request->org_id) {
            $query->whereHas('details', function ($q) use ($request) {
                $q->where('org_id', $request->org_id);
            });
        }
        
        if ($request->designation_id) {
            $query->whereHas('details', function ($q) use ($request) {
                $q->where('designation_id', $request->designation_id);
            });
        }
        
        if ($request->office_id) {
            $query->whereHas('details', function ($q) use ($request) {
                $q->where('office_id', $request->office_id);
            });
        }

        if ($request->name) {
            $query->where('users.name', 'like', "{$request->name}%")
                    ->orWhere('users.name_bn', 'like', "{$request->name}%");
        }

        if ($request->username) {
            $query->where('users.username', 'like', "{$request->username}%");
        }

        if ($request->email) {
            $query->where('users.email', 'like', "%{$request->email}%");
        }

        if ($request->user_type) {
            $query->where('users.user_type', $request->user_type);
        }

        $list = $query->paginate(request('per_page', config('app.per_page')));

        return response([
            'success' => true,
            'message' => 'User list',
            'data'    => $list
        ]);
    }
    /**
     * @queryParam name Filter by English or Bangla Name of the Name Example: User Name
     * @queryParam name_bn Filter by English or Bangla Name of the Name Example: ব্যবহারকারীর নাম
     * @queryParam org_id Filter by Office Example: 1
     * @queryParam office_id Filter by Office Example: 1
     * @queryParam org_id Filter by Office Example: 1
     * @queryParam designation_id Filter by Office Example: 1
     * @queryParam office_id Filter by Office Example: 1
     */   
    public function getUserList(Request $request)
    {
        $query = DB::table('users')
                ->join('user_details','users.id', '=', 'user_details.user_id')
                ->select(
                    'users.id',
                    'users.id as value',
                    'users.username as text',
                    'users.email as email',
                    'users.mobile as mobile',
                    'users.name as text_en',
                    'users.name_bn as text_bn',
                    'user_details.org_id',
                    'user_details.office_type_id',
                    'user_details.designation_id',
                    'user_details.office_id',
                    'user_details.role_id',
                )
                ->where('username', '!=' ,"")
                ->orderBy('username', 'asc');

        if(!empty($request->org_id)) {
            $query = $query->where('user_details.org_id', $request->org_id);
        }
        if(!empty($request->office_type_id)) {
            $query = $query->where('user_details.office_type_id', $request->office_type_id);
        }
        if(!empty($request->office_id)) {
            $query = $query->where('user_details.office_id', $request->office_id);
        }
        if(!empty($request->designation_id)) {
            $query = $query->where('user_details.designation_id', $request->designation_id);
        }

        if(!empty($request->user_ids) && count($request->user_ids) > 0 ) {
            $query = $query->whereIn('users.id', $request->user_ids);
        }

        if ($request->user_type) {
            $query->where('user_type', $request->user_type);
        }

        $list = $query->get();

        return response([
            'success' => true,
            'message' => 'User list',
            'data' => $list
        ]);
    }

    /**
     * @response scenario=success {
     *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 1,
    *     "name": "Admin",
    *     "name_bn": "এডমিন",
    *     "username": "admin",
    *     "mobile": "01620505050",
    *     "email": "admin@gmail.com"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * 
    * @bodyParam name string required The English name Name of the Example: "Admin".
    * @bodyParam name_bn string required The Bangla Name of the Example: "এডমিন".
    * @bodyParam mobile string required mobile of the User Example: 01620505050
    * @bodyParam email string required email of the User Example: 1
    */
    public function store (Request $request) 
    {   
        $validationResult = UserValidations::validate($request);

        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $requestAll = $request->all();
        $requestAll['status'] = 1;
        $requestAll['password'] = Hash::make($request->password); 

        $requestDetails = $request->details;
        if ($request->details['photo']) {
            $image = Base64FileUpload::uploadImage($request->details, 'photo', '/user/photo', null, 100, 80);         
            $requestDetails['photo'] = $image['success'] ? $image['data']: null;
        }     

        DB::beginTransaction();

        try {
            
            $model = User::create($requestAll);
            $model->details()->create($requestDetails);

            if (!empty($request->answer->secret_question_id)) {
                $model->answer()->create($request->answer);
            }

            DB::commit();

        } catch (\Exception $ex) {

            DB::rollBack();

            return response([
                'success' => false,
                'message' => 'Failed to save data.',
                'errors'  => env('APP_ENV') !== 'production' ? $ex->getMessage() : []
            ]);
        }

        return response([
            'success' => true,
            'message' => 'Data save successfully',
            'data'    => $model
        ]);
    }

    /**
     * @response scenario=success {
     *  "success": true,
    *  "message": "Data Update Successfully",
    *  "data": {
    *      id: 1,
    *     "name": "Admin",
    *     "name_bn": "এডমিন",
    *     "username": "admin",
    *     "mobile": "01620505050",
    *     "email": "admin@gmail.com"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to update data"
    *  "errors"  => "....."
    * }
    * 
    * @bodyParam name string required The English name Name of the Example: "Admin".
    * @bodyParam name_bn string required The Bangla Name of the Example: "এডমিন".
    * @bodyParam mobile string required mobile of the User Example: 01620505050
    * @bodyParam email string required email of the User Example: 1
    */
    public function update(Request $request, $id)
    {  
        $validationResult = UserValidations::validate($request, $id);

        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $model = User::find($id);

        if (!$model) {
            return response([
                'success' => false,
                'message' => 'Data not found.'
            ]);
        }

        if ($request->details['photo'] != null && isset($request->details['update_photo'])) { 
            $image = Base64FileUpload::uploadImage($request->details, 'photo', '/user/photo', $model->photo, 100, 80);              
        }       

        DB::beginTransaction();

        try {
            
            $requestAll = $request->all();
            // return $requestAll;
            $requestAll['password'] = !empty($request->password) ? Hash::make($request->password) : $model->password; 
           
            $model->update($requestAll);
            
            $requestDetails = $request->details;

            if (isset($requestDetails['update_photo'])) {
                unset($requestDetails['update_photo']);
            }           
           
            $requestDetails['photo'] = isset($image) ? ($image['success'] ? $image['data']: $model->details['photo']) : $model->details['photo'];
            $model->details()->update($requestDetails);
            if (!empty($request->answer->secret_question_id)) {
           
                    SecretQuestionAnswer::updateOrCreate(
                        [
                            'user_id' => $request->answer['user_id'],
                        ],
                        [
                            'user_id' => $request->answer['user_id'],
                            'secret_question_id' => $request->answer['secret_question_id'],
                            'answer' => $request->answer['answer']
                        ]
                    );
            }
            DB::commit();

        } catch (\Exception $ex) {

            DB::rollBack();

            return response([
                'success' => false,
                'message' => 'Failed to save data.',
                'errors'  => env('APP_ENV') !== 'production' ? $ex->getMessage() : []
            ]);
        }

        return response([
            'success' => true,
            'message' => 'Data update successfully',
            'data'    => $model
        ]);
    }

    /**
     * @queryParam org_id Filter by org_id the User of the list
     * @queryParam designation_id Filter by designation_id the User of the list
     * @queryParam office_type_id Filter by designation_id the User of the list
     * @queryParam office_id Filter by designation_id the User of the list
    */

    public function allUserByOrg(Request $request) {
        // $query = User::with(['details:id,user_id,org_id,designation_id,office_type_id,office_id,role_id,photo'])->where('org_id', 8);
        $query = DB::table('users')
        ->join('user_details', 'users.id', 'user_details.user_id')->where('user_details.org_id','=', 8)->select(
            'users.id as ID',
            'users.name',
            'users.name_bn',
            'user_details.user_id'
        )->get();
        return $query;
    }

    public function listByDesignation(Request $request)
    {
        $query = DB::table('users')
                ->join('user_details', 'users.id', 'user_details.user_id')
                ->select(
                    'users.id',
                    'users.username',
                    'users.email',
                    'users.mobile',
                    // 'users.nothi_user_id',
                    // 'users.user_type_id',
                    // 'users.is_org_admin',
                    'users.name',
                    'users.name_bn',
                    'user_details.user_id',
                    'user_details.org_id',
                    // 'user_details.phone_no',
                    'user_details.office_type_id',
                    'user_details.office_id',
                    'user_details.photo',
                    'user_details.designation_id',
                    'user_details.role_id'
                );
                    // ->where('users.user_type_id', 0);

        if (!empty($request->org_id)) {
            $query = $query->where('user_details.org_id',$request->org_id);
        }
        if (!empty($request->designation_id)) {
            $query = $query->where('user_details.designation_id',$request->designation_id);
        }

        if (!empty($request->office_type_id)) {
            $query = $query->where('user_details.office_type_id',$request->office_type_id);
        }

        if (!empty($request->office_id)) {
            $query = $query->where('user_details.office_id',$request->office_id);
        }

        if ($request->user_ids) {
            $query->whereIn('users.id',$request->user_ids);
        }

        $data =  $query->get();

        if (!$data) {

            return response([
                'success' => false,
                'message' => 'Data Not Found!'
            ]);

        } else {

            return response([
                'success' => true,
                'message' => 'User account list',
                'data' => $data
            ]);
        }
    }

    /**
     * Get user list based on user id
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function getUserInfoList(Request $request)
    {
//        return $request->all();
        $query = DB::table('users')
            ->leftJoin('user_details', 'users.id', 'user_details.user_id')
            ->select(
                'users.id',
                'users.username',
                'users.email',
                'users.name',
                'users.name_bn',
                'users.user_type',
                'user_details.org_id',
                'user_details.office_type_id',
                'user_details.office_id',
                'user_details.photo',
                'user_details.designation_id',
                'user_details.role_id'
            );

        if (!empty($request->org_id)) {
            $query->where('user_details.org_id',$request->org_id);
        }

        if (!empty($request->designation_id)) {
            $query->where('user_details.designation_id',$request->designation_id);
        }

        if (!empty($request->office_type_id)) {
            $query->where('user_details.office_type_id',$request->office_type_id);
        }

        if (!empty($request->office_id)) {
            $query->where('user_details.office_id',$request->office_id);
        }

        if ($request->user_ids) {
            $query->whereIn('users.id',$request->user_ids);
//            $query->whereIn('users.id', ['246', '257']);
        }

        $list =  $query->get();

        if ($list->isEmpty()) {
            return response([
                'success' => false,
                'message' => 'Data Not Found!'
            ]);
        }

        return response([
            'success' => true,
            'message' => 'User account list',
            'data' => $list
        ]);
    }

    /**
     * Get user details
     *
     * @param \Illuminate\Http\Request $request user id
     * @return \Illuminate\Http\Response
     */
    public function userDetails($id)
    {
        $data = DB::table('users')
                ->join('user_details','users.id', '=', 'user_details.user_id')
                ->select(
                    'users.id as value',
                    'users.username as text',
                    'users.email as email',
                    'users.mobile as mobile',
                    'users.name as text_en',
                    'users.name_bn as text_bn',
                    'users.signature',
                    'user_details.org_id',
                    'user_details.office_type_id',
                    'user_details.designation_id',
                    'user_details.office_id',
                    'user_details.role_id',
                )
                ->where('users.id', $id)->first();
        
        if(empty($data)) {
            return response([
                'success' => false,
                'message' => 'User Details not found!',
                'data' => $data
            ]);
        }

        return response([
            'success' => true,
            'message' => 'User Details found!',
            'data' => $data
        ]);
    }
}
