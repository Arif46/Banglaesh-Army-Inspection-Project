<?php

namespace App\Http\Controllers\Menu;

use App\Http\Controllers\Controller;
use App\Http\Validations\Menu\MasterServiceValidation;
use App\Models\Menu\MasterService;
use App\Repositories\Repository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Cache;

class MasterServiceController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(MasterService $masterService)
    {
        // Set the model
        $this->model = new Repository($masterService);
    }

    /**
     * @queryParam service_name Filter by Module Name in List.
     * @queryParam component_id Filter by component id in List.
     * @queryParam module_id Filter by module id in List.
     */
    public function list($columns = ['*'], $limit = 10)
    { 
        $searchable = [
            'service_name' => array(
                'service_name' => 'like',
                'service_name_bn' => 'orLike',
            ),
            'component_id',
            'module_id'
        ];
        return $this->model->paginate($columns, $searchable, [], $limit);
    }

    /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *      id: 1,
    *     "service_name": "Service name",
    *     "service_name_bn": "Service name bn",
    *     "component_id": "1",
    *     "module_id": "1",
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
    * @bodyParam service_name string required The Service Name of the MasterService.
    * @bodyParam service_name_bn string required The service_name_bn of the MasterService
    * @bodyParam component_id string required The component_id of the MasterService
    * @bodyParam module_id string required The module_id of the MasterService
    * ......
    */
    public function store(Request $request) {

        $validationResult = MasterServiceValidation::validate($request);    
            if (!$validationResult['success']) {
            return response($validationResult);
        }

        $requestAll = $request->all();      
        $data = $this->model->create($requestAll);

        if ($data['success']) {
            Cache::store('redis')->forget('service');
            App::make('serviceList');
        }
        return $data;
    }

    /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Updated Successfully",
    *  "data": {
    *     id: 4,
    *     "service_name": "Service name",
    *     "service_name_bn": "Service name bn",
    *     "component_id": "1",
    *     "module_id": "1",
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
    * @bodyParam service_name string required The Service Name of the MasterService.
    * @bodyParam service_name_bn string required The service_name_bn of the MasterService
    * @bodyParam component_id string required The component_id of the MasterService
    * @bodyParam module_id string required The module_id of the MasterService
    * ......
    */
    public function update(Request $request, $id)
    {
        $validationResult = MasterServiceValidation::validate($request, $id);    
        if (!$validationResult['success']) {
            return response($validationResult);
        } 

        $requestAll = $request->all();
        $data = $this->model->update($requestAll, $id);

        if ($data['success']) {
            Cache::store('redis')->forget('service');
            App::make('serviceList');
        }
        return $data;
    }

    /**
    * @urlParam id integer required The ID of the MasterService.     
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
            Cache::store('redis')->forget('service');
            App::make('serviceList');
        }
        return $data;
    }
}
