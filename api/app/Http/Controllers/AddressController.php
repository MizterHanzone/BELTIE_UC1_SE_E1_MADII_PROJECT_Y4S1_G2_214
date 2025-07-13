<?php

namespace App\Http\Controllers;

use App\Models\Address;
use App\Models\Commune;
use App\Models\District;
use App\Models\Province;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AddressController extends Controller
{
    /**
     * list provice
     */
    public function getProvinces()
    {
        try {
            // sort last data to top
            $provinces = Province::orderBy('id', 'desc')->get();
            $data = $provinces->map(function ($province) {
                return [
                    'id' => $province->id,
                    'name' => $province->name,
                ];
            });

            // response
            return response()->json([
                'success' => true,
                'message' => 'Province retrieve successfully!',
                'data' => $data,
            ]);
        } catch (\Exception $e) {
            // message error
            return response()->json([
                'success' => false,
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * list district
     */
    public function getDistricts($province_id)
    {
        try {
            // get districts that belong to province, sort latest first
            $districts = District::where('province_id', $province_id)
                ->orderBy('id', 'desc')
                ->with('province')
                ->get();

            // If no districts found
            if ($districts->isEmpty()) {
                return response()->json([
                    'success' => false,
                    'message' => 'No districts found for the selected province.',
                    'data' => [],
                ], 404);
            }

            // format data
            $data = $districts->map(function ($district) {
                return [
                    'id' => $district->id,
                    'name' => $district->name,
                    'province' => $district->province->name,
                ];
            });

            // response
            return response()->json([
                'success' => true,
                'message' => 'District retrieve successfully!',
                'data' => $data,
            ]);
        } catch (\Exception $e) {
            // message error
            return response()->json([
                'success' => false,
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * list commune
     */
    public function getCommunes($district_id)
    {
        try {
            // get districts that belong to province, sort latest first
            $communes = Commune::where('district_id', $district_id)
                ->orderBy('id', 'desc')
                ->with('district')
                ->get();

            // If no commune found
            if ($communes->isEmpty()) {
                return response()->json([
                    'success' => false,
                    'message' => 'No commune found for the selected district.',
                    'data' => [],
                ], 404);
            }

            // format data
            $data = $communes->map(function ($commune) {
                return [
                    'id' => $commune->id,
                    'name' => $commune->name,
                    'district' => $commune->district->name,
                ];
            });

            // response
            return response()->json([
                'success' => true,
                'message' => 'Commune retrieve successfully!',
                'data' => $data,
            ]);
        } catch (\Exception $e) {
            // message error
            return response()->json([
                'success' => false,
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    // List all addresses of the authenticated user
    public function index()
    {
        try {
            $addresses = Address::where('user_id', Auth::id())->get();

            return response()->json([
                'success' => true,
                'message' => 'Addresses retrieved successfully.',
                'data' => $addresses,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve addresses.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function show($id)
    {
        try {
            // Fetch the address with the associated user, province, district, and commune
            $address = Address::with(['user', 'province', 'district', 'commune'])
                ->where('user_id', Auth::id())
                ->findOrFail($id);

            // Prepare the response data
            $data = [
                'address' => $address,
                'user_name' => $address->user->first_name . ' ' . $address->user->last_name,  // Full user name
                'province_name' => $address->province->name,  // Province name
                'district_name' => $address->district->name,  // District name
                'commune_name' => $address->commune->name,  // Commune name
            ];

            return response()->json([
                'success' => true,
                'message' => 'Address retrieved successfully.',
                'data' => $data,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Address not found.',
                'error' => $e->getMessage(),
            ], 404);
        }
    }

    // Store a new address
    public function store(Request $request)
    {
        $request->validate([
            'province_id' => 'required|exists:provinces,id',
            'district_id' => 'required|exists:districts,id',
            'commune_id' => 'required|exists:communes,id',
            'street' => 'nullable|string',
            'description' => 'nullable|string',
        ]);

        try {
            // Check if district belongs to province
            $district = \App\Models\District::where('id', $request->district_id)
                ->where('province_id', $request->province_id)
                ->first();

            if (!$district) {
                return response()->json([
                    'success' => false,
                    'message' => 'The selected district does not belong to the specified province.',
                ], 422);
            }

            // Check if commune belongs to district
            $commune = \App\Models\Commune::where('id', $request->commune_id)
                ->where('district_id', $request->district_id)
                ->first();

            if (!$commune) {
                return response()->json([
                    'success' => false,
                    'message' => 'The selected commune does not belong to the specified district.',
                ], 422);
            }

            $address = Address::create([
                'user_id' => Auth::id(),
                'province_id' => $request->province_id,
                'district_id' => $request->district_id,
                'commune_id' => $request->commune_id,
                'street' => $request->street,
                'description' => $request->description,
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Address created successfully.',
                'data' => $address,
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to create address.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    // Update an address
    public function update(Request $request, $id)
    {
        $request->validate([
            'province_id' => 'required|exists:provinces,id',
            'district_id' => 'required|exists:districts,id',
            'commune_id' => 'required|exists:communes,id',
            'street' => 'nullable|string',
            'description' => 'nullable|string',
        ]);

        try {
            // Find the address by ID
            $address = Address::findOrFail($id);

            // Check if district belongs to province
            $district = \App\Models\District::where('id', $request->district_id)
                ->where('province_id', $request->province_id)
                ->first();

            if (!$district) {
                return response()->json([
                    'success' => false,
                    'message' => 'The selected district does not belong to the specified province.',
                ], 422);
            }

            // Check if commune belongs to district
            $commune = \App\Models\Commune::where('id', $request->commune_id)
                ->where('district_id', $request->district_id)
                ->first();

            if (!$commune) {
                return response()->json([
                    'success' => false,
                    'message' => 'The selected commune does not belong to the specified district.',
                ], 422);
            }

            // Update the address
            $address->update([
                'province_id' => $request->province_id,
                'district_id' => $request->district_id,
                'commune_id' => $request->commune_id,
                'street' => $request->street,
                'description' => $request->description,
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Address updated successfully.',
                'data' => $address,
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to update address.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    // Delete an address
    public function destroy($id)
    {
        try {
            $address = Address::where('user_id', Auth::id())->findOrFail($id);
            $address->delete();

            return response()->json([
                'success' => true,
                'message' => 'Address deleted successfully.',
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete address.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
}
