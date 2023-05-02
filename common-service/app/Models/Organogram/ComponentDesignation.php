<?php

namespace App\Models\Organogram;

use Illuminate\Database\Eloquent\Model;

class ComponentDesignation extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table = "component_designations";

    protected $guarded = ['id', 'created_at', 'updated_at'];

    public function designation () {
        return $this->belongsTo(MasterDesignation::class, 'designation_id');
    }
}
