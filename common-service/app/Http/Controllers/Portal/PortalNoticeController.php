<?php

namespace App\Http\Controllers\Portal;

use App\Http\Controllers\Controller;
use App\Http\Validations\Portal\PortalNoticeValidation;
use App\Models\Portal\PortalNotice;
use App\Repositories\Repository;
use Illuminate\Support\Facades\{Cache, App};
use App\Helpers\Base64FileUpload;
use Illuminate\Http\Request;

class PortalNoticeController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(PortalNotice $PortalNotice)
    {
        // set the model
        $this->model = new Repository($PortalNotice);
    }

    /**
     * @queryParam title Filter by PortalNotice Name En or Bn in List.
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
            *   "title": "Service Portal",
            *   "title_bn": "সেবা পোর্টাল",
            *   "description": "Nowadays, Around 50 million people are using internet daily in Bangladesh.",
            *   "description_bn": "বর্তমানে বাংলাদেশে প্রায় ৫ কোটি মানুষ প্রতিদিন ইন্টারনেট ব্যবহার করছে",
            *   "attachment": "Logo",
            *   "user_id": "1",
            *   "status": "1"
            *   .........
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to save data"
        *  "errors"  => "....."
        * }
        * @bodyParam title string required The Ministry Name of the PortalNotice.
        * ......
    */
    public function store(Request $request)
    {   
        $validationResult = PortalNoticeValidation::validate($request);    
        if (!$validationResult['success']) {
            return response($validationResult);
        }  

        $requestAll = $request->all();
        $requestAll['user_id'] = 1; // user_id();
        $image = Base64FileUpload::uploadFile($request, 'attachment', 'PortalNotice', null);
        $requestAll['attachment'] = $image['success'] ? $image['data']: null;

        if ($image['success']) {
            $data = $this->model->create($requestAll);
        }
        
        if ($data['success']) {
            Cache::store('redis')->forget('PortalNotices');
            App::make('PortalNoticeList');
        }
        return $data;
    }
  
    /**
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data Updated Successfully",
        *  "data": {
            *   id: 1,
            *   "title": "Service Portal",
            *   "title_bn": "সেবা পোর্টাল",
            *   "description": "Nowadays, Around 50 million people are using internet daily in Bangladesh.",
            *   "description_bn": "বর্তমানে বাংলাদেশে প্রায় ৫ কোটি মানুষ প্রতিদিন ইন্টারনেট ব্যবহার করছে",
            *   "attachment": "Logo",
            *   "user_id": "1",
            *   "status": "1"
            *   .........
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to update data"
        *  "errors"  => "....."
        * }
        * @bodyParam title string required The Ministry Name of the PortalNotice.
        * ......
    */
    public function update(Request $request, $id)
    {
        $validationResult = PortalNoticeValidation::validate($request, $id);    
        if (!$validationResult['success']) {
            return response($validationResult);
        }
        
        $requestAll = $request->all(); 
        if ($request->file) {
            $image = Base64FileUpload::uploadFile($request, 'attachment', 'PortalNotice', $request->oldfile);
            $requestAll['attachment'] = $image['success'] ? $image['data']: null;
        }
        $data = $this->model->update($requestAll, $id);
        
        if ($data['success']) {
            Cache::store('redis')->forget('PortalNotices');
            App::make('PortalNoticeList');
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
        Cache::store('redis')->forget('PortalNotices');
            App::make('PortalNoticeList');
    }
    return $data;
  }


}
