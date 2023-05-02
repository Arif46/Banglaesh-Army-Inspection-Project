<?php

namespace App\Http\Controllers\Organogram;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Organogram\MasterAssignDesignation;
use App\Http\Validations\Organogram\MasterAssignDesignValidation;
use Illuminate\Support\Facades\{Cache, App};
use App\Repositories\Repository;
use DB;

class MasterAssignDesignationController extends Controller
{
    // space that we can use the repository from
  protected $model;

  public function __construct(MasterAssignDesignation $MasterAssignDesignation)
  {
      // set the model
      $this->model = new Repository($MasterAssignDesignation);
  }

   /**
   * @queryParam org_id Filter by Assign Designation Example: 1
   * @queryParam office_type_id Filter by Assign Designation Example: 1
   * @queryParam office_id Filter by Assign Designation Example: 1
   * @queryParam designation_id Filter by Assign Designation Example: 1
   * @queryParam limit int Example: 10
  */
  public function index($columns = ['*'], $limit = 10)
  {
    $searchable = [
        'org_id', 'office_type_id', 'office_id', 'designation_id'
    ];
    return $this->model->paginate($columns, $searchable, [], $limit);
  }

  /**
   * @queryParam org_id Filter by Assign Designation Example: 1
   * @queryParam office_type_id Filter by Assign Designation Example: 1
   * @queryParam office_id Filter by Assign Designation Example: 1
   * @queryParam designation_id Filter by Assign Designation Example: 1
   * @queryParam approved_post Filter by Assign Designation Example: 1
   * @queryParam sorting_order Filter by Assign Designation Example: 1
  */
  public function getAll($columns = ['*'])
  {
    $list = DB::table('assign_designations')
            ->select("assign_designations.*")
            ->get();

    if (!$list) {
      return response([
        'success' => false,
        'message' => 'Data Not Found'
      ]);
    } else {
      return response([
          'success' => true,
          'message' => 'Master assign designation Get All Data',
          'data'    => $list
      ]);
    }  
  }
  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 4,
    *     "org_id": "1",
    *     "office_type_id": "1",
    *     "office_id": "1",
    *     "designation_id": "1",
    *     "approved_post": "1",
    *     "sorting_order": "1",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam org_id integer Assign Desingation Example: 1
    * @bodyParam office_type_id integer Assign Desingation Example: 1
    * @bodyParam office_id integer Assign Desingation Example: 1
    * @bodyParam designation_id integer Assign Desingation Code Example: 1
    * @bodyParam approved_post integer Assign Desingation Code Example: 1
    * @bodyParam sorting_order integer Assign Desingation Code Example: 1
    * ......
  */
  public function store(Request $request)
  {
    $validationResult = MasterAssignDesignValidation::validate($request);

    if (!$validationResult['success']) {
      return response($validationResult);
    }

    $requestAll = $request->all();

    $data = $this->model->create($requestAll);

    if ($data['success']) {
      Cache::store('redis')->forget('assignDesignation');
      App::make('assignDesignationList');
    }

    return $data;
  }

  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 4,
    *     "org_id": "1",
    *     "office_type_id": "1",
    *     "office_id": "1",
    *     "designation_id": "1",
    *     "approved_post": "1",
    *     "sorting_order": "1",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam org_id integer Assign Desingation Example: 1
    * @bodyParam office_type_id integer Assign Desingation Example: 1
    * @bodyParam office_id integer Assign Desingation Example: 1
    * @bodyParam designation_id integer Assign Desingation Code Example: 1
    * @bodyParam approved_post integer Assign Desingation Code Example: 1
    * @bodyParam sorting_order integer Assign Desingation Code Example: 1
    * ......
  */
  public function update(Request $request, $id)
  {
    $validationResult = MasterAssignDesignValidation::validate($request, $id);
    if (!$validationResult['success']) {
      return response($validationResult);
    }

    $requestAll = $request->all();
    $data = $this->model->update($requestAll, $id);

    if ($data['success']) {
      Cache::store('redis')->forget('assignDesignation');
      App::make('assignDesignationList');
    }

    return $data;
  }

  /**
    * @urlParam id integer required The ID of the assgin designation.
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    *     id: 4,
    *     "org_id": "1",
    *     "office_type_id": "1",
    *     "office_id": "1",
    *     "designation_id": "1",
    *     "approved_post": "1",
    *     "sorting_order": "1",
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
   * @urlParam id integer required The ID of the Assign Designation.
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

    return $data;
  }

  /**
   * @urlParam id integer required The ID of the Assign Designation.
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
      Cache::store('redis')->forget('assignDesignation');
      App::make('assignDesignationList');
  }
    return $data;
  }
}
