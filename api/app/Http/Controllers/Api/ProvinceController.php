<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Province;
use Illuminate\Http\Request;

class ProvinceController extends Controller
{
    //
    public function index()
    {
        try {
            // Sort new data to the top
            $provinces = Province::get();

            // Map data
            $data = $provinces->map(function ($province) {
                return [
                    'id' => $province->id,
                    'name' => $province->name,
                ];
            });

            // Response data
            return response()->json([
                'success' => true,
                'message' => 'Provinces retrieved successfully!',
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
