<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class CategoryController extends Controller
{
    public function index(Request $request)
    {
        $query = Category::query();

        if ($request->has('search') && $request->search != '') {
            $searchTerm = strtolower($request->search);
            $query->where(function($q) use ($searchTerm) {
                $q->whereRaw('LOWER(name) LIKE ?', ['%' . $searchTerm . '%'])
                 ->orWhereRaw('LOWER(description) LIKE ?', ['%' . $searchTerm . '%']);
            });
        }

        $categories = $query->latest()->paginate(10);

        return view('admin.categories.categories', compact('categories'));
    }

    public function create()
    {
        return view('admin.categories.add_categories');
    }

    public function store(Request $request)
    {
        // Validate the incoming data, including the image
        $validatedData = $request->validate([
            'name' => 'required|string|max:255|unique:categories,name',
            'description' => 'nullable|string',
            'photo' => 'nullable|image|mimes:jpg,jpeg,png,gif|max:2048',  // Validation for the image
        ]);

        // Handle the image upload (if an image is provided)
        $photoPath = null;
        if ($request->hasFile('photo') && $request->file('photo')->isValid()) {
            // Store the image in the 'categories' directory within the public folder
            $photoPath = $request->file('photo')->store('categories', 'public');
        }

        // Create and store the category
        $category = new Category();
        $category->name = $validatedData['name'];
        $category->description = $validatedData['description'] ?? '';  // Optional description
        $category->photo = $photoPath;  // Store the image path in the database
        $category->user_id = Auth::user()->id; // Assuming the user is authenticated
        $category->save();

        // Redirect back with success message
        return redirect()->route('categories.index')->with('status', 'Category created successfully!');
    }

    public function edit(Category $category)
    {
        return view('admin.categories.edit_categories', compact('category'));
    }

    public function update(Request $request, Category $category)
    {
        // Validate the incoming data, including the image
        $validatedData = $request->validate([
            'name' => 'required|string|max:255|unique:categories,name,' . $category->id,
            'description' => 'nullable|string',
            'photo' => 'nullable|image|mimes:jpg,jpeg,png,gif|max:2048',  // Validation for the image
        ]);

        // Handle the image upload (if an image is provided)
        if ($request->hasFile('photo') && $request->file('photo')->isValid()) {
            // Delete the old photo if it exists
            if ($category->photo) {
                Storage::disk('public')->delete($category->photo);
            }
            // Store the new image
            $photoPath = $request->file('photo')->store('categories', 'public');
            $category->photo = $photoPath;
        }

        // Update the category
        $category->name = $validatedData['name'];
        $category->description = $validatedData['description'] ?? '';
        $category->user_id = Auth::user()->id; // Assuming the user is authenticated
        $category->save();

        // Redirect back with success message
        return redirect()->route('categories.index')->with('status', 'Category updated successfully!');
    }

    public function destroy(Category $category)
    {
        try {
            // Delete the associated photo if it exists
            if ($category->photo) {
                Storage::disk('public')->delete($category->photo);
            }
            $category->delete();
            return redirect()->route('categories.index')->with('status', 'Category deleted successfully!');
        } catch (\Exception $e) {
            return redirect()->back()->with('error', 'Failed to delete category: ' . $e->getMessage());
        }
    }
}
