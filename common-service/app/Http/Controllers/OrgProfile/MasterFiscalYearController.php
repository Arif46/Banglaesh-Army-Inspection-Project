<?php

namespace App\Http\Controllers\OrgProfile;

use App\Http\Controllers\Controller;
use App\Http\Validations\OrgProfile\MasterFiscalYearValidation;
use App\Models\OrgProfile\MasterFiscalYear;
use App\Repositories\Repository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Cache;

class MasterFiscalYearController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(MasterFiscalYear $masterFiscalYear)
    {
        // Set the model
        $this->model = new Repository($masterFiscalYear);
    }

    /**
     * @queryParam year Filter by Year in List.
     */
    public function list($columns = ['*'], $limit = 10)
    { 
        $searchable = [
            'id',
        ];
        return $this->model->paginate($columns, $searchable, [], $limit);
    }

    /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *      id: 1,
    *     "year": "2021-2022",
    *     "start_date": "01/06/2021",
    *     "end_date": "31/05/2022",
    *     "sorting_order": "101",
    *     "status": "1" 1 = active , 2 = inactive
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam year string required The year of the MasterFiscalYear.
    * @bodyParam start_date date required The start_date of the MasterFiscalYear
    * @bodyParam end_date date required The end_date of the MasterFiscalYear
    * @bodyParam sorting_order integer required The sorting_order of the MasterFiscalYear
    * ......
    */
    public function store(Request $request) {

        $validationResult = MasterFiscalYearValidation::validate($request);    
            if (!$validationResult['success']) {
            return response($validationResult);
        }

        $requestAll = $request->all();      
        $data = $this->model->create($requestAll);

        if ($data['success']) {
            Cache::store('redis')->forget('fiscalyear');
            App::make('fiscalYearList');
        }
        return $data;
    }
    
    /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Updated Successfully",
    *  "data": {
    *      id: 1,
    *     "year": "2021-2022",
    *     "start_date": "01/06/2021",
    *     "end_date": "31/05/2022",
    *     "sorting_order": "101",
    *     "status": "1" 1 = active , 2 = inactive
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to update data"
    *  "errors"  => "....."
    * }
    * @bodyParam year string required The year of the MasterFiscalYear.
    * @bodyParam start_date date required The start_date of the MasterFiscalYear
    * @bodyParam end_date date required The end_date of the MasterFiscalYear
    * @bodyParam sorting_order integer required The sorting_order of the MasterFiscalYear
    * ......
    */
    public function update(Request $request, $id)
    {
        $validationResult = MasterFiscalYearValidation::validate($request, $id);    
        if (!$validationResult['success']) {
            return response($validationResult);
        } 

        $requestAll = $request->all();
        $data = $this->model->update($requestAll, $id);

        if ($data['success']) {
            Cache::store('redis')->forget('fiscalyear');
            App::make('fiscalYearList');
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
            Cache::store('redis')->forget('fiscalyear');
            App::make('fiscalYearList');
        }
        return $data;
    }

    /**
     * Show current fiscal year
     *
     * @return \Illuminate\Http\Response
     */
    public function getCurrentFiscalYear()
    {
        $model = MasterFiscalYear::where([
            ['start_date', '<=', date('Y-m-d')],
            ['end_date', '>=', date('Y-m-d')],
        ])->first();

        if (!$model) {
            return response([
                'success' => false,
                'message' => 'Data not found!'
            ]);
        }

        return response([
            'success' => false,
            'message' => 'Data found!',
            'data' => $model
        ]);
    }
}
