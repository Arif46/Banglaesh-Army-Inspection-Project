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

Route::get('/clear-cache', function() {
    Cache::store('redis')->flush();
    return "Cache is cleared";
});

$router->get('/', function () use ($router) {
    return $router->app->version();
});

//download file path from storage
Route::get('download-attachment', 'DownloadController@downloadAttachment');
Route::get('show-attachment', 'DownloadController@showAttachment');

// Route::get('common-dropdowns', function () {
    // $list = [
    //     'tradeTariffCountryList' => App::make('tradeTariffCountryList'),
    //     'capitalInfoList' => App::make('capitalInfoList'),
    //     'applicationTypeList' => App::make('applicationTypeList'),
    //     'currencyList' => App::make('currencyList'),
    //     'productList' => App::make('productList'),
    //     'unitMeasurementList' => App::make('unitMeasurementList'),
    //     'chapterList' => App::make('chapterList'),
    //     'sectionList' => App::make('sectionList'),
    //     'headingList' => App::make('headingList'),
    //     'subHeadingList' => App::make('subHeadingList'),
    //     'subjectList' => App::make('subjectList'),
    // ];
    // return response()->json([
    //     'success' => true,
    //     'data' => $list
    // ]);
// });

include('specification.php');
