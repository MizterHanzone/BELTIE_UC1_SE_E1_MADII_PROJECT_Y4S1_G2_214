<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Category;
use App\Models\Product;
use App\Models\User;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    // get products all
    public function index()
    {
        $categories = Category::with('product.brand', 'product.favorites')->get();
        $totalUsers = User::count();

        $data = $categories->map(function ($category) use ($totalUsers) {
            return [
                'category_name' => $category->name,
                'category_photo' => $category->photo ?? null,
                'product' => $category->product->map(function ($product) use ($totalUsers) {
                    $favoriteCount = $product->favorites->count();
                    $rating = $totalUsers > 0 ? round($favoriteCount / $totalUsers, 2) : 0;

                    return [
                        'id' => $product->id,
                        'name' => $product->name,
                        'description' => $product->description,
                        'price' => $product->price,
                        'uom' => $product->uom,
                        'photo' => $product->photo ?? null,
                        'brand' => $product->brand->name ?? null,
                        'favorite_count' => $favoriteCount,
                        'rating' => $rating,
                    ];
                }),
            ];
        });

        return response()->json([
            'success' => true,
            'message' => 'Products grouped by category retrieved successfully!',
            'data' => $data,
        ]);
    }


    // filter products by category
    public function filterByCategory(Request $request, $categoryId)
    {
        $category = Category::find($categoryId);

        if (!$category) {
            return response()->json([
                'success' => false,
                'message' => 'Category not found.',
            ], 404);
        }

        $query = Product::where('category_id', $categoryId);

        if ($request->has('search') && !empty($request->search)) {
            $searchTerm = strtolower($request->search);
            $query->where(function ($q) use ($searchTerm) {
                $q->whereRaw('LOWER(name) LIKE ?', ["%{$searchTerm}%"])
                    ->orWhereRaw('LOWER(description) LIKE ?', ["%{$searchTerm}%"]);
            });
        }

        $products = $query->with('brand')->get();

        $data = $products->map(function ($product) {
            return [
                'id' => $product->id,
                'name' => $product->name,
                'description' => $product->description,
                'price' => $product->price,
                'uom' => $product->uom,
                'photo' => $product->photo,
                'brand' => $product->brand ? $product->brand->name : null,
                'category' => $product->category->name,
                'category_id' => $product->category ? $product->category->id : null,
            ];
        });

        return response()->json([
            'success' => true,
            'message' => 'Products retrieved successfully!',
            'category' => [
                'name' => $category->name,
                'photo' => $category->photo,
            ],
            'products' => $data,
        ]);
    }

    // search products
    public function searchProducts(Request $request)
    {
        $query = Product::query();

        if ($request->has('search') && !empty($request->search)) {
            $searchTerm = strtolower($request->search);
            $query->where(function ($q) use ($searchTerm) {
                $q->whereRaw('LOWER(name) LIKE ?', ["%{$searchTerm}%"])
                    ->orWhereRaw('LOWER(description) LIKE ?', ["%{$searchTerm}%"]);
            });
        }

        $products = $query->get();

        $data = $products->map(function ($product) {
            return [
                'id' => $product->id,
                'name' => $product->name,
                'description' => $product->description,
                'price' => $product->price,
                'uom' => $product->uom,
                'photo' => $product->photo,
                'brand' => $product->brand->name ?? null,
                'category' => $product->category->name ?? null,
                'category_id' => $product->category ? $product->category->id : null,
            ];
        });

        return response()->json([
            'success' => true,
            'message' => 'Products retrieved successfully!',
            'data' => $data,
        ]);
    }

}
