<?php

namespace App\Http\Controllers\Portal;

use App\Http\Controllers\Controller;
use App\Http\Validations\Portal\MinistryEntryValidation;
use App\Models\Portal\MinistryEntry;
use App\Repositories\Repository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\{Cache, App};
use App\Helpers\Base64FileUpload;

class MinistryEntryController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(MinistryEntry $MinistryEntry)
    {
        // set the model
        $this->model = new Repository($MinistryEntry);
    }

    /**
     * @queryParam ministry_name Filter by Ministry Name En or Bn in List.
    */
    public function list($columns = ['*'], $limit = 10)
    {
        $searchable = [
        'ministry_name' => array(
            'ministry_name' => 'like',
            'ministry_name_bn' => 'orLike',
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
            *   "ministry_name": "Ministry of Commerce",
            *   "ministry_name_bn": "বাণিজ্য মন্ত্রণালয়",
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
        * @bodyParam ministry_name string required The Ministry Name of the MinistryEntry.
        * ......
    */
    public function store(Request $request)
    {
        $validationResult = MinistryEntryValidation::validate($request);  

        if (!$validationResult['success']) {
            return response($validationResult);
        }
        
        $requestAll = $request->all();
        if ($requestAll['logo']) {
            $image = Base64FileUpload::uploadImage($requestAll, 'logo', '/portal/ministry-logo', null, 100, 100);         
            $requestAll['logo'] = $image['success'] ? $image['data']: null;
        }   

        $data = $this->model->create($requestAll);

        if ($data['success']) {
            Cache::store('redis')->forget('ministryNames');
            App::make('ministryNameList');
        }

        return $data;
    }
  
    /**
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data Updated Successfully",
        *  "data": {
            *   id: 1,
            *   "ministry_name": "License & Registration",
            *   "ministry_name_bn": "লাইসেন্স ও নিবন্ধন",
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
        * @bodyParam ministry_name string required The Ministry Name of the MinistryEntry.
        * ......
    */
    public function update(Request $request, $id)
    {
        $validationResult = MinistryEntryValidation::validate($request, $id);

        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $requestAll = $request->all();
        $model = MinistryEntry::find($id);

        if ($requestAll['logo'] != null && isset($requestAll['update_logo'])) { 
            $image = Base64FileUpload::uploadImage($requestAll, 'logo', '/portal/ministry-logo', $model->logo, 100, 100);              
        }

        $requestAll['logo'] = isset($image) ? ($image['success'] ? $image['data']: $model['logo']) : $model['logo'];
        $data = $this->model->update($requestAll, $id);

        if ($data['success']) {
            Cache::store('redis')->forget('ministryNames');
            App::make('ministryNameList');
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
        Cache::store('redis')->forget('ministryNames');
        App::make('ministryNameList');
    }
    return $data;
  }


}
