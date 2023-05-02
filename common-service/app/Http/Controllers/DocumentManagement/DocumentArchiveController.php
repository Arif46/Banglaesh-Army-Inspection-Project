<?php

namespace App\Http\Controllers\DocumentManagement;

use App\Http\Controllers\Controller;
use App\Models\DocumentManagement\AddDocument;
use App\Repositories\Repository;

class DocumentArchiveController extends Controller
{
    // space that we can use the repository from
    protected $model;

    public function __construct(AddDocument $addDocument)
    {
        // set the model
        $this->model = new Repository($addDocument);
    }

    /**
    * @queryParam status Filter by status of the doc_doc_infos Example: 3
    */

    public function list($columns = ['*'], $limit = 10)
    {
        $searchable = [
            'status'
        ];
        return $this->model->paginate($columns, $searchable, [], $limit);        
    }
}
