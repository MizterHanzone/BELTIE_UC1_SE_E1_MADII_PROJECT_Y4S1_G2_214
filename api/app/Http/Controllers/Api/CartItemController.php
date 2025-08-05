<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Cart;
use App\Models\CartItem;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CartItemController extends Controller
{
    public function getCartItems($cartId)
    {
        try {
            $cart = Cart::with('cartItems.product')->findOrFail($cartId);

            if ($cart->user_id !== Auth::id()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Unauthorized access to cart.'
                ], 403);
            }

            $items = $cart->cartItems;

            $total = $items->sum(fn($item) => $item->price * $item->quantity);
            $count = $items->sum('quantity');

            return response()->json([
                'success' => true,
                'message' => 'Cart items retrieved successfully.',
                'data' => [
                    'items' => $items,
                    'total' => $total,
                    'count' => $count,
                ],
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve cart items.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function storeCartItem(Request $request)
    {
        $request->validate([
            'cart_id' => 'required|exists:carts,id',
            'product_id' => 'required|exists:products,id',
            'quantity' => 'required|integer|min:1',
        ]);

        try {
            $cart = Cart::findOrFail($request->cart_id);

            if ($cart->user_id !== Auth::id()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Unauthorized access to cart.'
                ], 403);
            }

            $product = Product::findOrFail($request->product_id);

            $cartItem = CartItem::where('cart_id', $request->cart_id)
                ->where('product_id', $request->product_id)
                ->first();

            if ($cartItem) {
                $newQuantity = $cartItem->quantity + $request->quantity;
                if ($product->stock < $newQuantity) {
                    return response()->json([
                        'success' => false,
                        'message' => 'Not enough stock available.'
                    ], 400);
                }

                $cartItem->quantity = $newQuantity;
                $cartItem->save();
            } else {
                if ($product->stock < $request->quantity) {
                    return response()->json([
                        'success' => false,
                        'message' => 'Insufficient stock.'
                    ], 400);
                }

                $cartItem = CartItem::create([
                    'cart_id' => $request->cart_id,
                    'product_id' => $request->product_id,
                    'quantity' => $request->quantity,
                    'price' => $product->price,
                ]);
            }

            return response()->json([
                'success' => true,
                'message' => 'Cart item added/updated successfully.',
                'data' => $cartItem->load('product'),
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to add/update item to cart.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function updateCartItem(Request $request, $id)
    {
        $request->validate([
            'quantity' => 'required|integer|min:1',
        ]);

        try {
            $item = CartItem::with('cart')->findOrFail($id);

            // if ($item->cart->user_id !== Auth::id()) {
            //     return response()->json([
            //         'success' => false,
            //         'message' => 'Unauthorized.'
            //     ], 403);
            // }

            // Only allow decreasing quantity
            if ($request->quantity >= $item->quantity) {
                return response()->json([
                    'success' => false,
                    'message' => 'Increasing quantity is not allowed from this action.'
                ], 400);
            }

            $item->quantity = $request->quantity;
            $item->save();

            return response()->json([
                'success' => true,
                'message' => 'Cart item updated successfully.',
                'data' => $item->load('product'),
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to update cart item.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function removeCartItem($id)
    {
        try {
            $item = CartItem::with('cart')->findOrFail($id);

            if ($item->cart->user_id !== Auth::id()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Unauthorized.'
                ], 403);
            }

            $item->delete();

            return response()->json([
                'success' => true,
                'message' => 'Cart item deleted successfully.',
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete cart item.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
}
