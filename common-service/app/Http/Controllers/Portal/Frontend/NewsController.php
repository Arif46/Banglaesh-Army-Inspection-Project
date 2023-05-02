<?php

namespace App\Http\Controllers\Portal\Frontend;

use App\Http\Controllers\Controller;

use App\Models\Portal\News;
use Illuminate\Http\Request;

class NewsController extends Controller
{

    public function index(Request $request)
    {
        $query = News::query();
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
            'message' => 'News data found.',
            'data' => $list
        ]);
    }

    public function newsListHome(Request $request)
    {
        $query = News::where('status', 1);
        $list = $query->orderBy('id', 'desc')->take(5)->get();
        if (!$list) {
            return response([
                'success' => false,
                'message' => 'Data not found.'
            ]);
        }

        return response([
            'success' => true,
            'message' => 'News data found.',
            'data' => $list
        ]);
    }

    public function show(Request $request)
    {
        $data = News::find($request->id);
        if (!$data) {
            return response([
                'success' => false,
                'message' => 'Data not found.',
                'data' => []
            ]);
        }

        return response([
            'success' => true,
            'message' => 'News data found.',
            'data' => $data
        ]);
    }

    public function popular(Request $request)
    {
        $data = News::orderBy('id', 'desc')->where('status', 1)->take(10)->get();
        if (!$data) {
            return response([
                'success' => false,
                'message' => 'Data not found.',
                'data' => []
            ]);
        }

        return response([
            'success' => true,
            'message' => 'News data found.',
            'data' => $data
        ]);
    }
}
