<?php
use Illuminate\Support\Facades\Route;

Route::group(['prefix'=>'/portal', 'namespace' => 'Portal'], function() {
    //portal frontend routes
    Route::group(['prefix'=>'/frontend','namespace' => 'Frontend'], function(){
        Route::get('/header', 'FrontendController@header');
        Route::get('/footer', 'FrontendController@footer');
        Route::get('/service', 'FrontendController@service');
        Route::get('/service/show', 'ServiceController@show');
        Route::get('/service-searching', 'ServiceController@searching'); // frontend (portal search)
        Route::get('/customer-type-list', 'FrontendController@customerTypeList');
        Route::get('/service-list', 'FrontendController@serviceList');
        Route::get('/category-list', 'FrontendController@categoryList');
        Route::get('/org-list', 'FrontendController@orgList');
        Route::get('/qa-home', 'FAQController@faqListHome');
        Route::get('/news-home', 'NewsController@newsListHome');
        Route::get('/notice-home', 'NoticeController@noticeListHome');
        Route::get('/faq-list', 'FAQController@index');
        Route::get('/news-list', 'NewsController@index');
        Route::get('/notice-list', 'NoticeController@index');
        Route::get('/news/show', 'NewsController@show');
        Route::get('/news/popular', 'NewsController@popular');
        Route::get('/about-service-portal', 'FrontendController@aboutServicePortal');
    });

    // About Service Portal Routes
    Route::group(['prefix'=>'/about-service-portal'], function(){
        Route::get('/list', 'AboutServicePortalController@index');
        Route::post('/store', 'AboutServicePortalController@store');
        Route::put('/update/{id}', 'AboutServicePortalController@update');
        Route::delete('/toggle-status/{id}', 'AboutServicePortalController@toggleStatus');
    });

    /** Common Service Routes */
    // master service-category routes....
    Route::group(['prefix'=>'/service-category'], function(){
        Route::get('/list', 'ServiceCategoryController@list');
        Route::get('/get-all', 'ServiceCategoryController@getAll');
        Route::post('/store', 'ServiceCategoryController@store');
        Route::put('/update/{id}', 'ServiceCategoryController@update');
        Route::get('/show/{id}', 'ServiceCategoryController@show');
        Route::delete('/toggle-status/{id}', 'ServiceCategoryController@toggleStatus');
        Route::delete('/destroy/{id}', 'ServiceCategoryController@destroy');
    });   

    // master ministry-entry routes....
    Route::group(['prefix'=>'/ministry-entry'], function(){
        Route::get('/list', 'MinistryEntryController@list');
        Route::post('/store', 'MinistryEntryController@store');
        Route::put('/update/{id}', 'MinistryEntryController@update');
        Route::delete('/toggle-status/{id}', 'MinistryEntryController@toggleStatus');
    });

        // master service-customer-type routes....
        Route::group(['prefix'=>'/service-customer-type'], function(){
        Route::get('/list', 'ServiceCustomerTypeController@list');
        Route::post('/store', 'ServiceCustomerTypeController@store');
        Route::put('/update/{id}', 'ServiceCustomerTypeController@update');
        Route::delete('/toggle-status/{id}', 'ServiceCustomerTypeController@toggleStatus');
    });
    
    // master organization-entry routes....
    Route::group(['prefix'=>'/org-entry'], function(){
        Route::get('/list', 'OrganizationEntryController@list');
        Route::post('/store', 'OrganizationEntryController@store');
        Route::put('/update/{id}', 'OrganizationEntryController@update');
        Route::delete('/toggle-status/{id}', 'OrganizationEntryController@toggleStatus');
    });

        // master news routes....
        Route::group(['prefix'=>'/news'], function(){
        Route::get('/list', 'NewsController@list');
        Route::post('/store', 'NewsController@store');
        Route::put('/update/{id}', 'NewsController@update');
        Route::delete('/toggle-status/{id}', 'NewsController@toggleStatus');
    });

        // master faq routes....
        Route::group(['prefix'=>'/faq'], function(){
        Route::get('/list', 'PortalFaqController@list');
        Route::post('/store', 'PortalFaqController@store');
        Route::put('/update/{id}', 'PortalFaqController@update');
        Route::delete('/toggle-status/{id}', 'PortalFaqController@toggleStatus');
    });

    //portal service  crud operation routes
    Route::group(['prefix'=>'/services'], function(){
        Route::get('/list', 'ServiceController@index');
        Route::post('/store', 'ServiceController@store');
        Route::put('/update/{id}', 'ServiceController@update');
        Route::delete('/toggle-status/{id}', 'ServiceController@toggleStatus');
        Route::post('/update-feature', 'ServiceController@updateFeature');
    });


        // master notice routes....
        Route::group(['prefix'=>'/notice'], function(){
        Route::get('/list', 'PortalNoticeController@list');
        Route::post('/store', 'PortalNoticeController@store');
        Route::put('/update/{id}', 'PortalNoticeController@update');
        Route::delete('/toggle-status/{id}', 'PortalNoticeController@toggleStatus');
    });

      //portal Header  crud operation routes
    Route::group(['prefix'=>'/portal-header'], function(){
        Route::get('/list', 'PortalHeaderController@list');
        Route::post('/store', 'PortalHeaderController@store');
        Route::put('/update/{id}', 'PortalHeaderController@update');
        Route::delete('/toggle-status/{id}', 'PortalHeaderController@toggleStatus');
    });
});
