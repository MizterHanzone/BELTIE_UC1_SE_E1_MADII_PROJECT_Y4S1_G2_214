<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OrderItem extends Model
{
    //
    use HasFactory;
    protected $fillable = [
        'user_id',
        'order_id',
        'product_id',
        'product_variant_id',
        'quantity',
        'price'
    ];
    protected $casts = [
        'price' => 'decimal:2',
    ];
    public function user()
    {
        return $this->belongsTo(User::class);
    }
    public function order()
    {
        return $this->belongsTo(Order::class);
    }
    public function product()
    {
        return $this->belongsTo(Product::class);
    }
    public function productVariant()
    {
        return $this->belongsTo(ProductVarient::class);
    }
}
