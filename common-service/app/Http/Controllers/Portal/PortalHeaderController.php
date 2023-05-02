<?php

namespace App\Http\Controllers\Portal;

use App\Http\Controllers\Controller;
use App\Http\Validations\Portal\PortalHeaderValidation;
use App\Models\Portal\PortalHeader;
use App\Repositories\Repository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\{Cache, App};
use App\Helpers\Base64FileUpload;

class PortalHeaderController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(PortalHeader $PortalHeader)
    {
        // set the model
        $this->model = new Repository($PortalHeader);
    }

    /**
     * @queryParam title Filter by Ministry title En or Bn in List.
    */
    public function list($columns = ['*'], $limit = 10)
    {
        $searchable = [
            'title' => array(
                'title' => 'like',
                'title_bn' => 'orLike',
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
            *   "title": "License & Registration",
            *   "title_bn": "লাইসেন্স ও নিবন্ধন",
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
        * @bodyParam title string required The Ministry title of the PortalHeader.
        * ......
    */
    public function store(Request $request)
    {
      $validationResult = PortalHeaderValidation::validate($request);    
      if (!$validationResult['success']) {
        return response($validationResult);
      }
      $requestAll = $request->all(); 
      if ($requestAll['logo']) {
        $image = Base64FileUpload::uploadImage($requestAll, 'logo', '/portal/header', null, 100, 100);         
        $requestAll['logo'] = $image['success'] ? $image['data']: null;
      } 
      $data = $this->model->create($requestAll);
  
      if ($data['success']) {
        Cache::store('redis')->forget('PortalHeader');
        App::make('portalHeaderList');
      }
  
      return $data;
    }
  
    /**
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data Updated Successfully",
        *  "data": {
            *   id: 1,
            *   "title": "License & Registration",
            *   "title_bn": "লাইসেন্স ও নিবন্ধন",
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
        * @bodyParam title string required title of the PortalHeader.
        * ......
    */
    public function update(Request $request, $id)
    {
      $validationResult = PortalHeaderValidation::validate($request, $id);    
        if (!$validationResult['success']) {
          return response($validationResult);
        } 
    
        $requestAll = $request->all();
    
        if ($requestAll['logo'] != null && isset($requestAll['logo'])) {
          $image =  Base64FileUpload::uploadImage($requestAll, 'logo', '/portal/header', $requestAll['pre_logo'], 100, 100);
          $requestAll['logo'] = $image['success'] ? $image['data']: null;
        } else {
          $requestAll['logo'] = $requestAll['pre_logo'];
        }
    
        $data = $this->model->update($requestAll, $id);
    
        if ($data['success']) {
          Cache::store('redis')->forget('PortalHeader');
          App::make('portalHeaderList');
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
