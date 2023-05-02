<?php

namespace App\Http\Controllers\External;

use App\Http\Controllers\Controller;
use App\Http\Validations\External\MasterExternalMenuValidation;
use App\Models\External\ExternalMenu;
use App\Models\External\ExternalPanel;
use App\Repositories\Repository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Cache;

class MasterExternalMenuController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(ExternalMenu $externalPanel)
    {
        // Set the model
        $this->model = new Repository($externalPanel);
    }

    /**
     * @queryParam name Filter by Name in List.
    * @queryParam external_panel_id Filter by external_panel_id in List.
    */
    public function list($columns = ['*'], $limit = 10)
    { 
        $searchable = [
            'name' => array(
                'name' => 'like',
                'name_bn' => 'orLike',
            ),
            'external_panel_id'
        ];
        return $this->model->paginate($columns, $searchable, [], $limit);
    }

    /**
     * @queryParam name Filter by English or Bangla Name of the ExternalMenu Example: Configuration
     * @queryParam name_bn Filter by English or Bangla Bn of the ExternalMenu Example: কনফিগারেশন
    */
    public function getAll($columns = ['*'])
    {
        $searchable = [
            'name' => array(
                'name' => 'like',
                'name_bn' => 'orLike',
            ),
            'external_panel_id'
        ];
        return $this->model->getAll($columns, $searchable, [], ['created_at'=> 'DESC']);
    }

    /**
     * @response scenario=success {
     *  "success": true,
     *  "message": "Data Saved Successfully",
     *  "data": {
     *      id: 1,
     *     "name": "name",
     *     "name_bn": "name bn",
     *     "external_panel_id": "1",
     *     "sorting_order": "100",
     *     "status": "1" 1 = active , 2 = inactive
     *     .........
     *   }
     * }
     * @response scenario=Failed {
     *  "success": false,
     *  "message": "Failed to save data"
     *  "errors"  => "....."
     * }
     * @bodyParam external_panel_id integer required The external_panel_id of the ExternalMenu.
     * @bodyParam name string required The Name of the ExternalMenu.
     * @bodyParam name_bn string required The name_bn of the ExternalMenu
     * ......
    */
    public function store(Request $request)
    {
        $validationResult = MasterExternalMenuValidation::validate($request);    
        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $requestAll = $request->all();

        $data = $this->model->create($requestAll);

        if ($data['success']) {
            Cache::store('redis')->forget('externalMenu');
            App::make('externalMenuList');
        }
        return $data;
    }

    /**
     * @response scenario=success {
     *  "success": true,
     *  "message": "Data Update Successfully",
     *  "data": {
     *      id: 1,
     *     "name": "name",
     *     "name_bn": "name bn",
     *     "external_panel_id": "1",
     *     "sorting_order": "100",
     *     "status": "1" 1 = active , 2 = inactive
     *     .........
     *   }
     * }
     * @response scenario=Failed {
     *  "success": false,
     *  "message": "Failed to update data"
     *  "errors"  => "....."
     * }
     * @bodyParam external_panel_id integer required The external_panel_id of the ExternalMenu.
     * @bodyParam name string required The Name of the ExternalMenu.
     * @bodyParam name_bn string required The name_bn of the ExternalMenu
     * ......
    */
    public function update(Request $request, $id)
    {
    $validationResult = MasterExternalMenuValidation::validate($request, $id);    
    if (!$validationResult['success']) {
        return response($validationResult);
    } 

    $requestAll = $request->all();
    $data = $this->model->update($requestAll, $id);

    if ($data['success']) {
        Cache::store('redis')->forget('externalMenu');
        App::make('externalMenuList');
    }
    return $data;
    }

    /**
    * @urlParam id integer required The ID of the MasterExternalPanel.     
    * @response scenario=success {
    *  "message": "Data updated successfully"
    * }
    * @response scenario="Failed" {
    *  "message": "Data not found"
    * }
    */
    public function toggleStatus($id) {
        $data = $this->model->toggleStatus($id);

        if ($data['success']) {
            Cache::store('redis')->forget('externalMenu');
            App::make('externalMenuList');
        }
        return $data;
    }

    /**
     * Change Ordering
     */
    public function changeMenuSerialOrder(Request $request,$model)
    {
        $datas = $request->all();
        if(!empty($datas)){
            foreach($datas as $key=>$value){
            $modelName = 'App\Models\External\\' .$model;
            $UpdateData= $modelName::where('id',$value['id'])->first();
            $UpdateData->sorting_order= $value['sorting_order'];
            $UpdateData->save();
            }
        }
        
        Cache::store('redis')->forget('externalMenu');
        App::make('externalMenuList');

        return response([
            'success' => true,
            'message' => 'Data save successfully',
            'data'    => $datas
        ]);
    }
    /**
     * panel wise get menu
    */
    public function menuByPanel ($panelId)
    {
        $menus = ExternalMenu::where('external_panel_id', $panelId)
                ->orderBy('sorting_order', 'ASC')
                ->where('status', 1)->get();

        if ($menus->count() > 0) {
            return response([
                'success'   => true,
                'data'      => $menus,
                'message'   => 'Data Found!!'
            ]); 
        }

        return response([
            'success'   => false,
            'data'      => [],
            'message'   => 'Data not Found !!'
        ]); 
    }

    public function menuByUrl (Request $request) {
        $pos = strrpos($request->url,'/');
        $target_url = $pos ? substr($request->url, 0, $pos) : $request->url;
        $targetMenus = ExternalMenu::where('url', 'LIKE', "%$target_url%")->first();

        if ($targetMenus) {
            $menus = ExternalMenu::where('external_panel_id', $targetMenus->external_panel_id)
                    ->orderBy('sorting_order', 'ASC')
                    ->where('status', 1)->get();
        } else {
            $menus = [];
        }

        if (count($menus) > 0) {
            return response([
                'success'   => true,
                'data'      => $menus,
                'message'   => 'Data Found!!'
            ]); 
        }

        return response([
            'success'   => false,
            'data'      => [],
            'message'   => 'Data not Found !!'
        ]);
    }
}
