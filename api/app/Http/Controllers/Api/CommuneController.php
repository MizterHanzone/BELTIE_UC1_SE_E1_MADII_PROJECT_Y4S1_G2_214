<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Commune;
use Illuminate\Http\Request;

class CommuneController extends Controller
{
    //
    public function index(Request $request)
    {
        try {
            $query = Commune::query();

            // Filter by district_id (direct)
            if ($request->filled('district_id')) {
                $query->where('district_id', $request->district_id);
            }

            // Filter by province_id (indirect via district)
            if ($request->filled('province_id')) {
                $query->whereHas('district', function ($q) use ($request) {
                    $q->where('province_id', $request->province_id);
                });
            }

            $communes = $query->get();

            // Format response
            $data = $communes->map(function ($commune) {
                return [
                    'id' => $commune->id,
                    'name' => $commune->name,
                    'district' => [
                        'id' => $commune->district->id ?? null,
                        'name' => $commune->district->name ?? null,
                    ],
                    'province' => [
                        'id' => $commune->district->province->id ?? null,
                        'name' => $commune->district->province->name ?? null,
                    ]
                ];
            });

            return response()->json([
                'success' => true,
                'message' => 'Communes retrieved successfully!',
                'data' => $data
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'error' => $e->getMessage(),
            ], 500);
        }
    }
}
