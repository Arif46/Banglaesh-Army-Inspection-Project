<?php

namespace App\Models\DocumentManagement;

use Illuminate\Database\Eloquent\Model;

class AddDocument extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table = 'doc_doc_infos';
    protected $guarded = ['id', 'created_at', 'updated_at'];
}
