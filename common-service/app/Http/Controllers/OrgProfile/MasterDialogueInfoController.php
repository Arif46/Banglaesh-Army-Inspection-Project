<?php

namespace App\Http\Controllers\OrgProfile;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\OrgProfile\MasterDialogueInfo;
use App\Http\Validations\OrgProfile\MasterDialogueInfoValidations;
use Illuminate\Support\Facades\{Cache, App};
use App\Repositories\Repository;

class MasterDialogueInfoController extends Controller
{
  // space that we can use the repository from
  protected $model;

  public function __construct(MasterDialogueInfo $MasterDialogueInfo)
  {
    // set the model
    $this->model = new Repository($MasterDialogueInfo);
  }

  /**
   * @queryParam dialogue Filter by Dialogue En or Bn in List.
   * @queryParam position Filter by English or Bangla Position of the dialogue Example: বামে-নিচে
  */
  public function list($columns = ['*'], $limit = 10)
  { 
    $searchable = [
      'dialogue' => array(
        'dialogue' => 'like',
        'dialogue_bn' => 'orLike',
      ),
      'position'
    ];
    return $this->model->paginate($columns, $searchable, [], 10);
  }
  
  /**
   * @queryParam dialogue Filter by dialogue Name En or Bn in List.
  */
  public function getAll($columns = ['*'])
  {
    $searchable = [
      'dialogue' => array(
        'dialogue' => 'like',
        'dialogue_bn' => 'orLike',
      ),
      'position'
    ];
    return $this->model->getAll($columns, $searchable, [], ['created_at'=> 'DESC']);
  }
  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 1,
    *     "dialogue": "Bangladesh Is Self-Sufficient In Agriculture",
    *     "dialogue_bn": "কৃষিতে স্বনির্ভর বাংলাদেশ	",
    *     "position": "1	",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam dialogue string required The Dialogue Name of the MasterDialogueInfo.
    * ......
  */
  public function store(Request $request)
  {
    // return 'yes';
    $validationResult = MasterDialogueInfoValidations::validate($request);  

    if (!$validationResult['success']) {
      return response($validationResult);
    }
    // return $request->all();
    $requestAll = $request->all();      
    $data = $this->model->create($requestAll);

    if ($data['success']) {
      Cache::store('redis')->forget('dialogueInfos');
      App::make('dialogueInfosList');
    }

    return $data;
  }
  
  /**
    * @response scenario=success {
    *  "success": true,
    *  "message": "Data Saved Successfully",
    *  "data": {
    *     id: 1,
    *     "dialogue": "Bangladesh Is Self-Sufficient In Agriculture",
    *     "dialogue_bn": "কৃষিতে স্বনির্ভর বাংলাদেশ	",
    *     "position": "1",
    *     "status": "1"
    *     .........
    *   }
    * }
    * @response scenario=Failed {
    *  "success": false,
    *  "message": "Failed to save data"
    *  "errors"  => "....."
    * }
    * @bodyParam dialogue string required The Dialogue Name of the MasterDialogueInfo.
    * ......
  */
  public function update(Request $request, $id)
  {
    $validationResult = MasterDialogueInfoValidations::validate($request, $id);    
    if (!$validationResult['success']) {
      return response($validationResult);
    } 

    $requestAll = $request->all();
    $data = $this->model->update($requestAll, $id);

    if ($data['success']) {
      Cache::store('redis')->forget('dialogueInfos');
      App::make('dialogueInfosList');
    }
    return $data;
  }

  /**
    * @urlParam id integer required The ID of the Master Dialogue Info.
    * @urlParam lang The language. Example: en
    * @response scenario=success {
    *     id: 1,
    *    "dialogue": "Bangladesh Is Self-Sufficient In Agriculture",
    *     "dialogue_bn": "কৃষিতে স্বনির্ভর বাংলাদেশ",
    *     "position": "1	",
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
        Cache::store('redis')->forget('dialogueInfos');
        App::make('dialogueInfosList');
    }
    return $data;
  }

  /**
   * @urlParam id integer required The ID of the MasterComponent.     
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
        Cache::store('redis')->forget('dialogueInfos');
        App::make('dialogueInfosList');
    }
    return $data;
  }
}
