<?php
use Illuminate\Support\Facades\Route;

Route::group(['prefix'=>'/organogram', 'namespace' => 'Organogram'], function() {
    // master Office Type routes....
    Route::group(['prefix'=>'/office-type'], function(){
        Route::get('/list', 'MasterOfficeTypeController@list');
        Route::get('/get-all', 'MasterOfficeTypeController@getAll');
        Route::post('/store', 'MasterOfficeTypeController@store');
        Route::put('/update/{id}', 'MasterOfficeTypeController@update');
        Route::get('/show/{id}', 'MasterOfficeTypeController@show');
        Route::delete('/toggle-status/{id}', 'MasterOfficeTypeController@toggleStatus');
        Route::delete('/destroy/{id}', 'MasterOfficeTypeController@destroy');
    });

    // master division routes....
    Route::group(['prefix'=>'/designation'], function(){
        Route::get('/list', 'DesignationController@list');
        Route::post('/store', 'DesignationController@store');
        Route::put('/update/{id}', 'DesignationController@update');
        Route::delete('/toggle-status/{id}', 'DesignationController@toggleStatus');
        Route::get('/component-designation-list', 'DesignationController@getComponentDesignationList');
        Route::get('/component-assign-designation-list', 'DesignationController@getComponentAssignDesignationList');
    });


        // Master Assign ROutes routes....
    Route::group(['prefix'=>'/assign-designations'], function(){
        Route::get('/list', 'MasterAssignDesignationController@index');
        Route::get('/get-all', 'MasterAssignDesignationController@getAll');
        Route::post('/store', 'MasterAssignDesignationController@store');
        Route::put('/update/{id}', 'MasterAssignDesignationController@update');
        Route::get('/show/{id}', 'MasterAssignDesignationController@show');
        Route::delete('/toggle-status/{id}', 'MasterAssignDesignationController@toggleStatus');
        Route::delete('/destroy/{id}', 'MasterAssignDesignationController@destroy');
    });

    // master Office  routes....
    Route::group(['prefix'=>'/office'], function(){
        Route::get('/list', 'MasterOfficeController@list');
        Route::get('/get-all', 'MasterOfficeController@getAll');
        Route::post('/store', 'MasterOfficeController@store');
        Route::put('/update/{id}', 'MasterOfficeController@update');
        Route::get('/show/{id}', 'MasterOfficeController@show');
        Route::delete('/toggle-status/{id}', 'MasterOfficeController@toggleStatus');
        Route::delete('/destroy/{id}', 'MasterOfficeController@destroy');
        Route::get('/organogram', 'MasterOfficeController@organogram');
        Route::get('/office-wise-people', 'MasterOfficeController@officeWisePeople');
        Route::get('/parent-office', 'MasterOfficeController@parentOffice');
        Route::get('/region', 'MasterOfficeController@region');
        Route::get('/region-wise-division-or-district/{type}', 'MasterOfficeController@regionWiseDivisionOrDistrict');
        Route::get('/disabled-head-office', 'MasterOfficeController@getDisabledHeadOffice');
        Route::post('/create-update-tea-garden-office', 'MasterOfficeController@createOrUpdateTeaGardenOffice');
    });


    // Component Designation Api Route ....
    Route::group(['prefix'=>'/component-designaiton'], function(){
        Route::get('/list', 'ComponentDesignationController@list');
        Route::post('/store', 'ComponentDesignationController@store');
        Route::put('/update', 'ComponentDesignationController@update');
        Route::put('/toggle-status', 'ComponentDesignationController@toggleStatus');
        // load from mixin directly
        Route::get('/comp-designations/{componentId}', 'ComponentDesignationController@designationByComponentId');
    });
});
