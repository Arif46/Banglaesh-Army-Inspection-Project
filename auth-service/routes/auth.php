<?php

use Illuminate\Support\Facades\Route;

// Route::group(['middleware'  =>  'auth:api'], function () {
    Route::group(['prefix'=>'/auth'], function() {
        Route::get('/user-roles/{userId}', 'AuthController@userRoles');
        Route::get('/role-update/{roleId}', 'AuthController@roleUpdate');
        Route::get('/components-by-role/{roleId}', 'AuthController@componentsByRole');
        Route::post('logout', "AuthController@logout");
        Route::post('change-password', "AuthController@changePassword");
    });
// });
