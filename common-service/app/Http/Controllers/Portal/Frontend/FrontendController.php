<?php

namespace App\Http\Controllers\Portal\Frontend;

use App\Http\Controllers\Controller;
use App\Models\Portal\ServiceCategory;
use App\Models\Portal\ServiceCustomerType;
use App\Models\Portal\Service;
use Illuminate\Http\Request;
use App\Models\OrgProfile\MasterOrgProfile;
use App\Models\Portal\AboutServicePortal;
use App\Models\Portal\PortalHeader;

class FrontendController extends Controller
{
    public function header()
    {
        $query = PortalHeader::where('status', 1)
        ->select('id', 'title', 'title_bn', 'description', 'description_bn', 'helpline', 'logo');
        $list = $query->first();

        if (!$list) {
            return response([
                'success' => false,
                'message' => 'Data not found.'
            ]);
        }

        return response([
            'success' => true,
            'message' => 'Header data found.',
            'data' => $list
        ]);
    }

    public function customerTypeList()
    {
        $query = ServiceCustomerType::query();
        $query = $query->withCount([
            'service AS service_count' => function ($q) {
                $q->where('portal_services.service_type_id', 1);
            }
        ]);
        $list = $query->get();

        if (!$list) {
            return response([
                'success' => false,
                'message' => 'Data not found.'
            ]);
        }

        return response([
            'success' => true,
            'message' => 'customer type data found.',
            'data' => $list
        ]);
    }
    public function categoryList()
    {
        $query = ServiceCategory::query();
        $query = $query->withCount([
            'service AS service_count' => function ($q) {
                $q->where('portal_services.service_type_id', 1);
            }
        ]);
        $list = $query->get();

        if (!$list) {
            return response([
                'success' => false,
                'message' => 'Data not found.'
            ]);
        }

        return response([
            'success' => true,
            'message' => 'customer type data found.',
            'data' => $list
        ]);
    }
    public function orgList()
    {
        $query = MasterOrgProfile::query();
        $query = $query->withCount([
            'service AS service_count' => function ($q) {
                $q->where('portal_services.service_type_id', 1);
            }
        ]);
        $list = $query->get();

        if (!$list) {
            return response([
                'success' => false,
                'message' => 'Data not found.'
            ]);
        }

        return response([
            'success' => true,
            'message' => 'Org data found.',
            'data' => $list
        ]);
    }
    public function serviceList(Request $request)
    {
        $query = Service::with(['attachment', 'fees']);
        $query->leftJoin('portal_service_permissions', 'portal_services.id','=', 'portal_service_permissions.service_id')
        ->where('portal_services.service_type_id', 1)
        ->select(
            "portal_services.*",
            "portal_service_permissions.pr_apply_btn",
            "portal_service_permissions.pr_service_applied",
            "portal_service_permissions.pr_target_customer"
        );
        if ($request->service_category_id) {
            $query->where('portal_services.service_category_id', $request->service_category_id);
        }
        if ($request->org_id) {
            $query->join('portal_service_org', 'portal_services.id', 'portal_service_org.service_id');
            $query->where('portal_service_org.org_id', $request->org_id);
        }
        if ($request->name) {
            $query = $query->where('name', 'like', "{$request->name}%")
                            ->orWhere('name_bn', 'like', "{$request->name}%");
        }
        if ($request->status) {
            if ($request->status === 'active') {
                $query = $query->where('portal_services.status', 1);
            } else {
                $query = $query->where('portal_services.status', 2);
            }
        }
        if ($request->customer_type_id) {
            $query->join('portal_service_customers', 'portal_services.id', 'portal_service_customers.service_id');
            $query->where('portal_service_customers.customer_type_id', $request->customer_type_id);
        }
        $list = $query->orderBy('portal_services.status', 'desc')->get();

        if (!$list) {
            return response([
                'success' => false,
                'message' => 'Data not found.'
            ]);
        }

        return response([
            'success' => true,
            'message' => 'Service data found.',
            'data' => $list
        ]);
    }
    
    public function service()
    {
        $query = Service::with(['attachment', 'fees'])->where('service_type_id', 1);
        // ->where('status', 1);
        $serviceList = $query->get();
        $total_services = $query->count();
        
        if (!$serviceList) {
            return response([
                'success' => false,
                'message' => 'Data not found.'
            ]);
        }
        
        $query = ServiceCustomerType::query();
        $query = $query->with(['service'=> function ($d) {
            $d->select('portal_services.id', 'portal_services.name', 'portal_services.name_bn')
            ->where('portal_services.service_type_id', 1);
        }]);

        $serviceCustomerTypeList = $query->get();

        if (!$serviceCustomerTypeList) {
            return response([
                'success' => false,
                'message' => 'Data not found.'
            ]);
        }
        
        $query = ServiceCategory::query();
        $query = $query->with(['service'=> function ($d) {
            $d->select('portal_services.id', 'portal_services.name', 'portal_services.name_bn', 'portal_services.service_category_id')
            ->where('portal_services.service_type_id', 1);
        }]);

        $serviceCategoryList = $query->get();

        if (!$serviceCategoryList) {
            return response([
                'success' => false,
                'message' => 'Data not found.'
            ]);
        }


        $query = MasterOrgProfile::query();
        $query = $query->with(['service'=> function ($d) {
            $d->select('portal_services.id', 'portal_services.name', 'portal_services.name_bn', 'portal_services.service_type_id')
            ->where('portal_services.service_type_id', 1);
        }]);
        
        $query->select('id', 'abbreviation', 'abbreviation_bn', 'org_name','website_url', 'org_name_bn', 'logo', 'status');
        $orgList = $query->get();

        if (!$orgList) {
            return response([
                'success' => false,
                'message' => 'Data not found.'
            ]);
        }

        $data = [];
        $data['serviceList'] = $serviceList;
        $data['serviceCustomerTypeList'] = $serviceCustomerTypeList;
        $data['serviceCategoryList'] = $serviceCategoryList;
        $data['orgList'] = $orgList;
        $data['total_services'] = $total_services;


        return response([
            'success' => true,
            'message' => 'Service data found.',
            'data' => $data
        ]);
    }

    public function aboutServicePortal () {
        $aboutPortal = AboutServicePortal::select('id', 'description', 'description_bn')
        ->where('status', 1)
        ->latest()->first();

        if (!$aboutPortal) {
            $aboutPortal = null;
        }

        return response([
            'success' => true,
            'message' => 'About Service Portal Data Found.',
            'data' => $aboutPortal
        ]);
    }
}
