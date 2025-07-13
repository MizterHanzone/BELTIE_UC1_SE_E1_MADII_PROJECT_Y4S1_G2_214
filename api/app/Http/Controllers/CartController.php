<?php

namespace App\Http\Controllers;

use App\Models\Cart;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CartController extends Controller
{
    //
    public function viewCart()
    {
        $user = Auth::user();
        //        $cartItems = Cart::where('user_id', $user->id)->with('items.product')->get();

        // get cart count and total
        $cart = Cart::where('user_id', $user->id)->where('status', 'active')->with('items.product')->first();
        if (!$cart) {
            return response()->json([
                'message' => 'No active cart found.',
            ], 200);
        }
        $cartItems = $cart ? $cart->items : [];
        $total = 0;
        $count = 0;
        foreach ($cartItems as $item) {
            $total += $item->price * $item->quantity;
            $count += $item->quantity;
            $item->product->image = $item->product->image ? $item->product->image : null;
        }

        return response()->json([
            'cart' => $cartItems,
            'total' => $total,
            'count' => $count
        ]);
    }
    // Add a product to the cart
    public function addToCart(Request $request)
    {
        $request->validate([
            'product_id' => 'required|exists:products,id',
            'quantity' => 'required|integer|min:1',
        ]);

        try {
            $user = Auth::user();
            $cart = Cart::firstOrCreate(['user_id' => $user->id, 'status' => 'active']);
            $cartItem = $cart->items()->where('product_id', $request->product_id)->first();

            if ($cartItem) {
                $cartItem->quantity = $request->quantity;
                $cartItem->save();
            } else {
                $cart->items()->create([
                    'product_id' => $request->product_id,
                    'quantity' => $request->quantity,
                    'price' => Product::find($request->product_id)->price,
                    'status' => 'active',
                ]);
            }

            return response()->json(['message' => 'Product added to cart successfully.']);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to add product to cart.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function removeCartItemByProductId($productId)
    {
        try {
            $user = Auth::user();

            // Get the active cart for the user
            $cart = Cart::where('user_id', $user->id)->where('status', 'active')->first();

            // If no active cart, return an error message
            if (!$cart) {
                return response()->json(['message' => 'No active cart found.'], 404);
            }

            // Find the cart item by product_id
            $cartItem = $cart->items()->where('product_id', $productId)->first();

            // If the cart item is not found, return an error message
            if (!$cartItem) {
                return response()->json(['message' => 'Product not found in cart.'], 404);
            }

            // Delete the cart item
            $cartItem->delete();

            // Return success message
            return response()->json(['message' => 'Product removed from cart successfully.']);
        } catch (\Exception $e) {
            // Handle any exceptions that occur and return an error message
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete product from cart.',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
