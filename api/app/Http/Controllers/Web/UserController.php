<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;

class UserController extends Controller
{
    //
    public function index(Request $request)
    {
        $query = User::where('role', 'user');

        if ($request->has('search') && $request->search != '') {
            $searchTerm = strtolower($request->search);
            $query->where(function ($q) use ($searchTerm) {
                $q->whereRaw('LOWER(first_name) LIKE ?', ['%' . $searchTerm . '%'])
                  ->orWhereRaw('LOWER(last_name) LIKE ?', ['%' . $searchTerm . '%'])
                  ->orWhereRaw('LOWER(email) LIKE ?', ['%' . $searchTerm . '%']);
            });
        }              

        $users = $query->latest()->paginate(10);

        return view('admin.users.user_list', compact('users'));
    }
}
