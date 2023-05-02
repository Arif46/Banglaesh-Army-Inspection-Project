<?php

namespace App\Http\Controllers\OrgProfile;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\OrgProfile\MasterDistrict;
use App\Http\Validations\OrgProfile\MasterDistrictValidations;
use Illuminate\Support\Facades\{Cache, App};
use App\Repositories\Repository;

class MasterDistrictController extends Controller
{
    // space that we can use the repository from
  protected $model;

  public function __construct(MasterDistrict $MasterDistrict)
  {
      // set the model
      $this->model = new Repository($MasterDistrict);
  }

  /**
   * @queryParam district_name Filter by English or Bangla Name of the district Example: Lalmonirhat
   * @queryParam district_name Filter by English or Bangla Description of the district Example: লালমনিরহাট
   * @queryParam division_id Filter by district Example: 1
   * @queryParam limit int Example: 10
  */
  public function list($columns = ['*'], $limit = 10)
  {
    $searchable = [
      'district_name' => array(
        'district_name' => 'like',
        'district_name_bn' => 'orLike',
      ),
      'division_id'
    ];
    return $this->model->paginate($columns, $searchable, [], $limit);
  }

   /**
   * @queryParam district_name Filter by English or Bangla Name of the district Example: Lalmonirhat
   * @queryParam district_name Filter by English or Bangla Description of the district Example: লালমনিরহাট
   * @queryParam division_id Filter by district Example: 1
  */
  public function getAll($columns = ['*'])
  {
    $searchable = [
        'district_name' => array(
          'district_name' => 'like',
          'district_name_bn' => 'orLike',
        ),
        'division_id'
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
    *     "district_name": "Lalmonirhat",
    *     "district_name": "লালমনিরহাট",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam district_name string required The English District Name of the District Example: lalmonirhat.
    * @bodyParam district_name_bn string required The Bangla District Name Bn of the District Example: লালমনিরহাট.
    * @bodyParam division_id integer District Example: 1
    * @bodyParam district_code integer auto generate District Code Example: 1111
    * ......
  */
  public function store(Request $request)
  {
    $validationResult = MasterDistrictValidations::validate($request);

    if (!$validationResult['success']) {
      return response($validationResult);
    }
    // return $request->all();
    $requestAll = $request->all();
    $data = $this->model->create($requestAll);

    if ($data['success']) {
      Cache::store('redis')->forget('districts');
      App::make('districtList');
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
    *     "district_name": "Lalmonirhat",
    *     "district_name": "লালমনিরহাট",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam district_name string required The English District Name of the District Example: lalmonirhat.
    * @bodyParam district_name_bn string required The Bangla District Name Bn of the District Example: লালমনিরহাট.
    * @bodyParam division_id integer District Example: 1
    * @bodyParam district_code integer auto generate District Code Example: 1111
    * ......
  */
  public function update(Request $request, $id)
  {
    $validationResult = MasterDistrictValidations::validate($request, $id);
    if (!$validationResult['success']) {
      return response($validationResult);
    }

    $requestAll = $request->all();
    $data = $this->model->update($requestAll, $id);

    if ($data['success']) {
      Cache::store('redis')->forget('districts');
      App::make('districtList');
    }
    return $data;
  }

  /**
    * @urlParam id integer required The ID of the Master District.
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    *     id: 4,
    *     "division_id": "1",
    *     "district_name": "Lalmonirhat",
    *     "district_name": "লালমনিরহাট",
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
   * @urlParam id integer required The ID of the Master District.
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
      Cache::store('redis')->forget('districts');
      App::make('districtList');
    }
    return $data;
  }

  /**
   * @urlParam id integer required The ID of the Master District.
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
      Cache::store('redis')->forget('districts');
      App::make('districtList');
    }
    return $data;
  }
}
