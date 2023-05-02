<?php

namespace App\Http\Controllers\ComplainManagement;

use App\Http\Controllers\Controller;
use App\Http\Validations\ComplainManagement\ComplainSendValidation;
use App\Models\ComplainManagement\ComplainSend;
use App\Repositories\Repository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\{Cache, App};

class ComplainSendController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(ComplainSend $ComplainSend)
    {
        // set the model
        $this->model = new Repository($ComplainSend);
    }

   /**
   * @queryParam com_title Filter by English or Bangla Name of the ComplainSend Example: Complain title
   * @queryParam org_id Filter by org_id of the ComplainSend Example: 1
   * @queryParam component_id Filter by component_id of the ComplainSend Example: 1
   * @queryParam module_id Filter by module_id of the ComplainSend Example: 1
   * @queryParam service_id Filter by service_id of the ComplainSend Example: 1
   * @queryParam division_id Filter by division_id of the ComplainSend Example: 1
   * @queryParam district_id Filter by district_id of the ComplainSend Example: 1
   * @queryParam upazila_id Filter by upazila_id of the ComplainSend Example: 1
   * @queryParam union_id Filter by union_id of the ComplainSend Example: 1
   * @queryParam limit int Example: 10
   */
    public function index(Request $request)
    {  
        $query = DB::table('com_complain_cycle')                        
                        ->join('com_complain_infos','com_complain_cycle.complain_id', '=','com_complain_infos.id')
                        ->join('master_services','com_complain_infos.service_id', '=','master_services.id')
                        ->select('com_complain_cycle.*',
                            'com_complain_infos.service_id',
                            'master_services.service_name', 'master_services.service_name_bn',
                            'com_complain_infos.com_title','com_complain_infos.com_title_bn',
                            'com_complain_infos.description','com_complain_infos.description_bn',
                            'com_complain_infos.status as complain_status');
        
        if ($request->com_title) {
            $query = $query->where('com_complain_infos.com_title', 'like', "{$request->com_title}%")
                            ->orWhere('com_complain_infos.com_title_bn', 'like', "{$request->com_title}%");
        }
        if ($request->note) {
            $query = $query->where('com_complain_cycle.note', 'like', "{$request->note}%")
                            ->orWhere('com_complain_cycle.note_bn', 'like', "{$request->note}%");
        }

        if ($request->complain_id) {
            $query = $query->where('com_complain_cycle.complain_id', $request->complain_id);
        }

        if ($request->receiver_id) {
            $query = $query->where('com_complain_cycle.receiver_id', $request->receiver_id);
        }

        if ($request->sender_id) {
            $query = $query->where('com_complain_cycle.sender_id', $request->sender_id);
        }

        if ($request->status) {
            $query = $query->where('com_complain_cycle.status', $request->status);
        }

        $list = $query->paginate($request->limit ? $request->limit : 20);

        return response([
            'success' => true,
            'message' => 'Complain Info list',
            'data' => $list
        ]);
    }

    /**
     * get all master complain type
     */
    public function detailList($complain_id)
    {      
        $query = DB::table('com_complain_infos')
                        ->leftJoin('com_complain_cycle','com_complain_infos.id', '=','com_complain_cycle.complain_id')                        
                        ->leftJoin('master_services','com_complain_infos.service_id', '=','master_services.id')
                        ->select('com_complain_cycle.*',
                            'com_complain_infos.service_id',
                            'master_services.service_name', 'master_services.service_name_bn',
                            'com_complain_infos.com_title','com_complain_infos.com_title_bn',
                            'com_complain_infos.description','com_complain_infos.description_bn',
                            'com_complain_infos.status as complain_status')
                        ->where('com_complain_infos.id',$complain_id)
                        ->get(); 
     
        return response([
            'success' => true,
            'message' => 'Complain Info list',
            'data' => $query
        ]);
    }
  
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
        * @bodyParam com_title string required The English com_title of the ComplainSend Example: Complain Submit Title.
        * @bodyParam com_title_bn string required The English com_title_bn of the ComplainSend Example: অভিযোগ জমা শিরোনাম.
        * @bodyParam org_id integer required org_id of the ComplainSend Example: 1
        * @bodyParam component_id integer required component_id of the ComplainSend Example: 1
        * @bodyParam module_id integer required module_id of the ComplainSend Example: 1
        * @bodyParam service_id integer required service_id of the ComplainSend Example: 1
        * .....................................
    */

    public function store(Request $request)
    {   
        DB::table('com_complain_infos')
        ->where('id', '=', $request->complain_id)
        ->update(['status' =>  6]);
        
        $validationResult = ComplainSendValidations::validate($request);    
        if (!$validationResult['success']) {
            return response($validationResult);
        }  

        $requestAll = $request->all();
        // $requestAll['created_by'] = (int)user_id()??null;

        $data = $this->model->create($requestAll);
        if ($data['success']) {
            Cache::store('redis')->forget('ComplainSend');
            App::make('ComplainSendList');
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
        * @bodyParam com_title string required The English com_title of the ComplainSend Example: Complain Submit Title.
        * @bodyParam com_title_bn string required The English com_title_bn of the ComplainSend Example: অভিযোগ জমা শিরোনাম.
        * @bodyParam org_id integer required org_id of the ComplainSend Example: 1
        * @bodyParam component_id integer required component_id of the ComplainSend Example: 1
        * @bodyParam module_id integer required module_id of the ComplainSend Example: 1
        * @bodyParam service_id integer required service_id of the ComplainSend Example: 1
        * .....................................
    */
    public function update(Request $request, $id)
    {
        $validationResult = ComplainSendValidations::validate($request, $id);    
        if (!$validationResult['success']) {
            return response($validationResult);
        }
        $requestAll = $request->all(); 
        // $requestAll['updated_by'] = (int)user_id()??null;

        $data = $this->model->update($requestAll, $id);

        if ($data['success']) {
            Cache::store('redis')->forget('ComplainSend');
            App::make('ComplainSendList');
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
            Cache::store('redis')->forget('complainSend');
            App::make('complainSendList');
        }
        return $data;
    }
}
