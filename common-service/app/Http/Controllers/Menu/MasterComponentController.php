<?php

namespace App\Http\Controllers\Menu;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\{Cache, App};
use App\Repositories\Repository;
use App\Models\Menu\MasterComponent;
use App\Http\Validations\Menu\MasterComponentValidations;

class MasterComponentController extends Controller
{
  // space that we can use the repository from
  protected $model;

  public function __construct(MasterComponent $MasterComponent)
  {
    // set the model
    $this->model = new Repository($MasterComponent);
  }

  /**
   * @queryParam component_name Filter by English or Bangla Name of the Components Example: Common Service Configuration
   * @queryParam description Filter by English or Bangla Description of the Components Example: কমন সার্ভিস কনফিগারেশন
   * @queryParam limit int Example: 10
  */

  public function list($columns = ['*'], $limit = 10)
  { 
    $searchable = [
      'component_name' => array(
        'component_name' => 'like',
        'component_name_bn' => 'orLike',
      ),
      'description' => array(
        'description' => 'like',
        'description_bn' => 'orLike',
      )
    ];
    return $this->model->paginate($columns, $searchable, ['org_component:id,org_id,component_id', 'org'], $limit);
  }
  
  /**
   * @queryParam component_name Filter by English or Bangla Name of the Components Example: Common Service Configuration
   * @queryParam description Filter by English or Bangla Description of the Components Example: কমন সার্ভিস কনফিগারেশন
  */
  public function getAll($columns = ['*'])
  {
    
    $searchable = [
      'component_name' => array(
        'component_name' => 'like',
        'component_name_bn' => 'orLike',
      ),
      'description' => array(
        'description' => 'like',
        'description_bn' => 'orLike',
      )
    ];
    return $this->model->getAll($columns, $searchable, [], ['created_at'=> 'DESC']);
  }
  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 1,
    *     "component_name": "Common Service Configuration",
    *     "component_name_bn": "কমন সার্ভিস কনফিগারেশন",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam component_name string required The English Component Name of the Component Example: Common Service Configuration.
    * @bodyParam component_name_bn string required The Bangla Component Name of the Component Example: কমন সার্ভিস কনফিগারেশন.
    * @bodyParam description string required The English Description of the Component Example: Common Service Configuration
    * @bodyParam description_bn string required The Bangla Description of the Component Example: কমন সার্ভিস কনফিগারেশন .....
  */
  public function store(Request $request)
  {
    $validationResult = MasterComponentValidations::validate($request);    
    
    if (!$validationResult['success']) {
      return response($validationResult);
    }
    
    $requestAll = $request->all();   
    
    $orgs = explode(',', $request->org_id);

    $orgList = array();
    if (!empty($orgs)) {
      foreach($orgs as $key=>$value) {
        $orgList[$key]['org_id'] = $value;
      }
    }

    $data = $this->model->create($requestAll);
    $data['model']->org_component()->createMany($orgList);

    if ($data['success']) {
      Cache::store('redis')->forget('components');
      App::make('componentList');
      App::make('orgComponentList');
    }

    return $data;
  }
  
  /**
    * @urlParam id integer required The ID of the Component Example: 1
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 1,
    *     "component_name": "Common Service Configuration",
    *     "component_name_bn": "কমন সার্ভিস কনফিগারেশন",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam component_name string required The English Component Name of the Component Example: Common Service Configuration.
    * @bodyParam component_name_bn string required The Bangla Component Name of the Component Example: কমন সার্ভিস কনফিগারেশন.
    * @bodyParam description string required The English Description of the Component Example: Common Service Configuration
    * @bodyParam description_bn string required The Bangla Description of the Component Example: কমন সার্ভিস কনফিগারেশন .....
  */
  public function update(Request $request, $id)
  {
    $validationResult = MasterComponentValidations::validate($request, $id);    
    if (!$validationResult['success']) {
      return response($validationResult);
    } 

    $requestAll = $request->all();

    $orgs = $request->org_id;

    $orgList = array();
    if (!empty($orgs)) {
      foreach($orgs as $key=>$value) {
        $orgList[$key]['org_id'] = $value;
      }
    }
   
    $data = $this->model->update($requestAll, $id);
    $data['model']->org_component()->delete();
    // return $orgList;
    $data['model']->org_component()->createMany($orgList);

    if ($data['success']) {
      Cache::store('redis')->forget('components');
      Cache::store('redis')->forget('orgComponents');
      App::make('componentList');
      App::make('orgComponentList');
    }
    return $data;
  }

  /**
    * @urlParam id integer required The ID of the Component Example: 1
    * @response scenario=success {
    *     id: 1,
    *     "component_name": "Common Service Configuration",
    *     "component_name_bn": "কমন সার্ভিস কনফিগারেশন",
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
   * @urlParam id integer required The ID of the Component Example: 1
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
      Cache::store('redis')->forget('components');
      Cache::store('redis')->forget('orgComponents');
      App::make('componentList');
      App::make('orgComponentList');
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
      Cache::store('redis')->forget('components');
      App::make('componentList');
    }
    return $data;
  }
}