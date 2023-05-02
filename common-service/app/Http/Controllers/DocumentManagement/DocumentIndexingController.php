<?php

namespace App\Http\Controllers\DocumentManagement;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DocumentIndexingController extends Controller
{
    public function list(Request $request)
    {
        // return $request;
        if($request->org_id){
            $query = DB::table('doc_doc_infos')
            ->join('master_document_categories','doc_doc_infos.category_id', '=','master_document_categories.id')
            ->join('master_org_profiles','doc_doc_infos.org_id', '=','master_org_profiles.id')
            ->select('doc_doc_infos.*',
                'master_document_categories.category_name','master_document_categories.category_name_bn',
                'master_org_profiles.org_name','master_org_profiles.org_name_bn')
                ->whereIn('doc_doc_infos.category_id', $request->category_id)
                ->where('doc_doc_infos.org_id', $request->org_id)
                ->orderBy('master_org_profiles.org_name', 'ASC')
                ->orderBy('master_document_categories.category_name', 'ASC')
                ->orderBy('doc_doc_infos.doc_title', 'ASC')
                ->paginate($request->limit);

            return response([
                'success' => true,
                'message' => 'Document Indexing list',
                'data' => $query
            ]);
        }
    }
}
