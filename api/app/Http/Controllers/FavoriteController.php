<?php

namespace App\Http\Controllers;

use App\Models\Favorite;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class FavoriteController extends Controller
{
    public function index()
    {
        try {
            $favorites = Favorite::with('product')
                ->where('user_id', Auth::id())
                ->latest()
                ->get();

            $data = $favorites->map(function ($fav) {
                return [
                    'id' => $fav->id,
                    'product_id' => $fav->product->id,
                    'product_name' => $fav->product->name,
                    'photo' => $fav->product->photo ? asset('storage/' . $fav->product->photo) : null,
                    'price' => $fav->product->price,
                ];
            });

            return response()->json([
                'success' => true,
                'favorites' => $data,
            ]);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'error' => $e->getMessage()], 500);
        }
    }

    public function store(Request $request)
    {
        $request->validate([
            'product_id' => 'required|exists:products,id',
        ]);

        try {
            $favorite = Favorite::firstOrCreate([
                'user_id' => Auth::id(),
                'product_id' => $request->product_id,
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Product added to favorites.',
                'favorite' => $favorite,
            ], 201);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'error' => $e->getMessage()], 500);
        }
    }

    // Remove a product from favorites
    public function destroy($id)
    {
        try {
            $favorite = Favorite::where('id', $id)->where('user_id', Auth::id())->firstOrFail();
            $favorite->delete();

            return response()->json([
                'success' => true,
                'message' => 'Favorite removed successfully.',
            ]);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'error' => $e->getMessage()], 500);
        }
    }
}
