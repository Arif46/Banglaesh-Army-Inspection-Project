<?php

namespace App\Http\Controllers\OrgProfile;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\OrgProfile\MasterCityCorporation;
use App\Http\Validations\OrgProfile\MasterCityCorporationValidations;
use Illuminate\Support\Facades\{Cache, App};
use App\Repositories\Repository;

class MasterCityCorporationController extends Controller
{
    // space that we can use the repository from
  protected $model;

  public function __construct(MasterCityCorporation $MasterCityCorporation)
  {
      // set the model
      $this->model = new Repository($MasterCityCorporation);
  }

  /**
   * @queryParam city_corporation_name Filter by English or Bangla Name of the Corporation Corporations Example: Dhaka City Corporation
   * @queryParam city_corporation_name_bn Filter by English or Bangla Description of the Corporation Corporations Example: ঢাকা সিটি কর্পোরেশন
   * @queryParam division_id Filter by English or Bangla Description of the Corporation Corporations Example: 1
   * @queryParam district_id Filter by English or Bangla Description of the Corporation Corporations Example: 1
  */
  public function list($columns = ['*'], $limit = 10)
  {
    $searchable = [
      'city_corporation_name' => array(
        'city_corporation_name' => 'like',
        'city_corporation_name_bn' => 'orLike',
      ),
      'division_id',
      'district_id'
    ];
    return $this->model->paginate($columns, $searchable, [], $limit);
  }

  /**
   * @queryParam content Filter by content in List.
  */
  public function getAll($columns = ['*'])
  {
    $searchable = [
        'city_corporation_name' => array(
          'city_corporation_name' => 'like',
          'city_corporation_name_bn' => 'orLike',
        ),
        'division_id',
        'district_id'
      ];
    return $this->model->getAll($columns, $searchable, [], ['created_at'=> 'DESC']);
  }
  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 1,
    *     "division_id": "1",
    *     "district_id": "1",
    *     "city_corporation_name": "Dhaka City Corporation",
    *     "city_corporation_name_bn": "ঢাকা সিটি কর্পোরেশন",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam city_corporation_name string required The English Corporation Corporation Name of the Corporation Corporations Example: Common Service Configuration.
    * @bodyParam city_corporation_name_bn string required The Bangla Corporation Corporation of the Corporation Corporations  Example: কমন সার্ভিস কনফিগারেশন.
    * @bodyParam division_id string required The Division Id of the Corporation Corporations Example: 1
    * @bodyParam district_id string required The District Id of the Corporation Corporations Example: 1 .....
  */
  public function store(Request $request)
  {
    $validationResult = MasterCityCorporationValidations::validate($request);

    if (!$validationResult['success']) {
      return response($validationResult);
    }
    // return $request->all();
    $requestAll = $request->all();
    $data = $this->model->create($requestAll);

    if ($data['success']) {
      Cache::store('redis')->forget('cityCorporations');
      App::make('cityCorporationList');
    }

    return $data;
  }

  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 1,
    *     "division_id": "1",
    *     "district_id": "1",
    *     "city_corporation_name": "Dhaka City Corporation",
    *     "city_corporation_name_bn": "ঢাকা সিটি কর্পোরেশন",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam city_corporation_name string required The English Corporation Corporation Name of the Corporation Corporations Example: Common Service Configuration.
    * @bodyParam city_corporation_name_bn string required The Bangla Corporation Corporation of the Corporation Corporations  Example: কমন সার্ভিস কনফিগারেশন.
    * @bodyParam division_id string required The Division Id of the Corporation Corporations Example: 1
    * @bodyParam district_id string required The District Id of the Corporation Corporations Example: 1 .....
  */
  public function update(Request $request, $id)
  {
    $validationResult = MasterCityCorporationValidations::validate($request, $id);
    if (!$validationResult['success']) {
      return response($validationResult);
    }

    $requestAll = $request->all();
    $data = $this->model->update($requestAll, $id);

    if ($data['success']) {
      Cache::store('redis')->forget('cityCorporations');
      App::make('cityCorporationList');
    }
    return $data;
  }

  /**
    * @urlParam id integer required The ID of the Master District.
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    *     id: 4,
    *     "division_id": "1",
    *     "district_id": "1",
    *     "city_corporation_name": "Dhaka City Corporation",
    *     "city_corporation_name_bn": "ঢাকা সিটি কর্পোরেশন",
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
   * @urlParam id integer required The ID of the Master City Corporation.
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
      Cache::store('redis')->forget('cityCorporations');
      App::make('cityCorporationList');
    }
    return $data;
  }

  /**
   * @urlParam id integer required The ID of the Master City Corporation.
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
      Cache::store('redis')->forget('cityCorporations');
      App::make('cityCorporationList');
    }
    return $data;
  }
}
