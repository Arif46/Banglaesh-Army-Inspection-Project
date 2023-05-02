<?php

namespace App\Http\Controllers\Portal;

use App\Http\Controllers\Controller;
use App\Http\Validations\Portal\ServiceCustomerTypeValidation;
use App\Models\Portal\ServiceCustomerType;
use App\Repositories\Repository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\{Cache, App};
use App\Helpers\Base64FileUpload;

class ServiceCustomerTypeController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(ServiceCustomerType $ServiceCustomerType)
    {
        // set the model
        $this->model = new Repository($ServiceCustomerType);
    }

    /**
     * @queryParam name Filter by Ministry Name En or Bn in List.
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
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data Saved Successfully",
        *  "data": {
            *   id: 1,
            *   "name": "License & Registration",
            *   "name_bn": "লাইসেন্স ও নিবন্ধন",
            *   "logo": "Logo",
            *   "status": "1"
            *   .........
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to save data"
        *  "errors"  => "....."
        * }
        * @bodyParam name string required The Ministry Name of the ServiceCustomerType.
        * ......
    */
    public function store(Request $request)
    {
        $validationResult = ServiceCustomerTypeValidation::validate($request);  

        if (!$validationResult['success']) {
            return response($validationResult);
        }
        
        $requestAll = $request->all();
        if ($requestAll['image']) {
            $image = Base64FileUpload::uploadImage($requestAll, 'image', '/customer-type/image', null, 100, 100);         
            $requestAll['image'] = $image['success'] ? $image['data']: null;
        }   

        $data = $this->model->create($requestAll);

        if ($data['success']) {
            Cache::store('redis')->forget('CustomerTypes');
            App::make('portalCustomerTypeList');
        }

        return $data;
    }
  
    /**
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data Updated Successfully",
        *  "data": {
            *   id: 1,
            *   "name": "License & Registration",
            *   "name_bn": "লাইসেন্স ও নিবন্ধন",
            *   "logo": "Logo",
            *   "status": "1"
            *   .........
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to update data"
        *  "errors"  => "....."
        * }
        * @bodyParam name string required The Ministry Name of the ServiceCustomerType.
        * ......
    */
    public function update(Request $request, $id)
    {
        $validationResult = ServiceCustomerTypeValidation::validate($request, $id);

        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $requestAll = $request->all();
        $model = ServiceCustomerType::find($id);

        if ($requestAll['image'] != null && isset($requestAll['update_logo'])) { 
            $image = Base64FileUpload::uploadImage($requestAll, 'image', '/customer-type/image', $model->image, 100, 100);              
        }

        $requestAll['image'] = isset($image) ? ($image['success'] ? $image['data']: $model['image']) : $model['image'];
        $data = $this->model->update($requestAll, $id);

        if ($data['success']) {
            Cache::store('redis')->forget('CustomerTypes');
            App::make('portalCustomerTypeList');
        }
        return $data;
    }

    /**
   * @urlParam id integer required The ID of the Ministry Entry.     
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
        Cache::store('redis')->forget('CustomerTypes');
        App::make('portalCustomerTypeList');
    }
    return $data;
  }
}
