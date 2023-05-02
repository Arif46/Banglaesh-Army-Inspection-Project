<?php

namespace App\Http\Controllers\Portal;

use App\Http\Controllers\Controller;
use App\Http\Validations\Portal\NewsValidation;
use App\Models\Portal\News;
use App\Repositories\Repository;
use Illuminate\Support\Facades\{Cache, App};
use App\Helpers\Base64FileUpload;
use Illuminate\Http\Request;

class NewsController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(News $News)
    {
        // set the model
        $this->model = new Repository($News);
    }

    /**
     * @queryParam title Filter by news Name En or Bn in List.
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
            *   "image_bn": "Logo",
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
        * @bodyParam title string required The Ministry Name of the News.
        * ......
    */
    public function store(Request $request)
    {
      $validationResult = NewsValidation::validate($request);    
      if (!$validationResult['success']) {
        return response($validationResult);
      }
      $requestAll = $request->all(); 
      $requestAll['user_id'] = 1; // user_id();

    if ($requestAll['logo']) {
        $image = Base64FileUpload::uploadImage($requestAll, 'logo', '/news', null, null, null, 2048);
        $requestAll['logo'] = $image['success'] ? $image['data']: null;
    }  
      $data = $this->model->create($requestAll);
  
      if ($data['success']) {
        Cache::store('redis')->forget('news');
        App::make('newsList');
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
            *   "image_bn": "Logo",
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
        * @bodyParam title string required The Ministry Name of the News.
        * ......
    */
    public function update(Request $request, $id)
    {
        $validationResult = NewsValidation::validate($request, $id);    
        if (!$validationResult['success']) {
            return response($validationResult);
        }
        
        $requestAll = $request->all(); 
        $model = News::find($id);

        if ($requestAll['logo'] != null && isset($requestAll['update_logo'])) { 
            $image = Base64FileUpload::uploadImage($requestAll, 'logo', '/news', $model->logo, null, null, 2048);              
        }
        $requestAll['logo'] = isset($image) ? ($image['success'] ? $image['data']: $model['logo']) : $model['logo'];
        $data = $this->model->update($requestAll, $id);

        if ($data['success']) {
            Cache::store('redis')->forget('news');
            App::make('newsList');
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
        Cache::store('redis')->forget('news');
            App::make('newsList');
    }
    return $data;
  }


}
