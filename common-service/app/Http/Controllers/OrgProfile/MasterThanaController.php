<?php

namespace App\Http\Controllers\OrgProfile;

use App\Http\Controllers\Controller;
use App\Http\Validations\OrgProfile\MasterThanaValidations;
use App\Models\OrgProfile\MasterThana;
use App\Repositories\Repository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\{ App, Cache };

class MasterThanaController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(MasterThana $masterThana)
    {
        // set the model
        $this->model = new Repository($masterThana);
    }

    /**
     * @queryParam thana_name Filter by Thana Name in List.
     * @queryParam Thana Code Filter by Description in List.
     * @queryParam district id Filter by Description in List.
     */
    public function index($columns = ['*'], $limit = 10)
    {
        $searchable = [
            'thana_name' => array(
                'thana_name' => 'like',
                'thana_name_bn' => 'orLike',
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
            'thana_name' => array(
                'thana_name' => 'like',
                'thana_name_bn' => 'orLike',
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
     *     "thana_name": "Common Service Configuration",
     *     "thana_name_bn": "কমন সার্ভিস কনফিগারেশন",
     *     "status": "1"
     *     .........
     *   }
     * }
     * @response scenario=Failed {
     *  "success": false,
     *  "message": "Failed to save data"
     *  "errors"  => "....."
     * }
     * @bodyParam thana_name string required The upazila Name of the MasterThana.
     * ......
     */
    public function store(Request $request)
    {
        $validationResult = MasterThanaValidations::validate($request);

        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $requestAll = $request->all();
        $data = $this->model->create($requestAll);

        if ($data['success']) {
            Cache::store('redis')->forget('thanas');
            App::make('thanaList');
        }

        return $data;
    }

    /**
     * @response scenario=success {
     *  "success": true,
     *  "message": "Data Saved Successfully",
     *  "data": {
     *     id: 4,
     *     "thana_name": "Common Service Configuration",
     *     "thana_name_bn": "কমন সার্ভিস কনফিগারেশন",
     *     "status": "1"
     *     .........
     *   }
     * }
     * @response scenario=Failed {
     *  "success": false,
     *  "message": "Failed to save data"
     *  "errors"  => "....."
     * }
     * @bodyParam thana_name string required The Thana Name of the MasterThana.
     * ......
     */
    public function update(Request $request, $id)
    {
        $validationResult = MasterThanaValidations::validate($request, $id);
        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $requestAll = $request->all();
        $data = $this->model->update($requestAll, $id);

        if ($data['success']) {
            Cache::store('redis')->forget('thanas');
            App::make('thanaList');
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
            Cache::store('redis')->forget('thanas');
            App::make('thanaList');
        }
        return $data;
    }

    /**
     * @urlParam id integer required The ID of the MasterThana.
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
            Cache::store('redis')->forget('thanas');
            App::make('thanaList');
        }
        return $data;
    }
}
