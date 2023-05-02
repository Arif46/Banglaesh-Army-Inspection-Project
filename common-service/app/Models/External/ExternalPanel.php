<?php

namespace App\Models\External;

use Illuminate\Database\Eloquent\Model;

class ExternalPanel extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
    */
    protected $table = 'external_panels';
    protected $guarded = ['id', 'created_at', 'updated_at'];

    public function menus() 
    {
        return $this->hasMany(ExternalMenu::class, 'external_panel_id', 'id');
    }
}
