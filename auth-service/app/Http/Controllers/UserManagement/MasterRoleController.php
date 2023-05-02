<?php

namespace App\Http\Controllers\UserManagement;


use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use App\Http\Validations\UserManagement\MasterRoleValidations;
use App\Models\UserManagement\MasterRole; 
use App\Models\UserManagement\RoleUser;
use App\Models\UserManagement\MenuWiseRole;
use App\Repositories\Repository;
use App\Models\User;

class MasterRoleController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(MasterRole $masterRole)
    {
        // Set the model
        $this->model = new Repository($masterRole);
    }

    /**
     * @queryParam role_name Filter by English or Bangla Name of the Role Example: Admin
     * @queryParam role_name_bn Filter by English or Bangla Name of the Role Example: এডমিন
     * @queryParam org_id Filter by org_id the Role of the list
     * @queryParam designation_id Filter by designation_id the Role of the list
    */
    public function list($columns = ['*'], $limit = 10)
    {
        $searchable = [
            'role_name' => array(
            'role_name' => 'like',
            'role_name_bn' => 'orLike',
        ),
        'org_id',
        'designation_id'
    ];
    return $this->model->paginate($columns, $searchable, [], $limit);
    }

    /**
     * @queryParam content Filter by content in List.
    */
    public function getAll($columns = ['*'])
    {
        $searchable = [
                'role_name' => array(
                'role_name' => 'like',
                'role_name_bn' => 'orLike',
            ),
            'org_id',
            'designation_id'
        ];
    return $this->model->getAll($columns, $searchable, [], ['created_at'=> 'DESC']);
    }
    /**
     * @response scenario=success {
     *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 1,
    *     "org_id": "1"
    *     "designation_id": "1"
    *     "role_name": "Admin",
    *     "role_name_bn": "এডমিন",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * 
    * @bodyParam role_name string required The English Role name Name of the Role Example: "Admin".
    * @bodyParam role_name_bn string required The Bangla Role Name of the Role Example: "এডমিন".
    * @bodyParam org_id string required org_id of the Role Example: 1
    * @bodyParam designation_id string required designation_id of the Role Example: 1
    */
    public function store(Request $request)
    {
        $validationResult = MasterRoleValidations::validate($request);

        if (!$validationResult['success']) {
            return response($validationResult);
        }
        // return $request->all();
        $requestAll = $request->all();
        $data = $this->model->create($requestAll);

        if ($data['success']) {
            Cache::store('redis')->forget('role');
            App::make('roleList');
        }

        return $data;
    }

    /**
     * @response scenario=success {
     *  "success": true,
    *  "message": "Data Update Successfully",
    *  "data": {
    *     id: 1,
    *     "org_id": "1"
    *     "designation_id": "1"
    *     "role_name": "Admin",
    *     "role_name_bn": "এডমিন",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to update data"
    *  "errors"  => "....."
    * }
     * 
     * @bodyParam role_name string required The English Role name Name of the Role Example: "Admin".
     * @bodyParam role_name_bn string required The Bangla Role Name of the Role Example: "এডমিন".
     * @bodyParam org_id string required org_id of the Role Example: 1
     * @bodyParam designation_id string required designation_id of the Role Example: 1
    */
    public function update(Request $request, $id)
    {
        $validationResult = MasterRoleValidations::validate($request, $id);
        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $requestAll = $request->all();
        $data = $this->model->update($requestAll, $id);

        if ($data['success']) {
            Cache::store('redis')->forget('role');
            App::make('roleList');
        }
        return $data;
    }


    /**
     * @urlParam id integer required The ID of the Master Bank .
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    *     id: 4,
    *     "org_id": "1"
    *     "designation_id": "1"
    *     "role_name": "Admin",
    *     "role_name_bn": "এডমিন",
    *     "status": "1"
    *     .........
    * }
    * @response scenario="Failed" {
    *  "message": "Data not found"
    * }
    */
    public function show($id)
    {
        return $this->model->show($id, $columns = ['*']);
    }

    /**
     * @urlParam id integer required The ID of the Master Bank .
     * @response scenario=success {
     *  "message": "Data deleted successfully"
     * }
     * @response scenario="Failed" {
     *  "message": "Data not found"
     * }
    */
    public function destroy($id)
    {
        $data = $this->model->delete($id);

        if ($data['success']) {
            Cache::store('redis')->forget('role');
            App::make('roleList');
        }
        return $data;
    }

    /**
     * @urlParam id integer required The ID of the Master Bank .
     * @response scenario=success {
     *  "message": "Data updated successfully"
     * }
     * @response scenario="Failed" {
     *  "message": "Data not found"
     * }
    */
    public function toggleStatus($id)
    {
        $data = $this->model->toggleStatus($id);

        if ($data['success']) {
            Cache::store('redis')->forget('role');
            App::make('roleList');
        }
        return $data;
    }

    public function storeMenu(Request $request,$role_id,$component_id,$module_id)
    {
        $datas=$request->all();
        if(!empty($datas)){
            $query = MenuWiseRole::where('role_id',$role_id);
            if (!empty($component_id)) {
                $query = $query->where('component_id', $component_id);
            }
            if (!empty($module_id)) {
                $query = $query->where('module_id', $module_id);
            }
            $role_menu=$query->delete();
            if(!empty($datas)){
                foreach ($datas as $key=>$value){
                    if(!empty($value['service'])){
                        foreach ($value['service'] as $key1=>$value1){
                            if(!empty($value1['master_menus'])){
                                foreach ($value1['master_menus'] as $key2=>$value2){
                                    if(isset($value2['checked']) && $value2['checked']){
                                        $new_data=[
                                            'role_id'=>$role_id,
                                            'master_menu_id'=>$value2['id'],
                                            'component_id'=>$value2['component_id'],
                                            'module_id'=>$value2['module_id'],
                                            'service_id'=>$value2['service_id'],
                                            // 'created_by'=>(int)user_id(),
                                            // 'updated_by'=>(int)user_id()
                                        ];
                                        MenuWiseRole::create($new_data);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        return response([
            'success' => true,
            'message' => 'Menu wise  Role save successfully'
        ]);
    }

    public function roleList($org_id){
        $roles = MasterRole::activeRole();
        if(!empty($org_id) && $org_id != 'all'){
            $roles = $roles->where('org_id',$org_id);
        }
        return $roles->oldest('role_name')->get();
    }

    public function desigWiseRole(Request $request){

        $query = MasterRole::activeRole();

        if (!empty($request->designation_id)) {
            $query->where('designation_id', $request->designation_id);
        }
        $allData = $query->oldest('role_name')->get();

        return response([
            'success' => true,
            'data' => $allData,
            'message' => 'Designation wise  Role save successfully'
        ]);
    }
    public function userData(Request $request){

        $query = DB::table('users')
            ->join('user_details', 'users.id', 'user_details.user_id')
            ->select(
                'users.id',
                'users.username',
                'users.email',
                'users.name',
                'users.name_bn',
                'users.mobile',
                'user_details.user_id',
                'user_details.photo',
                'user_details.designation_id',
            );
        if (!empty($request->org_id)) {
            $query->where('user_details.org_id',$request->org_id);
        }
        if (!empty($request->office_type_id)) {
            $query->where('user_details.office_type_id',$request->office_type_id);
        }
        $data =  $query->get();
        return $data;

    }

    public function roleUserData(Request $request){

        $query = DB::table('role_user');
        if (!empty($request->role_id)) {
            $query->where('role_id',$request->role_id);
        }
        $roleUser =  $query->get();

        return $roleUser;

    }
    public function desigRoleWiseUser(Request $request){

        $userData = json_decode($this->userData($request), true);
        $roleUser = json_decode($this->roleUserData($request), true);
        $roleId = $request->role_id;
        $designationId = $request->designation_id;
        if(!empty($userData)) {
            foreach($userData as $key=>$value) {
                $userData[$key]['select'] = 0;
                $userData[$key]['role_id'] = $roleId;
                $dbData = collect($roleUser)->where('user_id', $value['id'])->first();
                if (!empty($dbData)) {
                    $userData[$key]['select'] = 1;
                }
            }
        }

        if(count($userData) === 0) {
            return response([
                'success' => false,
                'message' => 'Data Not Found'
            ]);
        }
        return response([
            'success' => true,
            'data' => $userData,
            'message' => 'Role User Data'
        ]);
    }

    public function assignMenus(Request $request){
        $query = MenuWiseRole::defaultField()->where('role_id',$request->role_id);
        if (!empty($request->component_id)) {
            $query = $query->where('component_id', $request->component_id);
        }
        if (!empty($request->module_id)) {
            $query = $query->where('module_id', $request->module_id);
        }
        $datas= $query->get();
        return  $datas;
    }

    public function roleWiseMenuList(Request $request)
    {
        $query = MenuWiseRole::defaultField()->with(['role:id,role_name,role_name_bn'])->latest();
        if (!empty($request->component_id)) {
            $query = $query->where('component_id', $request->component_id);
        }
        if (!empty($request->module_id)) {
            $query = $query->where('module_id', $request->module_id);
        }
        if (!empty($request->service_id)) {
            $query = $query->where('service_id', $request->service_id);
        }
        if (!empty($request->menu_id)) {
            $query = $query->where('master_menu_id', $request->menu_id);
        }
        if (!empty($request->role_id)) {
            $query = $query->where('role_id', $request->role_id);
        }
        $role_wise_menus = $query->paginate($request->per_page ?? 10);
        return response([
            'success' => true,
            'message' => 'Role Wise Menu list',
            'data' =>$role_wise_menus
        ]);
    }

    //  /**
    //  * @queryParam name Filter by English or Bangla Name of the Name Example: User Name
    //  * @queryParam name_bn Filter by English or Bangla Name of the Name Example: ব্যবহারকারীর নাম
    //  */

    public function roleUser (Request $request)
    {
        $data = $request->all();
        $query= MasterRole::activeRole();

        if (!empty($request->org_id)) {
            $query = $query->where('org_id', $request->org_id);
        }


        $datas = $query->get()->each(function ($role) use ($data) {
            $role->checked = false;
            $role->user_id = $data['user_id'];
            $role->role_id = $role['id'];

            $role_user = RoleUser::where('user_id', $data['user_id'])->where('role_id', $role['id'])->first();

            if (!empty($role_user)){
                $role->checked = true;
            }

            return $role;
        });
        
        return $datas;
    }

    public function assignDesignationWiseRole(Request $request, $role_id)
    {

        DB::beginTransaction();

        try {
            RoleUser::where('role_id', $role_id)->delete();

            $roleDatas = [];
            $datas = $request->all();
            if(!empty($datas)){
                foreach ($datas as $key=>$value){
                    if ($value['select'] == 1) {
                        $roleDatas[] = [
                            'user_id' => $value['id'],
                            'role_id' => $role_id,
                            'created_at' => date('Y-m-d H:i:s'),
                            'updated_at' => date('Y-m-d H:i:s'),
                        ];
                    }
                }
                DB::table('role_user')->insert($roleDatas);
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
            'message' => 'Role assign successfully'
        ]);
    }

    public function assignRole(Request $request)
    {
        $data=$request->all();
        if(!empty($data)){
            RoleUser::where('user_id',$data['user_id'])->delete();
            if(!empty($data['roles'])){
                foreach ($data['roles'] as $key=>$value){
                    if($value['checked']){
                        RoleUser::create($value);
                    }
                }
            }
        }
        return response([
            'success' => true,
            'message' => 'Role assign successfully'
        ]);
    }

    /**
     * @queryParam name Filter by English or Bangla Name of the Role Example: Admin
     * @queryParam role_id Filter by English or Bangla Name of the Role Example: এডমিন
    */
    public function roleUserList(Request $request)
    {
        $query = User::with([
            'role_user:user_id,role_id','role_user.role:id,role_name,role_name_bn','userDetail:id,user_id,org_id,office_id,designation_id,org_id']
        );

        if ($request->name) {
            $query->where('name','like','%'.$request->name.'%');
        }

        if ($request->role_id) {
            $query->wherehas('role_user', function ($query1) use ($request)
            {
                $query = $query1->where('role_id', $request->role_id);
            });
        }

        // $query = $query->where('user_type_id', 0);

        // $userRole = $query->orderBy('name', 'ASC')->latest()->paginate($request->per_page ?? 1);
        $userRole = $query->orderBy('name', 'ASC')->latest()->paginate(request('per_page', config('app.per_page')));

        return response([
            'success' => true,
            'message' => 'User Role list',
            'data' =>$userRole
        ]);
    }
    public function menusByRole($roleId) {
        \Log::info("role_id @{$roleId}");
        return MenuWiseRole::defaultField()->where('role_id', $roleId)->get();
    }
}
