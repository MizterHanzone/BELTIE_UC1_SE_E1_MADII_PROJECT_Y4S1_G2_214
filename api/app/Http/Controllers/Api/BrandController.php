<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Brand;
use Illuminate\Http\Request;

class BrandController extends Controller
{
    //
    public function index()
    {
        try {
            // Sort new data to the top
            $brands = Brand::get();

            // Map data
            $data = $brands->map(function ($brand) {
                return [
                    'id' => $brand->id,
                    'name' => $brand->name,
                    'description' => $brand->description,
                    'photo' => $brand->photo ? $brand->photo : null,
                ];
            });

            // Response data
            return response()->json([
                'success' => true,
                'message' => 'Brands retrieved successfully!',
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
