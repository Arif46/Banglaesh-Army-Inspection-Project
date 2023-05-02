<?php
namespace App\Library;

class UserHelper
{
    public static function getUserDetailByUserIds ($userIds) {
        $baseUrl = config('app.base_url.auth_service');
        $uri = "/user-detail-by-user-ids";
        $param = ['user_ids' => $userIds];
        return \App\Library\RestService::getData($baseUrl, $uri, $param);
    }

    public static function getExterUserDetailByUserIds ($userIds) {
        $baseUrl = config('app.base_url.auth_service');
        $uri = "/externel-user-detail-by-user-ids";
        $param = ['user_ids' => $userIds];
        return \App\Library\RestService::getData($baseUrl, $uri, $param);
    }

    public static function fiscalYearById ($id) {
        $baseUrl = config('app.base_url.common_service');
        $uri = "/master-fiscal-year/show/".$id;
        return \App\Library\RestService::getData($baseUrl, $uri, null);
    }

    
}