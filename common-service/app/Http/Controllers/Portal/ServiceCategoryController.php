<?php

namespace App\Http\Controllers\Portal;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Portal\ServiceCategory;
use App\Http\Validations\Portal\ServiceCategoryValidation;
use Illuminate\Support\Facades\{Cache, App};
use App\Repositories\Repository;
use App\Helpers\Base64FileUpload;

class ServiceCategoryController extends Controller
{
  // space that we can use the repository from
  protected $model;

  public function __construct(ServiceCategory $ServiceCategory)
  {
    // set the model
    $this->model = new Repository($ServiceCategory);
  }

  /**
   * @queryParam name Filter by service category En or Bn in List.
  */
  public function list($columns = ['*'], $limit = 10)
  {
    $searchable = [
      'name' => array(
        'name' => 'like',
        'name_bn' => 'orLike',
      )
    ];
    return $this->model->paginate($columns, $searchable, [], 10);
  }
  
  /**
   * @queryParam name Filter by service category En or Bn in List.
  */
  public function getAll($columns = ['*'])
  {
    $searchable = [
        'name' => array(
            'name' => 'like',
            'name_bn' => 'orLike',
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
    *    "name": "License & Registration",
    *     "name_bn": "লাইসেন্স ও নিবন্ধন",
    *     "status": "1",
    *     "logo": "logo",
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam name string required The service category of the ServiceCategory.
    * ......
  */
  public function store(Request $request)
  {
    $validationResult = ServiceCategoryValidation::validate($request);  

    if (!$validationResult['success']) {
      return response($validationResult);
    }
    
    $requestAll = $request->all();    
    
    if ($requestAll['logo']) {
      $image = Base64FileUpload::uploadImage($requestAll, 'logo', '/portal/service-category', null, 100, 100);         
      $requestAll['logo'] = $image['success'] ? $image['data']: null;
    }  
    $data = $this->model->create($requestAll);

    if ($data['success']) {
      Cache::store('redis')->forget('ServiceCategories');
      App::make('portalServiceCategoryList');
    }

    return $data;
  }
  
  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 1,
    *    "name": "License & Registration",
    *    "name_bn": "লাইসেন্স ও নিবন্ধন",
    *     "logo": "logo",
    *    "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam name string required Name of the ServiceCategory.
    * ......
  */
  public function update(Request $request, $id)
  {
    $validationResult = ServiceCategoryValidation::validate($request, $id);    
    if (!$validationResult['success']) {
      return response($validationResult);
    } 

    $requestAll = $request->all();
    $model = ServiceCategory::find($id);

    if ($requestAll['logo'] != null && isset($requestAll['update_logo'])) { 
        $image = Base64FileUpload::uploadImage($requestAll, 'logo', '/portal/service-category', $model->logo, 100, 100);              
    }
    $requestAll['logo'] = isset($image) ? ($image['success'] ? $image['data']: $model['logo']) : $model['logo'];
    $data = $this->model->update($requestAll, $id);

    if ($data['success']) {
      Cache::store('redis')->forget('ServiceCategories');
      App::make('portalServiceCategoryList');
    }
    return $data;
  }

  /**
    * @urlParam id integer required The ID of the Service Category.
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    *     id: 1,
    *    "name": "License & Registration",
    *     "name_bn": "লাইসেন্স ও নিবন্ধন",
    *     "logo": "logo",
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
   * @urlParam id integer required The ID of the Service Category.     
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
      Cache::store('redis')->forget('ServiceCategories');
      App::make('portalServiceCategoryList');
    }
    return $data;
  }

  /**
   * @urlParam id integer required The ID of the Service Category.     
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
      Cache::store('redis')->forget('ServiceCategories');
      App::make('portalServiceCategoryList');
    }
    return $data;
  }
}
