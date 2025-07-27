<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class CategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            // Sort new data to the top
            $categories = Category::orderBy('id', 'desc')->get();

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

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        // Validate data input
        $request->validate(
            [
                'name' => ['required', 'string', 'unique:categories,name'],
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
                $photo_path = $photo->store('categories', 'public');
            }

            // Create new category
            $category = new Category();
            $category->name = $request->name;
            $category->description = $request->description;
            $category->photo = $photo_path;
            $category->save();

            DB::commit();

            // Response data
            return response()->json([
                'success' => true,
                'message' => 'Category stored successfully!',
                'data' => $category,
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
            // Find category to update
            $category = Category::findOrFail($id); // If not found, automatically throws ModelNotFoundException

            // Validate data input
            $request->validate(
                [
                    'name' => ['required', 'string', 'unique:categories,name,' . $id],
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
                if ($category->photo && Storage::disk('public')->exists($category->photo)) {
                    Storage::disk('public')->delete($category->photo);
                }
                $category->photo = $request->file('photo')->store('categories', 'public');
            }

            $category->name = $request->name;
            $category->description = $request->description;
            $category->save();

            DB::commit();

            // Response data
            return response()->json([
                'success' => true,
                'message' => 'Category updated successfully!',
                'data' => $category,
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
            $category = Category::findOrFail($id); // If not found, automatically throws ModelNotFoundException

            // Delete photo if exists
            if ($category->photo && Storage::disk('public')->exists($category->photo)) {
                Storage::disk('public')->delete($category->photo);
            }

            // Delete category
            $category->delete();

            return response()->json([
                'success' => true,
                'message' => 'Category deleted successfully.',
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            // Handle case where the Category ID is not found
            return response()->json([
                'success' => false,
                'error' => 'Category not found.',
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
