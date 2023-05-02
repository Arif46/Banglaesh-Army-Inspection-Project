<?php

namespace App\Http\Controllers\NotificationManagement;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\NotificationManagement\NotificationTemplate;
use App\Http\Validations\NotificationManagement\NotificationTemplateValidation;
use Illuminate\Support\Facades\{Cache, App};
use App\Repositories\Repository;

class NotificationTemplateController extends Controller
{
  // space that we can use the repository from
  protected $model;

  public function __construct(NotificationTemplate $NotificationTemplate)
  {
    // set the model
    $this->model = new Repository($NotificationTemplate);
  }

  /**
   * @queryParam template Filter by Notification Template En or Bn in List.
  */
  public function list($columns = ['*'], $limit = 10)
  { 
    $searchable = [
        'template',
        'mobile_text',
        'email_web_text',
    ];
    return $this->model->paginate($columns, $searchable, [], 10);
  }
  
  /**
   * @queryParam template Filter by Notification Template En or Bn in List.
   * @queryParam mobile_text Filter by Notification mobile_text En or Bn in List.
   * @queryParam email_web_text Filter by Notification email_web_text En or Bn in List.
  */
  public function getAll($columns = ['*'])
  {
    $searchable = [
        'template',
        'mobile_text',
        'email_web_text',
    ];
    return $this->model->getAll($columns, $searchable, [], ['created_at'=> 'DESC']);
  }
  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 1,
    *     "template": "Bangladesh",
    *     "mobile_text": "বাংলাদেশ",
    *     "email_web_text": "বাংলাদেশ",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam not_type_name string required The Notification Template of the NotificationTemplate.
    * ......
  */
  public function store(Request $request)
  {
    $validationResult = NotificationTemplateValidation::validate($request);  

    if (!$validationResult['success']) {
      return response($validationResult);
    }
    
    $requestAll = $request->all();      
    $data = $this->model->create($requestAll);

    if ($data['success']) {
        Cache::store('redis')->forget('notificationTemplates');
        App::make('notificationTemplateList');
    }

    return $data;
  }
  
  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 1,
    *     "template": "Bangladesh",
    *     "mobile_text": "01687070714",
    *     "email_web_text": "admin@gmail.com",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam template string required The Division Name of the NotificationTemplate.
    * @bodyParam mobile_text string required The Division Name of the NotificationTemplate.
    * @bodyParam email_web_text string required The Division Name of the NotificationTemplate.

    * ......
  */
  public function update(Request $request, $id)
  {
    $validationResult = NotificationTemplateValidation::validate($request, $id);    
    if (!$validationResult['success']) {
      return response($validationResult);
    } 

    $requestAll = $request->all();
    $data = $this->model->update($requestAll, $id);

    if ($data['success']) {
        Cache::store('redis')->forget('notificationTemplates');
        App::make('notificationTemplateList');
    }
    return $data;
  }

  /**
    * @urlParam id integer required The ID of the Master Country.
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    *     id: 1,
    *    "template": "Bangladesh",
    *     "mobile_text": "01687070714",
    *     "email_web_text": "admin@gmail.com",
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
        Cache::store('redis')->forget('notificationTemplates');
        App::make('notificationTemplateList');
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
        Cache::store('redis')->forget('notificationTemplates');
        App::make('notificationTemplateList');
    }
    return $data;
  }
}
