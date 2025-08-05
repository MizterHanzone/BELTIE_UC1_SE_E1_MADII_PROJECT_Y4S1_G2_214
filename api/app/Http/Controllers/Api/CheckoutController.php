<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Cart;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Payment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Stripe\Stripe;
use Stripe\Charge;
use App\Models\PaymentMethod;

class CheckoutController extends Controller
{

    public function checkout(Request $request)
    {
        $user = Auth::user();

        $request->validate([
            'cart_id' => 'required|exists:carts,id',
            'payment_method_id' => 'required|exists:payment_methods,id',
            'address_id' => 'required|exists:addresses,id',
            'stripe_token' => 'nullable|string', // Required for stripe payments
        ]);

        $cart = Cart::where('id', $request->cart_id)
            ->where('user_id', $user->id)
            ->where('is_active', true)
            ->with('cartItems.product')
            ->first();

        if (!$cart || $cart->cartItems->isEmpty()) {
            return response()->json(['message' => 'Cart is empty.'], 400);
        }

        DB::beginTransaction();

        try {
            foreach ($cart->cartItems as $item) {
                if ($item->product->quantity < $item->quantity) {
                    return response()->json([
                        'message' => "Insufficient stock for product: {$item->product->name}"
                    ], 400);
                }
            }

            $totalAmount = $cart->cartItems->sum(fn($item) => $item->price * $item->quantity);

            $paymentMethod = PaymentMethod::findOrFail($request->payment_method_id);

            // Handle Stripe payment
            if ($paymentMethod->code === 'stripe') {
                if (!$request->has('stripe_token')) {
                    return response()->json(['message' => 'Stripe token is required.'], 422);
                }

                Stripe::setApiKey(config('services.stripe.secret'));

                $charge = Charge::create([
                    'amount' => (int) ($totalAmount * 100), // amount in cents
                    'currency' => 'usd',
                    'description' => 'Order Payment',
                    'source' => $request->stripe_token,
                ]);

                if ($charge->status !== 'succeeded') {
                    // handle failed payment
                    return response()->json([
                        'success' => false,
                        'message' => 'Payment failed.',
                    ], 400);
                }
            }

            $payment = Payment::create([
                'payment_method_id' => $paymentMethod->id,
                'amount' => $totalAmount,
                'status' => 'completed',
            ]);

            $order = Order::create([
                'user_id' => $user->id,
                'cart_id' => $cart->id,
                'payment_id' => $payment->id,
                'address_id' => $request->address_id,
                'status' => 'confirmed',
                'total_amount' => $totalAmount,
            ]);

            foreach ($cart->cartItems as $item) {
                OrderItem::create([
                    'order_id' => $order->id,
                    'product_id' => $item->product_id,
                    'quantity' => $item->quantity,
                    'price' => $item->price,
                ]);

                $item->product->decrement('quantity', $item->quantity);
            }

            $cart->is_active = false;
            $cart->save();

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Order placed successfully.',
                'data' => ['order_id' => $order->id],
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'success' => false,
                'message' => 'Checkout failed.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function checkoutSuccess(Request $request)
    {
        $sessionId = $request->get('session_id');

        if (!$sessionId) {
            return redirect('/')->with('error', 'Missing session ID.');
        }

        Stripe::setApiKey(config('services.stripe.secret'));
        $session = \Stripe\Checkout\Session::retrieve($sessionId);

        $customerEmail = $session->customer_email ?? null;

        // You can now create the Order, Payment, etc.
        // You'd ideally store the session_id in DB and associate with the cart/order

        return redirect('/')->with('success', 'Payment successful!');
    }
}
