<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Order;
use Illuminate\Http\Request;

class OrderController extends Controller
{
    //
    public function index()
    {
        $delivered_confirmed = Order::with([
            'user',
            'payment.paymentMethod',
            'cart.cartItems.product',
            'address',
            'orderItems',
        ])
            ->where('status', 'confirmed')
            ->latest()
            ->paginate(10);
        return view('admin.orders.orders', compact('delivered_confirmed'));
    }

    public function edit(Order $order)
    {
        return view('admin.orders.edit_orders', compact('order'));
    }

    public function update(Request $request, Order $order)
    {
        $request->validate([
            'status' => 'required|in:confirmed,preparing,delivering,delivered,cancelled',
        ]);

        $order->status = $request->status;
        $order->save();

        return redirect()->route('orders.index')->with('status', 'Order status updated successfully.');
    }

    public function show(Order $order)
    {
        $order->load([
            'user',
            'payment.paymentMethod',
            'cart.cartItems.product',
            'address',
        ]);

        return view('admin.orders.order_details', compact('order'));
    }

    public function getAllOrdersPreparing()
    {
        $order_preparings = Order::with([
            'user',
            'payment.paymentMethod',
            'cart.cartItems.product',
            'address'
        ])
            ->where('status', 'preparing')
            ->latest()
            ->paginate(10);

        return view('admin.orders.order_preparings', compact('order_preparings'));
    }

    public function getAllOrdersDelivering()
    {
        $order_deliverings = Order::with([
            'user',
            'payment.paymentMethod',
            'cart.cartItems.product',
            'address'
        ])
            ->where('status', 'delivering')
            ->latest()
            ->paginate(10);

        return view('admin.orders.order_deliverings', compact('order_deliverings'));
    }

    public function getAllOrdersDelivered()
    {
        $delivered_orders = Order::with([
            'user',
            'payment.paymentMethod',
            'cart.cartItems.product',
            'address'
        ])
            ->where('status', 'delivered')
            ->latest()
            ->paginate(10);

        return view('admin.orders.delivered_orders', compact('delivered_orders'));
    }

    public function getAllOrdersCancelled()
    {
        $order_cancelled = Order::with([
            'user',
            'payment.paymentMethod',
            'cart.cartItems.product',
            'address'
        ])
            ->where('status', 'cancelled')
            ->latest()
            ->paginate(10);

        return view('admin.orders.order_cancelled', compact('order_cancelled'));
    }
}
