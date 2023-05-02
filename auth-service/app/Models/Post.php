<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'user_id', 'title', 'content', 'status'
    ];

   /**
     * A post belongs to a user
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
   */
    public function user()
    {
        return $this->belongsTo('App\Models\User');
    }
    
    public function detail()
    {
        return $this->hasMany(Detail::class, 'post_id');
    }
}
