<?php

namespace App\Providers;
use Illuminate\Support\Facades\{Auth, Cache, DB, Redis};
use Illuminate\Support\ServiceProvider;

class DatabaseServiceProvider extends ServiceProvider
{

    protected $defer = true;
    /**
     * Register services.
     *
     * @return void
     */

    public function register()
    {
        /*-----Post Data-----*/
        $this->app->singleton('componentList', function ($app) {
            return Cache::store('redis')->rememberForever('components', function () {
                return DB::table('master_components')
                    ->select('id as value','component_name as text','component_name as text_en',
                        'component_name_bn as text_bn','sorting_order','status')
                    ->orderBy('component_name', 'asc')    
                    ->get();
            });
        });

        /*-----Country Info Data-----*/
        $this->app->singleton('tradeTariffCountryList', function ($app) {
            return Cache::store('redis')->rememberForever('countries', function () {
                return DB::table('master_country_infos')
                    ->select('id as value','country_name_en as text','country_name_en as text_en',
                        'country_name_bn as text_bn', 'status')
                    ->orderBy('country_name_en', 'asc')    
                    ->get();
            });
        });

         /*-----Application type Info Data-----*/
         $this->app->singleton('applicationTypeList', function ($app) {
            return Cache::store('redis')->rememberForever('applicationTypes', function () {
                return DB::table('master_application_types')
                    ->select('id as value','application_type_en as text','application_type_en as text_en',
                        'application_type_bn as text_bn', 'status')
                    ->orderBy('application_type_en', 'asc')    
                    ->get();
                });
            });
        /*-----Capital Info Data-----*/
        $this->app->singleton('capitalInfoList', function ($app) {
            return Cache::store('redis')->rememberForever('capitalInfos', function () {
                return DB::table('master_calpital_infos')
                    ->select('id as value','capital_name_en as text','capital_name_en as text_en',
                        'capital_name_bn as text_bn', 'country_name_id', 'status')
                    ->orderBy('capital_name_en', 'asc')    
                    ->get();
            });
        });
        /*-----Currency Data-----*/
        $this->app->singleton('currencyList', function ($app) {
            return Cache::store('redis')->rememberForever('currency', function () {
                return DB::table('master_currency')
                    ->select('id as value','currency_name_en as text','currency_name_en as text_en',
                        'currency_name_bn as text_bn', 'country_name_id', 'status')
                    ->orderBy('currency_name_en', 'asc')    
                    ->get();
            });
        });
        /*-----Product Data-----*/
        $this->app->singleton('productList', function ($app) {
            return Cache::store('redis')->rememberForever('products', function () {
                return DB::table('master_products')
                    ->select('id as value','product_name_en as text','product_name_en as text_en',
                        'product_name_bn as text_bn', 'product_type_id', 'status')
                    ->orderBy('product_name_en', 'asc')    
                    ->get();
            });
        });
        /*-----Unit Measurement Data-----*/
        $this->app->singleton('unitMeasurementList', function ($app) {
            return Cache::store('redis')->rememberForever('unitMeasurements', function () {
                return DB::table('master_unit_measurements')
                    ->select('id as value','unit_measurement_en as text','unit_measurement_en as text_en',
                        'unit_measurement_bn as text_bn', 'status')
                    ->orderBy('unit_measurement_en', 'asc')    
                    ->get();
            });
        });
        /*-----Master Section Data-----*/
        $this->app->singleton('sectionList', function ($app) {
            return Cache::store('redis')->rememberForever('sections', function () {
                return DB::table('master_sections')
                    ->select('id as value','section_number as text','section_number as text_en',
                        'section_number as text_bn', 'section_name_bn', 'section_name_en', 'status')
                    ->orderBy('section_number', 'asc')    
                    ->get();
            });
        });
        /*-----Master Chapter Data-----*/
        $this->app->singleton('chapterList', function ($app) {
            return Cache::store('redis')->rememberForever('chapters', function () {
                return DB::table('master_chapters')
                    ->select('id as value','chapter_number as text','chapter_number as text_en',
                        'chapter_number as text_bn', 'chapter_name_en', 'chapter_name_bn', 'section_id', 'status')
                    ->orderBy('chapter_number', 'asc')    
                    ->get();
            });
        });
        /*-----Master Heading Data-----*/
        $this->app->singleton('headingList', function ($app) {
            return Cache::store('redis')->rememberForever('headings', function () {
                return DB::table('master_headings')
                    ->select('id as value','heading_number as text','heading_number as text_en',
                        'heading_number as text_bn', 'heading_name_en', 'heading_name_bn', 'chapter_id', 'section_id', 'status')
                    ->orderBy('heading_number', 'asc')    
                    ->get();
            });
        });
        /*-----Master Sub Heading Data-----*/
        $this->app->singleton('subHeadingList', function ($app) {
            return Cache::store('redis')->rememberForever('subHeadings', function () {
                return DB::table('master_sub_headings')
                    ->select('id as value','sub_heading_number as text','sub_heading_number as text_en',
                        'sub_heading_number as text_bn', 'sub_heading_name_en', 'sub_heading_name_bn', 'chapter_id', 'section_id', 'heading_id', 'status')
                    ->orderBy('sub_heading_number', 'asc')    
                    ->get();
            });
        });
        /*-----Unit Subject Info Data-----*/
        $this->app->singleton('subjectList', function ($app) {
            return Cache::store('redis')->rememberForever('subjects', function () {
                return DB::table('master_subject_infos')
                    ->select('id as value','subject_title_en as text','subject_title_en as text_en',
                        'subject_title_bn as text_bn', 'status')
                    ->orderBy('subject_title_en', 'asc')    
                    ->get();
            });
        });
    }

    /**
     * Bootstrap services.
     *
     * @return void
     */
    public function boot()
    { }
}
