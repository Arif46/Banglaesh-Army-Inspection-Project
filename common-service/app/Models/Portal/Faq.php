<?php

namespace App\Models\Portal;

use Illuminate\Database\Eloquent\Model;

class Faq extends Model
{
    protected $table = "portal_faqs";

    protected $fillable = [
        'title', 'title_bn', 'description','description_bn','user_id','created_by', 'updated_by', 'status'
    ];
}
