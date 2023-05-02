<?php

namespace App\Http\Controllers\Organogram;

use App\Http\Controllers\Controller;
use App\Http\Validations\Organogram\MasterDesignationValidations;
use App\Models\Organogram\MasterDesignation;
use App\Repositories\Repository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;

class DesignationController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(MasterDesignation $masterDesignation)
    {
        // Set the model
        $this->model = new Repository($masterDesignation);
    }

    /**
     * @queryParam org_id Filter by org_id in List.
     * @queryParam designation Filter by designation id in List.
     */
    public function list($columns = ['*'], $limit = 10)
    {
        $searchable = [
            'org_id',
            'designation' => array(
                'designation' => 'like',
                'designation_bn' => 'orLike',
            )
        ];
        return $this->model->paginate($columns, $searchable, [], $limit);
    }

    /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *      id: 1,
    *     "org_id": "1",
    *     "designation": "Director",
    *     "designation_bn": "ডিরেকক্টর",
    *     "direct_post": "1",
    *     "promotional_post": "1",
    *     "total_post": "1",
    *     "grade_id": "1",
    *     "sorting_order": "100",
    *     "status": "1" 1 = active , 2 = inactive
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam designation string required The designation of the MasterDesignation.
    * @bodyParam designation_bn string required The designation_bn of the MasterDesignation
    * @bodyParam org_id integer required The org_id of the MasterDesignation
    * @bodyParam direct_post integer required The direct_post of the MasterDesignation
    * @bodyParam promotional_post integer required The promotional_post of the MasterDesignation
    * @bodyParam total_post integer required The total_post of the MasterDesignation
    * @bodyParam grade_id integer required The grade_id of the MasterDesignation
    * @bodyParam sorting_order integer required The sorting_order of the MasterDesignation
    * ......
    */
    public function store(Request $request) {

        $validationResult = MasterDesignationValidations::validate($request);
            if (!$validationResult['success']) {
            return response($validationResult);
        }

        $requestAll = $request->all();
        $data = $this->model->create($requestAll);

        if ($data['success']) {
            Cache::store('redis')->forget('designation');
            App::make('designationList');
        }
        return $data;
    }

    /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Updated Successfully",
    *  "data": {
    *      id: 1,
    *     "org_id": "1",
    *     "designation": "Director",
    *     "designation_bn": "ডিরেকক্টর",
    *     "direct_post": "1",
    *     "promotional_post": "1",
    *     "total_post": "1",
    *     "grade_id": "1",
    *     "sorting_order": "100",
    *     "status": "1" 1 = active , 2 = inactive
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to update data"
    *  "errors"  => "....."
    * }
    * @bodyParam designation string required The designation of the MasterDesignation.
    * @bodyParam designation_bn string required The designation_bn of the MasterDesignation
    * @bodyParam org_id integer required The org_id of the MasterDesignation
    * @bodyParam direct_post integer required The direct_post of the MasterDesignation
    * @bodyParam promotional_post integer required The promotional_post of the MasterDesignation
    * @bodyParam total_post integer required The total_post of the MasterDesignation
    * @bodyParam grade_id integer required The grade_id of the MasterDesignation
    * @bodyParam sorting_order integer required The sorting_order of the MasterDesignation
    * ......
    */
    public function update(Request $request, $id)
    {
        $validationResult = MasterDesignationValidations::validate($request, $id);
        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $requestAll = $request->all();
        $data = $this->model->update($requestAll, $id);

        if ($data['success']) {
            Cache::store('redis')->forget('designation');
            App::make('designationList');
        }
        return $data;
    }

    /**
    * @urlParam id integer required The ID of the MasterService.
    * @response scenario=success {
    *  "message": "Data updated successfully"
    * }
    * @response scenario="Failed" {
    *  "message": "Data not found"
    * }
    */
    public function toggleStatus($id) {
        $data = $this->model->toggleStatus($id);

        if ($data['success']) {
            Cache::store('redis')->forget('designation');
            App::make('designationList');
        }
        return $data;
    }

    /**
     * Get component designation list
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function getComponentDesignationList(Request $request)
    {
        $list = DB::table('master_designations AS d')
                ->join('component_designations AS cd', 'd.id', 'cd.designation_id')
                ->where([
                    'cd.component_id' => $request->component_id,
                    'cd.org_id' => $request->org_id
//                    'cd.office_type_id' => $request->office_type_id,
//                    'cd.office_id' => $request->office_id,
                ])
                ->where(function ($queryNested) use ($request) {
                    if ($request->office_type_id) {
                        $queryNested->where('cd.office_type_id', $request->office_type_id);
                    }

                    if ($request->office_id) {
                        $queryNested->where('cd.office_id', $request->office_id);
                    }

                    if (!$request->has('show_all')) {
                        $queryNested->where('d.grade_id', '<=', 9);
                    }
                })
                ->select('d.id AS value', 'd.designation AS text_en', 'd.designation_bn AS text_bn', 'd.status')
                ->get();

        return response([
            'success' => true,
            'data' => $list
        ]);
    }
    public function getComponentAssignDesignationList(Request $request)
    {
        $list = DB::table('master_designations AS d')
                ->join('assign_designations AS cd', 'd.id', 'cd.designation_id')
                ->join('component_designations AS cds', 'd.id', 'cds.designation_id')
                ->where([
                    'cds.component_id' => $request->component_id,
                    'cds.org_id' => $request->org_id
                ])
                ->where(function ($queryNested) use ($request) {
                    if ($request->office_type_id) {
                        $queryNested->where('cd.office_type_id', $request->office_type_id);
                    }
                    if ($request->office_id) {
                        $queryNested->where('cd.office_id', $request->office_id);
                    }
                    if (!$request->has('show_all')) {
                        $queryNested->where('d.grade_id', '<=', 9);
                    }
                })
                ->select('d.id AS value', 'd.designation AS text_en', 'd.designation_bn AS text_bn', 'd.status', 'cd.office_id')
                ->get();

        return response([
            'success' => true,
            'data' => $list
        ]);
    }
}
