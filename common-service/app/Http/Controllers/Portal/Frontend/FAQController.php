<?php

namespace App\Http\Controllers\Portal\Frontend;

use App\Http\Controllers\Controller;

use App\Models\Portal\Faq;
use Illuminate\Http\Request;
use App\Models\OrgProfile\MasterOrganizationProfile;

class FAQController extends Controller
{

    public function index(Request $request)
    {
        $query = Faq::query();
        if ($request->title) {
            $query = $query->where('title', 'like', "%{$request->title}%")
                    ->orWhere('title_bn', 'like', "%{$request->title}%");
        }
        $list = $query->orderBy('id', 'desc')->where('status', 1)->get();
        if (!$list) {
            return response([
                'success' => false,
                'message' => 'Data not found.'
            ]);
        }
        return response([
            'success' => true,
            'message' => 'Faq data found.',
            'data' => $list
        ]);
    }

    public function faqListHome(Request $request)
    {
        $query = Faq::query();
        $list = $query->orderBy('id', 'desc')->take(4)->get();
        if (!$list) {
            return response([
                'success' => false,
                'message' => 'Data not found.'
            ]);
        }
        return response([
            'success' => true,
            'message' => 'Faq data found.',
            'data' => $list
        ]);
    }
}
