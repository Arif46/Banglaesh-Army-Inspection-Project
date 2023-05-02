<?php

namespace App\Http\Controllers\OrgProfile;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\OrgProfile\MasterMunicipality;
use App\Http\Validations\OrgProfile\MasterMunicipalityValidations;
use Illuminate\Support\Facades\{Cache, App};
use App\Repositories\Repository;

class MasterMunicipalityController extends Controller
{
    // space that we can use the repository from
  protected $model;

  public function __construct(MasterMunicipality $MasterMunicipality)
  {
      // set the model
      $this->model = new Repository($MasterMunicipality);
  }

  /**
   * @queryParam pauroshoba_name Filter by English or Bangla Name of the Municipality Example: Savar
   * @queryParam pauroshoba_name_bn Filter by English or Bangla Name of the Municipality Example: সাভার
   * @queryParam division_id Filter by English or Bangla Description of the Municipality Example: 1
   * @queryParam district_id Filter by English or Bangla Description of the Municipality Example: 1
   * @queryParam upazila_id Filter by English or Bangla Description of the Municipality Example: 1
  */
  public function list($columns = ['*'], $limit = 10)
  {
    $searchable = [
      'pauroshoba_name' => array(
        'pauroshoba_name' => 'like',
        'pauroshoba_name_bn' => 'orLike',
      ),
      'division_id',
      'district_id',
      'upazila_id'
    ];
    return $this->model->paginate($columns, $searchable, [], $limit);
  }

  /**
   * @queryParam content Filter by content in List.
  */
  public function getAll($columns = ['*'])
  {
    $searchable = [
        'pauroshoba_name' => array(
          'pauroshoba_name' => 'like',
          'pauroshoba_name_bn' => 'orLike',
        ),
        'division_id',
        'district_id',
        'upazila_id'
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
    *     "upazila_id": "1",
    *     "pauroshoba_name": "Savar",
    *     "pauroshoba_name_bn": "সাভার",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam pauroshoba_name string required The English Municipality Name of the Municipality Example: Savar.
    * @bodyParam pauroshoba_name_bn string required The Bangla Municipality Name of the Municipality  Example: সাভার.
    * @bodyParam division_id string required The Division Id of the Municipality Example: 1
    * @bodyParam district_id string required The District Id of the Municipality Example: 1
    * @bodyParam upazila_id string required The District Id of the Municipality Example: 1
  */
  public function store(Request $request)
  {
    $validationResult = MasterMunicipalityValidations::validate($request);

    if (!$validationResult['success']) {
      return response($validationResult);
    }
    // return $request->all();
    $requestAll = $request->all();
    $data = $this->model->create($requestAll);

    if ($data['success']) {
      Cache::store('redis')->forget('municipalities');
      App::make('municipalityList');
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
    *     "upazila_id": "1",
    *     "pauroshoba_name": "Savar",
    *     "pauroshoba_name_bn": "সাভার",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam pauroshoba_name string required The English Municipality Name of the Municipality Example: Savar.
    * @bodyParam pauroshoba_name_bn string required The Bangla Municipality of the Municipality  Example: সাভার.
    * @bodyParam division_id string required The Division Id of the Municipality Example: 1
    * @bodyParam district_id string required The District Id of the Municipality Example: 1
    * @bodyParam upazila_id string required The District Id of the Municipality Example: 1
  */
  public function update(Request $request, $id)
  {
    $validationResult = MasterMunicipalityValidations::validate($request, $id);
    if (!$validationResult['success']) {
      return response($validationResult);
    }

    $requestAll = $request->all();
    $data = $this->model->update($requestAll, $id);

    if ($data['success']) {
      Cache::store('redis')->forget('municipalities');
      App::make('municipalityList');
    }
    return $data;
  }

  /**
    * @urlParam id integer required The ID of the Master Municipality.
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    *     id: 4,
    *     "division_id": "1",
    *     "district_id": "1",
    *     "upazila_id": "1",
    *     "pauroshoba_name": "Savar",
    *     "pauroshoba_name_bn": "সাভার",
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
   * @urlParam id integer required The ID of the Master Municipality.
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
      Cache::store('redis')->forget('municipalities');
      App::make('municipalityList');
    }
    return $data;
  }

  /**
   * @urlParam id integer required The ID of the Master Municipality.
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
      Cache::store('redis')->forget('municipalities');
      App::make('municipalityList');
    }
    return $data;
  }
}
