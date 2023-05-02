<?php

namespace App\Providers;

use Illuminate\Support\Facades\{Auth,Cache,DB,Redis};
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
        $this->app->singleton('postList', function ($app) {
            return Cache::store('redis')->rememberForever('postData', function () {
                return DB::table('posts')
                    ->get();
            });
        });

        /*-----User Data-----*/
        $this->app->singleton('userList', function ($app) {
            return Cache::store('redis')->rememberForever('userData', function () {
                return DB::table('users')
                    ->get();
            });
        });

        /*-----Role Data-----*/
        $this->app->singleton('roleList', function ($app) {
            return Cache::store('redis')->rememberForever('role', function () {
                return DB::table('roles')
                ->select('id as value','role_name as text','role_name as text_en',
                'role_name_bn as text_bn','org_id','designation_id','status')
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
