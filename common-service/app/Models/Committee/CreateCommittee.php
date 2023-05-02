<?php

namespace App\Models\Committee;

use Illuminate\Database\Eloquent\Model;
use App\Models\Committee\CreateCommitteeMember;

class CreateCommittee extends Model
{
    /**
     * The attributes that aren't mass assignable.
     *
     * @var array
    */
    protected $table = 'cmt_committees';

    protected $guarded = ['id', 'created_at', 'updated_at'];

    public function committee()
    {
     return $this->hasMany(CreateCommitteeMember::class,'cmt_committee_id', 'id');
    }

}
