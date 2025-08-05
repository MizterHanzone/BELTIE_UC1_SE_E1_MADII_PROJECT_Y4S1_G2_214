<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Address;
use App\Models\Commune;
use App\Models\District;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AddressController extends Controller
{
    //
    public function index()
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User not authenticated.',
            ], 401);
        }

        // Retrieve addresses with related models
        $addresses = Address::with(['province', 'district', 'commune'])
            ->where('user_id', $user->id)
            ->get()
            ->map(function ($address) {
                return [
                    'id' => $address->id,
                    'phone' => $address->user->phone,
                    'village' => $address->village,
                    'street' => $address->street,
                    'house_number' => $address->house_number,
                    'province' => $address->province->name ?? null,
                    'district' => $address->district->name ?? null,
                    'commune' => $address->commune->name ?? null,
                    'latitude' => $address->latitude ?? null,
                    'longitude' => $address->longitude ?? null,
                ];
            });

        return response()->json([
            'success' => true,
            'message' => 'User addresses retrieved successfully.',
            'data' => $addresses,
        ]);
    }

    public function store(Request $request)
    {
        // Step 1: Basic Validation
        $validatedData = $request->validate([
            'province_id' => 'required|exists:provinces,id',
            'district_id' => 'required|exists:districts,id',
            'commune_id' => 'required|exists:communes,id',
            'village' => 'nullable|string|max:255',
            'street' => 'nullable|string|max:255',
            'house_number' => 'nullable|string|max:255',
            'latitude' => 'nullable|string',
            'longitude' => 'nullable|string',
        ]);

        // Step 2: Check if district belongs to province
        $district = District::where('id', $validatedData['district_id'])
            ->where('province_id', $validatedData['province_id'])
            ->first();

        if (!$district) {
            return response()->json([
                'success' => false,
                'message' => 'Selected district does not belong to the selected province.',
            ], 422);
        }

        // Step 3: Check if commune belongs to district
        $commune = Commune::where('id', $validatedData['commune_id'])
            ->where('district_id', $validatedData['district_id'])
            ->first();

        if (!$commune) {
            return response()->json([
                'success' => false,
                'message' => 'Selected commune does not belong to the selected district.',
            ], 422);
        }

        // Step 4: Save Address
        $address = new Address();
        $address->user_id = Auth::id();
        $address->province_id = $validatedData['province_id'];
        $address->district_id = $validatedData['district_id'];
        $address->commune_id = $validatedData['commune_id'];
        $address->village = $validatedData['village'] ?? null;
        $address->street = $validatedData['street'] ?? null;
        $address->house_number = $validatedData['house_number'] ?? null;
        $address->latitude = $validatedData['latitude'] ?? null;
        $address->longitude = $validatedData['longitude'] ?? null;
        $address->save();

        return response()->json([
            'success' => true,
            'message' => 'Address created successfully.',
            'data' => $address,
        ]);
    }

    public function update(Request $request, $id)
    {
        $validatedData = $request->validate([
            'province_id' => 'required|exists:provinces,id',
            'district_id' => 'required|exists:districts,id',
            'commune_id' => 'required|exists:communes,id',
            'village' => 'nullable|string|max:255',
            'street' => 'nullable|string|max:255',
            'house_number' => 'nullable|string|max:255',
            'latitude' => 'nullable|string',
            'longitude' => 'nullable|string',
        ]);

        // Find address and ensure it belongs to authenticated user
        $address = Address::where('id', $id)
            ->where('user_id', Auth::id())
            ->first();

        if (!$address) {
            return response()->json([
                'success' => false,
                'message' => 'Address not found or access denied.',
            ], 404);
        }

        // Validate province-district relationship
        $district = District::where('id', $validatedData['district_id'])
            ->where('province_id', $validatedData['province_id'])
            ->first();

        if (!$district) {
            return response()->json([
                'success' => false,
                'message' => 'Selected district does not belong to the selected province.',
            ], 422);
        }

        // Validate district-commune relationship
        $commune = Commune::where('id', $validatedData['commune_id'])
            ->where('district_id', $validatedData['district_id'])
            ->first();

        if (!$commune) {
            return response()->json([
                'success' => false,
                'message' => 'Selected commune does not belong to the selected district.',
            ], 422);
        }

        // Update fields
        $address->update([
            'province_id' => $validatedData['province_id'],
            'district_id' => $validatedData['district_id'],
            'commune_id' => $validatedData['commune_id'],
            'village' => $validatedData['village'] ?? null,
            'street' => $validatedData['street'] ?? null,
            'house_number' => $validatedData['house_number'] ?? null,
            'latitude' => $validatedData['latitude'] ?? null,
            'longitude' => $validatedData['longitude'] ?? null,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Address updated successfully.',
            'data' => $address,
        ]);
    }

    public function destroy($id)
    {
        $address = Address::where('id', $id)
            ->where('user_id', Auth::id())
            ->first();

        if (!$address) {
            return response()->json([
                'success' => false,
                'message' => 'Address not found or access denied.',
            ], 404);
        }

        $address->delete();

        return response()->json([
            'success' => true,
            'message' => 'Address deleted successfully.',
        ]);
    }
}
