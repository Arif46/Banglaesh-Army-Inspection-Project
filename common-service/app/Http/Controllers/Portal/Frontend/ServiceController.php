<?php

namespace App\Http\Controllers\Portal\Frontend;

use App\Http\Controllers\Controller;
use App\Models\Portal\Service;
use Illuminate\Http\Request;

use DB;

class ServiceController extends Controller
{

    public function show(Request $request)
    {
        $query = Service::with('attachment', 'fees', 'customerTypes:id', 'orgList')
        ->where('portal_services.service_type_id', 1);
        $query->leftJoin('portal_service_permissions', 'portal_services.id','=', 'portal_service_permissions.service_id')
        ->select(
            "portal_services.*",
            "portal_service_permissions.pr_apply_btn",
            "portal_service_permissions.pr_attachment_form",
            "portal_service_permissions.pr_service_applied",
            "portal_service_permissions.pr_service_time",
            "portal_service_permissions.pr_target_customer",
            "portal_service_permissions.pr_fees",
            "portal_service_permissions.pr_service_process",
            "portal_service_permissions.pr_policy",
            "portal_service_permissions.pr_rating"
        );
        $service = $query->where('portal_services.id', $request->id)->first();

        if (!$service) {
            return response([
                'success' => false,
                'message' => 'Data not found.'
            ]);
        }

        return response([
            'success' => true,
            'message' => 'Service found',
            'data' => $service
        ]);
    }


    /** Portal Search */
    public function searching (Request $request) {
        $query = Service::select('id', 'name', 'name_bn')->where('portal_services.service_type_id', 1);

        $name = $request->name;
        if ($name) {
            $query = $query->where(function ($q) use ($name) {
                $q->where('name', 'LIKE', "%$name%")->orWhere('name_bn', 'LIKE', "%$name%");
            });
            $list = $query->get();
        } else {
            $list = [];
        }
        
        return response([
            'success' => true,
            'message' => 'Searching item found..',
            'data' => $list
        ]);
    }

}
