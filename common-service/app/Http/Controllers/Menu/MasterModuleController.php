<?php

namespace App\Http\Controllers\Menu;

use App\Http\Controllers\Controller;
use App\Http\Validations\Menu\MasterModuleValidation;
use App\Models\Menu\MasterModule;
use App\Repositories\Repository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Cache;

class MasterModuleController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(MasterModule $masterModule)
    {
      // Set the model
      $this->model = new Repository($masterModule);
    }

    /**
     * @queryParam module_name Filter by Module Name in List.
     * @queryParam component_id Filter by component id in List.
     */
    public function list($columns = ['*'], $limit = 10)
    { 
      $searchable = [
        'module_name' => array(
          'module_name' => 'like',
          'module_name_bn' => 'orLike',
        ),
        'component_id'
      ];
      return $this->model->paginate($columns, $searchable, [], $limit);
    }

    /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *      id: 1,
    *     "module_name": "Module name",
    *     "module_name_bn": "Module name bn",
    *     "component_id": "1",
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
    * @bodyParam module_name string required The Module Name of the MasterModule.
    * @bodyParam module_name_bn string required The module_name_bn of the MasterModule
    * ......
  */
  public function store(Request $request)
  {
    
    $validationResult = MasterModuleValidation::validate($request);    
    if (!$validationResult['success']) {
      return response($validationResult);
    }

    $requestAll = $request->all();

    $data = $this->model->create($requestAll);

    if ($data['success']) {
      Cache::store('redis')->forget('module');
      App::make('moduleList');
    }
    return $data;
  }
  
  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Updated Successfully",
    *  "data": {
    *     id: 4,
    *     "module_name": "Module name",
    *     "module_name_bn": "Module name bn",
    *     "component_id": "1",
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
    * @bodyParam module_name string required The Module Name of the MasterModule.
    * @bodyParam module_name_bn string required The module_name_bn of the MasterModule
    * ......
  */
  public function update(Request $request, $id)
  {
    $validationResult = MasterModuleValidation::validate($request, $id);    
    if (!$validationResult['success']) {
      return response($validationResult);
    } 

    $requestAll = $request->all();
    $data = $this->model->update($requestAll, $id);

    if ($data['success']) {
      Cache::store('redis')->forget('module');
      App::make('moduleList');
    }
    return $data;
  }

  /**
   * @urlParam id integer required The ID of the MasterModule.     
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
      Cache::store('redis')->forget('module');
      App::make('moduleList');
    }
    return $data;
  }

}
