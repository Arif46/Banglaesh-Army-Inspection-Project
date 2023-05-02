<?php

namespace App\Library;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cache;

class CommonInfo
{
    /**
     * @queryParam Desingation Wise UserList 
     */
    public static function getUserByDesignationId ($request, $id) {
        return DB::table('users')
            ->join('user_details', 'users.id', '=', 'user_details.user_id')
            // ->where('users.user_type', '=', 0)
            ->where('user_details.designation_id', '=', $id)
            ->select('user_details.user_id as value',
                'users.name as text_en',
                'users.name_bn as text_bn',
                'users.signature',
                'users.email',
                'users.mobile'
             )
            ->get();
    }

    /** 
     * fetch user details by user ids
     */
    public static function getUserDetailByUserIds ($userIds) {
        return DB::table('users')
            ->join('user_details', 'users.id', '=', 'user_details.user_id')
            ->whereIn('users.id', $userIds)
            ->select('user_details.user_id as value','user_details.designation_id',
             'users.name as text_en',
             'users.name_bn as text_bn',
             'users.username', 'user_details.office_id',
             'users.mobile','users.email'
             )
            ->get();
    }
    /** 
     * fetch user details by user ids
     */
    public static function getExterUserDetailByUserIds ($userIds) {
          return DB::table('user_profiles')
            ->leftJoin('users', 'user_profiles.user_id', '=', 'users.id')
            ->whereIn('users.id', $userIds)
            ->select('user_profiles.user_id as value',
            'users.name as text_en',
            'users.name_bn as text_bn',
            'users.username',
            'users.mobile','users.email'
            )
            ->get();

    }

    /**
     * All Components are cached for 24 hours. Which are retrieved from 
     */
    public static function getAllComponents()
    {
        $baseUrl = config('app.base_url.common_service');
        $uri = "/menu/component/get-all";
        $param = [];
        return \App\Library\RestService::getData($baseUrl, $uri, $param);
    }
}
