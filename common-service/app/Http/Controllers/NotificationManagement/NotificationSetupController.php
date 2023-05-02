<?php

namespace App\Http\Controllers\NotificationManagement;

use App\Http\Controllers\Controller;
use App\Http\Validations\NotificationManagement\NotificationSetupValidation;
use App\Models\NotificationManagement\NotificationSetup;
use App\Repositories\Repository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Cache;

class NotificationSetupController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(NotificationSetup $notificationSetup)
    {
        // set the model
        $this->model = new Repository($notificationSetup);
    }

    /**
   * @queryParam component_id Filter by component_id of the NotificationSetup Example: 1
   * @queryParam module_id Filter by module_id of the NotificationSetup Example: 1
   * @queryParam service_id Filter by service_id of the NotificationSetup Example: 1
   * @queryParam menu_id Filter by service_id of the NotificationSetup Example: 1
   * @queryParam limit int Example: 10
   */

    public function list($columns = ['*'], $limit = 10)
    {
        $searchable = [
            'component_id',
            'module_id',
            'service_id',
            'menu_id',
            'template_id'
        ];

        return $this->model->paginate($columns, $searchable, [], $limit);
    }
  
    /**
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data Saved Successfully",
        *  "data": {
        *     "id": 1,
        *     "component_id": 1,
        *     "module_id": 1
        *     "service_id": 1
        *     "menu_id": 1
        *     "button_id": 1
        *     "template_id": 1
        *     "status": "1"
        *     ..............
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to save data"
        *  "errors"  => "....."
        * }
        * @bodyParam component_id integer required component_id of the NotificationSetup Example: 1
        * @bodyParam module_id integer required module_id of the NotificationSetup Example: 1
        * @bodyParam service_id integer Not required service_id of the NotificationSetup Example: 1
        * @bodyParam menu_id integer required menu_id of the NotificationSetup Example: 1
        * @bodyParam button_id integer required button_id of the NotificationSetup Example: 1
        * @bodyParam template_id integer required template_id of the NotificationSetup Example: 1
    */

    public function store(Request $request)
    {   
        $validationResult = NotificationSetupValidation::validate($request);    
        if (!$validationResult['success']) {
            return response($validationResult);
        }  

        $requestAll = $request->all();
        // $requestAll['created_by'] = (int)user_id()??null;

        $data = $this->model->create($requestAll);
        if ($data['success']) {
            Cache::store('redis')->forget('NotificationSetup');
            App::make('NotificationSetupList');
        }
        return $data;
    }
    
    /**
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data Saved Successfully",
        *  "data": {
        *     "id": 1,
        *     "component_id": 1,
        *     "module_id": 1
        *     "service_id": 1
        *     "menu_id": 1
        *     "button_id": 1
        *     "template_id": 1
        *     "status": "1"
        *     ..............
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to save data"
        *  "errors"  => "....."
        * }
        * @bodyParam component_id integer required component_id of the NotificationSetup Example: 1
        * @bodyParam module_id integer required module_id of the NotificationSetup Example: 1
        * @bodyParam service_id integer Not required service_id of the NotificationSetup Example: 1
        * @bodyParam menu_id integer required menu_id of the NotificationSetup Example: 1
        * @bodyParam button_id integer required button_id of the NotificationSetup Example: 1
        * @bodyParam template_id integer required template_id of the NotificationSetup Example: 1
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
            Cache::store('redis')->forget('NotificationSetup');
            App::make('NotificationSetupList');
        }
        return $data;
    }

    /**
    * @urlParam id integer required The ID of the Master Bank .
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    *     id: 4,
    *     "component_id": 1,
    *     "module_id": 1
    *     "service_id": 1
    *     "menu_id": 1
    *     "button_id": 1
    *     "template_id": 1
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
     * @urlParam id integer required The ID of the Master Bank .
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
            Cache::store('redis')->forget('NotificationSetup');
            App::make('NotificationSetupList');
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
            Cache::store('redis')->forget('NotificationSetup');
            App::make('NotificationSetupList');
        }
        return $data;
    }
}
