<?php

namespace App\Http\Controllers\OrgProfile;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\OrgProfile\MasterBank;
use App\Http\Validations\OrgProfile\MasterBankValidations;
use Illuminate\Support\Facades\{Cache, App};
use App\Repositories\Repository;

class MasterBankController extends Controller
{
    // space that we can use the repository from
  protected $model;

  public function __construct(MasterBank $MasterBank)
  {
      // set the model
      $this->model = new Repository($MasterBank);
  }

  /**
   * @queryParam bank_name Filter by English or Bangla Name of the Bank Example: Dhaka Bank
   * @queryParam bank_name_bn Filter by English or Bangla Name of the Bank Example: ঢাকা ব্যাংক
   * @queryParam org_id Filter by English or Bangla Name of the Bank Example: 1
   * @queryParam component_id Filter by English or Bangla Name of the Bank Example: 1
  */
  public function list($columns = ['*'], $limit = 10)
  {
    $searchable = [
      'bank_name' => array(
        'bank_name' => 'like',
        'bank_name_bn' => 'orLike',
      ),
      'org_id',
      'component_id'
    ];
    return $this->model->paginate($columns, $searchable, [], $limit);
  }

  /**
   * @queryParam content Filter by content in List.
  */
  public function getAll($columns = ['*'])
  {
    $searchable = [
        'bank_name' => array(
          'bank_name' => 'like',
          'bank_name_bn' => 'orLike',
        ),
        'org_id',
        'component_id'
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
    *     "component_id": "1"
    *     "bank_name": "Dhaka Bank",
    *     "bank_name_bn": "ঢাকা ব্যাংক",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam bank_name string required The English Bank Name of the Bank Example: Dhaka Bank.
    * @bodyParam bank_name_bn string required The Bangla Bank Name of the Bank  Example: ঢাকা ব্যাংক.
    * @bodyParam org_id string required The Org Id of the Bank Example: 1
    * @bodyParam component_id string required The Component Id of the Bank Example: 1
  */
  public function store(Request $request)
  {
    $validationResult = MasterBankValidations::validate($request);

    if (!$validationResult['success']) {
      return response($validationResult);
    }
    // return $request->all();
    $requestAll = $request->all();
    $data = $this->model->create($requestAll);

    if ($data['success']) {
      Cache::store('redis')->forget('banks');
      App::make('bankList');
      Cache::store('redis')->forget('bankNames');
      App::make('bankNameList');
    }

    return $data;
  }

  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 1,
    *     "org_id": "1",
    *     "component_id": "1",
    *     "bank_name": "Dhaka Bank",
    *     "bank_name_bn": "ঢাকা ব্যাংক",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam bank_name string required The English Bank Name of the Bank Example: Dhaka Bank.
    * @bodyParam bank_name_bn string required The Bangla Bank of the Bank  Example: ঢাকা ব্যাংক.
    * @bodyParam org_id string required The Org Id of the Bank Example: 1
    * @bodyParam component_id string required The Component Id of the Bank Example: 1
  */
  public function update(Request $request, $id)
  {
    $validationResult = MasterBankValidations::validate($request, $id);
    if (!$validationResult['success']) {
      return response($validationResult);
    }

    $requestAll = $request->all();
    $data = $this->model->update($requestAll, $id);

    if ($data['success']) {
      Cache::store('redis')->forget('banks');
      App::make('bankList');
      Cache::store('redis')->forget('bankNames');
      App::make('bankNameList');
    }
    return $data;
  }
  

  /**
    * @urlParam id integer required The ID of the Master Bank .
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    *     id: 4,
    *     "org_id": "1",
    *     "component_id": "1",
    *     "bank_name": "Dhaka Bank",
    *     "bank_name_bn": "ঢাকা ব্যাংক",
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
      Cache::store('redis')->forget('banks');
      App::make('bankList');
      Cache::store('redis')->forget('bankNames');
      App::make('bankNameList');
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
      Cache::store('redis')->forget('banks');
      App::make('bankList');
      Cache::store('redis')->forget('bankNames');
      App::make('bankNameList');
    }
    return $data;
  }
}
