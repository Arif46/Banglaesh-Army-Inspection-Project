<?php
use Illuminate\Support\Facades\Route;

Route::group(['prefix'=>'/committee-management', 'namespace' => 'Committee'], function() {

    // create-committee routes....
    Route::group(['prefix'=>'/create-committee'], function(){
        Route::get('/list', 'CreateCommitteeController@list');
        Route::get('/get-all', 'CreateCommitteeController@getAll');
        Route::post('/store', 'CreateCommitteeController@store');
        Route::put('/update/{id}', 'CreateCommitteeController@update');
        Route::get('/show/{id}', 'CreateCommitteeController@show');
        Route::delete('/toggle-status/{id}', 'CreateCommitteeController@toggleStatus');
        Route::delete('/destroy/{id}', 'CreateCommitteeController@destroy');
    });

    //  Committee  Agenda routes
     Route::group(['prefix'=>'/committee-agenda'], function(){
        Route::get('/list', 'CommitteeAgendaController@list');
        Route::get('/all-list', 'CommitteeAgendaController@getAll');
        Route::post('/store', 'CommitteeAgendaController@store');
        Route::put('/update/{id}', 'CommitteeAgendaController@update');
        Route::delete('/toggle-status/{id}', 'CommitteeAgendaController@toggleStatus');
        Route::delete('/destroy/{id}', 'CommitteeAgendaController@destroy');
    });

    //  Committee  Metting minute routes
    Route::group(['prefix'=>'/generate-circulate'], function(){
        Route::get('/list', 'GenerateCirculateController@list');
        Route::post('/store', 'GenerateCirculateController@store');
        Route::put('/update/{id}', 'GenerateCirculateController@update');
        Route::delete('/toggle-status/{id}', 'GenerateCirculateController@toggleStatus');
        Route::delete('/destroy/{id}', 'GenerateCirculateController@destroy');
    });

     //  Committee  Expenses  routes
     Route::group(['prefix'=>'/committee-expenses'], function(){
        Route::get('/list', 'CommitteeExpensesController@list');
        Route::post('/store', 'CommitteeExpensesController@store');
        Route::put('/update/{id}', 'CommitteeExpensesController@update');
        Route::delete('/toggle-status/{id}', 'CommitteeExpensesController@toggleStatus');
        Route::delete('/destroy/{id}', 'CommitteeExpensesController@destroy');
    });


});
