<?php
use Illuminate\Support\Facades\Route;

Route::group(['prefix'=>'/complain-management', 'namespace' => 'ComplainManagement'], function() {
    // complain-type routes....
    Route::group(['prefix'=>'/complain-type'], function(){
        Route::get('/list', 'ComplainTypeController@list');
        Route::get('/get-all', 'ComplainTypeController@getAll');
        Route::post('/store', 'ComplainTypeController@store');
        Route::put('/update/{id}', 'ComplainTypeController@update');
        Route::get('/show/{id}', 'ComplainTypeController@show');
        Route::delete('/toggle-status/{id}', 'ComplainTypeController@toggleStatus');
        Route::delete('/destroy/{id}', 'ComplainTypeController@destroy');
    });

        // complain-designation routes....
    Route::group(['prefix'=>'/complain-designation'], function(){
        Route::get('/list', 'ComplainDesignationController@list');
        Route::get('/get-all', 'ComplainDesignationController@getAll');
        Route::post('/store', 'ComplainDesignationController@store');
        Route::put('/update/{id}', 'ComplainDesignationController@update');
        Route::get('/show/{id}', 'ComplainDesignationController@show');
        Route::delete('/toggle-status/{id}', 'ComplainDesignationController@toggleStatus');
        Route::delete('/destroy/{id}', 'ComplainDesignationController@destroy');
    });

    // Complain-submit routes....
    Route::group(['prefix'=>'/complain-submit'], function(){
        Route::get('/list', 'ComplainSubmitController@index');
        Route::get('/get-all', 'ComplainSubmitController@getAll');
        Route::post('/store', 'ComplainSubmitController@store');
        Route::put('/update/{id}', 'ComplainSubmitController@update');
        Route::get('/show/{id}', 'ComplainSubmitController@show');
        Route::delete('/toggle-status/{id}', 'ComplainSubmitController@toggleStatus');
        Route::delete('/destroy/{id}', 'ComplainSubmitController@destroy');
    });

    // Complain-submit routes....
    Route::group(['prefix'=>'/complain-chain'], function(){
        Route::get('/list', 'ComplainChainController@list');
        Route::get('/get-all', 'ComplainChainController@getAll');
        Route::post('/store', 'ComplainChainController@store');
        Route::put('/update/{id}', 'ComplainChainController@update');
        Route::get('/show/{id}', 'ComplainChainController@show');
        Route::delete('/toggle-status/{id}', 'ComplainChainController@toggleStatus');
        Route::delete('/destroy/{id}', 'ComplainChainController@destroy');
    });

     // Complain manage operation routes
     Route::group(['prefix'=>'/complain-manage'], function(){
        Route::get('/complain-request', 'ComplainManageController@complainRequest');
        Route::post('/assign-committee', 'ComplainManageController@assignCommittee');
        Route::get('/get-committee/{complain_id}', 'ComplainManageController@getCommittee');
        Route::post('/report-submit', 'ComplainManageController@reportSubmit');
        Route::get('/get-committee-report/{complain_id}', 'ComplainManageController@getCommitteeReport');
        Route::post('/complain-approve/{id}', 'ComplainManageController@complainApprove');
        Route::post('/complain-reject/{id}', 'ComplainManageController@complainReject');
    });

       // Complain Send Crud operation routes
       Route::group(['prefix'=>'/complain-send'], function(){
        Route::get('/list', 'ComplainSendController@index');
        Route::get('/detailList/{complain_id}', 'ComplainSendController@detailList');
        Route::post('/store', 'ComplainSendController@store');
        Route::put('/update/{id}', 'ComplainSendController@update');
        Route::delete('/toggle-status/{id}', 'ComplainSendController@toggleStatus');
        Route::delete('/destroy/{id}', 'ComplainSendController@destroy');
    });

      // Master Complain Info Crud operation routes
      Route::group(['prefix'=>'/complain-info'], function(){
        Route::get('/list', 'ComplainInfoController@index');
        Route::post('/store', 'ComplainInfoController@store');
        Route::put('/update/{id}', 'ComplainInfoController@update');
        Route::delete('/toggle-status/{id}', 'ComplainInfoController@toggleStatus');
        Route::delete('/solve-status/{id}', 'ComplainInfoController@solveStatus');
    });
    
});
