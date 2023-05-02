<?php

namespace App\Http\Controllers\ComplainManagement;

use App\Http\Controllers\Controller;
use App\Http\Validations\ComplainManagement\ComplainChainValidations;
use App\Models\ComplainManagement\ComplainChain;
use App\Repositories\Repository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Cache;

class ComplainChainController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(ComplainChain $complainChain)
    {
        // Set the model
        $this->model = new Repository($complainChain);
    }

    /**
     * @queryParam org_id Filter by org_id the master_complain_chains of the list
     * @queryParam designation_id Filter by designation_id the master_complain_chains of the list
    */
    public function list($columns = ['*'], $limit = 10)
    {
        $searchable = [
            'org_id',
            'designation_id'
        ];
        return $this->model->paginate($columns, $searchable, [], $limit);
    }

    /**
     * @queryParam content Filter by content in List.
    */
    public function getAll($columns = ['*'])
    {
        $searchable = [
            'org_id',
            'designation_id'
        ];
        return $this->model->getAll($columns, $searchable, [], ['created_at'=> 'DESC']);
    }
    /**
     * @response scenario=success {
     *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 1,
    *     "org_id": "1"
    *     "designation_id": "1"
    *     "sorting_order": "1"
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * 
    * @bodyParam org_id string required org_id of the master_complain_chains Example: 1
    * @bodyParam designation_id string required designation_id of the master_complain_chains Example: 1
    * @bodyParam sorting_order string required sorting_order of the master_complain_chains Example: 1
    */
    public function store(Request $request)
    {
        $validationResult = ComplainChainValidations::validate($request);

        if (!$validationResult['success']) {
            return response($validationResult);
        }
                
        $requestAll = $request->all();
        $data = $this->model->create($requestAll);

        if ($data['success']) {
            Cache::store('redis')->forget('complainChain');
            App::make('complainChainList');
        }

        return $data;
    }

    /**
     * @response scenario=success {
     *  "success": true,
    *  "message": "Data Update Successfully",
    *  "data": {
    *     id: 1,
    *     "org_id": "1"
    *     "designation_id": "1"
    *     "sorting_order": "1"
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to update data"
    *  "errors"  => "....."
    * }
     * 
     * @bodyParam org_id string required org_id of the master_complain_chains Example: 1
     * @bodyParam designation_id string required designation_id of the master_complain_chains Example: 1
     * @bodyParam sorting_order string required sorting_order of the master_complain_chains Example: 1
    */
    public function update(Request $request, $id)
    {
        $validationResult = ComplainChainValidations::validate($request, $id);
        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $requestAll = $request->all();
        $data = $this->model->update($requestAll, $id);

        if ($data['success']) {
            Cache::store('redis')->forget('complainChain');
            App::make('complainChainList');
        }

        return $data;
    }


    /**
     * @urlParam id integer required The ID of the Master Bank .
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    *     id: 4,
    *     "org_id": "1"
    *     "designation_id": "1"
    *     "sorting_order": "1"
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
            Cache::store('redis')->forget('complainChain');
            App::make('complainChainList');
        }

        return $data;
    }

    /**
     * @urlParam id integer required The ID of the Master Bank .
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
            Cache::store('redis')->forget('complainChain');
            App::make('complainChainList');
        }
        
        return $data;
    }
}
