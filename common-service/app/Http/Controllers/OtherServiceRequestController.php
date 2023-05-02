<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\{Cache, App, Route};

class OtherServiceRequestController extends Controller
{
  public function commonRequest(Request $request)
  {
    $datas = [];
    if (!empty($request->common)) {
      foreach($request->common as $key=>$value) {
        $datas[$value] = App::make($value);
      }
    }
    return $datas;
  }
}
