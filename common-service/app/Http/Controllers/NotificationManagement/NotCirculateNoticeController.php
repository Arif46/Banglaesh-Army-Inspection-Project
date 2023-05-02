<?php

namespace App\Http\Controllers\NotificationManagement;

use App\Http\Controllers\Controller;
use App\Http\Validations\NotificationManagement\NotCirculateNoticeValidation;
use App\Models\NotificationManagement\NotCirculateNotice;
use App\Repositories\Repository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\{Cache, App};

class NotCirculateNoticeController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(NotCirculateNotice $NotCirculateNotice)
    {
        // set the model
        $this->model = new Repository($NotCirculateNotice);
    }

    /**
   * @queryParam notice_title Filter by English or Bangla Name of the NotCirculateNotice Example: Dhaka Notice Title
   * @queryParam notice_title_bn Filter by English or Bangla Name of the NotCirculateNotice Example: ঢাকা ব্যাংক
   * @queryParam description Filter by English or Bangla Name of the NotCirculateNotice Example: Dhaka Notice Title
   * @queryParam description_bn Filter by English or Bangla Name of the NotCirculateNotice Example: ঢাকা ব্যাংক
   * @queryParam notice_for Filter by English or Bangla Name of the NotCirculateNotice Example: 1
   * @queryParam org_id Filter by English or Bangla Name of the NotCirculateNotice Example: 1
   * @queryParam notification_type_id Filter by English or Bangla Name of the Notice Title Example: 1
   * @queryParam designation_id Filter by designation_id of the NotCirculateNotice Example: 1
   * @queryParam office_id Filter by office_id of the NotCirculateNotice Example: 1
   * @queryParam notice_date Filter by notice_date of the NotCirculateNotice Example: 2021-03-17
   * @queryParam notice_time Filter by notice_time of the NotCirculateNotice Example: 10:30:00
   * @queryParam limit int Example: 10
   */

    public function list($columns = ['*'], $limit = 10)
    {
        $searchable = [
            'notice_title' => array(
                'notice_title' => 'like',
                'notice_title_bn' => 'orLike',
            ),
            'notification_type_id',
            'designation_id',
            'org_id',
            'designation_id'
        ];

        return $this->model->paginate($columns, $searchable, [], $limit);
    }
  
    /**
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data Saved Successfully",
        *  "data": {
        *     "id": 1,
        *     "notice_title": "Budget Notice",
        *     "notice_title_bn": "বাজেটের বিজ্ঞপ্তি",
        *     "description": "N/A",
        *     "description_bn": "N/A",
        *     "menu_id": 1,
        *     "notice_for": 1,
        *     "office_id": 1,
        *     "notice_date": "2021-03-17",
        *     "notice_time": "10:30:00",
        *     "org_id": 1,
        *     "notification_type_id": 1,
        *     "designation_id": 1,
        *     "status": "1"
        *     ..............
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to save data"
        *  "errors"  => "....."
        * }
        * @queryParam notice_title Filter by English or Bangla Name of the NotCirculateNotice Example: Dhaka Notice Title
        * @queryParam notice_title_bn Filter by English or Bangla Name of the NotCirculateNotice Example: ঢাকা ব্যাংক
        * @queryParam description Filter by English or Bangla Name of the NotCirculateNotice Example: Dhaka Notice Title
        * @queryParam description_bn Filter by English or Bangla Name of the NotCirculateNotice Example: ঢাকা ব্যাংক
        * @queryParam notice_for Filter by English or Bangla Name of the NotCirculateNotice Example: 1
        * @queryParam org_id Filter by English or Bangla Name of the NotCirculateNotice Example: 1
        * @queryParam notification_type_id Filter by English or Bangla Name of the Notice Title Example: 1
        * @queryParam designation_id Filter by designation_id of the NotCirculateNotice Example: 1
        * @queryParam office_id Filter by office_id of the NotCirculateNotice Example: 1
        * @queryParam notice_date Filter by notice_date of the NotCirculateNotice Example: 2021-03-17
        * @queryParam notice_time Filter by notice_time of the NotCirculateNotice Example: 10:30:00
    */

    public function store(Request $request)
    {   
        $validationResult = NotCirculateNoticeValidation::validate($request);    
        if (!$validationResult['success']) {
            return response($validationResult);
        }  

        $requestAll = $request->all();
        // $requestAll['created_by'] = (int)user_id()??null;

        $data = $this->model->create($requestAll);
        if ($data['success']) {
            Cache::store('redis')->forget('NotCirculateNotice');
            App::make('NotCirculateNoticeList');
        }
        return $data;
    }
    
    /**
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data Saved Successfully",
        *  "data": {
        *     "id": 1,
        *     "notice_title": "Budget Notice",
        *     "notice_title_bn": "বাজেটের বিজ্ঞপ্তি",
        *     "description": "N/A",
        *     "description_bn": "N/A",
        *     "menu_id": 1,
        *     "notice_for": 1,
        *     "office_id": 1,
        *     "notice_date": "2021-03-17",
        *     "notice_time": "10:30:00",
        *     "org_id": 1,
        *     "notification_type_id": 1,
        *     "designation_id": 1,
        *     "status": "1"
        *     ..............
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to save data"
        *  "errors"  => "....."
        * }
        * @queryParam notice_title Filter by English or Bangla Name of the NotCirculateNotice Example: Dhaka Notice Title
        * @queryParam notice_title_bn Filter by English or Bangla Name of the NotCirculateNotice Example: ঢাকা ব্যাংক
        * @queryParam description Filter by English or Bangla Name of the NotCirculateNotice Example: Dhaka Notice Title
        * @queryParam description_bn Filter by English or Bangla Name of the NotCirculateNotice Example: ঢাকা ব্যাংক
        * @queryParam notice_for Filter by English or Bangla Name of the NotCirculateNotice Example: 1
        * @queryParam org_id Filter by English or Bangla Name of the NotCirculateNotice Example: 1
        * @queryParam notification_type_id Filter by English or Bangla Name of the Notice Title Example: 1
        * @queryParam designation_id Filter by designation_id of the NotCirculateNotice Example: 1
        * @queryParam office_id Filter by office_id of the NotCirculateNotice Example: 1
        * @queryParam notice_date Filter by notice_date of the NotCirculateNotice Example: 2021-03-17
        * @queryParam notice_time Filter by notice_time of the NotCirculateNotice Example: 10:30:00
    */
    public function update(Request $request, $id)
    {
        $validationResult = NotificationSetupValidation::validate($request, $id);    
        if (!$validationResult['success']) {
            return response($validationResult);
        }
        $requestAll = $request->all(); 
        // $requestAll['updated_by'] = (int)user_id()??null;

        $data = $this->model->update($requestAll, $id);

        if ($data['success']) {
            Cache::store('redis')->forget('NotCirculateNotice');
            App::make('NotCirculateNoticeList');
        }
        return $data;
    }

    /**
    * @urlParam id integer required The ID of the Master Notice Title .
    * @urlParam lang The language. Example: en
    * @response scenario=success {
        *     "id": 1,
        *     "notice_title": "Budget Notice",
        *     "notice_title_bn": "বাজেটের বিজ্ঞপ্তি",
        *     "description": "N/A",
        *     "description_bn": "N/A",
        *     "menu_id": 1,
        *     "notice_for": 1,
        *     "office_id": 1,
        *     "notice_date": "2021-03-17,
        *     "notice_time": "10:30:00",
        *     "org_id": 1,
        *     "notification_type_id": 1,
        *     "designation_id": 1,
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
     * @urlParam id integer required The ID of the Master Notice Title .
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
            Cache::store('redis')->forget('role');
            App::make('roleList');
        }
        return $data;
    }


    /**
     * @urlParam id integer required The ID of the Component.     
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
            Cache::store('redis')->forget('NotCirculateNotice');
            App::make('NotCirculateNoticeList');
        }
        return $data;
    }
}
