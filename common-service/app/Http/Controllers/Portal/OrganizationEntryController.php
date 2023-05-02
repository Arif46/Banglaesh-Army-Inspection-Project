<?php

namespace App\Http\Controllers\Portal;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Repositories\Repository;
use Illuminate\Support\Facades\{Cache, App};
use App\Helpers\Base64FileUpload;
use App\Http\Validations\Portal\OrganizationEntryValidation;
use App\Models\Portal\OrganizationEntry;

class OrganizationEntryController extends Controller
{
// space that we can use the repository from
    protected $model;

    public function __construct(OrganizationEntry $orgEntry)
    {
        // set the model
        $this->model = new Repository($orgEntry);
    }

    /**
     * @queryParam ex_org_name Filter by Organization Name En or Bn in List.
     * @queryParam ministry_id Filter by Minitry Name Example: 1
     * @queryParam limit int Example: 10
    */
    public function list($columns = ['*'], $limit = 10)
    {
        $searchable = [
            'ex_org_name' => array(
                'ex_org_name' => 'like',
                'ex_org_name_bn' => 'orLike',
            ),
            'ministry_id'
        ];
        return $this->model->paginate($columns, $searchable, [], 10);
    }

    /**
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data Saved Successfully",
        *  "data": {
            *   id: 1,
            *   "ministry_id": 1,
            *   "ex_org_name": "Organization Name",
            *   "ex_org_name_bn": "সংস্থার নাম",
            *   "logo": "Logo",
            *   "status": "1"
            *   .........
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to save data"
        *  "errors"  => "....."
        * }
        * @bodyParam ministry_id bigInteger required The Ministry Name of the MinistryEntry.
        * @bodyParam ex_org_name_bn string required The Organization Name BN of the OrganizationEntry.
        * @bodyParam ex_org_name_bn string required The Organization Name BN of the OrganizationEntry.
        * ......
    */
    public function store(Request $request)
    {
        $validationResult = OrganizationEntryValidation::validate($request);  

        if (!$validationResult['success']) {
            return response($validationResult);
        }
        
        $requestAll = $request->all();
        if ($requestAll['logo']) {
            $image = Base64FileUpload::uploadImage($requestAll, 'logo', '/portal/ex_org-logo', null, 100, 100);         
            $requestAll['logo'] = $image['success'] ? $image['data']: null;
        }   

        $data = $this->model->create($requestAll);

        if ($data['success']) {
            Cache::store('redis')->forget('exOrgNames');
            App::make('exOrgList');
        }

        return $data;
    }
  
    /**
        * @response scenario=success {
        *  "success": true,
        *  "message": "Data Updated Successfully",
        *  "data": {
            *   id: 1,
            *   "ministry_id": 1,
            *   "ex_org_name": "Organization Name",
            *   "ex_org_name_bn": "সংস্থার নাম",
            *   "logo": "Logo",
            *   "status": "1"
            *   .........
        *   }
        * }
        * @response scenario=Failed {
        *  "success": false,
        *  "message": "Failed to save data"
        *  "errors"  => "....."
        * }
        * @bodyParam ministry_id bigInteger required The Ministry Name of the MinistryEntry.
        * @bodyParam ex_org_name_bn string required The Organization Name BN of the OrganizationEntry.
        * @bodyParam ex_org_name_bn string required The Organization Name BN of the OrganizationEntry.
        * ......
    */
    public function update(Request $request, $id)
    {
        $validationResult = OrganizationEntryValidation::validate($request, $id);

        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $requestAll = $request->all();
        $model = OrganizationEntry::find($id);

        if ($requestAll['logo'] != null && isset($requestAll['update_logo'])) { 
            $image = Base64FileUpload::uploadImage($requestAll, 'logo', '/portal/ex_org-logo', $model->logo, 100, 100);              
        }

        $requestAll['logo'] = isset($image) ? ($image['success'] ? $image['data']: $model['logo']) : $model['logo'];
        $data = $this->model->update($requestAll, $id);

        if ($data['success']) {
            Cache::store('redis')->forget('exOrgNames');
            App::make('exOrgList');
        }
        return $data;
    }

    /**
   * @urlParam id integer required The ID of the Organization Entry.     
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
        Cache::store('redis')->forget('exOrgNames');
        App::make('exOrgList');
    }
    return $data;
  }


}
