<?php

namespace App\Models\DocumentManagement;

use Illuminate\Database\Eloquent\Model;

class DocumentCategory extends Model
{
     /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $table = 'master_document_categories';
    protected $guarded = ['id', 'created_at', 'updated_at'];
}
