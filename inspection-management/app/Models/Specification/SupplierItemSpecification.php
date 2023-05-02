<?php

namespace App\Models\Specification;

use Illuminate\Database\Eloquent\Model;

class SupplierItemSpecification extends Model
{
    /**
     * The table associated with the model.
     *
     * @var string
    */

    protected $table = 'supplier_item_specifications';

    protected $guarded = ['id', 'created_at', 'updated_at'];
 
    public function childs()
    {
        return $this->hasMany(SupplierItemSpecification::class, 'parent_id');
    }

    public function specification_item()
    {
        return $this->belongsTo(ItemSpecification::class, 'specification_id');
    }
}
