<?php
use Illuminate\Support\Facades\Route;

Route::group(['prefix'=>'/document-management', 'namespace' => 'DocumentManagement'], function() {
    // document-category routes....
    Route::group(['prefix'=>'/document-category'], function(){
        Route::get('/list', 'DocumentCategoryController@list');
        Route::get('/get-all', 'DocumentCategoryController@getAll');
        Route::post('/store', 'DocumentCategoryController@store');
        Route::put('/update/{id}', 'DocumentCategoryController@update');
        Route::get('/show/{id}', 'DocumentCategoryController@show');
        Route::delete('/toggle-status/{id}', 'DocumentCategoryController@toggleStatus');
        Route::delete('/destroy/{id}', 'DocumentCategoryController@destroy');
    });

    // document-add routes....
    Route::group(['prefix'=>'/document'], function(){
        Route::get('/list', 'AddDocumentController@list');
        Route::get('/get-all', 'AddDocumentController@getAll');
        Route::post('/store', 'AddDocumentController@store');
        Route::put('/update/{id}', 'AddDocumentController@update');
        Route::get('/show/{id}', 'AddDocumentController@show');
        Route::delete('/toggle-status/{id}', 'AddDocumentController@toggleStatus');
        Route::delete('/archive/{id}', 'AddDocumentController@archive');
        Route::delete('/destroy/{id}', 'AddDocumentController@destroy');
    });

    // document-indexing routes....
    Route::group(['prefix'=>'/document-indexing'], function(){
        Route::get('/list', 'DocumentIndexingController@list');
    });

    // document-archive routes....
    Route::group(['prefix'=>'/document-archive'], function(){
        Route::get('/list', 'DocumentArchiveController@list');
    });
    
});
