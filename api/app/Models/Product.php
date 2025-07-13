<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    //
    use HasFactory;
    protected $fillable = [
        'name',
        'description',
        'price',
        'quantity',
        'photo',
        'category_id',
    ];
    protected $table = 'products';
    public function category()
    {
        return $this->belongsTo(Category::class);
    }
    public function brand()
    {
        return $this->belongsTo(Brand::class);
    }
    public function photos()
    {
        return $this->hasMany(ProductPhoto::class);
    }
    public function variants()
    {   
        return $this->hasMany(ProductVarient::class);
    }
    public function orderItems()
    {
        return $this->hasMany(OrderItem::class);
    }
    public function favorites()
    {
        return $this->hasMany(Favorite::class);
    }
    public function cartItems()
    {
        return $this->hasMany(CartItem::class);
    }
    
}
