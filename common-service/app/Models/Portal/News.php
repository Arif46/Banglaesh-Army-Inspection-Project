<?php

namespace App\Models\Portal;

use Illuminate\Database\Eloquent\Model;

class News extends Model
{
    protected $table = "portal_news";

    protected $fillable = [
        'title', 'title_bn', 'description','description_bn','logo','user_id','created_by', 'updated_by', 'status'
    ];
}
