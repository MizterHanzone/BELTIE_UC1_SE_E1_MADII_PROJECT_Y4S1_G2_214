<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Category;

class CategoryController extends Controller
{
    public function index()
    {
        try {
            // Sort new data to the top
            $categories = Category::get();

            // Map data
            $data = $categories->map(function ($category) {
                return [
                    'id' => $category->id,
                    'name' => $category->name,
                    'description' => $category->description,
                    'photo' => $category->photo ? $category->photo : null,
                ];
            });

            // Response data
            return response()->json([
                'success' => true,
                'message' => 'Categories retrieved successfully!',
                'data' => $data,
            ]);
        } catch (\Exception $e) {
            // Error message
            return response()->json([
                'success' => false,
                'error' => $e->getMessage(),
            ], 500);
        }
    }
}
