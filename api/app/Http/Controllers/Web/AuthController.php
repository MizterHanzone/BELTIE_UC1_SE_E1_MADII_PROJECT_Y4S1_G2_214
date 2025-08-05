<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Session;

class AuthController extends Controller
{
    public function showLoginForm()
    {
        return view('auth.login');
    }

    public function showRegistrationForm()
    {
        return view('auth.register');
    }

    public function register(Request $request)
    {
        $validatedData = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8|confirmed',
        ]);

        $user = User::create([
            'name' => $validatedData['name'],
            'email' => $validatedData['email'],
            'password' => Hash::make($validatedData['password']),
            'role' => 'admin', // Set default role to admin
        ]);

        Auth::login($user);

        return Redirect::to('/dashboard');
    }

    public function login(Request $request)
    {
        $credentials = $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        if (Auth::attempt($credentials)) {
            $user = Auth::user();

            if ($user->role === 'admin') {
                return Redirect::intended('/dashboard');
            }
        }

        return Redirect::back()->withErrors([
            'email' => 'The provided credentials do not match our records.',
        ])->onlyInput('email');
    }

    public function logout(Request $request)
    {
        Auth::logout();

        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return Redirect::to('/login');
    }

    public function getCurrentUser()
    {
        $user = Auth::user();

        return view('admin.settings.account', compact('user'));
    }


    public function changePasswordForm()
    {
        return view('admin.settings.send_code');
    }

    public function sendCode(Request $request)
    {
        $request->validate([
            'email' => 'required|email|exists:users,email',
        ]);

        // Optional: Ensure only the logged-in user can request code for their own email
        if ($request->email !== Auth::user()->email) {
            return back()->withErrors(['email' => 'You can only request a code for your own account.']);
        }

        $code = rand(100000, 999999); // 6-digit code

        // Store in session
        Session::put('password_reset_code', $code);
        Session::put('password_reset_email', $request->email);

        // Send email
        Mail::raw("Your verification code is: $code", function ($message) use ($request) {
            $message->to($request->email)
                ->subject('Your Password Reset Verification Code');
        });

        return redirect()->route('admin.change_password')->with('status', 'Verification code sent to your email.');
    }

    public function updatePasswordForm()
    {
        return view('admin.settings.update_password');
    }

    public function updatePasswordWithCode(Request $request)
    {
        $request->validate([
            'code' => 'required',
            'new_password' => 'required|string|min:8|confirmed',
        ]);

        $sessionCode = Session::get('password_reset_code');
        $sessionEmail = Session::get('password_reset_email');
        $user = Auth::user();

        // Check if session code/email exist
        if (!$sessionCode || !$sessionEmail) {
            return back()->withErrors(['code' => 'Verification session expired.']);
        }

        // Check if user matches
        if ($user->email !== $sessionEmail) {
            return back()->withErrors(['email' => 'Email mismatch.']);
        }

        // Check if code matches
        if ($request->code != $sessionCode) {
            return back()->withErrors(['code' => 'Verification code is invalid.']);
        }

        // All checks passed: update password
        $user->password = Hash::make($request->new_password);
        $user->save();

        // Clear session
        Session::forget('password_reset_code');
        Session::forget('password_reset_email');

        return redirect()->route('admin.profile')->with('status', 'Password updated successfully!');
    }
}
