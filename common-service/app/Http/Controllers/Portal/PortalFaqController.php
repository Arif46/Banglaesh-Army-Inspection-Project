<?php

namespace App\Http\Controllers\Portal;

use App\Http\Controllers\Controller;
use App\Http\Validations\Portal\FaqValidation;
use App\Models\Portal\Faq;
use App\Repositories\Repository;
use Illuminate\Support\Facades\{Cache, App};
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Crypt;

class PortalFaqController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(Faq $Faq)
    {
        // set the model
        $this->model = new Repository($Faq);
    }

    /**
     * @queryParam title Filter by Faq Name En or Bn in List.
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
            *   "status": "1"
            *   .........
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to save data"
        *  "errors"  => "....."
        * }
        * @bodyParam title string required of the faq.
        * ......
    */
    public function store(Request $request)
    {
        $validationResult = FaqValidation::validate($request);  

        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $requestAll = $request->all();
        $requestAll['user_id'] = 1; // user_id();
        $data = $this->model->create($requestAll);

        if ($data['success']) {
            Cache::store('redis')->forget('faqs');
            App::make('faqList');
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
            *   "status": "1"
            *   .........
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to update data"
        *  "errors"  => "....."
        * }
        * @bodyParam title string required The title Name of the faq.
        * ......
    */
    public function update(Request $request, $id)
    {
        $validationResult = FaqValidation::validate($request, $id);

        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $requestAll = $request->all();
        $data = $this->model->update($requestAll, $id);

        if ($data['success']) {
            Cache::store('redis')->forget('faqs');
            App::make('faqList');
        }
        return $data;
    }

    /**
   * @urlParam id integer required The ID of the faq Entry.     
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
        Cache::store('redis')->forget('faqs');
            App::make('faqList');
    }
    return $data;
  }


}
