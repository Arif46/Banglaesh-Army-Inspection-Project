<?php


use Illuminate\Support\Facades\Route;

Route::group(['prefix'=>'/user-management', 'namespace' => 'UserManagement'], function() {

    Route::group(['prefix'=>'/role'], function() {
        Route::get('/get-allready-assign-menus', 'MasterRoleController@assignMenus');
        Route::get('/role-list-select/{org_id}', 'MasterRoleController@roleList');
        Route::get('/desig-wise-role', 'MasterRoleController@desigWiseRole');
        Route::get('/desig-role-wise-user', 'MasterRoleController@desigRoleWiseUser');
        Route::post('/assign-designation-wise-role/{role_id}', 'MasterRoleController@assignDesignationWiseRole');
        Route::post('/menu-wise-role-store/{role_id}/{component_id}/{module_id}', 'MasterRoleController@storeMenu');
        Route::get('/role-wise-menu-list', 'MasterRoleController@roleWiseMenuList');
         // The following route is created for replacement of the above route if the above route is only for the following purpose it should be deleted.
        Route::get('/role-menus/{roleId}', 'MasterRoleController@menusByRole');

        Route::get('/list', 'MasterRoleController@list');
        Route::get('/get-all', 'MasterRoleController@getAll');
        Route::post('/store', 'MasterRoleController@store');
        Route::put('/update/{id}', 'MasterRoleController@update');
        Route::get('/show/{id}', 'MasterRoleController@show');
        Route::delete('/toggle-status/{id}', 'MasterRoleController@toggleStatus');
        Route::delete('/destroy/{id}', 'MasterRoleController@destroy');
        Route::get('/user-role-data', 'MasterRoleController@roleUser');
        Route::post('/assign-role', 'MasterRoleController@assignRole');
        Route::get('/role-user-list', 'MasterRoleController@roleUserList');
    });

    Route::group(['prefix'=>'/user'], function() {
        Route::get('/list', 'UserController@list');
        Route::get('/get-all', 'UserController@getUserList');
        Route::post('/store', 'UserController@store');
        Route::put('/update/{id}', 'UserController@update');
        Route::get('/show/{id}', 'UserController@show');
        Route::get('/get-user-details/{id}', 'UserController@userDetails');
        Route::delete('/toggle-status/{id}', 'UserController@toggleStatus');
        Route::delete('/destroy/{id}', 'UserController@destroy');
        Route::get('/list-by-designation', 'UserController@listByDesignation');
        Route::get('/all-user-by-org', 'UserController@allUserByOrg');
        Route::post('/user-info-list', 'UserController@getUserInfoList');
    });

    Route::group(['prefix'=>'/secret-question'], function() {
        Route::get('/list', 'SecretQuestionController@list');
        Route::get('/get-all', 'SecretQuestionController@getAll');
        Route::post('/store', 'SecretQuestionController@store');
        Route::put('/update/{id}', 'SecretQuestionController@update');
        Route::get('/show/{id}', 'SecretQuestionController@show');
        Route::delete('/toggle-status/{id}', 'SecretQuestionController@toggleStatus');
        Route::delete('/destroy/{id}', 'SecretQuestionController@destroy');
    });

    Route::group(['prefix'=>'/external-user'], function() {
        Route::post('/store','ExternalUserController@store');
        Route::post('/set-last-panel', 'ExternalUserController@setLastPanel');
        Route::post('/external-user-create-update', 'ExternalUserController@externalUserCreateOrUpdate');
        Route::delete('/external-user-delete/{id}', 'ExternalUserController@userDelete');
    });
});
