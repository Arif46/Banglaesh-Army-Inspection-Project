<?php

/** @var \Laravel\Lumen\Routing\Router $router */

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

use Illuminate\Support\Facades\{Cache, App, Route, Artisan};

$router->get('/', function () use ($router) {
    return $router->app->version();
});

$router->get('/auto', function () {
    return 'auto deploy working & testing with aziz BOM';
});

Route::get('/clear-cache', function() {
    Artisan::call('cache:clear');
    Cache::store('redis')->flush();
    return "Cache is cleared";
});

/** Password Reset */
$router->post('/forgot-password/otp-sending','PasswordResetController@sendOtp');
$router->post('/forgot-password/otp-verification','PasswordResetController@verifyOtp');
$router->post('/forgot-password/change-password', 'PasswordResetController@changePassword');

Route::get('common-dropdowns', function () {
    $list = [
        'posts' => App::make('postList'),
        'users' => App::make('userList')
    ];
    return response()->json([
        'success' => true,
        'data' => $list
    ]);
});

Route::get('token-verification', 'AuthController@tokenVerification');

Route::post('signup', 'AuthController@register');
Route::post('otp-verify', 'AuthController@otpVerify');
Route::post('otp-resend', 'AuthController@otpResend');

Route::post('login', 'AuthController@login');
Route::post('logout', 'AuthController@logout');
Route::post('refresh', 'AuthController@refresh');
Route::post('user-profile', 'AuthController@me');

Route::group(['prefix'=>'/post'], function(){
    Route::get('/all', 'PostController@all');
    Route::get('/list', 'PostController@index');
    Route::get('/get-all', 'PostController@getAll');
    Route::post('/store', 'PostController@store');
    Route::put('/update/{id}', 'PostController@update');
    Route::get('/show/{id}', 'PostController@show');
    Route::delete('/toggle-status/{id}', 'PostController@toggleStatus');
    Route::delete('/destroy/{id}', 'PostController@destroy');
});

// User Common Profile Routes
Route::group(['prefix'=>'/common-profile'], function() {
    Route::post('/store', 'UserCommonProfileController@store');
    Route::put('/update/{id}', 'UserCommonProfileController@update');
    Route::get('/show/{id}', 'UserCommonProfileController@show');
});

// Desingation wise user list
Route::get('/user/users-by-designation-id/{id}', function (\Illuminate\Http\Request $request, $id)
{
    return \App\Library\CommonInfo::getUserByDesignationId($request, $id);
});

// get all users by Hasinur
Route::get('/user-detail-by-user-ids', function (\Illuminate\Http\Request $request)
{
    return \App\Library\CommonInfo::getUserDetailByUserIds($request->user_ids);
});

// get all Externel users List
Route::get('/externel-user-detail-by-user-ids', function (\Illuminate\Http\Request $request)
{
    return \App\Library\CommonInfo::getExterUserDetailByUserIds($request->user_ids);
});

//download file path from storage
Route::get('download-attachment', 'DownloadController@downloadAttachment');

// nothi routes
Route::group(['prefix' => '/nothi'], function () {
    Route::get('/api-access','NothiUserController@apiAccess');
    Route::post('/api-online-application','NothiUserController@apiOnlineApplication');
    Route::post('/api-re-online-application','NothiUserController@apiReOnlineApplication');
    Route::post('/nothi-return','NothiUserController@nothiReturn');
    Route::get('/demo-api-online-application','NothiUserController@demoApiOnlineApplication');
    Route::get('/sso-user','NothiUserController@ssoUser');
});


include('auth.php');
include('user_management.php');
include('portal.php');
