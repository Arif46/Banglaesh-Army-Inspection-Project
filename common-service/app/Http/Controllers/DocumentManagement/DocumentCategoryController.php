<?php

namespace App\Http\Controllers\DocumentManagement;

use App\Http\Controllers\Controller;
use App\Http\Validations\DocumentManagement\DocumentCategoryValidations;
use App\Models\DocumentManagement\DocumentCategory;
use App\Repositories\Repository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Cache;

class DocumentCategoryController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(DocumentCategory $documentCategory)
    {
        // set the model
        $this->model = new Repository($documentCategory);
    }

    /**
    * @queryParam category_name Filter by category_name of the master_document_categories Example: "Application"
    */

    public function list($columns = ['*'], $limit = 10)
    {
        $searchable = [
            'category_name',
        ];

        return $this->model->paginate($columns, $searchable, [], $limit);
    }
  
    /**
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data Saved Successfully",
        *  "data": {
        *     "id": 1,
        *     "category_name": "Application",
        *     "category_name_bn": "আবেদন"
        *     "sorting_order": 11
        *     "status": "1"
        *     ..............
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to save data"
        *  "errors"  => "....."
        * }
        * @bodyParam category_name string required category_name of the master_document_categories Example: "Application"
        * @bodyParam category_name_bn string required category_name_bn of the master_document_categories Example: "আবেদন"
        * @bodyParam sorting_order integer required sorting_order of the master_document_categories Example: 11
    */

    public function store(Request $request)
    {   
        $validationResult = DocumentCategoryValidations::validate($request);    
        if (!$validationResult['success']) {
            return response($validationResult);
        }  

        $requestAll = $request->all();
        // $requestAll['created_by'] = (int)user_id()??null;

        $data = $this->model->create($requestAll);
        if ($data['success']) {
            Cache::store('redis')->forget('documentCategory');
            App::make('documentCategoryList');
        }
        return $data;
    }
    
    /**
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data Saved Successfully",
        *  "data": {
        *     "id": 1,
        *     "category_name": "Application",
        *     "category_name_bn": "আবেদন"
        *     "sorting_order": 11
        *     "status": "1"
        *     ..............
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to save data"
        *  "errors"  => "....."
        * }
        * @bodyParam category_name string required category_name of the master_document_categories Example: "Application"
        * @bodyParam category_name_bn string required category_name_bn of the master_document_categories Example: "আবেদন"
        * @bodyParam sorting_order integer required sorting_order of the master_document_categories Example: 11
    */
    public function update(Request $request, $id)
    {
        $validationResult = DocumentCategoryValidations::validate($request, $id);    
        if (!$validationResult['success']) {
            return response($validationResult);
        }
        $requestAll = $request->all(); 
        // $requestAll['updated_by'] = (int)user_id()??null;

        $data = $this->model->update($requestAll, $id);

        if ($data['success']) {
            Cache::store('redis')->forget('documentCategory');
            App::make('documentCategoryList');
        }
        return $data;
    }

    /**
    * @urlParam id integer required The ID of the Master Bank .
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    *     id: 4,
    *     "category_name": "Application",
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
            Cache::store('redis')->forget('documentCategory');
            App::make('documentCategoryList');
        }
        return $data;
    }

    /**
     * @urlParam id integer required The ID of the Component.     
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
            Cache::store('redis')->forget('documentCategory');
            App::make('documentCategoryList');
        }
        return $data;
    }
}
