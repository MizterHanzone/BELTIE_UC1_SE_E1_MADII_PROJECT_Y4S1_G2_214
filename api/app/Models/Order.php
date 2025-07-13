<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    //
    use HasFactory;
    protected $fillable = [
        'user_id',
        'cart_id',
        'address_id',
        'payment_method_id',
        'order_number',
        'delivery_fee',
        'total_amount',
        'status'
    ];
    protected $casts = [
        'delivery_fee' => 'decimal:2',
        'total_amount' => 'decimal:2',
    ]; 
    public function user()
    {
        return $this->belongsTo(User::class);
    }
    public function cart()
    {
        return $this->belongsTo(Cart::class);
    }
    public function address()
    {
        return $this->belongsTo(Address::class);
    }
    public function paymentMethod()
    {
        return $this->belongsTo(PaymentMethod::class);
    }
    public function orderItems()
    {
        return $this->hasMany(OrderItem::class);
    }
}
