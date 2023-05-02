<?php

namespace App\Http\Controllers\OrgProfile;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\OrgProfile\MasterUnion;
use App\Http\Validations\OrgProfile\MasterUnionValidations;
use Illuminate\Support\Facades\{Cache, App};
use App\Repositories\Repository;

class MasterUnionController extends Controller
{
  // space that we can use the repository from
  protected $model;

  public function __construct(MasterUnion $MasterUnion)
  {
      // set the model
      $this->model = new Repository($MasterUnion);
  }

   /**
   * @queryParam union_name Filter by English or Bangla Name of the Union Example: Bhotmary
   * @queryParam union_name_bn Filter by English or Bangla Name of the Union Example: ভোটমারী
   * @queryParam division_id Filter by Union Example: 1
   * @queryParam district_id Filter by Union Example: 1
   * @queryParam upazila_id Filter by Union Example: 1
   * @queryParam limit int Example: 10
  */
  public function list($columns = ['*'], $limit = 10)
  {
    $searchable = [
      'union_name' => array(
        'union_name' => 'like',
        'union_name_bn' => 'orLike',
      ),
      'division_id', 'district_id', 'upazila_id'
    ];
    return $this->model->paginate($columns, $searchable, [], $limit);
  }

   /**
   * @queryParam union_name Filter by English or Bangla Name of the Union Example: Bhotmary
   * @queryParam union_name_bn Filter by English or Bangla Name of the Union Example: ভোটমারী
   * @queryParam division_id Filter by Union Example: 1
   * @queryParam district_id Filter by Union Example: 1
   * @queryParam upazila_id Filter by Union Example: 1
  */
  public function getAll($columns = ['*'])
  {
    $searchable = [
        'union_name' => array(
          'union_name' => 'like',
          'union_name_bn' => 'orLike',
        ),
        'division_id', 'district_id', 'upazila_id'
      ];
    return $this->model->getAll($columns, $searchable, [], ['created_at'=> 'DESC']);
  }
  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 4,
    *     "division_id": "1",
    *     "district_id": "1",
    *     "upazilla_id": "1",
    *     "union_name": "Bhotmary",
    *     "union_name_bn": "ভোটমারী",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam union_name string required The English Union Name of the UNION Example: Bhotmary.
    * @bodyParam union_name_bn string required The Bangla Union Name Bn of the UNION Example: ভোটমারী.
    * @bodyParam division_id integer UNION Example: 1
    * @bodyParam district_id integer UNION Example: 1
    * @bodyParam upazila_id integer UNION Example: 1
    * @bodyParam union_code integer auto generate Union Code Example: 2222
    * ......
  */
  public function store(Request $request)
  {
    $validationResult = MasterUnionValidations::validate($request);

    if (!$validationResult['success']) {
      return response($validationResult);
    }

    $requestAll = $request->all();
    $data = $this->model->create($requestAll);

    if ($data['success']) {
      Cache::store('redis')->forget('unions');
      App::make('unionList');
    }

    return $data;
  }

  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 4,
    *     "division_id": "1",
    *     "district_id": "1",
    *     "upazilla_id": "1",
    *     "union_name": "Bhotmary",
    *     "union_name_bn": "ভোটমারী",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam union_name string required The English Union Name of the UNION Example: Bhotmary.
    * @bodyParam union_name_bn string required The Bangla Union Name Bn of the UNION Example: ভোটমারী.
    * @bodyParam division_id integer UNION Example: 1
    * @bodyParam district_id integer UNION Example: 1
    * @bodyParam upazila_id integer UNION Example: 1
    * @bodyParam union_code integer auto generate Union Code Example: 2222
    * ......
  */
  public function update(Request $request, $id)
  {
    $validationResult = MasterUnionValidations::validate($request, $id);
    if (!$validationResult['success']) {
      return response($validationResult);
    }

    $requestAll = $request->all();
    $data = $this->model->update($requestAll, $id);

    if ($data['success']) {
      Cache::store('redis')->forget('unions');
      App::make('unionList');
    }
    return $data;
  }

  /**
    * @urlParam id integer required The ID of the Master Component.
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    *     id: 4,
    *     "division_id": "1",
    *     "district_id": "1",
    *     "upazilla_id": "1",
    *     "union_name": "Bhotmary",
    *     "union_name_bn": "ভোটমারী",
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
      Cache::store('redis')->forget('unions');
      App::make('unionList');
    }
    return $data;
  }

  /**
   * @urlParam id integer required The ID of the Master Division.
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
      Cache::store('redis')->forget('unions');
      App::make('unionList');
    }
    return $data;
  }
}
