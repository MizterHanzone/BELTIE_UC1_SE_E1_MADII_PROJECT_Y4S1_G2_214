<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class District extends Model
{
    //
    use HasFactory;
    protected $fillable = [
        'name',
        'code',
        'province_id',
    ];
    protected $hidden = [
        'created_at',
        'updated_at',
    ];
    public function province()
    {
        return $this->belongsTo(Province::class);
    }
    public function communes()
    {
        return $this->hasMany(Commune::class);
    }
    public function addresses()
    {
        return $this->hasMany(Address::class);
    }
}
