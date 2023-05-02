<?php

namespace App\Http\Controllers\Menu;

use App\Http\Controllers\Controller;
use App\Http\Validations\Menu\MasterMenuValidation;
use App\Models\Menu\{MasterComponent, MasterMenu, MasterModule, MasterService};
use App\Repositories\Repository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Cache;
use App\Library\SidebarMenus;

class MasterMenuController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(MasterMenu $MasterMenu)
    {
        // set the model
        $this->model = new Repository($MasterMenu);
    }

    /**
     * get all master office
     */
    public function changeSerialOrder(Request $request,$model)
    {
        $datas = $request->all();
        
        if(!empty($datas)){
            foreach($datas as $key=>$value){
                $modelName = 'App\Models\Menu\\' .$model;
                $UpdateData=$modelName::where('id',$value['id'])->first();
                $UpdateData->sorting_order= $value['sorting_order'];
                $UpdateData->save();
            }
        }
        
        Cache::store('redis')->forget('components');
        App::make('componentList');

        return response([
            'success' => true,
            'message' => 'Data save successfully',
            'data'    => $datas
        ]);
    }

    /**
   * @queryParam menu_name Filter by English or Bangla Name of the Menu Example: Configuration
   * @queryParam component_id Filter by component_id of the Menu Example: 1
   * @queryParam module_id Filter by module_id of the Menu Example: 1
   * @queryParam service_id Filter by service_id of the Menu Example: 1
   * @queryParam limit int Example: 10
   */

    public function list($columns = ['*'], $limit = 10)
    {
        $searchable = [
            'menu_name' => array(
                'menu_name' => 'like',
                'menu_name_bn' => 'orLike',
            ),
            'component_id',
            'module_id',
            'service_id'
        ];

        return $this->model->paginate($columns, $searchable, [], $limit);
    }
  
    /**
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data Saved Successfully",
        *  "data": {
        *     "id": 1,
        *     "component_id": 1,
        *     "module_id": 1
        *     "service_id": 1
        *     "menu_name": "Menu name"
        *     "menu_name_bn": "মেনু"
        *     "status": "1"
        *     ..............
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to save data"
        *  "errors"  => "....."
        * }
        * @bodyParam menu_name string required The English Menu Name of the Menu Example: Common Service Configuration.
        * @bodyParam menu_name_bn string required The Bangla Menu Name of the Menu Example: কমন সার্ভিস কনফিগারেশন.
        * @bodyParam component_id integer required component_id of the Menu Example: 1
        * @bodyParam module_id integer required module_id of the Menu Example: 1
        * @bodyParam service_id integer required service_id of the Menu Example: 1
        * @bodyParam sorting_order integer required sorting_order of the Menu Example: 1
        * @bodyParam url string required url of the Menu Example: http://localhost:8080/common-service/menu/menu
        * @bodyParam associated_urls string optional associated_urls of the Menu Example: 111
    */

    public function store(Request $request)
    {   
        $validationResult = MasterMenuValidation::validate($request);    
        if (!$validationResult['success']) {
            return response($validationResult);
        }  

        $requestAll = $request->all();
        // $requestAll['created_by'] = (int)user_id()??null;

        $data = $this->model->create($requestAll);
        if ($data['success']) {
            Cache::store('redis')->forget('menu');
            App::make('menuList');
        }
        return $data;
    }
    
    /**
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data Saved Successfully",
        *  "data": {
        *     "id": 1,
        *     "component_id": 1,
        *     "module_id": 1
        *     "service_id": 1
        *     "menu_name": "Menu name"
        *     "menu_name_bn": "মেনু"
        *     "status": "1"
        *     ..............
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to save data"
        *  "errors"  => "....."
        * }
        * @bodyParam menu_name string required The English Menu Name of the Menu Example: Common Service Configuration.
        * @bodyParam menu_name_bn string required The Bangla Menu Name of the Menu Example: কমন সার্ভিস কনফিগারেশন.
        * @bodyParam component_id integer required component_id of the Menu Example: 1
        * @bodyParam module_id integer required module_id of the Menu Example: 1
        * @bodyParam service_id integer required service_id of the Menu Example: 1
        * @bodyParam sorting_order integer required sorting_order of the Menu Example: 1
        * @bodyParam url string required url of the Menu Example: http://localhost:8080/common-service/menu/menu
        * @bodyParam associated_urls string optional associated_urls of the Menu Example: 111
    */
    public function update(Request $request, $id)
    {
        $validationResult = MasterMenuValidation::validate($request, $id);    
        if (!$validationResult['success']) {
            return response($validationResult);
        }
        $requestAll = $request->all(); 
        // $requestAll['updated_by'] = (int)user_id()??null;

        $data = $this->model->update($requestAll, $id);

        if ($data['success']) {
            Cache::store('redis')->forget('menu');
            App::make('menuList');
        }
        return $data;
    }

    /**
     * @urlParam id integer required The ID of the Component.     
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
            Cache::store('redis')->forget('menu');
            App::make('menuList');
        }
        return $data;
    }

    public function allMenus(Request $request)
    {
        $query = MasterModule::select(
                        'id',
                        'module_name',
                        'module_name_bn',
                        'component_id',
                    );
        if (!empty($request->component_id)) {
            $query = $query->where('component_id', $request->component_id);
        }

        if (!empty($request->module_id)) {
            $query = $query->where('id', $request->module_id);
        }
        $datas=$query->get();
        $all_menus =array();
        if(!empty($datas)){
            $sl =0;
            foreach ($datas as $key => $value) {
                $services= array();
                $master_muenus=MasterMenu::select([
                                'id',
                                'service_id',
                                'menu_name',
                                'menu_name_bn',
                                'component_id',
                                'module_id',
                                'url'
                            ])
                            ->where('module_id',$value['id'])
                            ->where('service_id',0)
                            ->get();
                if(count($master_muenus) > 0){
                    $data_new =array('id'=>date("Ymdhis").rand(10,100),'service_name'=>'','master_menus'=>$master_muenus);
                    $services[]=$data_new;
                }
                $servicelist=MasterService::select(['id','service_name','service_name_bn'])
                    ->with(['master_menus:id,service_id,menu_name,menu_name_bn,component_id,module_id,service_id,url'])
                    ->where('module_id',$value['id'])
                    ->get();
                foreach($servicelist as $key1=>$value1){
                    $services[]=$value1;
                }
                $datas[$key]['service']=$services;
                $all_menus[] = $datas[$key];
            }
        }
        return $all_menus;
    }

    public function componentsOfSuperAdmin()
    {
        $componentIds   = MasterMenu::select('component_id')->groupBy('component_id')->pluck('component_id')->all();
        $components     = MasterComponent::whereIn('id', $componentIds)->orderBy('sorting_order')->get();

        return response([
            'success' => true,
            'data' => $components
        ]);
    }

    public function menusByRoleComponent($roleId, $componentId)
    {
        if ((int)$roleId === 1) {
            return response(SidebarMenus::getMenus($roleId, $componentId, null, true));
        }

        $baseUrl = config('app.base_url.auth_service');
        
        $assignedMenus = \App\Library\RestService::getData($baseUrl, "/user-management/role/role-menus/{$roleId}");
        $assignedMenus =json_decode($assignedMenus, true);
        
        if (empty($assignedMenus)) {
            return response([
                'success' => false,
                'data' => [
                    'components' => [],
                    'modules' => [],
                    'services' => [],
                    'menus' => []
                ]
            ]);
        }
        
        if (count($assignedMenus) <= 0) {
            return response([
                'success' => false,
                'data' => [
                    'components' => [],
                    'modules' => [],
                    'services' => [],
                    'menus' => []
                ]
            ]);
        }

        if (empty($assignedMenus)) {
            return response([
                'success' => false,
                'data' => [$role_id, 1],
                'message' => "No menu assigned to this role"
            ]);
        }

        $assignedMenuIds = [];

        foreach ($assignedMenus as $key => $value) {
            $assignedMenuIds[] = $value['master_menu_id'];
        }

        $result = SidebarMenus::getMenus($roleId, $componentId, $assignedMenuIds);

        if (!$result['success']) {
            return response($result);
        }
        
        return response([
            'success' => true,
            'data' => $result['data'],
            'message' => 'All assigned menu details and its related information fetched'
        ]);      
        
    }
}
