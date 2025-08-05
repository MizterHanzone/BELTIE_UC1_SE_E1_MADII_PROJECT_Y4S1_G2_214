<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Advertise;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class AdvertiseController extends Controller
{
    //
    public function index(Request $request)
    {
        $query = Advertise::query();

        if ($request->has('search') && $request->search != '') {
            $searchTerm = strtolower($request->search);
            $query->where(function($q) use ($searchTerm) {
                $q->whereRaw('LOWER(title) LIKE ?', ['%' . $searchTerm . '%'])
                  ->orWhereRaw('LOWER(description) LIKE ?', ['%' . $searchTerm . '%']);
            });
        }

        $advertisements = $query->paginate(10);
        return view('admin.advertises.advertises', compact('advertisements'));
    }

    public function create()
    {
        return view('admin.advertises.add_advertise');
    }

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'link' => 'nullable|url|max:255',
            'photo' => 'nullable|image|mimes:jpg,jpeg,png,gif|max:2048',
            'status' => 'required|in:active,inactive',
        ]);

        $advertisement = new Advertise();
        $advertisement->title = $validatedData['title'];
        $advertisement->description = $validatedData['description'] ?? '';
        $advertisement->link = $validatedData['link'] ?? null;
        $advertisement->status = $validatedData['status'];
        $advertisement->user_id = Auth::user()->id;

        if ($request->hasFile('photo') && $request->file('photo')->isValid()) {
            $advertisement->photo = $request->file('photo')->store('advertisements', 'public');
        }

        $advertisement->save();

        return redirect()->route('advertisements.index')->with('status', 'Advertisement created successfully!');
    }

    public function edit($id)
    {
        $advertisement = Advertise::findOrFail($id);
        return view('admin.advertises.edit_advertise', compact('advertisement'));
    }

    public function update(Request $request, $id)
    {
        $advertisement = Advertise::findOrFail($id);

        $validatedData = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'link' => 'nullable|url|max:255',
            'photo' => 'nullable|image|mimes:jpg,jpeg,png,gif|max:2048',
            'status' => 'required|in:active,inactive',
        ]);

        $advertisement->title = $validatedData['title'];
        $advertisement->description = $validatedData['description'] ?? '';
        $advertisement->link = $validatedData['link'] ?? null;
        $advertisement->status = $validatedData['status'];
        $advertisement->user_id = Auth::user()->id;


        if ($request->hasFile('photo') && $request->file('photo')->isValid()) {
            // Delete old photo if exists
            if ($advertisement->photo) {
                Storage::disk('public')->delete($advertisement->photo);
            }
            $advertisement->photo = $request->file('photo')->store('advertisements', 'public');
        }

        $advertisement->save();

        return redirect()->route('advertisements.index')->with('status', 'Advertisement updated successfully!');
    }

    public function destroy($id)
    {
        $advertisement = Advertise::findOrFail($id);

        if ($advertisement->photo) {
            Storage::disk('public')->delete($advertisement->photo);
        }

        $advertisement->delete();

        return redirect()->route('advertisements.index')->with('status', 'Advertisement deleted successfully!');
    }
}
