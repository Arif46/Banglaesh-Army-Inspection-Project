<?php

namespace App\Models;

use Illuminate\Auth\Authenticatable;
use Laravel\Lumen\Auth\Authorizable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Illuminate\Contracts\Auth\Access\Authorizable as AuthorizableContract;
use App\Models\UserDetail;

//this is new
use Tymon\JWTAuth\Contracts\JWTSubject;

class User extends Model implements AuthenticatableContract, AuthorizableContract, JWTSubject 
{
    use Authenticatable, Authorizable;

    protected $table = "users";

    protected $guarded = ['id', 'created_at', 'updated_at'];

    /**
     * Get the identifier that will be stored in the subject claim of the JWT.
     *
     * @return mixed
     */
    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    /**
     * Return a key value array, containing any custom claims to be added to the JWT.
     *
     * @return array
     */
    public function getJWTCustomClaims()
    {
        return [];
    }

    public function details()
    {
        return $this->hasOne(UserDetail::class, 'user_id');
    }

    public function role_user()
    {
        return $this->hasMany(\App\Models\UserManagement\RoleUser::class, 'user_id');
    }

    public function userDetail()
    {
        return $this->hasOne(\App\Models\UserDetail::class, 'user_id', 'id');
    }

    public function answer()
    {
        return $this->hasOne(\App\Models\UserManagement\SecretQuestionAnswer::class, 'user_id');
    }

    /**
     * Defining relationship with roles
     */
    public function roles()
    {
        return $this->belongsToMany(\App\Models\UserManagement\MasterRole::class, 'role_user', 'user_id', 'role_id');
    }
}