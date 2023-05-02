<?php

namespace App\Http\Controllers\Portal;

use App\Helpers\Base64FileUpload;
use App\Http\Controllers\Controller;
use App\Http\Validations\Portal\ServiceValidation;
use App\Models\Portal\Service;
use App\Models\Portal\ServicePermission;
use Illuminate\Http\Request;
use DB;
use Illuminate\Support\Facades\{Cache, App};

class ServiceController extends Controller
{
    /**
     * @queryParam service_type_id Filter by Service Type in List.
     * @queryParam component_id Filter by Component Name in List.
     * @queryParam service_name Filter by Service Name En Bn in List.
     * @queryParam ministry_id Filter by Minitry Name in List.
     * ...............
     * @queryParam limit int Example: 10
    */
    public function index(Request $request) {

        $query = Service::with(['attachment', 'fees', 'permission', 'customers', 'orgList'])
        ->where('service_type_id', $request->service_type_id)
        ->orderBy('id', 'DESC');

        if ($request->component_id) {
            $query = $query->where('component_id', $request->component_id);
        }

        if ($request->org_id) {
            if ($request->service_type_id == 1) {
                $query = $query->whereHas('orgList', function ($q) use ($request) {
                    return $q->where('portal_service_org.org_id', $request->org_id);
                });
            } else {
                $query = $query->where('org_id', $request->org_id);
            }
        }

        if ($request->ministry_id) {
            $query = $query->where('ministry_id', $request->ministry_id);
        }

        if ($request->service_name) {
            $query = $query->where('name', 'like', "%{$request->service_name}%")
                ->orwhere('name_bn', 'like', "%{$request->service_name}%");
        }

        $list = $query->paginate($request->limit ? $request->limit : 20);

        return [
            'success' => true,
            'message' => 'Service List',
            'data'    => $list
        ];
    }
   
    /**
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data Saved Successfully",
        *  "data": {
            *   id: 1,
            *   "service_type_id": 1 (1 = IDSDP, 2= API, 3=Link),
            *   "component_id": 1 (when service_type_id 1),
            *   "org_id": [1, 2] (when service_type_id 1),
            *   "ministry_id": 2 (when service_type_id 2 and 3),
            *   "ex_org_id": 1 (when service_type_id 2 and 3),
            *   "api_manager": "attachment" (when service_type_id 2),
            *   "service_category_id": 2,
            *   "customer_type_id": [1],
            *   "name": 1,
            *   "name_bn": 1,
            *   ............,
            *   ............,
            *   "service_url": "bazar-monitoring-service/bazar-schedule/list",
            *   "status": "1"
            *   .........
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to save data"
        *  "errors"  => "....."
        * }
        * @bodyParam ministry_id bigInteger required The Ministry Name of the MinistryEntry.
        * @bodyParam ex_org_id bigInteger required The External Organization Name of the OrganizationEntry.
        * @bodyParam org_id bigInteger required The Organization Name of the OrganizationProfile.
        * ......
    */
    public function store(Request $request)
    {
        // return $request->all();
        $validationResult = ServiceValidation::validate($request);

        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $allData = $request->all();
        try {
            DB::beginTransaction();

            if ($allData['operating_procedure']) {
                $attachment = Base64FileUpload::uploadFile($request, 'operating_procedure', 'portal/service', null);
                $allData['operating_procedure'] = $attachment['success'] ? $attachment['data'] : null;
            }

            if ($allData['form_attachment']) {
                $attachment = Base64FileUpload::uploadFile($request, 'form_attachment', 'portal/service', null);
                $allData['form_attachment'] = $attachment['success'] ? $attachment['data'] : null;
            }

            if ($allData['policy_attachment']) {
                $attachment = Base64FileUpload::uploadFile($request, 'policy_attachment', 'portal/service', null);
                $allData['policy_attachment'] = $attachment['success'] ? $attachment['data'] : null;
            }

            if ($allData['process']) {
                $attachment = Base64FileUpload::uploadImage($request, 'process', '/storage/portal/service', null);
                $allData['process'] = $attachment['success'] ? $attachment['data'] : null;
            }

            if ($allData['api_manager']) {
                $attachment = Base64FileUpload::uploadFile($request, 'api_manager', 'portal/service', null);
                $allData['api_manager'] = $attachment['success'] ? $attachment['data'] : null;
            }

            if ($allData['image']) {
                // $attachment = Base64FileUpload::uploadFile($request, 'image', 'portal/service', null);
                // $allData['image'] = $attachment['success'] ? $attachment['data'] : null;

                $image = Base64FileUpload::uploadImage($allData, 'image', '/storage/portal/service', null);         
                $allData['image'] = $image['success'] ? $image['data'] : null;
            }

            if ($allData['service_type_id'] == 1) {
                $allData['ministry_id'] = null;
                $allData['ex_org_id'] = null;
            } else {
                $allData['component_id'] = null;
            }

            // $allData['updated_by'] = (int) user_id();
            $allData['created_by'] = 1;
            $allData['updated_by'] = 1;
            $model = Service::create($allData);

            if ($allData['service_type_id'] == 1) {
                $model->orgList()->attach($allData['org_id']);
            }

            $attachment = $allData['attachment'];
            if(!empty($attachment[0]['name'] !== '')) {
                $model->attachment()->createMany($attachment);
            }

            $customers = $allData['customer_type_id'];
            $model->customers()->attach($customers);

            $fees = $request->fees;
            if($fees[0]['name'] !== '') {
                $model->fees()->createMany($fees);
            }

            $modelPr = $allData['permission'];
            $modelPr['service_id'] = $model->id;
            ServicePermission::create($modelPr);

            // save_log([
            //     'data_id'    => $model->id,
            //     'table_name' => 'portal_services',
            // ]);

            DB::commit();

            Cache::store('redis')->forget('portalServiceName');
            App::make('portalServiceNameList');
        
            return [
                'success' => true,
                'message' => 'Data save successfully',
                'model'    => $model
            ];

        } catch (\Exception $ex) {
            DB::rollback();
            return [
                'success' => false,
                'message' => 'Failed to save data.',
                'errors'  => env('APP_ENV') !== 'production' ? $ex->getMessage() : []
            ];
        }
    }


        /**
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data Updated Successfully",
        *  "data": {
            *   id: 1,
            *   "service_type_id": 1 (1 = IDSDP, 2= API, 3=Link),
            *   "component_id": 1 (when service_type_id 1),
            *   "org_id": [1, 2] (when service_type_id 1),
            *   "ministry_id": 2 (when service_type_id 2 and 3),
            *   "ex_org_id": 1 (when service_type_id 2 and 3),
            *   "api_manager": "attachment" (when service_type_id 2),
            *   "service_category_id": 2,
            *   "customer_type_id": [1],
            *   "name": 1,
            *   "name_bn": 1,
            *   ............,
            *   ............,
            *   "service_url": "bazar-monitoring-service/bazar-schedule/list",
            *   "status": "1"
            *   .........
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to save data"
        *  "errors"  => "....."
        * }
        * @bodyParam ministry_id bigInteger required The Ministry Name of the MinistryEntry.
        * @bodyParam ex_org_id bigInteger required The External Organization Name of the OrganizationEntry.
        * @bodyParam org_id bigInteger required The Organization Name of the OrganizationProfile.
        * ......
    */
    public function update(Request $request, $id)
    {
        // return $request->all();
        $validationResult = ServiceValidation::validate($request, $id);

        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $service = Service::find($id);
        if (!$service) {
            return [
                'success' => false,
                'message' => 'Data not found.'
            ];
        }

        $allData = $request->all();
        try {
            DB::beginTransaction();

            if ($allData['operating_procedure']) {
                $attachment = Base64FileUpload::uploadFile($request, 'operating_procedure', 'portal/service', $service->operating_procedure);
                $service['operating_procedure'] = $attachment['success'] ? $attachment['data']: null;
            } else {
                $allData['operating_procedure'] =  $service->operating_procedure;
            }

            if ($allData['form_attachment']) {
                $attachment = Base64FileUpload::uploadFile($request, 'form_attachment', 'portal/service', $service->form_attachment);
                $allData['form_attachment'] = $attachment['success'] ? $attachment['data']: null;
            } else {
                $allData['form_attachment'] =  $service->form_attachment;
            }

            if ($allData['policy_attachment']) {
                $attachment = Base64FileUpload::uploadFile($request, 'policy_attachment', 'portal/service', $service->policy_attachment);
                $allData['policy_attachment'] = $attachment['success'] ? $attachment['data']: null;
            } else {
                $allData['policy_attachment'] =  $service->policy_attachment;
            }

            // if ($allData['process']) {
            //     $attachment = Base64FileUpload::uploadFile($request, 'process', 'portal/service', $service->process);
            //     $allData['process'] = $attachment['success'] ? $attachment['data']: null;
            // } else {
            //     $allData['process'] =  $service->process;
            // }

            if ($allData['process']) {
                $image = Base64FileUpload::uploadImage($request, 'process', '/portal/service', $service->process);
                $allData['process'] = $image['success'] ? $image['data'] : null;
            } else {
                $allData['process'] =  $service->process;
            }

            if ($allData['api_manager']) {
                $attachment = Base64FileUpload::uploadFile($request, 'api_manager', 'portal/service', $service->api_manager);
                $allData['api_manager'] = $attachment['success'] ? $attachment['data'] : null;
            } else {
                $allData['api_manager'] =  $service->api_manager;
            }

            if ($allData['image']) {
                $image = Base64FileUpload::uploadImage($request, 'image', '/portal/service', $service->image);
                $allData['image'] = $image['success'] ? $image['data'] : null;
            } else {
                $allData['image'] =  $service->image;
            }


            if ($allData['service_type_id'] == 1) {
                $allData['ministry_id'] = null;
                $allData['ex_org_id'] = null;
            } else {
                $allData['component_id'] = null;
            }

            // $allData['updated_by'] = (int) user_id();
            $allData['updated_by'] = 1;
            $model = $service->update($allData);

            if ($allData['service_type_id'] == 1) {
                $service->orgList()->sync($allData['org_id']);
            }

            $service->attachment()->delete();
            $attachment = $allData['attachment'];
            if(!empty($attachment[0]['name'] !== '')) {
                $service->attachment()->createMany($attachment);
            }

            $customers = $allData['customer_type_id'];
            $service->customers()->sync($customers);

            $service->fees()->delete();
            $fees = $request->fees;
            if($fees[0]['name'] !== '') {
                $service->fees()->createMany($fees);
            }

            $modelPr = $allData['permission'];
            $updatePr = ServicePermission::where('service_id', $service->id)->first();
            $updatePr->update($modelPr);

            DB::commit();

            Cache::store('redis')->forget('portalServiceName');
            App::make('portalServiceNameList');

            return [
                'success' => true,
                'message' => 'Data updated successfully',
                'model'    => $model
            ];

        } catch (\Exception $ex) {
            DB::rollback();
            return [
                'success' => false,
                'message' => 'Failed to save data.',
                'errors'  => env('APP_ENV') !== 'production' ? $ex->getMessage() : []
            ];
        }
    }

/**
   * @urlParam id integer required The ID of the Service Entry.     
   * @response scenario=success {
   *  "message": "Data updated successfully"
   * }
   * @response scenario="Failed" {
   *  "message": "Data not found"
   * }
  */
    public function toggleStatus($id)
    {
        $service = Service::find($id);

        if (!$service) {
            return [
                'success' => false,
                'message' => 'Data not found.'
            ];
        }

        $service->status = $service->status === 1 ? 2 : 1;
        $service->update();

        // save_log([
        //     'data_id'        => $id,
        //     'table_name'     => 'portal_services',
        //     'execution_type' => 2
        // ]);

        Cache::store('redis')->forget('portalServiceName');
        App::make('portalServiceNameList');

        return [
            'success' => true,
            'message' => 'Data updated successfully',
            'data'    => $service
        ];
    }


/**
   * @urlParam id integer required The ID of the Service Entry.     
   * @urlParam is_featured small string required 1 for featured and 0 = unfeatured the services.     
   * @response scenario=success {
   *  "message": "Data updated successfully"
   * }
  */
    public function updateFeature(Request $request)
    {
        $datas = $request->all();
        if(!empty($datas)){
            foreach($datas as $key=>$value){
                $UpdateData= Service::where('id',$value['id'])->first();
                $UpdateData->is_featured = $value['is_featured'];
                $UpdateData->save();
            }
        }
        return [
            'success' => true,
            'message' => 'Data updated successfully',
            'data'    => $datas
        ];
    }

}
