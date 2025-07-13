<?php

namespace App\Http\Controllers;

use App\Models\ProductPhoto;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class ProductPhotoController extends Controller
{
    // 📃 List all photos for a product
    public function index($productId)
    {
        try {
            $photos = ProductPhoto::where('product_id', $productId)->get();

            $formatted = $photos->map(fn($photo) => [
                'id' => $photo->id,
                'photo_url' => $photo->photo ?  $photo->photo : null,
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Photos retrieved successfully',
                'data' => $formatted,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve photos',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    // 📥 Store a new product photo
    // public function store(Request $request, $productId)
    // {
    //     $request->validate([
    //         'photo' => ['required', 'file', 'mimes:jpg,jpeg,png,gif', 'max:2048'],
    //     ]);

    //     try {
    //         DB::beginTransaction();

    //         if (!Product::find($productId)) {
    //             return response()->json(['message' => 'Product not found'], 404);
    //         }

    //         $path = $request->file('photo')->store('product_photos', 'public');

    //         $photo = new ProductPhoto();
    //         $photo->product_id = $productId;
    //         $photo->photo = $path;
    //         $photo->save();

    //         DB::commit();

    //         return response()->json([
    //             'success' => true,
    //             'message' => 'Photo uploaded successfully',
    //             'data' => $photo,
    //         ]);
    //     } catch (\Exception $e) {
    //         DB::rollBack();
    //         return response()->json([
    //             'success' => false,
    //             'message' => 'Failed to upload photo',
    //             'error' => $e->getMessage(),
    //         ], 500);
    //     }
    // }

    public function store(Request $request)
    {
        $request->validate([
            'product_id' => 'required|exists:products,id',
            'photos' => 'required|array',
            'photos.*' => 'file|image|mimes:jpg,jpeg,png,gif|max:2048',
        ]);

        try {
            DB::beginTransaction();

            $storedPhotos = [];

            foreach ($request->file('photos') as $photoFile) {
                $path = $photoFile->store('product_photos', 'public');

                $photo = new ProductPhoto();
                $photo->product_id = $request->product_id;
                $photo->photo = $path;
                $photo->save();

                $storedPhotos[] = [
                    'id' => $photo->id,
                    'photo_url' => asset('storage/' . $path),
                ];
            }

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Photos uploaded successfully',
                'data' => $storedPhotos,
            ], 201);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'success' => false,
                'message' => 'Failed to upload photos.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    // 🗑️ Delete a photo
    public function destroyByProduct($productId)
    {
        try {
            $photos = ProductPhoto::where('product_id', $productId)->get();

            foreach ($photos as $photo) {
                if ($photo->photo && Storage::disk('public')->exists($photo->photo)) {
                    Storage::disk('public')->delete($photo->photo);
                }
                $photo->delete();
            }

            return response()->json([
                'success' => true,
                'message' => 'All photos for this product were deleted successfully.',
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete photos.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
}
