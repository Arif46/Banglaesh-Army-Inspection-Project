<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class DownloadController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }
    /** This download route will download file which has path like 
     * uploads/file_name or something like that
     * where full file in the project is like storage/uploads/file_name
     **/
    public function downloadAttachment(Request $request)
    {
        return response()->download(base_path('storage/' . $request->file));
    }
}
