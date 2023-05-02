<?php

namespace App\Http\Controllers\NotificationManagement;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\NotificationManagement\NotificationType;
use App\Http\Validations\NotificationManagement\NotificationTypeValidation;
use Illuminate\Support\Facades\{Cache, App};
use App\Repositories\Repository;

class NotificationTypeController extends Controller
{
  // space that we can use the repository from
  protected $model;

  public function __construct(NotificationType $NotificationType)
  {
    // set the model
    $this->model = new Repository($NotificationType);
  }

  /**
   * @queryParam not_type_name Filter by Notification Type En or Bn in List.
  */
  public function list($columns = ['*'], $limit = 10)
  {
    $searchable = [
      'not_type_name' => array(
        'not_type_name' => 'like',
        'not_type_name_bn' => 'orLike',
      )
    ];
    return $this->model->paginate($columns, $searchable, [], 10);
  }
  
  /**
   * @queryParam not_type_name Filter by Notification Type En or Bn in List.
  */
  public function getAll($columns = ['*'])
  {
    $searchable = [
        'not_type_name' => array(
            'not_type_name' => 'like',
            'not_type_name_bn' => 'orLike',
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
    *     "not_type_name": "Bangladesh",
    *     "not_type_name_bn": "বাংলাদেশ",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam not_type_name string required The Notification Type of the NotificationType.
    * ......
  */
  public function store(Request $request)
  {
    $validationResult = NotificationTypeValidation::validate($request);  

    if (!$validationResult['success']) {
      return response($validationResult);
    }
    
    $requestAll = $request->all();      
    $data = $this->model->create($requestAll);

    if ($data['success']) {
      Cache::store('redis')->forget('notificationTypes');
      App::make('notificationTypeList');
    }

    return $data;
  }
  
  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 1,
    *     "not_type_name": "Bangladesh",
    *     "not_type_name_bn": "বাংলাদেশ",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam division_name string required The Division Name of the NotificationType.
    * ......
  */
  public function update(Request $request, $id)
  {
    $validationResult = NotificationTypeValidation::validate($request, $id);    
    if (!$validationResult['success']) {
      return response($validationResult);
    } 

    $requestAll = $request->all();
    $data = $this->model->update($requestAll, $id);

    if ($data['success']) {
        Cache::store('redis')->forget('notificationTypes');
        App::make('notificationTypeList');
      }
    return $data;
  }

  /**
    * @urlParam id integer required The ID of the Master Country.
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    *     id: 1,
    *    "not_type_name": "Bangladesh",
    *     "not_type_name_bn": "বাংলাদেশ",
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
        Cache::store('redis')->forget('notificationTypes');
        App::make('notificationTypeList');
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
        Cache::store('redis')->forget('notificationTypes');
        App::make('notificationTypeList');
    }
    return $data;
  }
}
