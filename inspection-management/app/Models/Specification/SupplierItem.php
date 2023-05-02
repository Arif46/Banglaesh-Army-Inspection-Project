<?php

namespace App\Models\Specification;

use Illuminate\Database\Eloquent\Model;
use App\Models\Specification\ItemSpecification;

class SupplierItem extends Model
{
    /**
     * The table associated with the model.
     *
     * @var string
    */
    protected $table = 'supplier_items';

    protected $guarded = ['id', 'created_at', 'updated_at'];

    public function supplierSpecifications ()
    {
        return $this->hasMany(SupplierItemSpecification::class, 'supplier_item_id');
    }

    // public function specifications ()
    // {
    //     return $this->hasMany(ItemSpecification::class, 'item_id');
    // }
    
    public function supplier_specification_details ()
    {
        return $this->hasMany(SupplierItemSpecification::class, 'supplier_item_id')->where('parent_id', null);
    }

    public function specification_details ()
    {
        return $this->hasMany(SupplierItemSpecification::class, 'supplier_item_id');
    }

    public function items_name()
    {
        return $this->belongsTo(Item::class, 'item_id');
    }
}
