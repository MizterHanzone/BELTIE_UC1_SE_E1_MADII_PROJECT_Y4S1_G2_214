<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Commune extends Model
{
    //
    use HasFactory;
    protected $fillable = [
        'name',
        'code',
        'district_id',
    ];
    protected $hidden = [
        'created_at',
        'updated_at',
    ];
    public function district()
    {
        return $this->belongsTo(District::class);
    }
    public function villages()
    {
        return $this->hasMany(Village::class);
    }
    public function addresses()
    {
        return $this->hasMany(Address::class);
    }
}
