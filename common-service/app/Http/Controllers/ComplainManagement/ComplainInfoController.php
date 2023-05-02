<?php

namespace App\Http\Controllers\ComplainManagement;

use App\Http\Controllers\Controller;
use App\Models\ComplainManagement\ComplainInfo;
use App\Http\Validations\ComplainManagement\ComplainInfoValidation;
use App\Repositories\Repository;
use Illuminate\Http\Request;
use DB;
use Illuminate\Support\Facades\{Cache, App};

class ComplainInfoController extends Controller
{
    // protected $model;

    // public function __construct(ComplainInfo $ComplainInfo)
    // {
    //     // set the model
    //     $this->model = new Repository($ComplainInfo);
    // }
    public function index(Request $request)
    {  
        $query = DB::table('com_complain_infos')->select('com_complain_infos.*');

        // $query = DB::table('com_complain_infos')                        
        //                 ->join('master_components','com_complain_infos.component_id', '=','master_components.id')
        //                 ->join('master_modules','com_complain_infos.module_id', '=','master_modules.id')
        //                 ->join('master_services','com_complain_infos.service_id', '=','master_services.id')
        //                 ->join('master_org_profiles','com_complain_infos.org_id', '=','master_org_profiles.id')
        //                 ->join('master_divisions','com_complain_infos.division_id', '=','master_divisions.id')
        //                 ->join('master_districts','com_complain_infos.district_id', '=','master_districts.id')
        //                 ->join('master_upazilas','com_complain_infos.upazilla_id', '=','master_upazilas.id')
        //                 ->join('master_unions','com_complain_infos.union_id', '=','master_unions.id')
        //                 ->select('com_complain_infos.*',
        //                     'master_components.component_id',
        //                     'master_modules.module_id',
        //                     'master_services.service_id',
        //                     'master_org_profiles.org_id',
        //                     'master_unions.union_name',
        //                     'master_unions.union_name_bn',
        //                     'master_upazilas.upazilla_id',
        //                     'master_districts.district_id',
        //                     'master_divisions.division_id');
  
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

        if ($request->upazilla_id) {
            $query = $query->where('com_complain_infos.upazilla_id', $request->upazilla_id);
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

        $list = $query->orderBy('master_org_profiles.org_name', 'ASC')
                        ->orderBy('master_services.service_name', 'ASC')
                        ->orderBy('com_complain_infos.com_title', 'ASC')
                        ->paginate($request->limit ? $request->limit : 20);

        return response([
            'success' => true,
            'message' => 'Complain Info list',
            'data' => $list
        ]);
    }

    // /**
    //  * master complain type store
    //  */
    // public function store(Request $request)
    // {
    //     $validationResult = ComplainInfoValidation:: validate($request);    
        
    //     if (!$validationResult['success']) {
    //         return response($validationResult);
    //     }
        
    //     try {
    //         $compl_info = new ComplainInfo();
    //         $compl_info->com_title      = $request->com_title;
    //         $compl_info->com_title_bn   = $request->com_title_bn;
    //         $compl_info->description    = $request->description;
    //         $compl_info->description_bn = $request->description_bn;
    //         $compl_info->org_id         = (int)$request->org_id;
    //         $compl_info->component_id     = (int)$request->component_id;
    //         $compl_info->module_id     = (int)$request->module_id;
    //         $compl_info->service_id     = (int)$request->service_id;
    //         $compl_info->division_id    = (int)$request->division_id;
    //         $compl_info->district_id    = (int)$request->district_id;
    //         $compl_info->upazilla_id    = (int)$request->upazilla_id;
    //         $compl_info->union_id       = (int)$request->union_id;
    //         $compl_info->mobile_no      = $request->mobile_no;
    //         $compl_info->email          = $request->email;
    //         $compl_info->created_by     = (int)user_id();
    //         $compl_info->updated_by     = (int)user_id();
    //         $compl_info->save();

    //         save_log([
    //             'data_id'    => $compl_info->id,
    //             'table_name' => 'com_complain_infos'
    //         ]);

    //     } catch (\Exception $ex) {
    //         return response([
    //             'success' => false,
    //             'message' => 'Failed to save data.',
    //             'errors'  => env('APP_ENV') !== 'production' ? $ex->getMessage() : []
    //         ]);
    //     }

    //     return response([
    //         'success' => true,
    //         'message' => 'Data save successfully',
    //         'data'    => $compl_info
    //     ]);
    // }

    public function store(Request $request)
    {   
        $validationResult = ComplainInfoValidation::validate($request);    
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
     * master complain type update
     */
    public function update(Request $request, $id)
    {
        $validationResult = ComplainInfoValidation:: validate($request ,$id);    
        
        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $compl_info = ComplainInfo::find($id);

        if (!$compl_info) {
            return response([
                'success' => false,
                'message' => 'Data not found.'
            ]);
        }

        try {
            $compl_info->com_title      = $request->com_title;
            $compl_info->com_title_bn   = $request->com_title_bn;
            $compl_info->description    = $request->description;
            $compl_info->description_bn = $request->description_bn;
            $compl_info->org_id         = (int)$request->org_id;
            $compl_info->component_id     = (int)$request->component_id;
            $compl_info->module_id     = (int)$request->module_id;
            $compl_info->service_id     = (int)$request->service_id;
            $compl_info->division_id    = (int)$request->division_id;
            $compl_info->district_id    = (int)$request->district_id;
            $compl_info->upazilla_id    = (int)$request->upazilla_id;
            $compl_info->union_id       = (int)$request->union_id;
            $compl_info->mobile_no      = $request->mobile_no;
            $compl_info->email          = $request->email;
            $compl_info->updated_by     = (int)user_id();
            $compl_info->update();

            save_log([
                'data_id'       => $compl_info->id,
                'table_name'    => 'com_complain_infos',
                'execution_type'=> 1
            ]);

        } catch (\Exception $ex) {
            return response([
                'success' => false,
                'message' => 'Failed to update data.',
                'errors'  => env('APP_ENV') !== 'production' ? $ex->getMessage() : []
            ]);
        }

        return response([
            'success' => true,
            'message' => 'Data update successfully',
            'data'    => $compl_info
        ]);
    }

    /**
     * master complain type status update
     */
    // public function toggleStatus($id)
    // {
    //     $compl_info = ComplainInfo::find($id);

    //     if (!$compl_info) {
    //         return response([
    //             'success' => false,
    //             'message' => 'Data not found.'
    //         ]);
    //     }

    //     $compl_info->status = $compl_info->status ? 1 : 2;
    //     $compl_info->update();

    //     save_log([
    //         'data_id'       => $compl_info->id,
    //         'table_name'    => 'com_complain_infos',
    //         'execution_type'=> 2
    //     ]);

    //     return response([
    //         'success' => true,
    //         'message' => 'Data updated successfully',
    //         'data'    => $compl_info
    //     ]);
    // }
    public function toggleStatus($id)
    {
        $data = $this->model->toggleStatus($id);   
        return $data;
    }
    /**
     * master complain type status update
     */
    public function solveStatus($id)
    {
        $compl_info = ComplainInfo::find($id);

        if (!$compl_info) {
            return response([
                'success' => false,
                'message' => 'Data not found.'
            ]);
        }

        $compl_info->status = 5;
        $compl_info->update();

        save_log([
            'data_id'       => $compl_info->id,
            'table_name'    => 'com_complain_infos',
            'execution_type'=> 2
        ]);

        return response([
            'success' => true,
            'message' => 'Data updated successfully',
            'data'    => $compl_info
        ]);
    }

    /**
     * master complain type destroy
     */
    public function destroy($id)
    {
        $compl_info = ComplainInfo::find($id);

        if (!$compl_info) {
            return response([
                'success' => false,
                'message' => 'Data not found.'
            ]);
        }

        $compl_info->delete();

        save_log([
            'data_id'       => $id,
            'table_name'    => 'com_complain_infos',
            'execution_type'=> 2
        ]);

        return response([
            'success' => true,
            'message' => 'Data deleted successfully'
        ]);
    }
}

