<?php

namespace App\Http\Controllers\UserManagement;

use App\Http\Controllers\Controller;
use App\Http\Validations\UserManagement\MasterSectetQuestionValidations;
use App\Models\UserManagement\SecretQuestion;
use App\Repositories\Repository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Cache;

class SecretQuestionController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(SecretQuestion $secretQuestion)
    {
        // Set the model
        $this->model = new Repository($secretQuestion);
    }

    /**
     * @queryParam question_name Filter by English or Bangla Name of the secret_questions Example: Admin
     * @queryParam question_name_bn Filter by English or Bangla Name of the secret_questions Example: এডমিন
    */
    public function list($columns = ['*'], $limit = 10)
    {
        $searchable = [
            'question_name' => array(
            'question_name' => 'like',
                'question_name_bn' => 'orLike',
            )
        ];
        return $this->model->paginate($columns, $searchable, [], $limit);
    }

    /**
     * @queryParam content Filter by content in List.
    */
    public function getAll($columns = ['*'])
    {
        $searchable = [
                'question_name' => array(
                'question_name' => 'like',
                'question_name_bn' => 'orLike',
            )
        ];
        return $this->model->getAll($columns, $searchable, [], ['created_at'=> 'DESC']);
    }
    /**
     * @response scenario=success {
     *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 1,
    *     "question_name": "What's is Secret question",
    *     "question_name_bn": "আপনার গোপন নামটা কি?",
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
    * @bodyParam question_name string required The English question name of the secret_questions Example: "What's is Secret question".
    * @bodyParam question_name_bn string required The Bangla question name bn Name of the secret_questions Example: "আপনার গোপন নামটা কি?".
    */
    public function store(Request $request)
    {
        $validationResult = MasterSectetQuestionValidations::validate($request);

        if (!$validationResult['success']) {
            return response($validationResult);
        }
        // return $request->all();
        $requestAll = $request->all();
        $data = $this->model->create($requestAll);

        if ($data['success']) {
            Cache::store('redis')->forget('secretQuestion');
            App::make('secretQuestionList');
        }

        return $data;
    }

    /**
     * @response scenario=success {
     *  "success": true,
    *  "message": "Data Update Successfully",
    *  "data": {
    *      id: 1,
    *     "question_name": "What's is Secret question",
    *     "question_name_bn": "আপনার গোপন নামটা কি?",
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
    *@bodyParam question_name string required The English question name of the secret_questions Example: "What's is Secret question".
    * @bodyParam question_name_bn string required The Bangla question name bn Name of the secret_questions Example: "আপনার গোপন নামটা কি?".
    */
    public function update(Request $request, $id)
    {
        $validationResult = MasterSectetQuestionValidations::validate($request, $id);
        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $requestAll = $request->all();
        $data = $this->model->update($requestAll, $id);

        if ($data['success']) {
            Cache::store('redis')->forget('secretQuestion');
            App::make('secretQuestionList');
        }
        return $data;
    }


    /**
     * @urlParam id integer required The ID of the Master Bank .
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    *      id: 1,
    *     "question_name": "What's is Secret question",
    *     "question_name_bn": "আপনার গোপন নামটা কি?",
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

        if ($data['success']) {
            Cache::store('redis')->forget('secretQuestion');
            App::make('secretQuestionList');
        }
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

        if ($data['success']) {
            Cache::store('redis')->forget('secretQuestion');
            App::make('secretQuestionList');
        }
        return $data;
    }
}
