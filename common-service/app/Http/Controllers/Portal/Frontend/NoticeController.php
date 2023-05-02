<?php

namespace App\Http\Controllers\Portal\Frontend;

use App\Http\Controllers\Controller;
use App\Models\Portal\PortalNotice;
use Illuminate\Http\Request;

class NoticeController extends Controller
{
    public function index(Request $request)
    {
        $query = PortalNotice::query();
        if ($request->title) {
            $query = $query->where('title', 'like', "%{$request->title}%")
                    ->orWhere('title_bn', 'like', "%{$request->title}%");
        }
        if ($request->date) {
            $query = $query->whereDate('created_at', $request->date);
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
            'message' => 'Notice data found.',
            'data' => $list
        ]);
    }

    public function noticeListHome(Request $request)
    {
        $query = PortalNotice::query();
        $list = $query->orderBy('id', 'desc')->take(4)->get();
        if (!$list) {
            return response([
                'success' => false,
                'message' => 'Data not found.'
            ]);
        }

        return response([
            'success' => true,
            'message' => 'Notice data found.',
            'data' => $list
        ]);
    }
}
