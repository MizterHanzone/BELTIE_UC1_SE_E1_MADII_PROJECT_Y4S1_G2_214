<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\PaymentMethod;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class PaymentMethodController extends Controller
{
    //
    public function index(Request $request)
    {
        $query = PaymentMethod::query();

        if ($request->has('search') && $request->search != '') {
            $searchTerm = strtolower($request->search);
            $query->where(function ($q) use ($searchTerm) {
                $q->whereRaw('LOWER(name) LIKE ?', ['%' . $searchTerm . '%']);
            });
        }

        $payment_methods = $query->latest()->paginate(10);

        return view('admin.payment_methods.payment_methods', compact('payment_methods'));
    }

    public function create()
    {
        return view('admin.payment_methods.add_payment_methods');
    }

    public function store(Request $request)
    {
        // Validate the incoming data, including the image
        $validatedData = $request->validate([
            'name' => 'required|string|max:255|unique:categories,name',
            'code' => 'nullable|string',
            'photo' => 'nullable|image|mimes:jpg,jpeg,png,gif|max:2048',  // Validation for the image
        ]);

        // Handle the image upload (if an image is provided)
        $photoPath = null;
        if ($request->hasFile('photo') && $request->file('photo')->isValid()) {
            // Store the image in the 'categories' directory within the public folder
            $photoPath = $request->file('photo')->store('payment_method', 'public');
        }


        $payment_methods = new PaymentMethod();
        $payment_methods->name = $validatedData['name'];
        $payment_methods->code = $validatedData['code'];
        $payment_methods->photo = $photoPath;
        $payment_methods->save();

        // Redirect back with success message
        return redirect()->route('payment_methods.index')->with('status', 'Payment method created successfully!');
    }

    public function edit(PaymentMethod $payment_method)
    {
        return view('admin.payment_methods.edit_payment_method', compact('payment_method'));
    }

    public function update(Request $request, PaymentMethod $payment_method)
    {
        // Validate the incoming data, including the image
        $validatedData = $request->validate([
            'name' => 'required|string|max:255|unique:categories,name,' . $payment_method->id,
            'code' => 'nullable|string',
            'photo' => 'nullable|image|mimes:jpg,jpeg,png,gif|max:2048',
        ]);

        // Handle the image upload (if an image is provided)
        if ($request->hasFile('photo') && $request->file('photo')->isValid()) {
            // Delete the old photo if it exists
            if ($payment_method->photo) {
                Storage::disk('public')->delete($payment_method->photo);
            }
            // Store the new image
            $photoPath = $request->file('photo')->store('payment_methods', 'public');
            $payment_method->photo = $photoPath;
        }

        // Update the category
        $payment_method->name = $validatedData['name'];
        $payment_method->code = $validatedData['code'] ?? '';
        $payment_method->is_active = $request->has('is_active') ? true : false;
        $payment_method->save();

        // Redirect back with success message
        return redirect()->route('payment_methods.index')->with('status', 'Payment Method updated successfully!');
    }

    public function destroy($id)
    {
        try {
            $payment_methods = PaymentMethod::findOrFail($id);

            // Delete the associated photo if it exists
            if ($payment_methods->photo) {
                Storage::disk('public')->delete($payment_methods->photo);
            }

            // Delete the record from the database
            $payment_methods->delete();

            // Redirect back with success message
            return redirect()->route('payment_methods.index')->with('status', 'Payment method deleted successfully!');
        } catch (\Exception $e) {
            // Handle any errors
            return redirect()->back()->with('error', 'Failed to delete payment method: ' . $e->getMessage());
        }
    }
}
