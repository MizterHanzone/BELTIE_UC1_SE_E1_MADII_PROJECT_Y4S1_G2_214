<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;

class OrderController extends Controller
{
    // Get all orders for authenticated user
    public function index()
    {
        $orders = Order::with(['address', 'paymentMethod', 'items.product'])
            ->where('user_id', Auth::id())
            ->get();

        return response()->json([
            'success' => true,
            'message' => 'Orders retrieved successfully.',
            'data' => $orders,
        ]);
    }

    // Store a new order
    public function store(Request $request)
    {
        $request->validate([
            'cart_id' => 'required|exists:carts,id',
            'address_id' => 'required|exists:addresses,id',
            'payment_method_id' => 'required|exists:payment_methods,id',
            'delivery_fee' => 'nullable|numeric',
            'total_amount' => 'required|numeric',
            'items' => 'required|array',
            'items.*.product_id' => 'required|exists:products,id',
            'items.*.quantity' => 'required|integer|min:1',
        ]);

        try {
            DB::beginTransaction();

            $order = Order::create([
                'user_id' => Auth::id(),
                'cart_id' => $request->cart_id,
                'address_id' => $request->address_id,
                'payment_method_id' => $request->payment_method_id,
                'order_number' => strtoupper(Str::random(10)),
                'delivery_fee' => $request->delivery_fee ?? 0,
                'total_amount' => $request->total_amount,
                'status' => 'pending',
            ]);

            foreach ($request->items as $item) {
                $product = Product::findOrFail($item['product_id']);

                OrderItem::create([
                    'user_id' => Auth::id(),
                    'order_id' => $order->id,
                    'product_id' => $product->id,
                    'product_variant_id' => $item['product_variant_id'] ?? null,
                    'quantity' => $item['quantity'],
                    'price' => $product->price,
                ]);
            }

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Order created successfully.',
                'data' => $order,
            ], 201);

        } catch (\Exception $e) {
            DB::rollBack();

            return response()->json([
                'success' => false,
                'message' => 'Failed to create order.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    // Show single order
    public function show($id)
    {
        $order = Order::with(['address', 'paymentMethod', 'items.product'])
            ->where('user_id', Auth::id())
            ->findOrFail($id);

        return response()->json([
            'success' => true,
            'message' => 'Order retrieved successfully.',
            'data' => $order,
        ]);
    }

    // Update order status (optional)
    public function update(Request $request, $id)
    {
        $request->validate([
            'status' => 'required|string',
        ]);

        $order = Order::where('user_id', Auth::id())->findOrFail($id);
        $order->status = $request->status;
        $order->save();

        return response()->json([
            'success' => true,
            'message' => 'Order updated successfully.',
            'data' => $order,
        ]);
    }

    // Delete an order (optional)
    public function destroy($id)
    {
        $order = Order::where('user_id', Auth::id())->findOrFail($id);
        $order->delete();

        return response()->json([
            'success' => true,
            'message' => 'Order deleted successfully.',
        ]);
    }
}
