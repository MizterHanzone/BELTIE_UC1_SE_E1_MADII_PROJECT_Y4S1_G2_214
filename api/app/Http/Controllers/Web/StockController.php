<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Product;

class StockController extends Controller
{
    /**
     * Show the stock update form
     */
    public function showQuantityForm()
    {
        $products = Product::all();
        return view('admin.stocks.update_stock', compact('products'));
    }

    public function showSubtractForm()
    {
        $products = Product::all();
        return view('admin.stocks.subtract_stock', compact('products'));
    }

    /**
     * Add quantity to the existing product stock
     */
    public function updateQuantity(Request $request)
    {
        $request->validate([
            'product_id' => 'required|exists:products,id',
            'add_quantity' => 'required|integer|min:1',
        ]);

        $product = Product::findOrFail($request->product_id);
        $product->quantity += $request->add_quantity; // Add quantity
        $product->save();

        return redirect()->route('products.index')
            ->with('status', 'Stock quantity updated successfully!');
    }

    public function decreaseQuantity(Request $request)
    {
        $request->validate([
            'product_id' => 'required|exists:products,id',
            'decrease_quantity' => 'required|integer|min:1',
        ]);

        $product = Product::findOrFail($request->product_id);

        // Prevent decreasing below zero
        if ($product->quantity < $request->decrease_quantity) {
            return redirect()->back()->withErrors([
                'decrease_quantity' => 'Cannot decrease more than current stock (Qty: ' . $product->quantity . ').',
            ]);
        }

        $product->quantity -= $request->decrease_quantity;
        $product->save();

        return redirect()->route('products.index')
            ->with('status', 'Stock quantity decreased successfully!');
    }
}
