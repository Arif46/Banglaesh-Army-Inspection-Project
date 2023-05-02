<?php

namespace App\Http\Controllers\Organogram;

use Validator;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Organogram\MasterOffice;
use App\Models\Organogram\MasterAssignDesignation;
use App\Models\OrgProfile\MasterDivision;
use App\Models\OrgProfile\MasterDistrict;
use App\Http\Validations\Organogram\MasterOfficeValidations;
use App\Models\Organogram\MasterOfficeType;
use Illuminate\Support\Facades\{Cache, App};
use App\Repositories\Repository;

class MasterOfficeController extends Controller
{
    // space that we can use the repository from
  protected $model;

  public function __construct(MasterOffice $MasterOffice)
  {
      // set the model
      $this->model = new Repository($MasterOffice);
  }

  /**
   * get all master office
   */
  public function organogram(Request $request)
  {
    $query= MasterOffice::
            select([
                'id',
                'office_name',
                'office_name_bn',
                'org_id',
                'parent_office_id',
                'parent_office_type_id'
            ])
            ->where('parent_office_id',0);
    if ($request->org_id ) {
        $query = $query->where('org_id', $request->org_id);
    }
    $query = $query->with(['allChildrenOffice']);
    $masterOffice= $query->orderBy('office_name', 'asc')->get();
    return response([
        'success' => true,
        'message' => 'Master Office list',
        'data' =>$masterOffice
    ]);
  }
  
  public function officeWisePeople(Request $request)
  {
      $data = $request->all();
      $baseUrl = config('app.base_url.auth_service');
      $users = \App\Library\RestService::getData($baseUrl,'/user/get-designations-wise-people');
      $users =json_decode($users, true);
      $AssignDesignation = MasterAssignDesignation::select(['id','office_id','org_id','designation_id'])->where('office_id', $data['office_id'])->with(['designation:id,org_id,designation,designation_bn'])->get()->each(function ($designation) use ($request, $users) {
          $total= 0;
          if(!empty($users)){
              foreach($users as $key=>$value){
                  if($designation->designation_id == $value['designation_id']) {
                      $total = $value['total'];
                  }
              }
          }
          $designation->total = $total;
          return $designation;
      });

      return response([
          'success' => true,
          'message' => 'Org Wise People',
          'data' =>$AssignDesignation
      ]);
  }

  /**
   * @queryParam office_name Filter by English or Bangla Name of the Office Example: District Office
   * @queryParam office_name_bn Filter by English or Bangla Name of the Office Example: জেলা অফিস
   * @queryParam org_id Filter by Office Example: 1
   * @queryParam office_code Filter by Office Example: 1
   * @queryParam area_type_id Filter by Office Example: 1
   * @queryParam office_type_id Filter by Office Example: 1
   * @queryParam division_id Filter by Office Example: 1
   * @queryParam district_id Filter by Office Example: 1
   * @queryParam upazila_id Filter by Office Example: 1
   * @queryParam union_id Filter by Office Example: 1
  */
  public function list($columns = ['*'], $limit = 10)
  {
    $searchable = [
      'office_name' => array(
        'office_name' => 'like',
        'office_name_bn' => 'orLike',
      ),
      'org_id',
      'office_code',
      'office_type_id',
      'area_type_id',
      'division_id',
      'district_id',
      'upazila_id',
      'union_id'
    ];
    return $this->model->paginate($columns, $searchable, [], $limit);
  }

  /**
   * @queryParam content Filter by content in List.
  */
  public function getAll($columns = ['*'])
  {
    $searchable = [
        'office_name' => array(
          'office_name' => 'like',
          'office_name_bn' => 'orLike',
        ),
        'org_id',
        'office_code',
        'office_type_id',
        'area_type_id',
        'division_id',
        'district_id',
        'upazila_id',
        'union_id'
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
    *     "office_name": "District Office",
    *     "office_name_bn": "জেলা অফিস",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam office_name string required The English Office Name of the Office Example: District Office.
    * @bodyParam office_name_bn string required The Bangla Office Name of the Office  Example: জেলা অফিস.
    * @queryParam org_id Filter by Office Example: 1
    * @queryParam office_code Filter by Office Example: 1
    * @queryParam area_type_id Filter by Office Example: 1
    * @queryParam office_type_id Filter by Office Example: 1
    * @queryParam division_id Filter by Office Example: 1
    * @queryParam district_id Filter by Office Example: 1
    * @queryParam upazila_id Filter by Office Example: 1
    * @queryParam union_id Filter by Office Example: 1
    *.....................
    */

    public function regionWiseDivisionOrDistrict(Request $request, $type)
    {
        if($type == 'district') {
            $query = MasterDistrict::select(['id','district_name','district_name_bn'])->oldest('district_name');
        } else if ($type == 'division') {
            $query = MasterDivision::select(['id','division_name','division_name_bn'])->oldest('division_name');
        }
        if ($request->id) {
            if ($request->id != 0) {
                $query = $query->whereHas('office', function ($q) use($request) {
                    $q->where('id', $request->id);
                    $q->where('office_type_id', 72);
                });
            }
        }
        $query = $query->with(['office' => function ($query1) use ($request) {
            $query1 = $query1->where('office_type_id', 72);
        }]);
        $datas = $query->get();
        return response([
            'success' => true,
            'message' => 'Region Wise District',
            'data' =>$datas
        ]);
    }

    public function region(Request $request)
    {
        // $query = MasterOfficeType::select("*");
        $query = MasterOffice::select(['id','office_type_id','office_name','office_name_bn'])
                ->where('status',0)
                ->where('office_type_id',72);
        if ($request->id) {
            $query = $query->where('id', $request->id);
        }
        $list = $query->orderBy('office_name', 'ASC')->get();
        return response([
            'success' => true,
            'message' => 'Region List',
            'data' => $list
        ]);
    }

  public function store(Request $request)
  {
    $validationResult = MasterOfficeValidations::validate($request);

    if (!$validationResult['success']) {
      return response($validationResult);
    }
    // return $request->all();
    $requestAll = $request->all();
    $data = $this->model->create($requestAll);

    if ($data['success']) {
      Cache::store('redis')->forget('offices');
      App::make('officeList');
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
    *     "office_name": "District Office",
    *     "office_name_bn": "জেলা অফিস",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam office_name string required The English Office Name of the Office Example: District Office.
    * @bodyParam office_name_bn string required The Bangla Office of the Office  Example: জেলা অফিস.
    * @bodyParam @queryParam org_id Filter by Office Example: 1
    * @queryParam office_code Filter by Office Example: 1
    * @queryParam area_type_id Filter by Office Example: 1
    * @queryParam office_type_id Filter by Office Example: 1
    * @queryParam division_id Filter by Office Example: 1
    * @queryParam district_id Filter by Office Example: 1
    * @queryParam upazila_id Filter by Office Example: 1
    * @queryParam union_id Filter by Office Example: 1
    *.....................
  */
  public function update(Request $request, $id)
  {
    $validationResult = MasterOfficeValidations::validate($request, $id);
    if (!$validationResult['success']) {
      return response($validationResult);
    }

    $requestAll = $request->all();
    $data = $this->model->update($requestAll, $id);

    if ($data['success']) {
      Cache::store('redis')->forget('offices');
      App::make('officeList');
    }
    return $data;
  }

  /**
    * @urlParam id integer required The ID of the Master Office.
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    *     id: 4,
    *     "org_id": "1",
    *     "office_name": "District Office",
    *     "office_name_bn": "জেলা অফিস",
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
   * @urlParam id integer required The ID of the Master Office.
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
      Cache::store('redis')->forget('offices');
      App::make('officeList');
    }
    return $data;
  }

  /**
   * @urlParam id integer required The ID of the Master Office.
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
      Cache::store('redis')->forget('offices');
      App::make('officeList');
    }
    return $data;
  }

  /**
   * get parent office by org_id, parent_office_type_id
  */
  public function parentOffice(Request $request)
  {
      $validator = Validator::make($request->all(), [
          'org_id' => 'required',
          'parent_office_type_id' => 'required',
      ]);

      if ($validator->fails()) {
          return response([
              'success' => false,
              'errors'  => $validator->errors()
          ]);
      }

      try {
          $mo = MasterOffice::select('id','office_name','office_name_bn')
                              ->where('org_id', $request->org_id)
                              ->where('id', $request->parent_office_type_id)
                              ->get();

      } catch (\Exception $ex) {
          return response([
              'success' => false,
              'message' => 'Failed to update data.',
              'errors'  => $ex->getMessage()
          ]);

      }

      return response([
          'success' => true,
          'message' => 'Parent Office List',
          'data'    => $mo
      ]);
  }

  public function getOfficeDetail($officeId)
  {
      $result = [
          'success' => true,
          'message' => '',
          'data' => null
      ];
      if (!$officeId) {
          $result['success'] = false;
          return response($result);
      }

      $model = MasterOffice::find($officeId);

      if (!$model) {
          $result['success'] = false;
      }

      $result['data'] = $model;

      return response($result);
  }

  public function getDisabledHeadOffice()
  {
      $model = MasterOffice::whereRaw("LOWER(office_name) LIKE 'head office%'")
                  ->whereOrgId(3)->first();

      if (!$model) {
          return response([
              'success' => false,
              'message' => 'Data not found!'
          ]);
      }

      return response([
          'success' => true,
          'message' => 'Data found!',
          'data' => $model
      ]);
  }

  /**
   * Create or update Tea garden office
   * 
   * @param \Illuminate\Http\Request $request
   * @return \Illuminate\Http\Response
   */
  public function createOrUpdateTeaGardenOffice(Request $request)
  {
    $officeType = MasterOfficeType::whereRaw("LOWER(office_type_name) LIKE '%tea garden%'")
        ->first(['id', 'org_id']);

    if (!$officeType) {
        return response([
            'success' => false,
            'message' => 'Tea Garden office type not exists'
        ]);
    }

    $officeData = $request->except('office_id', 'action');
    $officeData['org_id'] = $officeType->org_id;
    $officeData['office_type_id'] = $officeType->id;

    if ($request->action == 'create') {

        $office = MasterOffice::where([
            'org_id' => $officeType->org_id,
            'office_type_id' => $officeType->id,
            'office_name' => $request->office_name
        ])->first();

        if ($office) {
            return response([
                'success' => false,
                'message' => 'Office already exists'
            ]);
        }

        $office = MasterOffice::create($officeData);
    } else {
        if ($request->office_id > 0) {
            $office = MasterOffice::find($request->office_id);
            unset($officeData['created_by']);
            $office->update($officeData);
        } else {
            $office = MasterOffice::where([
                'org_id' => $officeType->org_id,
                'office_type_id' => $officeType->id,
                'office_name' => $request->office_name
            ])->first();

            if ($office) {
                return response([
                    'success' => false,
                    'message' => 'Office already exists'
                ]);
            }

            $office = MasterOffice::create($officeData);
        }
    }

    if ($data['success']) {
        Cache::store('redis')->forget('offices');
        App::make('officeList');
    }

    return response([
        'success' => true,
        'message' => "Data saved successfully",
        'data' => $office
    ]);
  }
}
