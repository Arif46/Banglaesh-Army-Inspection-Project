<?php

namespace App\Traits;

trait ModelSetup {

    /**
     * Boot the trait
     *
     * @return void
     */
    protected static function bootModelSetup()
    {
        // static::creating(function ($model) {
        //     $model->created_by = (int)user_id();
        //     $model->updated_by = (int)user_id();
        // });

        static::updating(function ($model) {
            $model->updated_by = (int)user_id();
        });
    }
}
