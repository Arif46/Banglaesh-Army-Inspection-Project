<?php

use Illuminate\Support\Facades\Route;

Route::group(['prefix'=>'/external', 'namespace' => 'External'], function() {
    
    Route::group(['prefix'=>'/external-panel'], function(){
        Route::get('/list', 'MasterExternalPanelController@list');
        Route::get('/get-all', 'MasterExternalPanelController@getAll'); // loaded from external panel
        Route::post('/store', 'MasterExternalPanelController@store');
        Route::put('/update/{id}', 'MasterExternalPanelController@update');
        Route::delete('/toggle-status/{id}', 'MasterExternalPanelController@toggleStatus');
    });
    
    Route::group(['prefix'=>'/external-menu'], function(){
        Route::get('/list', 'MasterExternalMenuController@list');
        Route::get('/get-all', 'MasterExternalMenuController@getAll');
        Route::post('/store', 'MasterExternalMenuController@store');
        Route::put('/update/{id}', 'MasterExternalMenuController@update');
        Route::delete('/toggle-status/{id}', 'MasterExternalMenuController@toggleStatus');
        Route::get('/sidebar-menus/{panelId}', 'MasterExternalMenuController@menuByPanel');
        // Route::get('/sidebar-menus-by-url', 'MasterExternalMenuController@menuByUrl');
    });    
    Route::post('/change-serial-order/{model}', 'MasterExternalPanelController@changeSerialOrder');
    Route::post('/change-menu/serial-order/{model}', 'MasterExternalMenuController@changeMenuSerialOrder');
});
