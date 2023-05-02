<?php

namespace App\Http\Controllers\External;

use App\Http\Controllers\Controller;
use App\Http\Validations\External\MasterExternalPanelValidation;
use App\Models\External\ExternalPanel;
use App\Repositories\Repository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Cache;

class MasterExternalPanelController extends Controller
{
  // space that we can use the repository from
  protected $model;

  public function __construct(ExternalPanel $externalPanel)
  {
    // Set the model
    $this->model = new Repository($externalPanel);
  }

  /**
   * @queryParam name Filter by Name in List.
  * @queryParam component_id Filter by component id in List.
  */
  public function list($columns = ['*'], $limit = 10)
  { 
    $searchable = [
      'name' => array(
        'name' => 'like',
        'name_bn' => 'orLike',
      ),
      'component_id'
    ];
    return $this->model->paginate($columns, $searchable, [], $limit);
  }

  /**
   * @queryParam component_name Filter by English or Bangla Name of the Components Example: Common Service Configuration
   * @queryParam description Filter by English or Bangla Description of the Components Example: কমন সার্ভিস কনফিগারেশন
  */
  public function getAll($columns = ['*'])
  {
    $query = ExternalPanel::whereHas('menus');
    $data = $query->orderBy('sorting_order', 'ASC')->get();

    return response([
      'success' => true,
      'data' => $data,
      'message' => 'Data Found'
    ]);
    
    // $searchable = [
    //   'name' => array(
    //     'name' => 'like',
    //     'name_bn' => 'orLike',
    //   ),
    //   'component_id'
    // ];
    // return $this->model->getAll($columns, $searchable, ['menus'], ['sorting_order'=> 'ASC']);
  }

  /**
   * @response scenario=success {
   *  "success": true,
   *  "message": "Data Saved Successfully",
   *  "data": {
   *      id: 1,
   *     "name": "name",
   *     "name_bn": "name bn",
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
   * @bodyParam component_id integer required The component_id of the MasterExternalPanel.
   * @bodyParam name string required The Name of the MasterExternalPanel.
   * @bodyParam name_bn string required The name_bn of the MasterExternalPanel
   * ......
 */
  public function store(Request $request)
  {
    
    $validationResult = MasterExternalPanelValidation::validate($request);    
    if (!$validationResult['success']) {
      return response($validationResult);
    }

    $requestAll = $request->all();

    $data = $this->model->create($requestAll);

    if ($data['success']) {
      Cache::store('redis')->forget('externalPanel');
      App::make('externalPanelList');
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
   * @bodyParam component_id integer required The component_id of the MasterExternalPanel.
   * @bodyParam name string required The Name of the MasterExternalPanel.
   * @bodyParam name_bn string required The name_bn of the MasterExternalPanel
   * ......
  */
  public function update(Request $request, $id)
  {
    $validationResult = MasterExternalPanelValidation::validate($request, $id);    
    if (!$validationResult['success']) {
      return response($validationResult);
    } 

    $requestAll = $request->all();
    $data = $this->model->update($requestAll, $id);

    if ($data['success']) {
      Cache::store('redis')->forget('externalPanel');
      App::make('externalPanelList');
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
  public function toggleStatus($id)
  {
    $data = $this->model->toggleStatus($id);

    if ($data['success']) {
      Cache::store('redis')->forget('externalPanel');
      App::make('externalPanelList');
    }
    return $data;
  }

  /**
   * Change Ordering
   */
  public function changeSerialOrder(Request $request,$model)
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
    
    Cache::store('redis')->forget('externalPanel');
    App::make('externalPanelList');

    return response([
      'success' => true,
      'message' => 'Data save successfully',
      'data'    => $datas
    ]);
  }
}
