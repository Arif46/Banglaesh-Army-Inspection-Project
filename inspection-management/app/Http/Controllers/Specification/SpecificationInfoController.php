<?php

namespace App\Http\Controllers\Specification;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use App\Models\Specification\{ Item, ItemSpecification };
use App\Http\Validations\Specification\SpecficationInfoValidations;

class SpecificationInfoController extends Controller
{
    /**
     * @queryParam specification create Function
     * @queryParam @store
     */
    public function store(Request $request)
    {
        $validationResult = SpecficationInfoValidations::validate($request);  

        if (!$validationResult['success']) {
            return response($validationResult);
        }

        DB::beginTransaction();

        try {

            $requestAll = $request->all();
            $model = Item::create($requestAll);

            $specificationData = [];

            foreach ($request->specifications as $specificationItem) {

                $specificationData = $specificationItem;
                if ($specificationItem['has_child']) {
                    unset($specificationData['childs']);
                }

                $specificationModel = $model->specifications()->create($specificationData);

                if ($specificationItem['has_child']) {
                    $childsArr = $specificationItem['childs'];
                    foreach ($childsArr as $key => $item) {
                        $childsArr[$key]['item_id'] = $model->id;
                    }
                    $specificationModel->childs()->createMany($childsArr);
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
     * @queryParam Specification List
     * @queryParam Specification 
    */
    public function index(Request $request)
    {
        $query = Item::with([
            'specifications' => function ($query) {
                $query->where('parent_id', null);
            },
            'specifications.childs'
        ])->latest();
        // $query = Item::with('specificationDetails.childs')->latest();

        if ($request->item_name) {
            $query = $query->where('item_name', 'like', "%{$request->item_name}%");
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
                'message' => 'Specification Info List'
            ],201);
        }

    }


    /**
     * @queryParam Specification Update
    */
    public function update(Request $request, $id)
    {
        // return $request->specifications;
        $validationResult = SpecficationInfoValidations::validate($request, $id); 

        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $model = Item::find($id);

        if (!$model) {
            return response([
                'success' => false,
                'message' => 'Data not found.'
            ]);
        }
        DB::beginTransaction();

        try {

            $requestAll = $request->all();
            $model->update($requestAll);
            // Delete Previous Specification Data
            $model->specifications()->delete();

            $specificationData = [];

            foreach ($request->specifications as $specificationItem) {

                $specificationData = $specificationItem;
                if ($specificationItem['has_child']) {
                    unset($specificationData['childs']);
                }
                $specificationModel = $model->specifications()->create($specificationData);

                if ($specificationItem['has_child']) {
                    $childsArr = $specificationItem['childs'];
                    foreach ($childsArr as $key => $item) {
                        $childsArr[$key]['item_id'] = $model->id;
                    }
                    $specificationModel->childs()->createMany($childsArr);
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
