<?php
use Illuminate\Support\Facades\Route;

Route::group(['prefix'=>'/information-service-management', 'namespace' => 'InformationServiceManagement'], function() {
    // master information-service-management routes....
    
    Route::group(['prefix'=>'/service-eligibility-type'], function(){
        Route::get('/list', 'ServiceEligibilityTypeController@list');
        Route::get('/get-all', 'ServiceEligibilityTypeController@getAll');
        Route::post('/store', 'ServiceEligibilityTypeController@store');
        Route::put('/update/{id}', 'ServiceEligibilityTypeController@update');
        Route::get('/show/{id}', 'ServiceEligibilityTypeController@show');
        Route::delete('/toggle-status/{id}', 'ServiceEligibilityTypeController@toggleStatus');
        Route::delete('/destroy/{id}', 'ServiceEligibilityTypeController@destroy');
    });   
});
