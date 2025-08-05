<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Category;
use App\Models\Favorite;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class FavoriteController extends Controller
{
    public function toggleFavorite(Request $request)
    {
        // Validate input
        $request->validate([
            'product_id' => 'required|exists:products,id',
        ]);

        // Get the authenticated user
        $user = Auth::user();

        // Find if the product is already favorited by this user
        $favorite = Favorite::where('user_id', $user->id)
            ->where('product_id', $request->product_id)
            ->first();

        if ($favorite) {
            // If favorite exists, remove it
            $favorite->delete();

            return response()->json([
                'success' => true,
                'action' => 'removed',
                'message' => 'Removed from favorites',
                'data' => [
                    'product_id' => $request->product_id,
                    'user_id' => $user->id,
                ],
            ]);
        } else {
            // Otherwise, create a new favorite
            Favorite::create([
                'user_id' => $user->id,
                'product_id' => $request->product_id,
            ]);

            return response()->json([
                'success' => true,
                'action' => 'added',
                'message' => 'Added to favorites',
                'data' => [
                    'product_id' => $request->product_id,
                    'user_id' => $user->id,
                ],
            ]);
        }
    }

    // get own favorites
    public function getFavorites()
    {
        $user = Auth::user();

        $favorites = Favorite::with(['product.brand', 'user']) // notice 'user' here
            ->where('user_id', $user->id)
            ->get()
            ->map(function ($fav) {
                $product = $fav->product;
                return [
                    'id' => $product->id,
                    'name' => $product->name,
                    'description' => $product->description,
                    'price' => $product->price,
                    'uom' => $product->uom,
                    'photo' => $product->photo ?? null,
                    'brand' => $product->brand->name ?? null,
                    'favorite_by_id' => $fav->user_id,
                ];
            });

        return response()->json([
            'success' => true,
            'message' => 'Favorite products retrieved successfully!',
            'data' => $favorites,
        ]);
    }

    public function searchOwnFavorites(Request $request)
    {
        $user = Auth::user();
        $searchTerm = strtolower($request->input('search', ''));

        $favorites = Favorite::with(['product.brand', 'user'])
            ->where('user_id', $user->id)
            ->whereHas('product', function ($query) use ($searchTerm) {
                $query->whereRaw('LOWER(name) LIKE ?', ["%{$searchTerm}%"])
                    ->orWhereRaw('LOWER(description) LIKE ?', ["%{$searchTerm}%"]);
            })
            ->get()
            ->map(function ($fav) {
                $product = $fav->product;
                return [
                    'id' => $product->id,
                    'name' => $product->name,
                    'description' => $product->description,
                    'price' => $product->price,
                    'uom' => $product->uom,
                    'photo' => $product->photo ?? null,
                    'brand' => $product->brand->name ?? null,
                    'favorite_by_id' => $fav->user_id,
                ];
            });

        return response()->json([
            'success' => true,
            'message' => 'Favorite products retrieved successfully!',
            'data' => $favorites,
        ]);
    }

    public function getCategoryFavorite()
    {
        $user = Auth::user();

        $categories = Category::whereHas('product.favorites', function ($query) use ($user) {
            $query->where('user_id', $user->id);
        })
            ->select('id', 'name', 'photo') // select only fields you need
            ->distinct()
            ->get();

        return response()->json([
            'success' => true,
            'message' => 'Categories of favorited products retrieved successfully!',
            'data' => $categories,
        ]);
    }


    public function filterFavoriteByCategory($categoryId)
    {
        $user = Auth::user();

        $favorites = Favorite::with(['product.brand', 'user'])
            ->where('user_id', $user->id)
            ->whereHas('product', function ($query) use ($categoryId) {
                $query->where('category_id', $categoryId);
            })
            ->get()
            ->map(function ($fav) {
                $product = $fav->product;
                return [
                    'id' => $product->id,
                    'name' => $product->name,
                    'description' => $product->description,
                    'price' => $product->price,
                    'uom' => $product->uom,
                    'photo' => $product->photo ?? null,
                    'brand' => $product->brand->name ?? null,
                    'favorite_by_id' => $fav->user_id,
                ];
            });

        return response()->json([
            'success' => true,
            'message' => 'Favorite products by category retrieved successfully!',
            'data' => $favorites,
        ]);
    }
}
