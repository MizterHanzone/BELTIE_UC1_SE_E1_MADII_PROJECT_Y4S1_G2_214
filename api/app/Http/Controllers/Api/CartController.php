<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Cart;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class CartController extends Controller
{
    /**
     * View active cart for authenticated user.
     */
    public function viewCart()
    {
        $user = Auth::user();

        $cart = Cart::where('user_id', $user->id)
            ->where('is_active', true)
            ->with('cartItems.product')
            ->first();

        if (!$cart) {
            return response()->json([
                'success' => true,
                'message' => 'No active cart found.',
                'data' => [
                    'cart' => [],
                    'total' => 0,
                    'count' => 0,
                ],
            ], 200);
        }

        $cartItems = $cart->cartItems;
        $total = 0;
        $count = 0;

        $items = $cartItems->map(function ($item) use (&$total, &$count) {
            $subtotal = $item->price * $item->quantity;
            $total += $subtotal;
            $count += $item->quantity;

            return [
                'id' => $item->id,
                'product_id' => $item->product_id,
                'name' => optional($item->product)->name,
                'photo' => optional($item->product)->photo,
                'quantity' => $item->quantity,
                'price' => $item->price,
                'current_price' => optional($item->product)->price, // helpful if price changed
                'subtotal' => $subtotal,
            ];
        });

        return response()->json([
            'success' => true,
            'message' => 'Cart retrieved successfully.',
            'data' => [
                'cart' => $items,
                'total' => $total,
                'count' => $count,
            ],
        ], 200);
    }

    /**
     * Add product to cart.
     */
    public function addToCart(Request $request)
    {
        $request->validate([
            'product_id' => 'required|exists:products,id',
            'quantity' => 'required|integer|min:1',
        ]);

        try {
            $user = Auth::user();
            $product = Product::findOrFail($request->product_id);

            // Check stock availability
            if ($product->quantity  < $request->quantity) {
                return response()->json([
                    'success' => false,
                    'message' => 'Insufficient stock available.',
                ], 400);
            }

            $cart = Cart::firstOrCreate([
                'user_id' => $user->id,
                'is_active' => true
            ]);

            $cartItem = $cart->cartItems()->where('product_id', $request->product_id)->first();

            if ($cartItem) {
                $newQuantity = $cartItem->quantity + $request->quantity;

                if ($product->quantity  < $newQuantity) {
                    return response()->json([
                        'success' => false,
                        'message' => 'Requested quantity exceeds available stock.',
                    ], 400);
                }

                $cartItem->quantity = $newQuantity;
                $cartItem->save();
            } else {
                $cart->cartItems()->create([
                    'product_id' => $request->product_id,
                    'quantity' => $request->quantity,
                    'price' => $product->price,
                ]);
            }

            // DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Product added to cart successfully.',
            ]);
        } catch (\Exception $e) {
            // DB::rollBack();
            return response()->json([
                'success' => false,
                'message' => 'Failed to add product to cart.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Remove item from cart by product ID.
     */
    public function removeCartItemByProductId($productId)
    {
        try {
            $user = Auth::user();

            $cart = Cart::where('user_id', $user->id)
                ->where('is_active', true)
                ->first();

            if (!$cart) {
                return response()->json([
                    'success' => false,
                    'message' => 'No active cart found.'
                ], 404);
            }

            $cartItem = $cart->cartItems()->where('product_id', $productId)->first();

            if (!$cartItem) {
                return response()->json([
                    'success' => false,
                    'message' => 'Product not found in cart.'
                ], 404);
            }

            $cartItem->delete();

            return response()->json([
                'success' => true,
                'message' => 'Product removed from cart successfully.'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete product from cart.',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
