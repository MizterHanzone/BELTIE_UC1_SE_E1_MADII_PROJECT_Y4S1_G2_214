<?php

namespace App\Http\Controllers;

use App\Models\ProductVarient;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ProductVarientController extends Controller
{
    // Get all variants
    public function index()
    {
        try {
            $variants = ProductVarient::with('product:id,name') 
                ->latest()
                ->get(['id', 'product_id', 'size', 'color']);
                
            $formatted = $variants->map(function ($variant) {
                return [
                    'size' => $variant->size,
                    'color' => $variant->color,
                    'product_name' => $variant->product ? $variant->product->name : null,
                ];
            });

            return response()->json([
                'success' => true,
                'message' => 'Product variants retrieved successfully.',
                'data' => $formatted,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch product variants.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    // Store a new variant
    public function store(Request $request)
    {
        $request->validate([
            'product_id' => 'required|exists:products,id',
            'size' => 'required|string|max:100',
            'color' => 'required|string|max:100',
        ]);

        try {
            DB::beginTransaction();

            $variant = new ProductVarient();
            $variant->product_id = $request->product_id;
            $variant->size = $request->size;
            $variant->color = $request->color;
            $variant->save();

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Product variant created successfully.',
                'data' => $variant,
            ], 201);
        } catch (\Exception $e) {
            DB::rollBack();

            return response()->json([
                'success' => false,
                'message' => 'Failed to create product variant.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    // Update a variant
    public function update(Request $request, $id)
    {
        $request->validate([
            'product_id' => 'required|exists:products,id',
            'size' => 'required|string|max:100',
            'color' => 'required|string|max:100',
        ]);

        try {
            $variant = ProductVarient::findOrFail($id);

            DB::beginTransaction();

            $variant->product_id = $request->product_id;
            $variant->size = $request->size;
            $variant->color = $request->color;
            $variant->save();

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Product variant updated successfully.',
                'data' => $variant,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();

            return response()->json([
                'success' => false,
                'message' => 'Failed to update product variant.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    // Delete a variant
    public function destroy($id)
    {
        try {
            $variant = ProductVarient::findOrFail($id);
            $variant->delete();

            return response()->json([
                'success' => true,
                'message' => 'Product variant deleted successfully.',
                'data' => $variant,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete product variant.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
}
