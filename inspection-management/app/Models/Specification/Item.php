<?php

namespace App\Models\Specification;

use Illuminate\Database\Eloquent\Model;
use App\Models\Specification\ItemSpecification;

class Item extends Model
{
    protected $table = 'items';

    protected $fillable = ['item_name', 'demand_no', 'date', 'quantity', 'created_by', 'updated_by'];

    public function specifications ()
    {
        return $this->hasMany(ItemSpecification::class, 'item_id');
    }

    public function specificationDetails ()
    {
        return $this->hasMany(ItemSpecification::class, 'item_id')->where('parent_id', null);
    }
}
