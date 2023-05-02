<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\App;
use App\Repositories\Repository;
use App\Models\Post;
use App\Http\Validations\PostValidations;
use App\Helpers\FileUpload;
use Validator;

class PostController extends Controller
{
  // space that we can use the repository from
  protected $model;

  public function __construct(Post $post)
  {
    // set the model
    $this->model = new Repository($post);
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
    * @bodyParam title string required The title of the post.
    * @bodyParam body string required The content of the post.
    * @bodyParam image file required The image.
    * @bodyParam cars object[] List of cars
    * @bodyParam cars[].year string The year the car was made. Example: 1997
    * @bodyParam cars[].make string The make of the car. Example: Toyota
    * @bodyParam cars[].file file required The cars[].file.
  */
  public function store(Request $request)
  {
    $validationResult = PostValidations::validate($request);    
    if (!$validationResult['success']) {
      return response($validationResult);
    }
    $requestAll = $request->all();      
    /*
      // Single Image upload
      $image = FileUpload::uploadImage($request, 'image', '/demo-new/image', null, 100, 80);
      $requestAll['image'] = $image['success'] ? $image['data']: '';

      // Single File upload
      $file = FileUpload::uploadFile($request, 'file', '/demo-new/file');
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
      Cache::store('redis')->forget('postData');
      App::make('postList');
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
    * @bodyParam title string required The title of the post.
    * @bodyParam body string required The content of the post.
    * @bodyParam cars object[] List of cars
    * @bodyParam cars[].year string The year the car was made. Example: 1997
    * @bodyParam cars[].make string The make of the car. Example: Toyota
  */
  public function update(Request $request, $id)
  {
    $data = $this->model->update($request->all(), $id);
    if ($data['success']) {
      Cache::store('redis')->forget('postData');
      App::make('postList');
    }
    return $data;
  }

  /**
    * @urlParam id integer required The ID of the post.
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
   * @urlParam id integer required The ID of the post.     
   * @response scenario=success {
   *  "message": "Data deleted successfully"
   * }
   * @response scenario="Failed" {
   *  "message": "Data not found"
   * }
  */
  public function destroy($id)
  {
    return $this->model->delete($id);
  }

  /**
   * @urlParam id integer required The ID of the post.     
   * @response scenario=success {
   *  "message": "Data updated successfully"
   * }
   * @response scenario="Failed" {
   *  "message": "Data not found"
   * }
  */
  public function toggleStatus($id)
  {
    return $this->model->toggleStatus($id);
  }
}