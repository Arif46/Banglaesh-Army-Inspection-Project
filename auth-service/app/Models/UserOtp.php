<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserOtp extends Model
{
    protected $table = "user_otps";

    protected $fillable = [
        'user_id', 'mobile_no', 'otp', 'is_active', 'expiry_date'
    ];
}
