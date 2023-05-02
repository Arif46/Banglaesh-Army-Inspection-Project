<?php

namespace App\Http\Controllers\DocumentManagement;

use App\Helpers\Base64FileUpload;
use App\Http\Controllers\Controller;
use App\Http\Validations\DocumentManagement\DocuementValidations;
use App\Models\DocumentManagement\AddDocument;
use App\Repositories\Repository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Cache;

class AddDocumentController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(AddDocument $addDocument)
    {
        // set the model
        $this->model = new Repository($addDocument);
    }

    /**
    * @queryParam org_id  Filter by org_id  of the doc_doc_infos Example: 1
    * @queryParam category_id  Filter by category_id of the doc_doc_infos Example: 1
    * @queryParam doc_title Filter by doc_title of the doc_doc_infos Example: "Document Title"
    */

    public function list($columns = ['*'], $limit = 10)
    {
        $searchable = [
                'doc_title' => array(
                'doc_title' => 'like',
                'doc_title_bn' => 'orLike',
            ),
            'org_id',
            'category_id',
            'status'
        ];
        return $this->model->paginate($columns, $searchable, [], $limit);
        
    }
  
    /**
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data Saved Successfully",
        *  "data": {
        *     "id": 1,
        *     "doc_title": "Document Title",
        *     "doc_title_bn": "ডকুমেন্ট টাইটেল বাংলা"
        *     "org_id": 1
        *     "category_id": 1
        *     "attachment": 'file'
        *     "status": "1"
        *     ..............
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to save data"
        *  "errors"  => "....."
        * }
        * @bodyParam doc_title string required doc_title of the doc_doc_infos Example: "Document Title"
        * @bodyParam doc_title_bn string required doc_title_bn of the doc_doc_infos Example: "ডকুমেন্ট টাইটেল বাংলা"
        * @bodyParam org_id integer required org_id of the doc_doc_infos Example: 1
        * @bodyParam category_id integer required category_id of the doc_doc_infos Example: 1
        * @bodyParam attachment string required attachment of the doc_doc_infos Example: "file.jpg"
    */

    public function store(Request $request)
    {   
        $validationResult = DocuementValidations::validate($request);    
        if (!$validationResult['success']) {
            return response($validationResult);
        }  

        $requestAll = $request->all();

        $image = Base64FileUpload::uploadFile($request, 'attachment', 'document', null);
        $requestAll['attachment'] = $image['success'] ? $image['data']: null;

        if ($image['success']) {
            $data = $this->model->create($requestAll);
        }
        
        if ($data['success']) {
            Cache::store('redis')->forget('document');
            App::make('documentList');
        }
        return $data;
    }
    
    /**
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data Update Successfully",
        *  "data": {
        *     "id": 1,
        *     "doc_title": "Document Title",
        *     "doc_title_bn": "ডকুমেন্ট টাইটেল বাংলা"
        *     "org_id": 1
        *     "category_id": 1
        *     "attachment": 'file'
        *     "status": "1"
        *     ..............
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to update data"
        *  "errors"  => "....."
        * }
        * @bodyParam doc_title string required doc_title of the doc_doc_infos Example: "Document Title"
        * @bodyParam doc_title_bn string required doc_title_bn of the doc_doc_infos Example: "ডকুমেন্ট টাইটেল বাংলা"
        * @bodyParam org_id integer required org_id of the doc_doc_infos Example: 1
        * @bodyParam category_id integer required category_id of the doc_doc_infos Example: 1
        * @bodyParam attachment string required attachment of the doc_doc_infos Example: "file.jpg"
    */
    public function update(Request $request, $id)
    {
        $validationResult = DocuementValidations::validate($request, $id);    
        if (!$validationResult['success']) {
            return response($validationResult);
        }
        
        $requestAll = $request->all(); 
        if ($request->file) {
            $image = Base64FileUpload::uploadFile($request, 'attachment', 'document', $request->oldfile);
            $requestAll['attachment'] = $image['success'] ? $image['data']: null;
        }
        $data = $this->model->update($requestAll, $id);
        
        if ($data['success']) {
            Cache::store('redis')->forget('document');
            App::make('documentList');
        }
        return $data;
    }

    /**
    * @urlParam id integer required The ID of the Master Bank .
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    *     "doc_title": "Document Title",
    *     "doc_title_bn": "ডকুমেন্ট টাইটেল বাংলা"
    *     "org_id": 1
    *     "category_id": 1
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
            Cache::store('redis')->forget('document');
            App::make('documentList');
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
            Cache::store('redis')->forget('document');
            App::make('documentList');
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

    public function archive($id)
    {
        $model = AddDocument::find($id);

        if (!$model) {
            return [
                'success' => false,
                'message' => 'Data not found.'
            ];
        }

        $model->status = 3;

        if ($model->update()) {
            Cache::store('redis')->forget('document');
            App::make('documentList');
        }

        // save_log([
        //     'data_id' => $model->id,
        //     'table_name' => $model->getTable(),
        //     'execution_type' => 2
        // ]);

        return [
            'success' => true,
            'message' => 'Data updated successfully',
            'data'    => $model
        ];
    }
    
}
