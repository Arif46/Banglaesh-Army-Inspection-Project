<?php
use Illuminate\Support\Facades\Route;

Route::group(['prefix'=>'/notification-management', 'namespace' => 'NotificationManagement'], function() {
    // notification-type routes....
    Route::group(['prefix'=>'/notification-type'], function(){
        Route::get('/list', 'NotificationTypeController@list');
        Route::get('/get-all', 'NotificationTypeController@getAll');
        Route::post('/store', 'NotificationTypeController@store');
        Route::put('/update/{id}', 'NotificationTypeController@update');
        Route::get('/show/{id}', 'NotificationTypeController@show');
        Route::delete('/toggle-status/{id}', 'NotificationTypeController@toggleStatus');
        Route::delete('/destroy/{id}', 'NotificationTypeController@destroy');
    });

        // notification-template routes....
        Route::group(['prefix'=>'/notification-template'], function(){
        Route::get('/list', 'NotificationTemplateController@list');
        Route::get('/get-all', 'NotificationTemplateController@getAll');
        Route::post('/store', 'NotificationTemplateController@store');
        Route::put('/update/{id}', 'NotificationTemplateController@update');
        Route::get('/show/{id}', 'NotificationTemplateController@show');
        Route::delete('/toggle-status/{id}', 'NotificationTemplateController@toggleStatus');
        Route::delete('/destroy/{id}', 'NotificationTemplateController@destroy');
    });
    
    // Master Notification routes....
    Route::group(['prefix'=>'/notification-setup'], function(){
        Route::get('/list', 'NotificationSetupController@list');
        Route::get('/get-all', 'NotificationSetupController@getAll');
        Route::post('/store', 'NotificationSetupController@store');
        Route::put('/update/{id}', 'NotificationSetupController@update');
        Route::get('/show/{id}', 'NotificationSetupController@show');
        Route::delete('/toggle-status/{id}', 'NotificationSetupController@toggleStatus');
        Route::delete('/destroy/{id}', 'NotificationSetupController@destroy');
    });

        // NotCirculate Notice Controller routes....
        Route::group(['prefix'=>'circulate-notice'], function(){
        Route::get('/list', 'NotCirculateNoticeController@list');
        Route::get('/get-all', 'NotCirculateNoticeController@getAll');
        Route::post('/store', 'NotCirculateNoticeController@store');
        Route::put('/update/{id}', 'NotCirculateNoticeController@update');
        Route::get('/show/{id}', 'NotCirculateNoticeController@show');
        Route::delete('/toggle-status/{id}', 'NotCirculateNoticeController@toggleStatus');
        Route::delete('/destroy/{id}', 'NotCirculateNoticeController@destroy');
    });
    
});
