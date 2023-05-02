<?php

namespace App\Http\Controllers\OrgProfile;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\OrgProfile\{ MasterWard, MasterWardDetails };
use App\Http\Validations\OrgProfile\MasterWardValidations;
use Illuminate\Support\Facades\{Cache, App};
use App\Repositories\Repository;
use Illuminate\Support\Facades\DB;

class MasterWardController extends Controller
{
    // space that we can use the repository from
  protected $model;

  public function __construct(MasterWard $MasterWard)
  {
      // set the model
      $this->model = new Repository($MasterWard);
  }

   /**
   * @queryParam ward_name Filter by English or Bangla Name of the Ward Example: Ward-1
   * @queryParam ward_name_bn Filter by English or Bangla Name of the Ward Example: ওয়ার্ড-১
   * @queryParam division_id Filter by Ward Example: 1
   * @queryParam district_id Filter by Ward Example: 1
   * @queryParam upazila_id Filter by Ward Example: 1
   * @queryParam union_id Filter by Ward Example: 1
   * @queryParam pauroshoba_id Filter by Ward Example: 1
   * @queryParam type Filter by Ward Example: 1
   * @queryParam limit int Example: 10
  */
  public function index(Request $request)
  {
    // $searchable = [
    //   'ward_name' => array(
    //     'ward_name' => 'like',
    //     'ward_name_bn' => 'orLike',
    //   ),
    //   'type','division_id', 'district_id', 'upazila_id', 'union_id', 'pauroshoba_id'
    // ];
    // return $this->model->paginate($columns, $searchable, [], $limit);
      $query = MasterWard::with('ward_details');
        
        if ($request->type) {
            $query = $query->where('type', $request->type);
        }

        if ($request->city_corporation_id) {
            $query = $query->where('city_corporation_id', $request->city_corporation_id);
        }

        if ($request->division_id) {
            $query = $query->where('division_id', $request->division_id);
        }

        if ($request->district_id) {
            $query = $query->where('district_id', $request->district_id);
        }

        if ($request->upazila_id) {
            $query = $query->where('upazila_id', $request->upazila_id);
        }

        if ($request->union_id) {
            $query = $query->where('union_id', $request->union_id);
        }

        if ($request->pauroshoba_id) {
            $query = $query->where('pauroshoba_id', $request->pauroshoba_id);
        }

        // $query->get();

        $list = $query->paginate($request->limit ? $request->limit : 20);

        if( count($list)>0){
            return response([
                'success' => true,
                'message' => 'Ward List!',
                'data' => $list
            ]);
        }
        else
        {
            return response([
                'success' => false,
                'message' => 'Data not found!!'
            ]);
        }
  }
    /**
   * @queryParam ward_name Filter by English or Bangla Name of the Ward Example: Ward-1
   * @queryParam ward_name_bn Filter by English or Bangla Name of the Ward Example: ওয়ার্ড-১
   * @queryParam division_id Filter by Ward Example: 1
   * @queryParam district_id Filter by Ward Example: 1
   * @queryParam upazila_id Filter by Ward Example: 1
   * @queryParam union_id Filter by Ward Example: 1
   * @queryParam pauroshoba_id Filter by Ward Example: 1
   * @queryParam Type Filter by Ward Example: 1
  */
  public function getAll($columns = ['*'])
  {
    $searchable = [
        'ward_name' => array(
          'ward_name' => 'like',
          'ward_name_bn' => 'orLike',
        ),
        'type','division_id', 'district_id', 'upazila_id', 'union_id', 'pauroshoba_id'
      ];
    return $this->model->getAll($columns, $searchable, [], ['created_at'=> 'DESC']);
  }
  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 1,
    *     "type": "1",
    *     "city_corporation_id": "1",
    *     "division_id": "1",
    *     "district_id": "1",
    *     "upazilla_id": "1",
    *     "union_id": "1",
    *     "pauroshoba_id": "1",
    *     "ward_name": "Ward-2",
    *     "ward_name_bn": "ওয়ার্ড-১",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam ward_name string required The English Ward Name of the Ward Example: ward-1.
    * @bodyParam ward_name string required The Bangla Ward Name Bn of the Ward Example: ওয়ার্ড-১.
    * @bodyParam division_id integer Ward Example: 1
    * @bodyParam district_id integer Ward Example: 1
    * @bodyParam upazila_id integer Ward Example: 1
    * @bodyParam union_id integer Ward Example: 1
    * @bodyParam pauroshoba_id integer Ward Example: 1
    * @bodyParam city_corporation_id integer Ward Example: 1
    * @bodyParam type integer Ward Example: 1
    * ......
  */
  public function store(Request $request)
  {
    $validationResult = MasterWardValidations::validate($request);

    if (!$validationResult['success']) {
      return response($validationResult);
    }
    DB::beginTransaction();

    $requestAll = $request->all();
    $data = $this->model->create($requestAll);

    $ward_details = [];
    foreach($request->all()['ward_details'] as $detail) {
        $ward_details[] = [
            'ward_name' => $detail['ward_name'],
            'ward_name_bn' => $detail['ward_name_bn']
        ];
    }
    $data['model']->ward_details()->createMany($ward_details);
    
    DB::commit();

    if ($data['success']) {
      Cache::store('redis')->forget('wards');
      App::make('wardList');
    }
    DB::rollback();
    return $data;
  }

  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 1,
    *     "type": "1",
    *     "city_corporation_id": "1",
    *     "division_id": "1",
    *     "district_id": "1",
    *     "upazilla_id": "1",
    *     "union_id": "1",
    *     "pauroshoba_id": "1",
    *     "ward_name": "Ward-2",
    *     "ward_name_bn": "ওয়ার্ড-১",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam ward_name string required The English Ward Name of the Ward Example: ward-1.
    * @bodyParam ward_name string required The Bangla Ward Name Bn of the Ward Example: ওয়ার্ড-১.
    * @bodyParam division_id integer Ward Example: 1
    * @bodyParam district_id integer Ward Example: 1
    * @bodyParam upazila_id integer Ward Example: 1
    * @bodyParam union_id integer Ward Example: 1
    * @bodyParam pauroshoba_id integer Ward Example: 1
    * @bodyParam city_corporation_id integer Ward Example: 1
    * @bodyParam type integer Ward Example: 1
    * ......
  */
  public function update(Request $request, $id)
  {
    $validationResult = MasterWardValidations::validate($request, $id);
    if (!$validationResult['success']) {
      return response($validationResult);
    }
    DB::beginTransaction();
    $requestAll = $request->all();
    $data = $this->model->update($requestAll, $id);

    $ward_details = [];
    foreach($request->all()['ward_details'] as $detail) {
        $ward_details[] = [
            'ward_name' => $detail['ward_name'],
            'ward_name_bn' => $detail['ward_name_bn']
        ];
    }
    $data['model']->ward_details()->delete();
    $data['model']->ward_details()->createMany($ward_details);

    DB::commit();
    if ($data['success']) {
      Cache::store('redis')->forget('wards');
      App::make('wardList');
    }
    DB::rollback();
    return $data;
  }

  /**
    * @urlParam id integer required The ID of the Master Component.
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    * @bodyParam ward_name string required The English Ward Name of the Ward Example: ward-1.
    * @bodyParam ward_name string required The Bangla Ward Name Bn of the Ward Example: ওয়ার্ড-১.
    * @bodyParam division_id integer Ward Example: 1
    * @bodyParam district_id integer Ward Example: 1
    * @bodyParam upazila_id integer Ward Example: 1
    * @bodyParam union_id integer Ward Example: 1
    * @bodyParam pauroshoba_id integer Ward Example: 1
    * @bodyParam city_corporation_id integer Ward Example: 1
    * @bodyParam type integer Ward Example: 1
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
   * @urlParam id integer required The ID of the Master Division.
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
      Cache::store('redis')->forget('wards');
      App::make('wardList');
    }
    return $data;
  }

  /**
   * @urlParam id integer required The ID of the Master Division.
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
      Cache::store('redis')->forget('wards');
      App::make('wardList');
    }
    return $data;
  }
}
