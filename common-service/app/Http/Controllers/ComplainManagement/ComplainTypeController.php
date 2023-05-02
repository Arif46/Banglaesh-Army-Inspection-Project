<?php

namespace App\Http\Controllers\ComplainManagement;

use App\Http\Controllers\Controller;
use App\Http\Validations\ComplainManagement\ComplainTypeValidations;
use App\Models\ComplainManagement\ComplainType;
use App\Repositories\Repository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Cache;

class ComplainTypeController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(ComplainType $complainType)
    {
        // set the model
        $this->model = new Repository($complainType);
    }

    /**
    * @queryParam com_type_name Filter by com_type_name of the master_complain_types Example: "Verbal Complain"
    */

    public function list($columns = ['*'], $limit = 10)
    {
        $searchable = [
            'com_type_name',
        ];

        return $this->model->paginate($columns, $searchable, [], $limit);
    }
  
    /**
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data Saved Successfully",
        *  "data": {
        *     "id": 1,
        *     "com_type_name": "Verbal Complain",
        *     "com_type_name_bn": "মৌখিক অভিযোগ"
        *     "status": "1"
        *     ..............
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to save data"
        *  "errors"  => "....."
        * }
        * @bodyParam com_type_name string required com_type_name of the master_complain_types Example: "Verbal Complain"
        * @bodyParam com_type_name_bn string required com_type_name_bn of the master_complain_types Example: "মৌখিক অভিযোগ"
    */

    public function store(Request $request)
    {   
        $validationResult = ComplainTypeValidations::validate($request);    
        if (!$validationResult['success']) {
            return response($validationResult);
        }  

        $requestAll = $request->all();
        // $requestAll['created_by'] = (int)user_id()??null;

        $data = $this->model->create($requestAll);
        if ($data['success']) {
            Cache::store('redis')->forget('complainType');
            App::make('complainTypeList');
        }
        return $data;
    }
    
    /**
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data update Successfully",
        *  "data": {
        *     "id": 1,
        *     "com_type_name": "Verbal Complain",
        *     "com_type_name_bn": "মৌখিক অভিযোগ"
        *     "status": "1"
        *     ..............
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to update data"
        *  "errors"  => "....."
        * }
        * @bodyParam com_type_name string required com_type_name of the master_complain_types Example: "Verbal Complain"
        * @bodyParam com_type_name_bn string required com_type_name_bn of the master_complain_types Example: "মৌখিক অভিযোগ"
    */
    public function update(Request $request, $id)
    {
        $validationResult = ComplainTypeValidations::validate($request, $id);    
        if (!$validationResult['success']) {
            return response($validationResult);
        }
        $requestAll = $request->all(); 
        // $requestAll['updated_by'] = (int)user_id()??null;

        $data = $this->model->update($requestAll, $id);

        if ($data['success']) {
            Cache::store('redis')->forget('complainType');
            App::make('complainTypeList');
        }
        return $data;
    }

    /**
    * @urlParam id integer required The ID of the Master Bank .
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    *     id: 1,
    *     "com_type_name": "Verbal Complain",
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
            Cache::store('redis')->forget('complainType');
            App::make('complainTypeList');
        }
        return $data;
    }

    /**
     * @urlParam id integer required The ID of the Component.     
     * @response scenario=success {
     *  "message": "Data Update successfully"
     * }
     * @response scenario="Failed" {
     *  "message": "Data not found"
     * }
    */
    public function toggleStatus($id)
    {
        $data = $this->model->toggleStatus($id);

        if ($data['success']) {
            Cache::store('redis')->forget('complainType');
            App::make('complainTypeList');
        }
        return $data;
    }
}
