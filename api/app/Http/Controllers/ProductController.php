<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class ProductController extends Controller
{
    //
    public function index()
    {
        try {
            // Retrieve categories with up to 5 products each
            $categories = Category::with([
                'products' => function ($query) {
                    $query->select('id', 'name', 'description', 'price', 'quantity', 'photo', 'category_id')
                        ->limit(5);
                },
            ])->latest()->get(['id', 'name', 'description']);

            // Map categories with products
            $groupedProducts = $categories->map(function ($category) {
                if ($category->products->isEmpty()) return null;

                return [
                    'category_name' => $category->name,
                    'category_description' => $category->description,
                    'products' => $category->products->map(function ($product) {
                        return [
                            'id' => $product->id,
                            'name' => $product->name,
                            'description' => $product->description,
                            'price' => $product->price,
                            'quantity' => $product->quantity,
                            'photo' => $product->photo ? $product->photo : null,
                        ];
                    }),
                ];
            })->filter()->values();

            return response()->json([
                'success' => true,
                'categories' => $groupedProducts
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to load categories and products.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'price' => 'required|numeric|min:0',
            'quantity' => 'required|integer|min:0',
            'category_id' => 'required|exists:categories,id',
            'brand_id' => 'required|exists:brands,id',
            'photo' => 'nullable|file|mimes:jpg,jpeg,png,gif|max:2048',
        ]);

        try {
            DB::beginTransaction();

            $photoPath = null;
            if ($request->hasFile('photo')) {
                $photoPath = $request->file('photo')->store('products', 'public');
            }

            $product = new Product();
            $product->name = $request->name;
            $product->description = $request->description;
            $product->price = $request->price;
            $product->quantity = $request->quantity;
            $product->category_id = $request->category_id;
            $product->brand_id = $request->brand_id;
            $product->photo = $photoPath;
            $product->save();

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Product created successfully.',
                'data' => $product,
            ], 201);
        } catch (\Exception $e) {
            DB::rollBack();

            return response()->json([
                'success' => false,
                'message' => 'Failed to create product.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'price' => 'required|numeric|min:0',
            'quantity' => 'required|integer|min:0',
            'category_id' => 'required|exists:categories,id',
            'brand_id' => 'required|exists:brands,id',
            'photo' => 'nullable|file|mimes:jpg,jpeg,png,gif|max:2048',
        ]);

        try {
            $product = Product::findOrFail($id);

            DB::beginTransaction();

            if ($request->hasFile('photo')) {
                if ($product->photo && Storage::disk('public')->exists($product->photo)) {
                    Storage::disk('public')->delete($product->photo);
                }
                $product->photo = $request->file('photo')->store('products', 'public');
            }

            $product->name = $request->name;
            $product->description = $request->description;
            $product->price = $request->price;
            $product->quantity = $request->quantity;
            $product->category_id = $request->category_id;
            $product->brand_id = $request->brand_id;
            $product->save();

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Product updated successfully.',
                'data' => $product,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();

            return response()->json([
                'success' => false,
                'message' => 'Failed to update product.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function destroy($id)
    {
        try {
            $product = Product::findOrFail($id);

            DB::beginTransaction();

            if ($product->photo && Storage::disk('public')->exists($product->photo)) {
                Storage::disk('public')->delete($product->photo);
            }

            $product->delete();

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Product deleted successfully.',
                'data' => $product,
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Product not found.',
            ], 404);
        } catch (\Exception $e) {
            DB::rollBack();

            return response()->json([
                'success' => false,
                'message' => 'Failed to delete product.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

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

}
