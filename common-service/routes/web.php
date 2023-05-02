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

use Illuminate\Support\Facades\{Cache, App, Route};

$router->get('/', function () use ($router) {
    return $router->app->version();
});

Route::get('/clear-cache', function() {
    Cache::store('redis')->flush();
    return "Cache is cleared";
});

$router->get('/auto', function () {
    return 'auto deploy working';
});


Route::get('portal-common-dropdowns', function () {
    $list = [
        'orgProfileList'  => App::make('orgProfileList'),
        'fiscalYearList'  => App::make('fiscalYearList'),
        'designationList'  => App::make('designationList'),
        'countryList'  => App::make('countryList')
    ];
    return response()->json([
        'success' => true,
        'data' => $list
    ]);
});

Route::get('rjsc-portal-common-dropdowns', function () {
    $list = [
        'fiscalYearList'    => App::make('fiscalYearList'),
        'divisionList'      => App::make('divisionList'),
        'districtList'      => App::make('districtList'),
        'officeTypeList'    => App::make('officeTypeList'),
        'officeList'        => App::make('officeList'),
    ];
    return response()->json([
        'success' => true,
        'data' => $list
    ]);
});


//download file path from storage
Route::get('download-attachment', 'DownloadController@downloadAttachment');
Route::get('show-attachment', 'DownloadController@showAttachment');
Route::post('common-request', 'OtherServiceRequestController@commonRequest');

Route::get('common-dropdowns', function () {
    $list = [
        'committeeList' => App::make('committeeList'),
        'agendaList' => App::make('agendaList'),
        'componentList' => App::make('componentList'),
        'divisionList'  => App::make('divisionList'),
        'countryList'  => App::make('countryList'),
        'moduleList'  => App::make('moduleList'),
        'districtList'  => App::make('districtList'),
        'upazilaList'  => App::make('upazilaList'),
        'thanaList'  => App::make('thanaList'),
        'serviceList'  => App::make('serviceList'),
        'unionList'  => App::make('unionList'),
        'municipalityList'  => App::make('municipalityList'),
        'cityCorporationList'  => App::make('cityCorporationList'),
        'wardList'  => App::make('wardList'),
        'officeList' => App::make('officeList'),
        'officeTypeList'  => App::make('officeTypeList'),
        'orgProfileList'  => App::make('orgProfileList'),
        'orgComponentList'  => App::make('orgComponentList'),
        'dialogueInfosList'  => App::make('dialogueInfosList'),
        'fiscalYearList'  => App::make('fiscalYearList'),
        'designationList'  => App::make('designationList'),
        'assignDesignationList'  => App::make('assignDesignationList'),
        'bankList'  => App::make('bankList'),
        'branchList'  => App::make('branchList'),
        'bankNameList'  => App::make('bankNameList'),
        'branchNameList'  => App::make('branchNameList'),
        'notificationTypeList'  => App::make('notificationTypeList'),
        'menuList'  => App::make('menuList'),
        'documentCategoryList'  => App::make('documentCategoryList'),
        'notificationTemplateList'  => App::make('notificationTemplateList'),
        'ministryNameList'  => App::make('ministryNameList'),
        'portalServiceCategoryList'  => App::make('portalServiceCategoryList'),
        'portalCustomerTypeList'  => App::make('portalCustomerTypeList'),
        'exOrgList'  => App::make('exOrgList'),
        'externalPanelList'  => App::make('externalPanelList'),
        'externalMenuList'  => App::make('externalMenuList'),
        'portalServiceNameList'  => App::make('portalServiceNameList')
    ];
    return response()->json([
        'success' => true,
        'data' => $list
    ]);
});

Route::get('common-dropdowns-external', function () {
    $list = [
        'componentList' => App::make('componentList'),
        'orgComponentList'  => App::make('orgComponentList'),
        'divisionList'  => App::make('divisionList'),
        'districtList'  => App::make('districtList'),
        'upazilaList'  => App::make('upazilaList'),
        'unionList'  => App::make('unionList'),
        'municipalityList'  => App::make('municipalityList'),
        'serviceList'  => App::make('serviceList'),
        'cityCorporationList'  => App::make('cityCorporationList'),
        'orgProfileList'  => App::make('orgProfileList'),
        'fiscalYearList'  => App::make('fiscalYearList'),
        'wardList'  => App::make('wardList'),
        'officeList' => App::make('officeList'),
        'officeTypeList'  => App::make('officeTypeList'),
        'dialogueInfosList'  => App::make('dialogueInfosList'),
        'designationList'  => App::make('designationList'),
        'countryList'  => App::make('countryList'),
        'bankNameList'  => App::make('bankNameList'),
        'branchNameList'  => App::make('branchNameList')
    ];
    return response()->json([
        'success' => true,
        'data' => $list
    ]);
});

// Route::group(['middleware'  =>  'token'], function () {

    // Route::group(['prefix'=>'/config', 'namespace' => 'Menu'], function() {
        Route::group(['prefix'=>'/component'], function(){
            Route::get('/all', 'DemoController@all');
            Route::get('/list', 'DemoController@list');
            Route::get('/get-all', 'DemoController@getAll');
            Route::post('/store', 'DemoController@store');
            Route::put('/update/{id}', 'DemoController@update');
            Route::get('/show/{id}', 'DemoController@show');
            Route::delete('/toggle-status/{id}', 'DemoController@toggleStatus');
            Route::delete('/destroy/{id}', 'DemoController@destroy');
        });
    // });

    include('menu.php');
    include('orgProfile.php');
    include('organogram.php');
    include('notificationManagement.php');
    include('portal.php');
    include('informationServiceManagement.php');
    include('documentManagement.php');
    include('complainManagement.php');
    include('committeeManagement.php');
    include('external.php');

// });
