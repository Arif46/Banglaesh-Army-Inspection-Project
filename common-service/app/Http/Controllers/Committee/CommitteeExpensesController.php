<?php

namespace App\Http\Controllers\Committee;

use App\Http\Controllers\Controller;
use App\Http\Validations\Committee\CommitteeExpensesValidation;
use App\Models\Committee\CommitteeExpenses;
use App\Repositories\Repository;
use Illuminate\Http\Request;
use App\Helpers\Base64FileUpload;

class CommitteeExpensesController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(CommitteeExpenses $cmt_expenses)
    {
        // Set the model
        $this->model = new Repository($cmt_expenses);
    }

    /**
     * @queryParam org_id Filter by org_id the cmt_committees of the list
     * @queryParam committee_name Filter by committee_name the cmt_committees of the list
    */
    public function list($columns = ['*'], $limit = 10)
    {
        $searchable = [
            'org_id',
            'cmt_committee_id',
            'cmt_agenda_id'
        ];
        return $this->model->paginate($columns, $searchable, [], $limit);
    }

    /**
     * @queryParam content Filter by content in List.
    */
    public function getAll($columns = ['*'])
    {
        $searchable = [
            'org_id',
            'cmt_committee_id',
            'cmt_agenda_id'
        ];
        return $this->model->getAll($columns, $searchable, [], ['created_at'=> 'DESC']);
    }
    /**
     * @response scenario=success {
     *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 1,
    *     "org_id": "1"
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    *
    * @bodyParam org_id string required org_id of the master_complain_chains Example: 1
    * @bodyParam sorting_order string required sorting_order of the master_complain_chains Example: 1
    */
    public function store(Request $request)
    {

        $validationResult = CommitteeExpensesValidation::validate($request);

        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $requestAll = $request->all();

        if ($request->attachment) {
            $image = Base64FileUpload::uploadFile($request, 'attachment', 'committee/cmtExpenses', null);
            $requestAll['attachment'] = $image['success'] ? $image['data']: null;
        }

        $data = $this->model->create($requestAll);

        return $data;
    }

    /**
     * @response scenario=success {
     *  "success": true,
    *  "message": "Data Update Successfully",
    *  "data": {
    *     id: 1,
    *     "org_id": "1"
    *     "sorting_order": "1"
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to update data"
    *  "errors"  => "....."
    * }
     *
     * @bodyParam org_id string required org_id of the master_complain_chains Example: 1
     * @bodyParam sorting_order string required sorting_order of the master_complain_chains Example: 1
    */
    public function update(Request $request, $id)
    {
        $validationResult = CommitteeExpensesValidation::validate($request, $id);

        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $requestAll = $request->all();

        if ($request->attachment) {
            $image = Base64FileUpload::uploadFile($request, 'attachment', 'committee/cmtMeeting', null);
            $requestAll['attachment'] = $image['success'] ? $image['data']: null;
        }

        $data = $this->model->update($requestAll, $id);

        return $data;
    }


    /**
     * @urlParam id integer required The ID of the Master Bank .
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    *     id: 4,
    *     "org_id": "1"
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
     * @urlParam id integer required The ID of the Master Bank .
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

        return $data;
    }

    /**
     * @urlParam id integer required The ID of the Master Bank .
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

        return $data;
    }
}
