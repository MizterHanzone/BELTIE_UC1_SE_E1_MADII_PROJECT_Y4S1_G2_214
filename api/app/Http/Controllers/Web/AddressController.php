<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Address;
use Illuminate\Http\Request;

class AddressController extends Controller
{
    //
    public function index(Request $request)
    {
        $query = Address::with(['user', 'province', 'district', 'commune'])->latest();

        if ($request->has('search') && $request->search != '') {
            $searchTerm = strtolower($request->search);

            $query->where(function ($q) use ($searchTerm) {
                $q->whereHas('user', function ($query) use ($searchTerm) {
                    $query->whereRaw('LOWER(first_name) LIKE ?', ["%$searchTerm%"])
                        ->orWhereRaw('LOWER(last_name) LIKE ?', ["%$searchTerm%"]);
                })
                    ->orWhereHas(
                        'province',
                        fn($query) =>
                        $query->whereRaw('LOWER(name) LIKE ?', ["%$searchTerm%"])
                    )
                    ->orWhereHas(
                        'district',
                        fn($query) =>
                        $query->whereRaw('LOWER(name) LIKE ?', ["%$searchTerm%"])
                    )
                    ->orWhereHas(
                        'commune',
                        fn($query) =>
                        $query->whereRaw('LOWER(name) LIKE ?', ["%$searchTerm%"])
                    )
                    ->orWhereRaw('LOWER(village) LIKE ?', ["%$searchTerm%"])
                    ->orWhereRaw('LOWER(street) LIKE ?', ["%$searchTerm%"])
                    ->orWhereRaw('LOWER(house_number) LIKE ?', ["%$searchTerm%"]);
            });
        }


        if ($request->province_id) {
            $query->where('province_id', $request->province_id);
        }

        if ($request->district_id) {
            $query->where('district_id', $request->district_id);
        }

        if ($request->commune_id) {
            $query->where('commune_id', $request->commune_id);
        }

        $addresses = $query->paginate(20);

        $provinces = \App\Models\Province::all();
        $districts = $request->province_id ? \App\Models\District::where('province_id', $request->province_id)->get() : [];
        $communes = $request->district_id ? \App\Models\Commune::where('district_id', $request->district_id)->get() : [];

        return view('admin.addresses.addresses', compact('addresses', 'provinces', 'districts', 'communes'));
    }
}
