<?php

namespace App\Http\Controllers\OrgProfile;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\OrgProfile\MasterDivision;
use App\Http\Validations\OrgProfile\MasterDivisionValidations;
use Illuminate\Support\Facades\{Cache, App};
use App\Repositories\Repository;


class MasterDivisionController extends Controller
{
  // space that we can use the repository from
  protected $model;

  public function __construct(MasterDivision $MasterDivision)
  {
      // set the model
      $this->model = new Repository($MasterDivision);
  }

  /**
   * @queryParam division_name Filter by English or Bangla Name of the Division Example: Rangpur
   * @queryParam division_name_bn Filter by English or Bangla Division Name of the Division Example: রংপুর
   * @queryParam limit int Example: 10
  */
  public function list($columns = ['*'], $limit = 10)
  {
    $searchable = [
      'division_name' => array(
        'division_name' => 'like',
        'division_name_bn' => 'orLike',
      )
    ];
    return $this->model->paginate($columns, $searchable, [], $limit);
  }

  /**
     * get all master office
     */
    public function changeSerialOrder(Request $request,$model)
    {
      $datas = $request->all();
      
      if(!empty($datas)){
        foreach($datas as $key=>$value){
          $modelName = 'App\Models\OrgProfile\\' .$model;
          $UpdateData=$modelName::where('id',$value['id'])->first();
          $UpdateData->sorting_order= $value['sorting_order'];
          $UpdateData->save();
        }
      }
      

      return response([
        'success' => true,
        'message' => 'Data save successfully',
        'data'    => $datas
      ]);
    }

  /**
   * @queryParam division_name Filter by English or Bangla Name of the Division Example: Rangpur
   * @queryParam division_name_bn Filter by English or Bangla Division Name of the Division Example: রংপুর
  */
  public function getAll($columns = ['*'])
  {
    $searchable = [
      'division_name' => array(
        'division_name' => 'like',
        'division_name_bn' => 'orLike',
      )
    ];
    return $this->model->getAll($columns, $searchable, [], ['created_at'=> 'DESC']);
  }
  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 4,
    *     "division_name": "Rangpur",
    *     "division_name_bn": "বিভাগ",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam division_name string required The English Division Name of the Division Example: Rangpur.
    * @bodyParam division_name_bn string required The Bangla Division Name of the Division Example: রংপুর.
    * ......
  */
  public function store(Request $request)
  {
    $validationResult = MasterDivisionValidations::validate($request);

    if (!$validationResult['success']) {
      return response($validationResult);
    }

    $requestAll = $request->all();
    $data = $this->model->create($requestAll);

    if ($data['success']) {
      Cache::store('redis')->forget('divisions');
      App::make('divisionList');
    }

    return $data;
  }

  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 4,
    *     "division_name": "Rangpur",
    *     "division_name_bn": "বিভাগ",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam division_name string required The English Division Name of the Division Example: Rangpur.
    * @bodyParam division_name_bn string required The Bangla Division Name of the Division Example: রংপুর.
    * ......
  */
  public function update(Request $request, $id)
  {
    $validationResult = MasterDivisionValidations::validate($request, $id);
    if (!$validationResult['success']) {
      return response($validationResult);
    }

    $requestAll = $request->all();
    $data = $this->model->update($requestAll, $id);

    if ($data['success']) {
      Cache::store('redis')->forget('divisions');
      App::make('divisionList');
    }
    return $data;
  }

  /**
    * @urlParam id integer required The ID of the Master Component.
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    *     id: 4,
    *     "division_name": "Rangpur",
    *     "division_name_bn": "বিভাগ",
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
   * @urlParam id integer required The ID of the Master Division.
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
      Cache::store('redis')->forget('divisions');
      App::make('divisionList');
    }
    return $data;
  }
  /**
   * @urlParam id integer required The ID of the MasterComponent.     
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
      Cache::store('redis')->forget('divisions');
      App::make('divisionList');
    }
    return $data;
  }
}
