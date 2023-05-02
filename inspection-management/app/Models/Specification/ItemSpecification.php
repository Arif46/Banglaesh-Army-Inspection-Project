<?php

namespace App\Models\Specification;

use Illuminate\Database\Eloquent\Model;

class ItemSpecification extends Model
{
    /**
     * The table associated with the model.
     *
     * @var string
     */

    protected $table = 'item_specifications';

    protected $guarded = ['id', 'created_at', 'updated_at'];

    public function childs()
    {
        return $this->hasMany(ItemSpecification::class, 'parent_id');
    }
}
