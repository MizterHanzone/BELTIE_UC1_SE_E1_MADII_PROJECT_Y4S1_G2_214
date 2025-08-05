<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    //
    public function index()
    {

        $userCount = User::where('role', 'user')->count();

        return view('index', compact('userCount'));
    }
}
