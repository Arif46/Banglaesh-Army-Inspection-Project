<?php

namespace App\Http\Controllers\Organogram;

use App\Http\Controllers\Controller;
use App\Http\Validations\Organogram\ComponentDesignationValidations;
use App\Models\Organogram\ComponentDesignation;
use App\Repositories\Repository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;

class ComponentDesignationController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(ComponentDesignation $componentDesignation)
    {
        // Set the model
        $this->model = new Repository($componentDesignation);
    }

    /**
     * @queryParam org_id Filter by org_id in List.
     * @queryParam designation_id Filter by designation_id in List.
     */
    public function list(Request $request, $columns = ['*'], $limit = 10)
    { 
        $query = ComponentDesignation::query();

        if ($request->org_id) {
            $query = $query->where('org_id', $request->org_id);
        }

        if ($request->component_id) {
            $query = $query->where('component_id', $request->component_id);
        }
                
        $list = $query->select(DB::raw('org_id,component_id,status,GROUP_CONCAT(designation_id) as designation'))
                      ->groupBy('org_id','component_id','status')
                      ->paginate(request('per_page', $limit)); 

        return response([
            'success' => true,
            'message' => 'Component designation list',
            'data' => $list
        ]);
    }

    /**
     * @queryParam component_id Filter by component_id in List.
     */
    public function designationByComponentId(Request $request, $componentId)
    { 
        $data = ComponentDesignation::where('status', 1)
        ->where('component_id', $componentId)
        ->get();

        return response([
            'success' => true,
            'message' => 'Component designation list by Component Id',
            'data' => $data
        ]);
    }

    /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *      id: 1,
    *     "org_id": 1,
    *     "component_id": 1,
    *     "designation": [1,2,3],
    *     "status": "1" 1 = active , 2 = inactive
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    *
    * @bodyParam org_id integer required The org_id of the ComponentDesignation
    * @bodyParam component_id integer required The component_id of the ComponentDesignation
    * @bodyParam designation integer required The designation of the ComponentDesignation
    * ......
    */
    public function store(Request $request) {
        
        $validationResult = ComponentDesignationValidations::validate($request);    
            if (!$validationResult['success']) {
            return response($validationResult);
        }

        /* $models = ComponentDesignation::join('master_designations','component_designations.designation_id','master_designations.id')->where([
            'component_designations.org_id'         => $request->org_id,
            'component_designations.component_id'   => $request->component_id
        ])->whereIn('component_designations.designation_id', $request->designation_id)
        ->pluck('master_designations.designation')->all();

        if ($models) {
            $items = implode(", ", $models); 
            return [
                'warning' => true,
                'message' => $items
            ];
        } */

        $models = ComponentDesignation::where([
            'org_id'         => $request->org_id,
            'component_id'   => $request->component_id
        ])->first();

        if ($models) {
            return [
                'warning' => true,
                'message' => 'Already exist! You can update now.'
            ];
        }

        try {
            $status = 0;
            foreach ($request->designation_id as $designation_id) {
                $data = [
                    'org_id'         => $request->org_id,
                    'component_id'   => $request->component_id,
                    'designation_id' => $designation_id
                ];
                ComponentDesignation::create($data);
                $status++;
            }
    
        } catch (\Exception $ex) {
            return [
                'success' => false,
                'message' => 'Failed to save data.',
                'errors'  => env('APP_ENV') !== 'production' ? $ex->getMessage() : []
            ];
        }

        if ($status) {
            Cache::store('redis')->forget('ComponentDesignation');
            App::make('ComponentDesignationList');
        }

        return [
            'success' => true,
            'message' => 'Data save successfully'
        ];
    }

    /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Update Successfully",
    *  "data": {
    *      id: 1,
    *     "org_id": 1,
    *     "component_id": 1,
    *     "designation": [1,2,3],
    *     "status": "1" 1 = active , 2 = inactive
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to update data"
    *  "errors"  => "....."
    * }
    *
    * @bodyParam org_id integer required The org_id of the ComponentDesignation
    * @bodyParam component_id integer required The component_id of the ComponentDesignation
    * @bodyParam designation integer required The designation of the ComponentDesignation
    * ......
    */
    public function update(Request $request)
    {
        $validationResult = ComponentDesignationValidations::validate($request);    
        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $models = ComponentDesignation::where([
            'org_id'      => $request->org_id,
            'component_id' => $request->component_id
        ])->delete();

        try {
            $status = 0;
            foreach ($request->designation_id as $designation_id) {
                $data = [
                    'org_id'         => $request->org_id,
                    'component_id'   => $request->component_id,
                    'designation_id' => $designation_id
                ];
                ComponentDesignation::create($data);
                $status++;
            }
    
        } catch (\Exception $ex) {
            return [
                'success' => false,
                'message' => 'Failed to save data.',
                'errors'  => env('APP_ENV') !== 'production' ? $ex->getMessage() : []
            ];
        }

        if ($status) {
            Cache::store('redis')->forget('ComponentDesignation');
            App::make('ComponentDesignationList');
        }

        return [
            'success' => true,
            'message' => 'Data updated successfully'
        ];
    }
    
    /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *      id: 1,
    *     "org_id": "1",
    *     "component_id": "1",
    *     "status": "1" 1 = active , 2 = inactive
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    *
    * @bodyParam org_id integer required The org_id of the ComponentDesignation
    * @bodyParam component_id integer required The component_id of the ComponentDesignation
    * ......
    */
    public function toggleStatus(Request $request) {
        $model = ComponentDesignation::where([
            'org_id' => $request->org_id,
            'component_id' => $request->component_id
        ])->first();

        if (!$model) {
            return [
                'success' => false,
                'message' => 'Data not found.'
            ];
        }
        
        if ($model->status == 1) {
            ComponentDesignation::where([
                'org_id' => $request->org_id,
                'component_id' => $request->component_id
            ])->update(['status' => 2]);
        } else {
            ComponentDesignation::where([
                'org_id' => $request->org_id,
                'component_id' => $request->component_id
            ])->update(['status' => 1]);
        }
        
        return [
            'success' => true,
            'message' => 'Data updated successfully',
            'data'    => $model
        ];
    }
}
