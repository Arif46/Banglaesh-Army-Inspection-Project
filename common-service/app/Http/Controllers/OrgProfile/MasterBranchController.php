<?php

namespace App\Http\Controllers\OrgProfile;

use App\Http\Controllers\Controller;
use App\Http\Validations\OrgProfile\MasterBranchValidations;
use App\Models\orgProfile\MasterBranch;
use App\Repositories\Repository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Cache;

class MasterBranchController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(MasterBranch $masterBranch)
    {
        // Set the model
        $this->model = new Repository($masterBranch);
    }

    /**
     * @queryParam branch_name Filter by English or Bangla Name of the Branch Example: Chandpur Branch
     * @queryParam branch_name_bn Filter by English or Bangla Name of the Branch Example: চাঁদপুর ব্রাঞ্চ
     * @queryParam org_id Filter by org_id the Branch of the list
     * @queryParam bank_id Filter by bank_id the Branch of the list
    */
    public function list($columns = ['*'], $limit = 10)
    {
        $searchable = [
            'branch_name' => array(
            'branch_name' => 'like',
            'branch_name_bn' => 'orLike',
        ),
        'org_id',
        'bank_id'
    ];
    return $this->model->paginate($columns, $searchable, [], $limit);
    }

    /**
     * @queryParam content Filter by content in List.
    */
    public function getAll($columns = ['*'])
    {
        $searchable = [
                'branch_name' => array(
                'branch_name' => 'like',
                'branch_name_bn' => 'orLike',
            ),
            'org_id',
            'bank_id'
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
    *     "bank_id": "1"
    *     "bank_name": "Chandpur Branch",
    *     "bank_name_bn": "চাঁদপুর ব্রাঞ্চ",
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
     * @bodyParam branch_name string required The English Branch Name of the Branch Example: "Chandpur Branch".
     * @bodyParam branch_name_bn string required The Bangla Branch Name of the Branch Example: "চাঁদপুর ব্রাঞ্চ".
     * @bodyParam org_id string required org_id of the Branch Example: 1
     * @bodyParam bank_id string required bank_id of the Bank Example: 1
     * @bodyParam address string required address of the Branch Example: "Address"
     * @bodyParam address_bn string required address_bn of the Branch Example: "ঠিকানা"
    */
    public function store(Request $request)
    {
        $validationResult = MasterBranchValidations::validate($request);

        if (!$validationResult['success']) {
            return response($validationResult);
        }
        // return $request->all();
        $requestAll = $request->all();
        $data = $this->model->create($requestAll);

        if ($data['success']) {
            Cache::store('redis')->forget('branch');
            App::make('branchList');
            Cache::store('redis')->forget('branchName');
            App::make('branchNameList');
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
    *     "bank_id": "1"
    *     "bank_name": "Chandpur Branch",
    *     "bank_name_bn": "চাঁদপুর ব্রাঞ্চ",
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
     * @bodyParam branch_name string required The English Branch Name of the Branch Example: "Chandpur Branch".
     * @bodyParam branch_name_bn string required The Bangla Branch Name of the Branch Example: "চাঁদপুর ব্রাঞ্চ".
     * @bodyParam org_id string required org_id of the Branch Example: 1
     * @bodyParam bank_id string required bank_id of the Bank Example: 1
     * @bodyParam address string required address of the Branch Example: "Address"
     * @bodyParam address_bn string required address_bn of the Branch Example: "ঠিকানা"
    */
    public function update(Request $request, $id)
    {
        $validationResult = MasterBranchValidations::validate($request, $id);
        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $requestAll = $request->all();
        $data = $this->model->update($requestAll, $id);

        if ($data['success']) {
            Cache::store('redis')->forget('branch');
            App::make('branchList');
            Cache::store('redis')->forget('branchName');
            App::make('branchNameList');
        }
        return $data;
    }


    /**
     * @urlParam id integer required The ID of the Master Bank .
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    *     id: 4,
    *     "org_id": "1"
    *     "bank_id": "1"
    *     "bank_name": "Chandpur Branch",
    *     "bank_name_bn": "চাঁদপুর ব্রাঞ্চ",
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
            Cache::store('redis')->forget('branch');
            App::make('branchList');
            Cache::store('redis')->forget('branchName');
            App::make('branchNameList');
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
            Cache::store('redis')->forget('branch');
            App::make('branchList');
            Cache::store('redis')->forget('branchName');
            App::make('branchNameList');
        }
        return $data;
    }
}
