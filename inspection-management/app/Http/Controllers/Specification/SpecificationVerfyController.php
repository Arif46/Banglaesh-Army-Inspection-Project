<?php

namespace App\Http\Controllers\Specification;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Specification\{
    Item,
    ItemSpecification, 
    SupplierItem,
    SupplierItemSpecification 
};
use App\Http\Validations\Specification\SpecificationVerifyValidations;
use Illuminate\Support\Facades\DB;
use App\Helpers\Base64FileUpload;
class SpecificationVerfyController extends Controller
{
    /**
     * @queryParam Specification verify list
     */
    public function index(Request $request)
    {
        $query = SupplierItem::with([
            'supplier_specification_details.childs.specification_item',
            'supplier_specification_details.specification_item',
            'items_name'
        ])->latest();

        if ($request->supplier_name) {
            $query = $query->where('supplier_name', 'like', "%{$request->supplier_name}%");
        }

        if ($request->demand_no) {
            $query = $query->where('demand_no', 'like', "%{$request->demand_no}%");
        }

        $list = $query->paginate($request->limit);

        if (!$list) {

            return response()->json([
                'success' => false,
                'message' => 'Data Not Found'
            ]);

        } else {
            return response()->json([
                'success' => true,
                'data' => $list,
                'message' => 'Supplier Info List'
            ],201);
        }
    }

    /**
     * @queryParam Specification info list
     */
    public function verifyInfoList(Request $request)
    {
        $query = Item::with('specificationDetails.childs');

        if ($request->demand_no) {
            $query = $query->where('demand_no', $request->demand_no);
        }  
        
        $list = $query->first();

        if (!$list) {
            return response([
                'success' => false,
                'message' => 'Data not found.'
            ]);
        }

        return response([
            'success' => true,
            'message' => 'Data found.',
            'data' => $list
        ]);      
    }

    /**
     * @queryParam Specification verify 
     * @queryParam Store
     */
    public function store(Request $request)
    {
        $validationResult = SpecificationVerifyValidations::validate($request);  

        if (!$validationResult['success']) {
            return response($validationResult);
        }

        DB::beginTransaction();

        try {
            $requestAll = $request->all();
            $model = SupplierItem::create([
                'demand_no' => $request->demand_no,
                'item_id' => $request->id,
                'supplier_name' => $request->supplier_name,
                'offer_date' => $request->offer_date,
                'total_fully_comply' => $request->total_fully_comply,
                'total_partially_comply' => $request->total_partially_comply,
                'total_reject' => $request->total_reject,
                'result_id' => $request->result_id,
                'attachement' => $this->appFileUpload($request, 'attachement')
            ]);

            // $specificationData = [];
            foreach ($request->specification_details as $specificationItem) {
                $specificationData = [];
                if ($specificationItem['has_child']) {
                    unset($specificationData['childs']);
                }
                $specificationData['specification_id'] = $specificationItem['id'];
                $specificationData['received_specification'] = isset($specificationItem['received_specification']) ? $specificationItem['received_specification'] : NULL;
                $specificationData['verify_status'] = isset($specificationItem['verify_status']) ? $specificationItem['verify_status'] : 0;
                $specificationData['reason'] = isset($specificationItem['reason']) ? $specificationItem['reason'] : NULL;
                $specificationModel = $model->supplierSpecifications()->create($specificationData);
                
                if ($specificationItem['has_child']) {
                    $childsArr = $specificationItem['childs'];
                    $arr = [];
                    foreach ($childsArr as $key => $item) {
                        $arr[$key]['supplier_item_id'] = $model->id;
                        $arr[$key]['specification_id'] = $item['id'];
                        $arr[$key]['verify_status'] = $item['verify_status'];
                        $arr[$key]['received_specification'] = $item['received_specification'];
                        $arr[$key]['reason'] = $item['reason'] ?? '';
                    }
                    $specificationModel->childs()->createMany($arr);
                }
            }

            DB::commit();

        } catch (\Exception $ex) {
            DB::rollBack();
            return [
                'success' => false,
                'message' => 'Failed to saved data.',
                'errors'  => env('APP_ENV') !== 'production' ? $ex->getMessage() : []
            ];
        }   

        return response()->json([
            'success' => true,
            'message' => 'Data Save Successfully',
            'data' => $model
        ],200);
    }

    /**
     * file upload save and Update Function
     */

    private function appFileUpload ($request, $file_name) {
        if (isset($request[$file_name])) {
            $image = Base64FileUpload::uploadFile($request, $file_name, 'Specification/specificication-verify', null);
            return $image['success'] ? $image['data']: null;
        } else {
            return '';
        }
    }


    /**
     * Specification Verify All List
     */
    public function show(Request $request, $id)
    {
        $query = SupplierItem::with([
            'specification_details' => function ($query) {
                $query->where('parent_id', null);
            },
            'specification_details.childs.specification_item',
            'specification_details.specification_item',
            'items_name'
        ])->find($id);

        if ($request->supplier_name) {
            $query = $query->where('supplier_name', 'like', "%{$request->supplier_name}%");
        }

        if ($request->demand_no) {
            $query = $query->where('demand_no', 'like', "%{$request->demand_no}%");
        }

        $list = $query;

        if (!$list) {

            return response()->json([
                'success' => false,
                'message' => 'Data Not Found'
            ]);

        } else {
            return response()->json([
                'success' => true,
                'message' => 'Supplier Offer List',
                'data' => $list
            ],201);
        }
    }

    /**
     * Specification Verify Update Method
     */
    public function update(Request $request, $id)
    {
        // return $request->all();
        $validationResult = SpecificationVerifyValidations::validate($request, $id);  

        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $model = SupplierItem::find($id);

        if (!$model) {
            return response([
                'success' => false,
                'message' => 'Data not found.'
            ]);
        }

        DB::beginTransaction();

        try {
            $requestAll = $request->all();
            $model->update([
                'attachement' => $this->appFileUpload($request, 'attachement')
            ]);

            // Delete Previous Specification Details Data
            $model->specification_details()->delete();

            foreach ($request->specification_details as $specificationItem) {
                $specificationData = $specificationItem;
                if ($specificationItem['childs']) {
                    unset($specificationData['childs']);
                }
                $specificationData['specification_id'] = $specificationItem['specification_id'];
                $specificationData['received_specification'] = isset($specificationItem['received_specification']) ? $specificationItem['received_specification'] : NULL;
                $specificationData['verify_status'] = isset($specificationItem['verify_status']) ? $specificationItem['verify_status'] : 0;
                $specificationData['reason'] = isset($specificationItem['reason']) ? $specificationItem['reason'] : NULL;
                $specificationModel = $model->supplierSpecifications()->create($specificationData);
                
                if ($specificationItem['childs']) {
                    $childsArr = $specificationItem['childs'];
                    $arr = [];
                    foreach ($childsArr as $key => $item) {
                        $arr[$key]['supplier_item_id'] = $model->id;
                        $arr[$key]['specification_id'] = $item['specification_id'];
                        $arr[$key]['verify_status'] = $item['verify_status'];
                        $arr[$key]['received_specification'] = $item['received_specification'];
                        $arr[$key]['reason'] = $item['reason'] ?? '';
                    }
                    // child Data delete
                    // $specificationModel->childs()->delete();
                    $specificationModel->childs()->createMany($arr);
                }
            }

            DB::commit();

        } catch (\Exception $ex) {
            DB::rollBack();
            return [
                'success' => false,
                'message' => 'Failed to saved data.',
                'errors'  => env('APP_ENV') !== 'production' ? $ex->getMessage() : []
            ];
        }   

        return response()->json([
            'success' => true,
            'message' => 'Data Save Successfully',
            'data' => $model
        ],200);

    }
}
