<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Village extends Model
{
    //
    use HasFactory;
    protected $fillable = [
        'name',
        'code',
        'commune_id',
    ];
    protected $hidden = [
        'created_at',
        'updated_at',
    ];
    public function commune()
    {
        return $this->belongsTo(Commune::class);
    }
}
