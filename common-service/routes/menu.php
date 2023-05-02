<?php

use Illuminate\Support\Facades\Route;

Route::group(['prefix'=>'/menu', 'namespace' => 'Menu'], function() {

    Route::group(['prefix'=>'/component'], function(){
        Route::get('/list', 'MasterComponentController@list');
        Route::get('/get-all', 'MasterComponentController@getAll');
        Route::post('/store', 'MasterComponentController@store');
        Route::put('/update/{id}', 'MasterComponentController@update');
        Route::get('/show/{id}', 'MasterComponentController@show');
        Route::delete('/toggle-status/{id}', 'MasterComponentController@toggleStatus');
        Route::delete('/destroy/{id}', 'MasterComponentController@destroy');
    });

    Route::group(['prefix'=>'/module'], function(){
        Route::get('/list', 'MasterModuleController@list');
        Route::post('/store', 'MasterModuleController@store');
        Route::put('/update/{id}', 'MasterModuleController@update');
        Route::delete('/toggle-status/{id}', 'MasterModuleController@toggleStatus');
    });

    Route::group(['prefix'=>'/service'], function(){
        Route::get('/list', 'MasterServiceController@list');
        Route::post('/store', 'MasterServiceController@store');
        Route::put('/update/{id}', 'MasterServiceController@update');
        Route::delete('/toggle-status/{id}', 'MasterServiceController@toggleStatus');
    });

    Route::group(['prefix'=>'/menu'], function(){
        Route::get('/list', 'MasterMenuController@list');
        Route::get('/all-menu-list', 'MasterMenuController@allMenus');
        Route::post('/store', 'MasterMenuController@store');
        Route::put('/update/{id}', 'MasterMenuController@update');
        Route::delete('/toggle-status/{id}', 'MasterMenuController@toggleStatus');
    });

    Route::post('/change-serial-order/{model}', 'MasterMenuController@changeSerialOrder');
    Route::get('/components-from-menu', 'MasterMenuController@componentsOfSuperAdmin');
    Route::get('/sidebar-menus/{roleId}/{componentId}', 'MasterMenuController@menusByRoleComponent');
});
