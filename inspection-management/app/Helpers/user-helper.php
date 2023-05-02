<?php
use Illuminate\Support\Facades\Crypt;
namespace App\Library;

if (!function_exists('user_id')) {
  function user_id()
  {
    // return app('request')->header('accessUserId');
    $userDetail = unserialize(Crypt::decryptString(app('request')->header('user_detail')));
    return $userDetail['user_id'];    
  }
}

if (!function_exists('username')) {
  function username()
  {
    // return app('request')->header('accessUsername');
    $userDetail = unserialize(Crypt::decryptString(app('request')->header('user_detail')));
    return $userDetail['username'];
  }
}

if (!function_exists('per_page')) {
  function per_page()
  {
    return request('per_page', config('app.per_page'));
  }
}

function getAuthUser()
{
    $baseUrl = config('app.base_url.auth_service');
    $uri2 = '/auth-user';
    $param = [];
    $authUserJsonData = \App\Library\RestService::getData($baseUrl, $uri2, $param);

    $authUser = json_decode($authUserJsonData);

    return $authUser ? $authUser->data : false;
}