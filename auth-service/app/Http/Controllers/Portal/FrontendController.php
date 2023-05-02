<?php

namespace App\Http\Controllers\Portal;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;

class FrontendController extends Controller
{
//    public function TotalRegister () {
//         $total_user = User::where('user_type_id', '!=', 0)->count();
//         if (!$total_user) {
//             return response([
//                 'success' => false,
//                 'message' => 'Data not found.',
//                 'data' => []
//             ]);
//         }
//         return response([
//             'success' => true,
//             'message' => 'Total user found.',
//             'data' => $total_user
//         ]);
//    }

   public function getUsers (Request $request) {
        $user_ids = json_decode($request->user_ids, true);
        $users = User::whereIn('id', $user_ids)->select('id', 'name', 'name_bn')->get();
        
        return response([
            'success' => true,
            'message' => 'User data found.',
            'data' => $users
        ]);
   }
}
