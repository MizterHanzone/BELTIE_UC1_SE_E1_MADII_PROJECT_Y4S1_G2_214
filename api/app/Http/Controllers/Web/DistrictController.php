<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\District;
use App\Models\Province;
use Illuminate\Http\Request;

class DistrictController extends Controller
{
    //
    public function index(Request $request)
    {
        $query = District::query();
        
        if ($request->has('search') && $request->search != '') {
            $searchTerm = strtolower($request->search);
            $query->where(function($q) use ($searchTerm) {
                $q->whereRaw('LOWER(name) LIKE ?', ['%' . $searchTerm . '%']);
            });
        }

        if ($request->has('province_id') && $request->province_id != '') {
            $query->where('province_id', $request->province_id);
        }

        $districts = $query->latest()->paginate(10);
        $provinces = Province::all();

        return view('admin.districts.districts', compact('districts', 'provinces'));
    }
}
