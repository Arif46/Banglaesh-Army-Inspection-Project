<?php

namespace App\Http\Controllers\Portal;

use App\Http\Controllers\Controller;
use App\Models\Portal\AboutServicePortal;
use Illuminate\Http\Request;

class AboutServicePortalController extends Controller
{
    public function index(Request $request)
    {
        $query = AboutServicePortal::select("*");

        $list = $query->orderBy('id', 'desc')->get();

        if (count($list) > 0) {
            return response([
                'success' => true,
                'message' => 'About Service Portal list',
                'data' => $list
            ]);
        } else {
            return response([
                'success' => false,
                'message' => 'Not Found'
            ]);
        }

    }

    public function store(Request $request)
    {

        $model = new AboutServicePortal();
        $model->description = $request->description;
        $model->description_bn = $request->description_bn;
        $model->status = 1;
        $model->created_by = user_id();
        $model->updated_by = user_id();
        $model->save();

        return response([
            'success' => true,
            'message' => 'Data inserted successfully',
            'data' => $model
        ]);
    }

    public function update(Request $request, $id)
    {

        $model = AboutServicePortal::find($id);
        $model->description = $request->description;
        $model->description_bn = $request->description_bn;
        $model->updated_by = user_id();
        $model->update();

        return response([
            'success' => true,
            'message' => 'Data updated successfully',
            'data' => $request->all()
        ]);

    }

    public function toggleStatus($id)
    {
        $about = AboutServicePortal::find($id);

        if (!$about) {
            return response([
                'success' => false,
                'message' => 'Data not found.'
            ]);
        }

        $about->status = $about->status ? 0 : 1;
        $about->update();

        save_log([
            'data_id'        => $about->id,
            'table_name'     => 'portal_abouts',
            'execution_type' => 2
        ]);

        return response([
            'success' => true,
            'message' => 'Data updated successfully',
            'data'    => $about
        ]);
    }
}
