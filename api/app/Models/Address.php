<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Address extends Model
{
    //
    use HasFactory;
    protected $fillable = [
        'user_id',
        'province_id',
        'district_id',
        'commune_id',
        'street',
        'description',
    ];
    protected $hidden = [
        'created_at',
        'updated_at',
    ];
    public function user()
    {
        return $this->belongsTo(User::class);
    }
    public function province()
    {
        return $this->belongsTo(Province::class);
    }
    public function district()
    {       
         return $this->belongsTo(District::class);
    }
    public function commune()
    {
       return $this->belongsTo(Commune::class);
    }
    public function orders()
    {
        return $this->hasMany(Order::class);
    }

}
