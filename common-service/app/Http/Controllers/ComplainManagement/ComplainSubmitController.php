<?php

namespace App\Http\Controllers\ComplainManagement;

use App\Http\Controllers\Controller;
use App\Http\Validations\ComplainManagement\ComplainSubmitValidations;
use App\Models\ComplainManagement\ComplainSubmit;
use App\Repositories\Repository;
use Illuminate\Http\Request;
use DB;
use Illuminate\Support\Facades\{Cache, App};

class ComplainSubmitController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(ComplainSubmit $complainSubmit)
    {
        // set the model
        $this->model = new Repository($complainSubmit);
    }

   /**
   * @queryParam com_title Filter by English or Bangla Name of the ComplainSubmit Example: Complain title
   * @queryParam org_id Filter by org_id of the ComplainSubmit Example: 1
   * @queryParam component_id Filter by component_id of the ComplainSubmit Example: 1
   * @queryParam module_id Filter by module_id of the ComplainSubmit Example: 1
   * @queryParam service_id Filter by service_id of the ComplainSubmit Example: 1
   * @queryParam division_id Filter by division_id of the ComplainSubmit Example: 1
   * @queryParam district_id Filter by district_id of the ComplainSubmit Example: 1
   * @queryParam upazila_id Filter by upazila_id of the ComplainSubmit Example: 1
   * @queryParam union_id Filter by union_id of the ComplainSubmit Example: 1
   * @queryParam limit int Example: 10
   */
  public function index(Request $request)
  {  
      $query = DB::table('com_complain_infos')->select('com_complain_infos.*');

    //   $query = DB::table('com_complain_infos')                        
    //                   ->join('master_components','com_complain_infos.component_id', '=','master_components.id')
    //                   ->join('master_modules','com_complain_infos.module_id', '=','master_modules.id')
    //                   ->join('master_services','com_complain_infos.service_id', '=','master_services.id')
    //                   ->join('master_org_profiles','com_complain_infos.org_id', '=','master_org_profiles.id')
    //                   ->join('master_divisions','com_complain_infos.division_id', '=','master_divisions.id')
    //                   ->join('master_districts','com_complain_infos.district_id', '=','master_districts.id')
    //                   ->join('master_upazilas','com_complain_infos.upazila_id', '=','master_upazilas.id')
    //                   ->join('master_unions','com_complain_infos.union_id', '=','master_unions.id')
    //                   ->select('com_complain_infos.*',
    //                       'master_components.component_id',
    //                       'master_modules.module_id',
    //                       'master_services.service_id',
    //                       'master_org_profiles.org_id',
    //                       'master_unions.union_id',
    //                       'master_upazilas.upazila_id',
    //                       'master_districts.district_id',
    //                       'master_divisions.division_id');

      if ($request->com_title) {
          $query = $query->where('com_complain_infos.com_title', 'like', "{$request->com_title}%")
                          ->orWhere('com_complain_infos.com_title_bn', 'like', "{$request->com_title}%");
      }

      if ($request->email) {
          $query = $query->where('com_complain_infos.email', 'like', "{$request->email}%");
      }

      if ($request->org_id) {
          $query = $query->where('com_complain_infos.org_id', $request->org_id);
      }

      if ($request->component_id) {
          $query = $query->where('com_complain_infos.component_id', $request->component_id);
      }
      if ($request->module_id) {
          $query = $query->where('com_complain_infos.module_id', $request->module_id);
      }
      if ($request->service_id) {
          $query = $query->where('com_complain_infos.service_id', $request->service_id);
      }

      if ($request->division_id) {
          $query = $query->where('com_complain_infos.division_id', $request->division_id);
      }

      if ($request->district_id) {
          $query = $query->where('com_complain_infos.district_id', $request->district_id);
      }

      if ($request->upazila_id) {
          $query = $query->where('com_complain_infos.upazila_id', $request->upazila_id);
      }

      if ($request->union_id) {
          $query = $query->where('com_complain_infos.union_id', $request->union_id);
      }

      if ($request->mobile_no) {
          $query = $query->where('com_complain_infos.mobile_no', $request->mobile_no);
      }

      if ($request->status) {
          $query = $query->where('com_complain_infos.status', $request->status);
      }

      if ($request->from_date) {
          $query = $query->whereDate('com_complain_infos.created_at', '>=', date('Y-m-d', strtotime($request->from_date)));
      }

      if ($request->to_date) {
          $query = $query->whereDate('com_complain_infos.created_at', '<=', date('Y-m-d', strtotime($request->to_date)));
      }

      $list = $query->paginate(request('per_page', config('app.per_page')));
                    //   ->orderBy('master_services.service_id', 'ASC')
                    //   ->orderBy('com_complain_infos.com_title', 'ASC')
                    //   ->paginate(request('per_page', config('app.per_page')));

      return response([
          'success' => true,
          'message' => 'Complain Info list',
          'data' => $list
      ]);
  }
    // public function list($columns = ['*'], $limit = 10)
    // {
    //     $searchable = [
    //         'com_title' => array(
    //             'com_title' => 'like',
    //             'com_title_bn' => 'orLike',
    //         ),
    //         'org_id',
    //         'component_id',
    //         'module_id',
    //         'service_id',
    //         'division_id',
    //         'district_id',
    //         'upazila_id',
    //         'union_id',
    //         'status'
    //     ];

    //     // if ($request->from_date) {
    //     //     $query = $query->whereDate('com_complain_infos.created_at', '>=', date('Y-m-d', strtotime($request->from_date)));
    //     // }

    //     // if ($request->to_date) {
    //     //     $query = $query->whereDate('com_complain_infos.created_at', '<=', date('Y-m-d', strtotime($request->to_date)));
    //     // }
    //     return $this->model->paginate($columns, $searchable, [], $limit);
    // }
  
    /**
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data Saved Successfully",
        *  "data": {
        *     "id": 1,
        *     "org_id": 1,
        *     "component_id": 1,
        *     "module_id": 1
        *     "service_id": 1
        *     "division_id": 1
        *     "district_id": 1
        *     "upazila_id": 1
        *     "union_id": 1
        *     "com_title": "Complain Submit Title"
        *     "com_title_bn": "অভিযোগ জমা শিরোনাম"
        *     "description": "Complain Submit Description"
        *     "description_bn": "অভিযোগ জমা বিবরণ"
        *     "status": "1"
        *     ..............
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to save data"
        *  "errors"  => "....."
        * }
        * @bodyParam com_title string required The English com_title of the ComplainSubmit Example: Complain Submit Title.
        * @bodyParam com_title_bn string required The English com_title_bn of the ComplainSubmit Example: অভিযোগ জমা শিরোনাম.
        * @bodyParam org_id integer required org_id of the ComplainSubmit Example: 1
        * @bodyParam component_id integer required component_id of the ComplainSubmit Example: 1
        * @bodyParam module_id integer required module_id of the ComplainSubmit Example: 1
        * @bodyParam service_id integer required service_id of the ComplainSubmit Example: 1
        * .....................................
    */

    public function store(Request $request)
    {   
        $validationResult = ComplainSubmitValidations::validate($request);    
        if (!$validationResult['success']) {
            return response($validationResult);
        }  

        $requestAll = $request->all();
        // $requestAll['created_by'] = (int)user_id()??null;

        $data = $this->model->create($requestAll);
        if ($data['success']) {
            Cache::store('redis')->forget('complainSubmit');
            App::make('complainSubmitList');
        }
        return $data;
    }
    
    /**
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data Update Successfully",
        *  "data": {
        *     "id": 1,
        *     "org_id": 1,
        *     "component_id": 1,
        *     "module_id": 1
        *     "service_id": 1
        *     "division_id": 1
        *     "district_id": 1
        *     "upazila_id": 1
        *     "union_id": 1
        *     "com_title": "Complain Submit Title"
        *     "com_title_bn": "অভিযোগ জমা শিরোনাম"
        *     "description": "Complain Submit Description"
        *     "description_bn": "অভিযোগ জমা বিবরণ"
        *     "status": "1"
        *     ..............
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to uypdate data"
        *  "errors"  => "....."
        * }
        * @bodyParam com_title string required The English com_title of the ComplainSubmit Example: Complain Submit Title.
        * @bodyParam com_title_bn string required The English com_title_bn of the ComplainSubmit Example: অভিযোগ জমা শিরোনাম.
        * @bodyParam org_id integer required org_id of the ComplainSubmit Example: 1
        * @bodyParam component_id integer required component_id of the ComplainSubmit Example: 1
        * @bodyParam module_id integer required module_id of the ComplainSubmit Example: 1
        * @bodyParam service_id integer required service_id of the ComplainSubmit Example: 1
        * .....................................
    */
    public function update(Request $request, $id)
    {
        $validationResult = ComplainSubmitValidations::validate($request, $id);    
        if (!$validationResult['success']) {
            return response($validationResult);
        }
        $requestAll = $request->all(); 
        // $requestAll['updated_by'] = (int)user_id()??null;

        $data = $this->model->update($requestAll, $id);

        if ($data['success']) {
            Cache::store('redis')->forget('complainSubmit');
            App::make('complainSubmitList');
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
        return $data;
    }
}
