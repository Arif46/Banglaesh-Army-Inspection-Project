<?php
use Illuminate\Support\Facades\Route;

// Route::group(['middleware'  =>  'token'], function () {
    Route::group(['prefix'=>'/specification', 'namespace' => 'Specification'], function() {

        // Master Specification Info...
        Route::group(['prefix'=>'/specification-info'], function() {
            Route::post('/store', 'SpecificationInfoController@store');
            Route::get('/list', 'SpecificationInfoController@index');
            Route::put('/update/{id}', 'SpecificationInfoController@update');
        }); 
        // Specification Verify
        Route::group(['prefix'=>'/specification-verify'], function() {
            Route::get('/verify-lists', 'SpecificationVerfyController@verifyInfoList');
            Route::post('/store', 'SpecificationVerfyController@store');
            Route::get('/list', 'SpecificationVerfyController@index');
            Route::get('/show/{id}', 'SpecificationVerfyController@show');
            Route::put('/update/{id}', 'SpecificationVerfyController@update');
        }); 

        // Specification Report List
        Route::group(['prefix'=>'/report'], function() {
            Route::get('/list', 'SpecficationReportController@getReport');
        }); 

    });

//});
