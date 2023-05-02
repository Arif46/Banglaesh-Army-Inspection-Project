<?php

namespace App\Http\Controllers\OrgProfile;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\{Cache, App};
use App\Repositories\Repository;
use App\Models\OrgProfile\MasterOrgProfile;
use App\Http\Validations\OrgProfile\MasterOrganizationProfileValidation;
use App\Helpers\Base64FileUpload;

class MasterOrgProfileController extends Controller
{
  // space that we can use the repository from
  protected $model;

  public function __construct(MasterOrgProfile $MasterOrgProfile)
  {
    // set the model
    $this->model = new Repository($MasterOrgProfile);
  }

  /**
   * @queryParam org_name Filter by English or Bangla Name of the organizationProfileList Example: Ministry of Agriculture
   * @queryParam establishment_year int Filter Establishment Year of the organizationProfileList Example: 1972
   * @queryParam limit int Example: 10
  */

  public function list($columns = ['*'], $limit = 10)
  { 
    $searchable = [
      'org_name' => array(
        'org_name' => 'like',
        'org_name_bn' => 'orLike',
      ),
      'establishment_year'
    ];
    return $this->model->paginate($columns, $searchable, [], $limit);
  }
  
  /**
   * @queryParam org_name Filter by English or Bangla Name of the organizationProfileList Example: Ministry of Agriculture
   * @queryParam establishment_year int Filter Establishment Year of the organizationProfileList Example: 1972
   * @queryParam limit int Example: 10
  */

  public function getAll($columns = ['*'])
  {
    
    $searchable = [
      'org_name' => array(
        'org_name' => 'like',
        'org_name_bn' => 'orLike',
      ),
      'establishment_year'
    ];
    return $this->model->getAll($columns, $searchable, [], ['created_at'=> 'DESC']);
  }

  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 1,
    *     "org_name": "Ministry of Agriculture",
    *     "org_name_bn": "কৃষি মন্ত্রণালয়",
    *     "establishment_year": "1972"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam org_name string required The English Org Name of the Organization Example: Ministry of Agriculture.
    * @bodyParam org_name_bn string required The Bangla Org Name of the Organization Example: কৃষি মন্ত্রণালয়.
    * @bodyParam establishment_year int required The Establishment Year of the Organization Example: 1972 ......
  */
  public function store(Request $request)
  {
    $validationResult = MasterOrganizationProfileValidation::validate($request);    
    if (!$validationResult['success']) {
      return response($validationResult);
    }
    $requestAll = $request->all(); 
    if ($requestAll['logo']) {
      $image = Base64FileUpload::uploadImage($requestAll, 'logo', '/org-logo', null, 100, 100);         
      $requestAll['logo'] = $image['success'] ? $image['data']: null;
    } 
    $data = $this->model->create($requestAll);

    if ($data['success']) {
      Cache::store('redis')->forget('organizationProfileList');
      App::make('orgProfileList');
    }

    return $data;
  }
  
  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 1,
    *     "org_name": "Ministry of Agriculture",
    *     "org_name_bn": "কৃষি মন্ত্রণালয়",
    *     "establishment_year": "1972"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam org_name string required The English Org Name of the Organization Example: Ministry of Agriculture.
    * @bodyParam org_name_bn string required The Bangla Org Name of the Organization Example: কৃষি মন্ত্রণালয়.
    * @bodyParam establishment_year int required The Establishment Year of the Organization Example: 1972 ......
  */

  public function update(Request $request, $id)
  {
    $validationResult = MasterOrganizationProfileValidation::validate($request, $id);    
    if (!$validationResult['success']) {
      return response($validationResult);
    } 

    $requestAll = $request->all();

    if ($requestAll['logo'] != null && isset($requestAll['logo'])) { 
      $image =  Base64FileUpload::uploadImage($requestAll, 'logo', '/org-logo', $requestAll['logo'], 100, 100);              
      $requestAll['logo'] = $image['success'] ? $image['data']: null;
    }

    $data = $this->model->update($requestAll, $id);

    if ($data['success']) {
      Cache::store('redis')->forget('organizationProfileList');
      App::make('orgProfileList');
    }
    return $data;
  }

  /**
    * @urlParam id integer required The ID of the Component Example: 1
    * @response scenario=success {
    *     id: 1,
    *     "org_name": "Ministry of Agriculture",
    *     "org_name_bn": "কৃষি মন্ত্রণালয়",
    *     "establishment_year": "1972"
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
      Cache::store('redis')->forget('organizationProfileList');
      App::make('orgProfileList');
    }
    return $data;
  }

  /**
   * @urlParam id integer required The ID of the Org Profile.     
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
      Cache::store('redis')->forget('organizationProfileList');
      App::make('orgProfileList');
    }
    return $data;
  }
}