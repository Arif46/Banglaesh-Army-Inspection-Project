<?php

namespace App\Http\Controllers\Organogram;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Organogram\MasterOfficeType;
use App\Http\Validations\Organogram\MasterOfficeTypeValidations;
use Illuminate\Support\Facades\{Cache, App};
use App\Repositories\Repository;

class MasterOfficeTypeController extends Controller
{
    // space that we can use the repository from
  protected $model;

  public function __construct(MasterOfficeType $MasterOfficeType)
  {
      // set the model
      $this->model = new Repository($MasterOfficeType);
  }

  /**
   * @queryParam office_type_name Filter by English or Bangla Name of the Office Type Example: District Office
   * @queryParam office_type_name_bn Filter by English or Bangla Name of the Office Type Example: জেলা অফিস
   * @queryParam org_id Filter by English or Bangla Name of the Office Type Example: 1
  */
  public function list($columns = ['*'], $limit = 10)
  {
    $searchable = [
      'office_type_name' => array(
        'office_type_name' => 'like',
        'office_type_name_bn' => 'orLike',
      ),
      'org_id'
    ];
    return $this->model->paginate($columns, $searchable, [], $limit);
  }

  /**
   * @queryParam content Filter by content in List.
  */
  public function getAll($columns = ['*'])
  {
    $searchable = [
        'office_type_name' => array(
          'office_type_name' => 'like',
          'office_type_name_bn' => 'orLike',
        ),
        'org_id'
      ];
    return $this->model->getAll($columns, $searchable, [], ['created_at'=> 'DESC']);
  }
  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 1,
    *     "org_id": "1"
    *     "office_type_name": "District Office",
    *     "office_type_name_bn": "জেলা অফিস",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam office_type_name string required The English Office Type Name of the Office Type Example: District Office.
    * @bodyParam office_type_name_bn string required The Bangla Office Type Name of the Office Type  Example: জেলা অফিস.
    * @bodyParam org_id string required The Division Id of the Office Type Example: 1
  */
  public function store(Request $request)
  {
    $validationResult = MasterOfficeTypeValidations::validate($request);

    if (!$validationResult['success']) {
      return response($validationResult);
    }
    $requestAll = $request->all();
    $data = $this->model->create($requestAll);

    if ($data['success']) {
      Cache::store('redis')->forget('officeTypes');
      App::make('officeTypeList');
    }

    return $data;
  }

  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 1,
    *     "org_id": "1",
    *     "office_type_name": "District Office",
    *     "office_type_name_bn": "জেলা অফিস",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam office_type_name string required The English Office Type Name of the Office Type Example: District Office.
    * @bodyParam office_type_name_bn string required The Bangla Office Type of the Office Type  Example: জেলা অফিস.
    * @bodyParam org_id string required The Division Id of the Office Type Example: 1
  */
  public function update(Request $request, $id)
  {
    $validationResult = MasterOfficeTypeValidations::validate($request, $id);
    if (!$validationResult['success']) {
      return response($validationResult);
    }

    $requestAll = $request->all();
    $data = $this->model->update($requestAll, $id);

    if ($data['success']) {
      Cache::store('redis')->forget('officeTypes');
      App::make('officeTypeList');
    }
    return $data;
  }

  /**
    * @urlParam id integer required The ID of the Master Office Type.
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    *     id: 4,
    *     "org_id": "1",
    *     "office_type_name": "District Office",
    *     "office_type_name_bn": "জেলা অফিস",
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
   * @urlParam id integer required The ID of the Master Office Type.
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
      Cache::store('redis')->forget('officeTypes');
      App::make('officeTypeList');
    }
    return $data;
  }

  /**
   * @urlParam id integer required The ID of the Master Office Type.
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
      Cache::store('redis')->forget('officeTypes');
      App::make('officeTypeList');
    }
    return $data;
  }
}
