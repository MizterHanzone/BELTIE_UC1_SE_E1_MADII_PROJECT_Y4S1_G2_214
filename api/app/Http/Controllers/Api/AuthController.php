<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;
use App\Mail\PasswordResetCodeMail;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class AuthController extends Controller
{
    // get all users
    public function index()
    {
        try {
            // get all users
            $users = User::orderBy('id', 'desc')->get();

            // format data users
            $formattedUsers = $users->map(function ($user) {
                return [
                    'id' => $user->id,
                    'name' => $user->first_name . ' ' . $user->last_name,
                    'email' => $user->email,
                    'photo' => $user->photo ? $user->photo : null,
                    'role' => $user->role,
                ];
            });

            // response data users
            return response()->json([
                'success' => true,
                'message' => 'Users retrieved successfully',
                'users' => $formattedUsers,
            ], 200);

            // catch error
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'error_message' => $e->getMessage(),
                'message' => 'Failed to get users, please try again',
            ], 500);
        }
    }
    
    public function getOwnUser(Request $request)
    {
        try {
            $user = $request->user();

            $photoUrl = $user->photo ?? null;

            return response()->json([
                'success' => true,
                'message' => 'User profile retrieved successfully',
                'user' => [
                    'name' => $user->first_name . ' ' . $user->last_name,
                    'first_name' => $user->first_name,
                    'last_name' => $user->last_name,
                    'email' => $user->email,
                    'phone' => $user->phone,
                    'photo_url' => $photoUrl,
                ],
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'error_message' => $e->getMessage(),
                'message' => 'Failed to retrieve profile, please try again',
            ], 500);
        }
    }

    // register user
    public function register(Request $request)
    {
        // validate data
        $request->validate(
            [
                'first_name' => ['required', 'string'],
                'last_name' => ['required', 'string'],
                'email' => ['required', 'email', 'unique:users,email'],
                'phone' => ['required', 'string', 'unique:users,phone'],
                'password' => ['required', 'string', 'min:6'],
            ],
            [
                'first_name.required' => 'Please enter your first name',
                'last_name.required' => 'Please enter your last name',
                'email.required' => 'Please enter your email',
                'email.unique' => 'This email is already taken',
                'phone.required' => 'Please enter your phone number',
                'phone.unique' => 'This phone is already taken',
                'password.min' => 'Password must be at least 6 characters long',
            ]
        );

        try {
            DB::beginTransaction();

            // create new user
            $user = new User();
            $user->first_name = $request->first_name;
            $user->last_name = $request->last_name;
            $user->email = $request->email;
            $user->phone = $request->phone;
            $user->role = 'user';
            $user->password = Hash::make($request->password);

            // save data user
            $user->save();
            // create token
            $token = $user->createToken('auth_token')->plainTextToken;
            DB::commit();

            // response data user and token
            return response()->json([
                'success' => true,
                'message' => 'User registered successfully',
                'token' => $token,
                'token_type' => 'Bearer',
                'user_info' => [
                    'id' => $user->id,
                    'name' => $user->first_name . ' ' . $user->last_name,
                    'email' => $user->email,
                    'phone' => $user->phone,
                ],
            ], 201);
        } catch (\Exception $e) {
            DB::rollBack();
            // Handle other exceptions error
            return response()->json([
                'success' => false,
                'error_message' => $e->getMessage(),
                'message' => 'Failed to register, please try again',
            ], 500);
        }
    }

    // login to plate form
    public function login(Request $request)
    {
        // validate data
        $request->validate(
            [
                'email' => ['required', 'email', 'exists:users,email'],
                'password' => ['required', 'string', 'min:6'],
            ],
            [
                'email.required' => 'Please enter your email',
                'password.min' => 'Password must be at least 6 characters',
            ]
        );

        try {
            // find user by email
            $user = User::where('email', $request->email)->first();

            // Check password
            if (!$user || !Hash::check($request->password, $user->password)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Incorrect password. Please try again.',
                ], 401);
            }

            // Create token
            $token = $user->createToken('auth_token')->plainTextToken;

            // response data user and token
            return response()->json([
                'success' => true,
                'message' => 'User logged in successfully',
                'token' => $token,
                'token_type' => 'Bearer',
                'user_info' => [
                    'id' => $user->id,
                    'name' => $user->first_name . ' ' . $user->last_name,
                    'email' => $user->email,
                    'role' => $user->role,
                    'phone' => $user->phone,
                ],
            ], 200);
        } catch (\Exception $e) {
            // Handle other exceptions
            return response()->json([
                'success' => false,
                'error_message' => $e->getMessage(),
                'message' => 'Failed to login, please try again',
            ], 500);
        }
    }

    public function logout(Request $request)
    {
        try {
            // Revoke the current user's token
            $request->user()->currentAccessToken()->delete();

            // response message
            return response()->json([
                'success' => true,
                'message' => 'Successfully logged out.',
            ], 200);
        } catch (\Exception $e) {
            // Handle other exceptions
            return response()->json([
                'success' => false,
                'error_message' => $e->getMessage(),
                'message' => 'Failed to logout, please try again',
            ], 500);
        }
    }

    public function refresh(Request $request)
    {
        try {
            // Delete the current token
            $request->user()->currentAccessToken()->delete();

            // Create a new token
            $newToken = $request->user()->createToken('auth_token')->plainTextToken;

            return response()->json([
                'success' => true,
                'token' => $newToken,
                'token_type' => 'Bearer',
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'error_message' => $e->getMessage(),
                'message' => 'Failed to refresh token',
            ], 500);
        }
    }

    // send email to get code
    public function sendPasswordResetCode(Request $request)
    {
        // Validate the email input
        $request->validate([
            'email' => 'required|email|exists:users,email',
        ]);

        try {
            // Find the user by the provided email
            $user = User::where('email', $request->email)->first();

            // Check if user exists
            if (!$user) {
                return response()->json([
                    'message' => 'User not found.',
                ], 404);
            }

            // Generate a random code for password reset
            $code = rand(10000, 99999);

            // Store the code temporarily (e.g., in cache)
            Cache::put('password_reset_code_' . $code, $user->id, now()->addMinutes(10));

            // Send code to email...
            Mail::to($user->email)->send(new PasswordResetCodeMail($code));

            // Return success message
            return response()->json([
                'message' => 'Verification code sent to your email',
            ]);
        } catch (\Exception $e) {
            // Log the error message for debugging
            Log::error('Failed to send password reset code: ' . $e->getMessage());

            // Return error message if something goes wrong
            return response()->json([
                'success' => false,
                'error_message' => $e->getMessage(),
                'message' => 'Failed to send code',
            ], 500);
        }
    }

    // verify code
    public function verifyPasswordCode(Request $request)
    {
        $request->validate([
            'code' => 'required|string',
        ]);

        $cacheKey = 'password_reset_code_' . $request->code;
        $userId = Cache::get($cacheKey);

        if (!$userId) {
            return response()->json(['message' => 'Invalid or expired code'], 400);
        }

        // Save verified state
        $verifiedKey = 'verified_user_for_password_reset_' . $request->ip();
        Cache::put($verifiedKey, $userId, now()->addMinutes(10));

        return response()->json(['message' => 'Code verified successfully']);
    }

    // reset password
    public function resetPassword(Request $request)
    {
        $request->validate([
            'new_password' => ['required', 'string', 'min:6'],
            'confirm_password' => ['required', 'same:new_password'],
        ]);

        // Identify user from verification cache
        $cacheKey = 'verified_user_for_password_reset_' . $request->ip();
        $userId = Cache::get($cacheKey);

        if (!$userId) {
            return response()->json(['message' => 'No verified reset request found'], 400);
        }

        $user = User::find($userId);
        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        $user->password = Hash::make($request->new_password);
        $user->save();

        // Clean up
        Cache::forget($cacheKey);

        return response()->json(['message' => 'Password reset successful']);
    }

    public function updateProfile(Request $request)
    {
        $user = Auth::user();

        $request->validate([
            'first_name' => ['sometimes', 'string'],
            'last_name' => ['sometimes', 'string'],
            'email' => ['sometimes', 'email', Rule::unique('users')->ignore($user->id)],
            'phone' => ['sometimes', 'string', Rule::unique('users')->ignore($user->id)],
            'password' => ['nullable', 'string', 'min:6', 'confirmed'],
            'photo' => ['nullable', 'image', 'max:2048'],
        ]);

        try {
            DB::beginTransaction();

            if ($request->hasFile('photo')) {
                // Delete old photo if exists
                if ($user->photo) {
                    $oldPath = str_replace('storage/', '', $user->photo);
                    if (Storage::disk('public')->exists($oldPath)) {
                        Storage::disk('public')->delete($oldPath);
                    }
                }

                // Store new photo
                $path = $request->file('photo')->store('uploads/users', 'public');
                $user->photo = 'storage/' . $path;
            }

            if ($request->filled('first_name')) $user->first_name = $request->first_name;
            if ($request->filled('last_name')) $user->last_name = $request->last_name;
            if ($request->filled('email')) $user->email = $request->email;
            if ($request->filled('phone')) $user->phone = $request->phone;
            if ($request->filled('password')) $user->password = Hash::make($request->password);

            $user->save();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Profile updated successfully',
                'user' => [
                    'id' => $user->id,
                    'name' => $user->first_name . ' ' . $user->last_name,
                    'email' => $user->email,
                    'phone' => $user->phone,
                    'photo' => $user->photo,
                ],
            ]);
        } catch (\Exception $e) {
            DB::rollBack();

            return response()->json([
                'success' => false,
                'message' => 'Failed to update profile',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function uploadPhoto(Request $request)
    {
        // Validate the incoming request
        $request->validate([
            'photo' => 'required|image|mimes:jpg,jpeg,png|max:2048',
        ]);

        // Get the authenticated user
        $user = Auth::user();

        try {
            // Handle photo upload if present
            if ($request->hasFile('photo')) {
                // Delete the old photo if it exists
                if ($user->photo) {
                    // Ensure the file exists before trying to delete
                    if (Storage::disk('public')->exists($user->photo)) {
                        Storage::disk('public')->delete($user->photo);
                    }
                }

                // Store the new photo in the public storage
                $path = $request->file('photo')->store('users', 'public');
                $user->photo = $path;
            }

            // Save the new photo URL (if photo uploaded)
            $user->save();

            // Respond with success and the new photo URL
            return response()->json([
                'success' => true,
                'message' => 'Photo updated successfully',
                'photo_url' => $user->photo, // Return the new photo URL
            ], 200);

        } catch (\Exception $e) {
            // If anything goes wrong, return an error response
            return response()->json([
                'success' => false,
                'message' => 'Failed to update photo',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
}
 