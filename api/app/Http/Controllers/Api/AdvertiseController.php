<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Advertise;
use Illuminate\Http\Request;

class AdvertiseController extends Controller
{
    //
    public function index()
    {
        try {
            // Get only advertisements with status 'active', newest first
            $advertisements = Advertise::where('status', 'active')->orderByDesc('id')->get();

            // Map data
            $data = $advertisements->map(function ($advertisements) {
                return [
                    'id' => $advertisements->id,
                    'title' => $advertisements->name,
                    'description' => $advertisements->description,
                    'link' => $advertisements->link,
                    'status' => $advertisements->status,
                    'photo' => $advertisements->photo ? $advertisements->photo : null,
                ];
            });

            // Response data
            return response()->json([
                'success' => true,
                'message' => 'Advertisements retrieved successfully!',
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
