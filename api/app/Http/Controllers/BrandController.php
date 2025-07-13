<?php

namespace App\Http\Controllers;

use App\Models\Brand;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class BrandController extends Controller
{
    //
    /**
     * Display a listing of the resource.
     */
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

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        // Validate data input
        $request->validate(
            [
                'name' => ['required', 'string', 'unique:brands,name'],
                'photo' => ['nullable', 'file', 'mimetypes:image/png,image/jpeg,image/jpg,image/gif'],
            ],
            [   // Message when input wrong
                'name.required' => 'Please enter name',
                'name.unique' => 'Name is already exist',
                'photo' => 'Photo must be png, jpeg, jpg, gif',
            ]
        );

        try {
            DB::beginTransaction();

            // Handle photo upload
            $photo_path = null;
            if ($request->hasFile('photo')) {
                $photo = $request->file('photo');
                $photo_path = $photo->store('brands', 'public');
            }

            // Create new brand
            $brand = new brand();
            $brand->name = $request->name;
            $brand->description = $request->description;
            $brand->photo = $photo_path;
            $brand->save();

            DB::commit();

            // Response data
            return response()->json([
                'success' => true,
                'message' => 'brand stored successfully!',
                'data' => $brand,
            ], 201);
        } catch (\Exception $e) {
            DB::rollBack();
            // Error message
            return response()->json([
                'success' => false,
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        try {
            // Find brand to update
            $brand = brand::findOrFail($id); // If not found, automatically throws ModelNotFoundException

            // Validate data input
            $request->validate(
                [
                    'name' => ['required', 'string', 'unique:brands,name,' . $id],
                    'photo' => ['nullable', 'file', 'mimetypes:image/png,image/jpeg,image/jpg,image/gif'],
                ],
                [   // Message when input wrong
                    'name.required' => 'Please enter name',
                    'name.unique' => 'Name is already exist',
                    'photo' => 'Photo must be png, jpeg, jpg, gif',
                ]
            );

            DB::beginTransaction();

            // If photo is uploaded, delete the old one
            if ($request->hasFile('photo')) {
                if ($brand->photo && Storage::disk('public')->exists($brand->photo)) {
                    Storage::disk('public')->delete($brand->photo);
                }
                $brand->photo = $request->file('photo')->store('brands', 'public');
            }

            $brand->name = $request->name;
            $brand->description = $request->description;
            $brand->save();

            DB::commit();

            // Response data
            return response()->json([
                'success' => true,
                'message' => 'brand updated successfully!',
                'data' => $brand,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            // Error message
            return response()->json([
                'success' => false,
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        try {
            $brand = brand::findOrFail($id); // If not found, automatically throws ModelNotFoundException

            // Delete photo if exists
            if ($brand->photo && Storage::disk('public')->exists($brand->photo)) {
                Storage::disk('public')->delete($brand->photo);
            }

            // Delete brand
            $brand->delete();

            return response()->json([
                'success' => true,
                'message' => 'brand deleted successfully.',
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            // Handle case where the brand ID is not found
            return response()->json([
                'success' => false,
                'error' => 'brand not found.',
            ], 404);
        } catch (\Exception $e) {
            // Handle other exceptions
            return response()->json([
                'success' => false,
                'error' => $e->getMessage(),
            ], 500);
        }
    }
}
