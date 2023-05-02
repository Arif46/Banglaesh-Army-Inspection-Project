<?php

namespace App\Http\Controllers\OrgProfile;

use App\Http\Controllers\Controller;
use App\Http\Validations\OrgProfile\MasterUpazilaValidations;
use App\Models\OrgProfile\MasterUpazila;
use App\Repositories\Repository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\{ App, Cache };

class MasterUpazilaController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(MasterUpazila $masterUpazila)
    {
        // set the model
        $this->model = new Repository($masterUpazila);
    }

    /**
     * @queryParam upazila_name Filter by Upazila Name in List.
     * @queryParam Upazila Code Filter by Description in List.
     * @queryParam district id Filter by Description in List.
     */
    public function index($columns = ['*'], $limit = 10)
    {
        $searchable = [
            'upazila_name' => array(
                'upazila_name' => 'like',
                'upazila_name_bn' => 'orLike',
            ),
            'upazila_code',
            'district_id'
        ];
        return $this->model->paginate($columns, $searchable, [], $limit);
    }

    /**
     * @queryParam title Filter by title in List.
     * @queryParam content Filter by content in List.
     */
    public function getAll($columns = ['*'])
    {
        $searchable = [
            'upazila_name' => array(
                'upazila_name' => 'like',
                'upazila_name_bn' => 'orLike',
            ),
            'upazila_code',
            'district_id'
        ];
        return $this->model->getAll($columns, $searchable, [], ['created_at'=> 'DESC']);
    }
    /**
     * @response scenario=success {
     *  "success": true,
     *  "message": "Data Saved Successfully",
     *  "data": {
     *     id: 4,
     *     "upazila_name": "Common Service Configuration",
     *     "upazila_name_bn": "কমন সার্ভিস কনফিগারেশন",
     *     "status": "1"
     *     .........
     *   }
     * }
     * @response scenario=Failed {
     *  "success": false,
     *  "message": "Failed to save data"
     *  "errors"  => "....."
     * }
     * @bodyParam upazila_name string required The upazila Name of the MasterUpazila.
     * ......
     */
    public function store(Request $request)
    {
        $validationResult = MasterUpazilaValidations::validate($request);

        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $requestAll = $request->all();
        $data = $this->model->create($requestAll);

        if ($data['success']) {
            Cache::store('redis')->forget('upazilas');
            App::make('upazilaList');
        }

        return $data;
    }

    /**
     * @response scenario=success {
     *  "success": true,
     *  "message": "Data Saved Successfully",
     *  "data": {
     *     id: 4,
     *     "upazila_name": "Common Service Configuration",
     *     "upazila_name_bn": "কমন সার্ভিস কনফিগারেশন",
     *     "status": "1"
     *     .........
     *   }
     * }
     * @response scenario=Failed {
     *  "success": false,
     *  "message": "Failed to save data"
     *  "errors"  => "....."
     * }
     * @bodyParam upazila_name string required The Upazila Name of the MasterUpazila.
     * ......
     */
    public function update(Request $request, $id)
    {
        $validationResult = MasterUpazilaValidations::validate($request, $id);
        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $requestAll = $request->all();
        $data = $this->model->update($requestAll, $id);

        if ($data['success']) {
            Cache::store('redis')->forget('upazilas');
            App::make('upazilaList');
        }
        return $data;
    }

    /**
     * @urlParam id integer required The ID of the Master Component.
     * @urlParam lang The language. Example: en
     * @response scenario=success {
     *     id: 4,
     *     "component_name": "Common Service Configuration",
     *     "component_name_bn": "কমন সার্ভিস কনফিগারেশন",
     *     "status": "1"
     *     .........
     * }
     * @response scenario="Failed" {
     *  "message": "Data not found"
     * }
     */
    public function show($id)
    {
        return $this->model->show($id, $columns = ['*']);
    }

    /**
     * @urlParam id integer required The ID of the Master Component.
     * @response scenario=success {
     *  "message": "Data deleted successfully"
     * }
     * @response scenario="Failed" {
     *  "message": "Data not found"
     * }
     */
    public function destroy($id)
    {
        $data = $this->model->delete($id);

        if ($data['success']) {
            Cache::store('redis')->forget('upazilas');
            App::make('upazilaList');
        }
        return $data;
    }

    /**
     * @urlParam id integer required The ID of the MasterUpazila.
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
            Cache::store('redis')->forget('upazilas');
            App::make('upazilaList');
        }
        return $data;
    }
}
