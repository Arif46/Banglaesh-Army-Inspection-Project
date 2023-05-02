<?php

namespace App\Http\Controllers\OrgProfile;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\OrgProfile\MasterCountry;
use App\Http\Validations\OrgProfile\MasterCountryValidations;
use Illuminate\Support\Facades\{Cache, App};
use App\Repositories\Repository;

class MasterCountryController extends Controller
{
  // space that we can use the repository from
  protected $model;

  public function __construct(MasterCountry $MasterCountry)
  {
    // set the model
    $this->model = new Repository($MasterCountry);
  }

  /**
   * @queryParam country_name Filter by Country Name En or Bn in List.
  */
  public function list($columns = ['*'], $limit = 10)
  { 
    $searchable = [
      'country_name' => array(
        'country_name' => 'like',
        'country_name_bn' => 'orLike',
      ),
      'nationality' => array(
        'nationality' => 'like',
        'nationality_bn' => 'orLike',
      )
    ];
    return $this->model->paginate($columns, $searchable, [], 10);
  }
  
  /**
   * @queryParam country_name Filter by Country Name En or Bn in List.
  */
  public function getAll($columns = ['*'])
  {
    $searchable = [
      'country_name' => array(
        'country_name' => 'like',
        'country_name_bn' => 'orLike',
      ),
      'nationality' => array(
        'nationality' => 'like',
        'nationality_bn' => 'orLike',
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
    *     "country_name": "Bangladesh",
    *     "country_name_bn": "বাংলাদেশ",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam country_name string required The Country Name of the MasterCountry.
    * ......
  */
  public function store(Request $request)
  {
    $validationResult = MasterCountryValidations::validate($request);  

    if (!$validationResult['success']) {
      return response($validationResult);
    }
    
    $requestAll = $request->all();      
    $data = $this->model->create($requestAll);

    if ($data['success']) {
      Cache::store('redis')->forget('countries');
      App::make('countryList');
    }

    return $data;
  }
  
  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 1,
    *     "country_name": "Bangladesh",
    *     "country_name_bn": "বাংলাদেশ",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam division_name string required The Division Name of the MasterCountry.
    * ......
  */
  public function update(Request $request, $id)
  {
    $validationResult = MasterCountryValidations::validate($request, $id);    
    if (!$validationResult['success']) {
      return response($validationResult);
    } 

    $requestAll = $request->all();
    $data = $this->model->update($requestAll, $id);

    if ($data['success']) {
      Cache::store('redis')->forget('countries');
      App::make('countryList');
    }
    return $data;
  }

  /**
    * @urlParam id integer required The ID of the Master Country.
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    *     id: 1,
    *    "country_name": "Bangladesh",
    *     "country_name_bn": "বাংলাদেশ",
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
   * @urlParam id integer required The ID of the Master Component.     
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
      Cache::store('redis')->forget('countries');
      App::make('countryList');
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
      Cache::store('redis')->forget('countries');
      App::make('countryList');
    }
    return $data;
  }
}
