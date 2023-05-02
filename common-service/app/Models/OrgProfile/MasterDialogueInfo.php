<?php

namespace App\Models\OrgProfile;

use Illuminate\Database\Eloquent\Model;

class MasterDialogueInfo extends Model
{
    protected $table = "master_dialogue_settings";

    protected $fillable = [
        'dialogue', 'dialogue_bn', 'position', 'status'
    ];
}
