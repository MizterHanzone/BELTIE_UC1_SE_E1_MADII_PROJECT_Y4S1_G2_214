<?php

namespace App\Http\Controllers;

use App\Models\PaymentMethod;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class PaymentMethodController extends Controller
{
    // Fetch all payment methods
    public function index()
    {
        try {
            $paymentMethods = PaymentMethod::all();
            return response()->json([
                'success' => true,
                'message' => 'Payment methods retrieved successfully.',
                'data' => $paymentMethods,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve payment methods.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'image' => 'required|image|mimes:jpg,jpeg,png,gif|max:2048',  // Validates the image file
        ]);

        try {
            $imagePath = $request->file('image')->store('payment_methods', 'public');  // Store image

            $paymentMethod = PaymentMethod::create([
                'name' => $request->name,
                'image' => $imagePath,
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Payment method created successfully.',
                'data' => $paymentMethod,
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to create payment method.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }


    // Show a single payment method by ID
    public function show($id)
    {
        try {
            $paymentMethod = PaymentMethod::findOrFail($id);
            return response()->json([
                'success' => true,
                'message' => 'Payment method retrieved successfully.',
                'data' => $paymentMethod,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Payment method not found.',
                'error' => $e->getMessage(),
            ], 404);
        }
    }

    // Update a payment method
    public function update(Request $request, $id)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'image' => 'required|image|mimes:jpg,jpeg,png,gif|max:2048',  // Image is optional during update
        ]);

        try {
            $paymentMethod = PaymentMethod::findOrFail($id);

            // Check if a new image is provided and delete the old one
            if ($request->has('image') && $paymentMethod->image && Storage::disk('public')->exists($paymentMethod->image)) {
                // Delete the old photo from storage
                Storage::disk('public')->delete($paymentMethod->image);
            }

            // Update the fields
            $paymentMethod->name = $request->name;
            if ($request->has('image')) {
                $paymentMethod->image = $request->image;
            }
            $paymentMethod->save();

            return response()->json([
                'success' => true,
                'message' => 'Payment method updated successfully.',
                'data' => $paymentMethod,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to update payment method.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    // Delete a payment method
    public function destroy($id)
    {
        try {
            $paymentMethod = PaymentMethod::findOrFail($id);

            // Delete the photo if it exists
            if ($paymentMethod->image && Storage::disk('public')->exists($paymentMethod->image)) {
                Storage::disk('public')->delete($paymentMethod->image);
            }

            // Delete the payment method
            $paymentMethod->delete();

            return response()->json([
                'success' => true,
                'message' => 'Payment method deleted successfully.',
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete payment method.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
}
