<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Commune;
use App\Models\District;
use App\Models\Province;
use Illuminate\Http\Request;

class CommuneController extends Controller
{

    public function index(Request $request)
    {
        $query = Commune::query();

        // Search
        if ($request->filled('search')) {
            $searchTerm = strtolower($request->search);
            $query->whereRaw('LOWER(name) LIKE ?', ['%' . $searchTerm . '%']);
        }

        // Filter by district_id
        if ($request->filled('district_id')) {
            $query->where('district_id', $request->district_id);
        }

        // Filter by province indirectly via district relation
        if ($request->filled('province_id')) {
            $query->whereHas('district', function ($q) use ($request) {
                $q->where('province_id', $request->province_id);
            });
        }

        // Get filtered data
        $communes = $query->latest()->paginate(100);

        // Get all provinces
        $provinces = Province::all();

        // Filter districts if province is selected
        $districts = $request->filled('province_id')
            ? District::where('province_id', $request->province_id)->get()
            : District::all();

        return view('admin.communes.communes', compact('communes', 'provinces', 'districts'));
    }
}
