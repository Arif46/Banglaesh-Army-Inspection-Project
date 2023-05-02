<?php

namespace App\Http\Controllers;

use App\Helpers\Base64FileUpload;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\{Cache,App};
use App\Repositories\Repository;
use App\Models\Menu\MasterComponent;
use App\Http\Validations\Menu\MasterComponentValidations;
use App\Helpers\FileUpload;
use Validator;

class DemoController extends Controller
{
  // space that we can use the repository from
  protected $model;

  public function __construct(MasterComponent $MasterComponent)
  {
    // set the model
    $this->model = new Repository($MasterComponent);
  }

  /**
   * @queryParam title Filter by title in List.
   * @queryParam content Filter by content in List.
  */
  public function index($columns = ['*'], $limit = 10)
  {
    $conditions = [];
    if (request()->title) {
      $conditions[] = ['title', request()->title];
    }
    if (request()->content) {
      $conditions[] = ['content', request()->content];
    }

    return $this->model->paginate($columns, $conditions, ['user:id,name'], $limit);
  }

  /**
   * @queryParam title Filter by title in List.
   * @queryParam content Filter by content in List.
  */
  public function getAll($columns = ['*'])
  {
    $conditions = [];
    if (request()->title) {
      $conditions[] = ['title', request()->title];
    }
    if (request()->content) {
      $conditions[] = ['content', request()->content];
    }
    return $this->model->getAll($columns, $conditions, ['user:id,name'], ['created_at'=> 'DESC']);
  }

  /**
   * @queryParam title Filter by title in List.
   * @queryParam content Filter by content in List.
  */
  public function all()
  {
    $data = $this->model->all(['id', 'title','content']);
    return $data;
  }

  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 4,
    *     "user_id": 2,
    *     "content": "Description"
    *     "status": "1"
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam user_id int required The id of the user. Example: 9
    * @bodyParam title string required The title of the MasterComponent.
    * @bodyParam body string required The content of the MasterComponent.
    * @bodyParam image file required The image.
    * @bodyParam cars object[] List of cars
    * @bodyParam cars[].year string The year the car was made. Example: 1997
    * @bodyParam cars[].make string The make of the car. Example: Toyota
    * @bodyParam cars[].file file required The cars[].file.
  */
  public function store(Request $request)
  {   
    $validationResult = MasterComponentValidations::validate($request);    
    if (!$validationResult['success']) {
      return response($validationResult);
    }  

    $requestAll = $request->all();      
    /*
      // Single Image upload
      $image = Base64FileUpload::uploadImage($request, 'image', '/demo-new/image', null, 100, 80);  
      $requestAll['image'] = $image['success'] ? $image['data']: '';
 
      // Single File upload
      $file = Base64FileUpload::uploadFile($request, 'file', '/demo-new/file');
      $requestAll['file'] = $file['success'] ? $file['data']: '';
       
      // Multiple File upload
      $details=array();
      if(!empty($requestAll['details'])){
        $details=$requestAll['details'];
        foreach ($details as $key=>$value){
          if(!empty($value['attachment'])){
            $details[$key]['attachment']= FileUpload::multipleUploadFile($value['attachment'], '/demo-new/multiple-file', $value['pre_attachment'] ?? '');
          } else {
            $details[$key]['attachment'] = $value['pre_attachment'];
          }
        }
      }
      $requestAll['details'] = $details;

      // Multiple Image upload
      $details=array();
      if(!empty($requestAll['details'])){
        $details=$requestAll['details'];
        foreach ($details as $key=>$value){
          if(!empty($value['attachment'])){
            $details[$key]['attachment']= FileUpload::imageUpload($value['attachment'], '/demo-new/multiple-file', $value['pre_attachment'] ?? '', 200, 100);
          } else {
            $details[$key]['attachment'] = $value['pre_attachment'];
          }
        }
        $requestAll['details'] = $details;
      }
    */

    $data = $this->model->create($requestAll);
    if ($data['success']) {
      Cache::store('redis')->forget('MasterComponentData');
      App::make('MasterComponentList');
    }

    return $data;
  }
  
  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 4,
    *     "user_id": 2,
    *     "content": "Description"
    *     "status": "1"
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam user_id int required The id of the user. Example: 9
    * @bodyParam title string required The title of the MasterComponent.
    * @bodyParam body string required The content of the MasterComponent.
    * @bodyParam cars object[] List of cars
    * @bodyParam cars[].year string The year the car was made. Example: 1997
    * @bodyParam cars[].make string The make of the car. Example: Toyota
  */
  public function update(Request $request, $id)
  {
    $validationResult = MasterComponentValidations::validate($request);    
    if (!$validationResult['success']) {
      return response($validationResult);
    }
    $requestAll = $request->all(); 
    $data = $this->model->update($requestAll, $id);

    if ($data['success']) {
      Cache::store('redis')->forget('demo');
      App::make('demoList');
    }
    return $data;
  }

  /**
    * @urlParam id integer required The ID of the MasterComponent.
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    *     id: 4,
    *     "user_id": 2,
    *     "content": "Description"
    *     "status": "1"
    * }
    * @response scenario="Failed" {
    *  "message": "Data not found"
    * }
  */
  public function show($id)
  {
    return $this->model->show($id, $columns = ['id', 'title', 'user_id'], ['user:id,name']);
  }

  /**
   * @urlParam id integer required The ID of the MasterComponent.     
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
      Cache::store('redis')->forget('demo');
      App::make('demoList');
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
      Cache::store('redis')->forget('demo');
      App::make('demoList');
    }
    return $data;
  }
}