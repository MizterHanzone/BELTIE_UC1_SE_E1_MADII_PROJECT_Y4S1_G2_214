<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Brand;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class BrandController extends Controller
{
    //
    public function index(Request $request)
    {
        $query = Brand::query();

        if ($request->has('search') && $request->search != '') {
            $searchTerm = strtolower($request->search);
            $query->where(function($q) use ($searchTerm) {
                $q->whereRaw('LOWER(name) LIKE ?', ['%' . $searchTerm . '%'])
                 ->orWhereRaw('LOWER(description) LIKE ?', ['%' . $searchTerm . '%']);
            });
        }

        $brands = $query->latest()->paginate(10);

        return view('admin.brands.brands', compact('brands'));
    }

    public function create()
    {
        return view('admin.brands.add_brands');
    }

    public function store(Request $request)
    {
        // Validate the incoming data, including the image
        $validatedData = $request->validate([
            'name' => 'required|string|max:255|unique:brands,name',
            'description' => 'nullable|string',
            'photo' => 'nullable|image|mimes:jpg,jpeg,png,gif|max:2048',  // Validation for the image
        ]);

        // Handle the image upload (if an image is provided)
        $photoPath = null;
        if ($request->hasFile('photo') && $request->file('photo')->isValid()) {
            // Store the image in the 'categories' directory within the public folder
            $photoPath = $request->file('photo')->store('brands', 'public');
        }

        // Create and store the category
        $brand = new Brand();
        $brand->name = $validatedData['name'];
        $brand->description = $validatedData['description'] ?? '';  // Optional description
        $brand->photo = $photoPath;  // Store the image path in the database
        $brand->user_id = Auth::user()->id; // Assuming the user is authenticated
        $brand->save();

        // Redirect back with success message
        return redirect()->route('brands.index')->with('status', 'Brand created successfully!');
    }

    public function edit(Brand $brand)
    {
        return view('admin.brands.edit_brands', compact('brand'));
    }

    public function update(Request $request, Brand $brand)
    {
        // Validate the incoming data, including the image
        $validatedData = $request->validate([
            'name' => 'required|string|max:255|unique:brands,name,' . $brand->id,
            'description' => 'nullable|string',
            'photo' => 'nullable|image|mimes:jpg,jpeg,png,gif|max:2048',  // Validation for the image
        ]);

        // Handle the image upload (if an image is provided)
        if ($request->hasFile('photo') && $request->file('photo')->isValid()) {
            // Delete the old photo if it exists
            if ($brand->photo) {
                Storage::disk('public')->delete($brand->photo);
            }
            // Store the new image
            $photoPath = $request->file('photo')->store('brands', 'public');
            $brand->photo = $photoPath;
        }

        // Update the category
        $brand->name = $validatedData['name'];
        $brand->description = $validatedData['description'] ?? '';
        $brand->user_id = Auth::user()->id;
        $brand->save();

        // Redirect back with success message
        return redirect()->route('brands.index')->with('status', 'Brand updated successfully!');
    }

    public function destroy(Brand $brand)
    {
        try {
            // Delete the associated photo if it exists
            if ($brand->photo) {
                Storage::disk('public')->delete($brand->photo);
            }
            $brand->delete();
            return redirect()->route('brands.index')->with('status', 'Brand deleted successfully!');
        } catch (\Exception $e) {
            return redirect()->back()->with('error', 'Failed to delete Crand: ' . $e->getMessage());
        }
    }
}
