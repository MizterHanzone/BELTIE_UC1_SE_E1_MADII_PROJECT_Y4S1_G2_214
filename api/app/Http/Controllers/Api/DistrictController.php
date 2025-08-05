<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\District;
use Illuminate\Http\Request;

class DistrictController extends Controller
{
    public function index(Request $request)
    {
        try {
            // Check for province_id filter
            $query = District::query();

            if ($request->filled('province_id')) {
                $query->where('province_id', $request->province_id);
            }

            $districts = $query->get();

            // Map the data
            $data = $districts->map(function ($district) {
                return [
                    'id' => $district->id,
                    'name' => $district->name,
                ];
            });

            return response()->json([
                'success' => true,
                'message' => 'Districts retrieved successfully!',
                'data' => $data,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'error' => $e->getMessage(),
            ], 500);
        }
    }
}
