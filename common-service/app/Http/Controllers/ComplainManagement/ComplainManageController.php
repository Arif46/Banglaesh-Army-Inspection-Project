<?php

namespace App\Http\Controllers\ComplainManagement;

use App\Http\Controllers\Controller;
use App\Models\ComplainManagement\{ComplainReject, ComplainApprove, ComplainCommittee, ComplainCommitteeReport};
use App\Http\Validations\ComplainManagement\{ComplainRejectValidation, ComplainApproveValidation, ComplainCommitteeValidation, ComplainReportSubmitValidation };
use App\Repositories\Repository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\{Cache, App};
use App\Helpers\Base64FileUpload;


class ComplainManageController extends Controller
{
    /**
     * get all complain request
     */
    public function complainRequest (Request $request) 
    {        
        $query = DB::table('com_complain_infos')                                                
                        ->join('master_services','com_complain_infos.service_id', '=','master_services.id')
                        ->join('master_org_profiles','com_complain_infos.org_id', '=','master_org_profiles.id')
                        ->join('master_divisions','com_complain_infos.division_id', '=','master_divisions.id')
                        ->join('master_districts','com_complain_infos.district_id', '=','master_districts.id')
                        ->join('master_upazilas','com_complain_infos.upazilla_id', '=','master_upazilas.id')
                        ->join('master_unions','com_complain_infos.union_id', '=','master_unions.id')
                        ->select('com_complain_infos.*',
                            'master_services.service_name','master_services.service_name_bn',
                            'master_org_profiles.org_name','master_org_profiles.org_name_bn',
                            'master_unions.union_name','master_unions.union_name_bn',
                            'master_upazilas.upazila_name','master_upazilas.upazila_name_bn',
                            'master_districts.district_name','master_districts.district_name_bn',
                            'master_divisions.division_name','master_divisions.division_name_bn');
        
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

        $list = $query->paginate($request->limit ? $request->limit : 20);

        return response([
            'success' => true,
            'message' => 'Complain Info list',
            'data' => $list
        ]);
    }

    /**
     * assign committee
     */
    public function assignCommittee (Request $request) 
    {     
        $validationResult = ComplainCommitteeValidation:: validate($request);    
        
        if (!$validationResult['success']) {
            return response($validationResult);
        }
        
        try {
            
            ComplainCommittee::where('complain_id', $request[0]['complain_id'])->delete();

            foreach($request->all() as $complain) { 
                $cc = new ComplainCommittee();
                $cc->complain_id    = (int)$complain['complain_id'];
                $cc->role_id        = (int)$complain['role_id'];
                $cc->user_id        = (int)$complain['user_id'];
                $cc->designation_id = (int)$complain['designation_id'];
                $cc->created_by     = (int)user_id();
                $cc->updated_by     = (int)user_id();
                $cc->save();
            }           

            save_log([
                'data_id'    => $cc->id,
                'table_name' => 'com_committees'
            ]);

        } catch (\Exception $ex) {
            return response([
                'success' => false,
                'message' => 'Failed to save data.',
                'errors'  => env('APP_ENV') !== 'production' ? $ex->getMessage() : []
            ]);
        }

        return response([
            'success' => true,
            'message' => 'Data save successfully',
            'data'    => $cc
        ]);
    }

    /**
     * get committee
     */
    public function getCommittee($complain_id) 
    {        
        $cc = ComplainCommittee::where('complain_id', $complain_id)->get()->toArray();
        if(!empty($cc)){
            foreach ($cc as $key=>$value) {
                $cc[$key]['roleList'] = [];
                $cc[$key]['userList'] = [];
                $cc[$key]['designationList'] = [];
            }
        }

        if (!$cc) {
            return response([
                'success' => false,
                'message' => 'Data not found.'
            ]);
        } else {
            return response([
                'success' => true,
                'message' => 'Data list',
                'data'    => $cc
            ]);
        }
    }

    /**
     * report submit
     */
    public function reportSubmit(Request $request) 
    {        
        $validationResult = ComplainReportSubmitValidation:: validate($request);    
        
        if (!$validationResult['success']) {
            return response($validationResult);
        }
        
        try {
           
            $requestAll = $request->all();
            if ($request->attachment) {
                $requestAll['attachment'] = Base64FileUpload::uploadFile($request, $file_path,'attachment');              
            }
            $model = ComplainCommitteeReport::create($requestAll);  
            save_log([
                'data_id'    => $rs->id,
                'table_name' => 'com_committee_reports'
            ]);

        } catch (\Exception $ex) {
            return response([
                'success' => false,
                'message' => 'Failed to save data.',
                'errors'  => env('APP_ENV') !== 'production' ? $ex->getMessage() : []
            ]);
        }

        return response([
            'success' => true,
            'message' => 'Data save successfully',
            'data'    => $rs
        ]);
    }

    /**
     * get report list
     */
    public function getCommitteeReport($complain_id) 
    {        
        $cr = ComplainCommitteeReport::where('complain_id', $complain_id)->get();

        if (!$cr) {
            return response([
                'success' => false,
                'message' => 'Data not found.'
            ]);
        } else {
            return response([
                'success' => true,
                'message' => 'Data list',
                'data'    => $cr
            ]);
        }        
    }

    /**
     * complain approve
     */
    public function complainApprove(Request $request, $id) 
    {   
        DB::table('com_complain_infos')
            ->where('id', '=', $id)
            ->update(['status' =>  5]);

        $validationResult = ComplainApproveValidation:: validate($request);    
        
        if (!$validationResult['success']) {
            return response($validationResult);
        }
        
        try {           
            $requestAll = $request->all();
            if ($request->attachment) {
                $requestAll['attachment'] = Base64FileUpload::uploadFile($request, $file_path,'attachment');              
            }
            $model = ComplainApprove::create($requestAll);            

            save_log([
                'data_id'    => $ca->id,
                'table_name' => 'com_approve'
            ]);

        } catch (\Exception $ex) {
            return response([
                'success' => false,
                'message' => 'Failed to save data.',
                'errors'  => env('APP_ENV') !== 'production' ? $ex->getMessage() : []
            ]);
        }

        return response([
            'success' => true,
            'message' => 'Data save successfully',
            'data'    => $ca
        ]);
    }

    /**
     * complain reject
     */
    public function complainReject(Request $request, $id) 
    {    
        DB::table('com_complain_infos')
            ->where('id', '=', $id)
            ->update(['status' =>  4]);

        $validationResult = ComplainRejectValidation:: validate($request);    
        
        if (!$validationResult['success']) {
            return response($validationResult);
        }
        
        try {

            $requestAll = $request->all();
            if ($request->attachment) {
                $requestAll['attachment'] = Base64FileUpload::uploadFile($request, $file_path,'attachment');              
            }
            $model = ComplainReject::create($requestAll);  

            save_log([
                'data_id'    => $cr->id,
                'table_name' => 'com_reject'
            ]);

        } catch (\Exception $ex) {
            return response([
                'success' => false,
                'message' => 'Failed to save data.',
                'errors'  => env('APP_ENV') !== 'production' ? $ex->getMessage() : []
            ]);
        }

        return response([
            'success' => true,
            'message' => 'Data save successfully',
            'data'    => $cr
        ]);
    }
}

