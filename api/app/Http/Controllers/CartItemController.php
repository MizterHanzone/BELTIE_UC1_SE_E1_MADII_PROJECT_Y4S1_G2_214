<?php

namespace App\Http\Controllers;

use App\Models\Cart;
use App\Models\CartItem;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CartItemController extends Controller
{
    public function index($cartId)
    {
        try {
            $cart = Cart::with('items.product')->findOrFail($cartId);

            return response()->json([
                'success' => true,
                'message' => 'Cart items retrieved successfully.',
                'data' => $cart->items,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve cart items.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function store(Request $request)
    {
        $request->validate([
            'cart_id' => 'required|exists:carts,id',
            'product_id' => 'required|exists:products,id',
            'quantity' => 'required|integer|min:1',
        ]);

        try {
            $product = Product::find($request->product_id);
            $price = $product->price;

            // Find if this product already exists in the cart
            $cartItem = CartItem::where('cart_id', $request->cart_id)
                ->where('product_id', $request->product_id)
                ->first();

            if ($cartItem) {
                // If item exists, update the quantity
                $cartItem->quantity += $request->quantity;
                $cartItem->save();
            } else {
                // If item doesn't exist, create a new cart item
                CartItem::create([
                    'cart_id' => $request->cart_id,
                    'product_id' => $request->product_id,
                    'quantity' => $request->quantity,
                    'price' => $price,
                ]);
            }

            return response()->json([
                'success' => true,
                'message' => 'Cart item added/updated successfully.',
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to add/update item to cart.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'quantity' => 'required|integer|min:1',
        ]);

        try {
            // Find the cart item by cart_id and product_id
            $item = CartItem::where('cart_id', $request->cart_id)
                ->where('product_id', $request->product_id)
                ->first();

            // If no cart item is found, return an error
            if (!$item) {
                return response()->json([
                    'success' => false,
                    'message' => 'Cart item not found.',
                ], 404);
            }

            // Update the quantity
            $item->quantity = $request->quantity;
            $item->save();

            return response()->json([
                'success' => true,
                'message' => 'Cart item updated successfully.',
                'data' => $item,
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
            // Find the cart item by its ID
            $cartItem = CartItem::find($id);

            // If the cart item doesn't exist, return an error
            if (!$cartItem) {
                return response()->json([
                    'success' => false,
                    'message' => 'Cart item not found.',
                ], 404);
            }

            // Delete the cart item
            $cartItem->delete();

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
