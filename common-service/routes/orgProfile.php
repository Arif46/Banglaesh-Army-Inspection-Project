<?php
use Illuminate\Support\Facades\Route;

Route::group(['prefix'=>'/org-profile', 'namespace' => 'OrgProfile'], function() {

    Route::post('/change-serial-order/{model}', 'MasterDivisionController@changeSerialOrder');

    // master division routes....
    Route::group(['prefix'=>'/master-division'], function(){
        Route::get('/list', 'MasterDivisionController@list');
        Route::get('/get-all', 'MasterDivisionController@getAll');
        Route::post('/store', 'MasterDivisionController@store');
        Route::put('/update/{id}', 'MasterDivisionController@update');
        Route::get('/show/{id}', 'MasterDivisionController@show');
        Route::delete('/toggle-status/{id}', 'MasterDivisionController@toggleStatus');
        Route::delete('/destroy/{id}', 'MasterDivisionController@destroy');
    });

    // master District Routes....
    Route::group(['prefix'=>'/master-district'], function(){
        Route::get('/list', 'MasterDistrictController@list');
        Route::get('/get-all', 'MasterDistrictController@getAll');
        Route::post('/store', 'MasterDistrictController@store');
        Route::put('/update/{id}', 'MasterDistrictController@update');
        Route::get('/show/{id}', 'MasterDistrictController@show');
        Route::delete('/toggle-status/{id}', 'MasterDistrictController@toggleStatus');
        Route::delete('/destroy/{id}', 'MasterDistrictController@destroy');
    });

        // master Union Routes....
        Route::group(['prefix'=>'/master-unions'], function(){
        Route::get('/list', 'MasterUnionController@list');
        Route::get('/get-all', 'MasterUnionController@getAll');
        Route::post('/store', 'MasterUnionController@store');
        Route::put('/update/{id}', 'MasterUnionController@update');
        Route::get('/show/{id}', 'MasterUnionController@show');
        Route::delete('/toggle-status/{id}', 'MasterUnionController@toggleStatus');
        Route::delete('/destroy/{id}', 'MasterUnionController@destroy');
    });

    // master country routes....
    Route::group(['prefix'=>'/master-country'], function(){
        Route::get('/list', 'MasterCountryController@list');
        Route::get('/get-all', 'MasterCountryController@getAll');
        Route::post('/store', 'MasterCountryController@store');
        Route::put('/update/{id}', 'MasterCountryController@update');
        Route::get('/show/{id}', 'MasterCountryController@show');
        Route::delete('/toggle-status/{id}', 'MasterCountryController@toggleStatus');
        Route::delete('/destroy/{id}', 'MasterCountryController@destroy');
    });

    // Org Profile routes....
    Route::group(['prefix'=>'/org-profile'], function(){
        Route::get('/list', 'MasterOrgProfileController@list');
        Route::get('/get-all', 'MasterOrgProfileController@getAll');
        Route::post('/store', 'MasterOrgProfileController@store');
        Route::put('/update/{id}', 'MasterOrgProfileController@update');
        Route::get('/show/{id}', 'MasterOrgProfileController@show');
        Route::delete('/toggle-status/{id}', 'MasterOrgProfileController@toggleStatus');
        Route::delete('/destroy/{id}', 'MasterOrgProfileController@destroy');
    });

    // master upazila routes....
    Route::group(['prefix'=>'/master-upazilas'], function(){
        Route::get('/list', 'MasterUpazilaController@index');
        Route::get('/list-all', 'MasterUpazilaController@getAll');
        Route::post('/store', 'MasterUpazilaController@store');
        Route::put('/update/{id}', 'MasterUpazilaController@update');
        Route::get('/show/{id}', 'MasterUpazilaController@show');
        Route::delete('/toggle-status/{id}', 'MasterUpazilaController@toggleStatus');
        Route::delete('/destroy/{id}', 'MasterUpazilaController@destroy');
    });

    // master Thana routes....
    Route::group(['prefix'=>'/master-thana'], function(){
        Route::get('/list', 'MasterThanaController@index');
        Route::get('/list-all', 'MasterThanaController@getAll');
        Route::post('/store', 'MasterThanaController@store');
        Route::put('/update/{id}', 'MasterThanaController@update');
        Route::get('/show/{id}', 'MasterThanaController@show');
        Route::delete('/toggle-status/{id}', 'MasterThanaController@toggleStatus');
        Route::delete('/destroy/{id}', 'MasterThanaController@destroy');
    });

    // master City Corporation  routes....
    Route::group(['prefix'=>'/master-city-corporation'], function(){
        Route::get('/list', 'MasterCityCorporationController@list');
        Route::get('/get-all', 'MasterCityCorporationController@getAll');
        Route::post('/store', 'MasterCityCorporationController@store');
        Route::put('/update/{id}', 'MasterCityCorporationController@update');
        Route::get('/show/{id}', 'MasterCityCorporationController@show');
        Route::delete('/toggle-status/{id}', 'MasterCityCorporationController@toggleStatus');
        Route::delete('/destroy/{id}', 'MasterCityCorporationController@destroy');
    });

    // master Municipality routes....
    Route::group(['prefix'=>'/master-municipality'], function(){
        Route::get('/list', 'MasterMunicipalityController@list');
        Route::get('/get-all', 'MasterMunicipalityController@getAll');
        Route::post('/store', 'MasterMunicipalityController@store');
        Route::put('/update/{id}', 'MasterMunicipalityController@update');
        Route::get('/show/{id}', 'MasterMunicipalityController@show');
        Route::delete('/toggle-status/{id}', 'MasterMunicipalityController@toggleStatus');
        Route::delete('/destroy/{id}', 'MasterMunicipalityController@destroy');
    });


    // master wards routes....
    Route::group(['prefix'=>'/master-wards'], function(){
        Route::get('/list', 'MasterWardController@index');
        Route::get('/list-all', 'MasterWardController@getAll');
        Route::post('/store', 'MasterWardController@store');
        Route::put('/update/{id}', 'MasterWardController@update');
        Route::get('/show/{id}', 'MasterWardController@show');
        Route::delete('/toggle-status/{id}', 'MasterWardController@toggleStatus');
        Route::delete('/destroy/{id}', 'MasterWardController@destroy');
    });

        // Master Dialogue Info Controller routes....
        Route::group(['prefix'=>'/master-dialogue-info'], function(){
        Route::get('/list', 'MasterDialogueInfoController@list');
        Route::get('/list-all', 'MasterDialogueInfoController@getAll');
        Route::post('/store', 'MasterDialogueInfoController@store');
        Route::put('/update/{id}', 'MasterDialogueInfoController@update');
        Route::get('/show/{id}', 'MasterDialogueInfoController@show');
        Route::delete('/toggle-status/{id}', 'MasterDialogueInfoController@toggleStatus');
        Route::delete('/destroy/{id}', 'MasterDialogueInfoController@destroy');
    });

    
    // Master fiscalyear controller.
    Route::group(['prefix'=>'/fiscalyear'], function(){
        Route::get('/list', 'MasterFiscalYearController@list');
        Route::post('/store', 'MasterFiscalYearController@store');
        Route::put('/update/{id}', 'MasterFiscalYearController@update');
        Route::delete('/toggle-status/{id}', 'MasterFiscalYearController@toggleStatus');
        Route::get('/current-fiscal-year', 'MasterFiscalYearController@getCurrentFiscalYear');
    });

    // master Bank routes....
    Route::group(['prefix'=>'/master-bank'], function(){
        Route::get('/list', 'MasterBankController@list');
        Route::get('/get-all', 'MasterBankController@getAll');
        Route::post('/store', 'MasterBankController@store');
        Route::put('/update/{id}', 'MasterBankController@update');
        Route::get('/show/{id}', 'MasterBankController@show');
        Route::delete('/toggle-status/{id}', 'MasterBankController@toggleStatus');
        Route::delete('/destroy/{id}', 'MasterBankController@destroy');
    });

    // master Branch routes....
    Route::group(['prefix'=>'/master-branch'], function(){
        Route::get('/list', 'MasterBranchController@list');
        Route::get('/get-all', 'MasterBranchController@getAll');
        Route::post('/store', 'MasterBranchController@store');
        Route::put('/update/{id}', 'MasterBranchController@update');
        Route::get('/show/{id}', 'MasterBranchController@show');
        Route::delete('/toggle-status/{id}', 'MasterBranchController@toggleStatus');
        Route::delete('/destroy/{id}', 'MasterBranchController@destroy');
    });
    
});
