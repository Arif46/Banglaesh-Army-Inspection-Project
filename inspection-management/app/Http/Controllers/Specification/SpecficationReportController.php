<?php

namespace App\Http\Controllers\Specification;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SpecficationReportController extends Controller
{
    /**
     * @queryParam Specification Report data
     */
    public function getReport(Request $request)
    {   
        $query = DB::table('supplier_items')
                ->select('demand_no', 'supplier_name', 'total_fully_comply',
                        'total_partially_comply', 'total_reject', 'result_id');

        if ($request->demand_no) {
            $query = $query->where('demand_no', 'like', "%{$request->demand_no}%");
        }

        if ($request->supplier_name) {
            $query = $query->where('supplier_name', 'like', "%{$request->supplier_name}%");
        }

        $list = $query->get();

        $arr = [];

        foreach($list as $listItem) {
            $arr[$listItem->demand_no][] = [
                'supplier_name' =>$listItem->supplier_name,
                'total_fully_comply' =>$listItem->total_fully_comply,
                'total_partially_comply' =>$listItem->total_partially_comply,
                'total_reject' =>$listItem->total_reject,
                'result_id' =>$listItem->result_id,
            ];
        }

        $collectionArr = [];

        if ($arr) {
            foreach ($arr as $demandNo => $data) {
                $collectionArr[] = (object) [
                    'demand_no' => $demandNo,
                    'count' => count($data),
                    'demand_info' => $data
                ];
            }
        }

        if (!$collectionArr) {
            return response([
                'success' => false,
                'message' => 'Data Not Found'
            ]);
        }

        return response([
            'success' => true,
            'message' => 'Specification Report List',
            'data' => collect($collectionArr)
        ]);

    }
}
